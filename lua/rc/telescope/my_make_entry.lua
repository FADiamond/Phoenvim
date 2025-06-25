local my_make_entry = {}

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")
local utils = require("telescope.utils")
local Path = require("plenary.path")

local filter = vim.tbl_filter
local map = vim.tbl_map

-- Buffer entry maker (your existing configuration)
function my_make_entry.gen_from_buffer_like_leaderf(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", {default = true})

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
      end, bufnrs)
    )
  )

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      {entry.bufnr, "TelescopeResultsNumber"},
      {entry.indicator, "TelescopeResultsComment"},
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
    }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

function my_make_entry.gen_from_file_like_leaderf(opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.loop.cwd()
  local default_icons, _ = devicons.get_icon("file", "", { default = true })

  -- Calculate max widths for alignment
  local max_filename_width = opts.max_filename_width or 30
  local icon_width = vim.fn.strwidth(default_icons)

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = icon_width }, -- Icon
      { width = max_filename_width }, -- Filename
      { remaining = true }, -- Directory path
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { entry.dir_name, "Comment" }
    })
  end

  return function(entry)
    local filename = entry.value or entry.filename or entry[1]
    if not filename then
      return nil
    end

    -- Convert to absolute path and then get relative to cwd
    local path = Path:new(filename)
    if not path:is_absolute() then
      path = Path:new(cwd, filename)
    end

    local file_name = path:basename()
    local dir_name = path:parent():make_relative(cwd)
    
    -- If the directory is the same as cwd, show "./"
    if dir_name == "." or dir_name == "" then
      dir_name = "./"
    else
      dir_name = dir_name .. "/"
    end

    -- Get file icon and highlight
    local icons, highlight = devicons.get_icon(file_name, vim.fn.fnamemodify(file_name, ":e"), { default = true })

    return {
      valid = true,
      value = filename,
      ordinal = file_name .. " " .. dir_name,
      display = make_display,
      
      devicons = icons,
      devicons_highlight = highlight,
      file_name = file_name,
      dir_name = dir_name,
      path = path:absolute(),
    }
  end
end

-- Alternative version with file size and modification date
function my_make_entry.gen_from_file_with_details(opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.loop.cwd()
  local default_icons, _ = devicons.get_icon("file", "", { default = true })

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = vim.fn.strwidth(default_icons) }, -- Icon
      { width = 30 }, -- Filename
      { width = 8 }, -- File size
      { remaining = true }, -- Directory path
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { entry.file_size, "TelescopeResultsNumber" },
      { entry.dir_name, "Comment" }
    })
  end

  return function(entry)
    local filename = entry.value or entry.filename or entry[1]
    if not filename then
      return nil
    end

    local path = Path:new(filename)
    if not path:is_absolute() then
      path = Path:new(cwd, filename)
    end

    local file_name = path:basename()
    local dir_name = path:parent():make_relative(cwd)
    
    if dir_name == "." or dir_name == "" then
      dir_name = "./"
    else
      dir_name = dir_name .. "/"
    end

    -- Get file stats
    local stat = vim.loop.fs_stat(path:absolute())
    local file_size = ""
    if stat then
      local size = stat.size
      if size < 1024 then
        file_size = size .. "B"
      elseif size < 1024 * 1024 then
        file_size = string.format("%.1fK", size / 1024)
      else
        file_size = string.format("%.1fM", size / (1024 * 1024))
      end
    end

    local icons, highlight = devicons.get_icon(file_name, vim.fn.fnamemodify(file_name, ":e"), { default = true })

    return {
      valid = true,
      value = filename,
      ordinal = file_name .. " " .. dir_name,
      display = make_display,
      
      devicons = icons,
      devicons_highlight = highlight,
      file_name = file_name,
      dir_name = dir_name,
      file_size = file_size,
      path = path:absolute(),
    }
  end
end

return my_make_entry
