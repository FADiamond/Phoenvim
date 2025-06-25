return {
  "tpope/vim-fugitive",
  config = function()
    -- Keymaps for vim-fugitive
    local keymap = vim.keymap.set

    -- Git status and basic commands
    keymap("n", "<leader>Gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
    keymap("n", "<leader>Ga", ":Git add .<CR>", { desc = "[G]it [A]dd all" })
    keymap("n", "<leader>Gc", ":Git commit<CR>", { desc = "[G]it [C]ommit" })
    keymap("n", "<leader>Gp", ":Git push<CR>", { desc = "[G]it [P]ush" })
    keymap("n", "<leader>GP", ":Git pull<CR>", { desc = "[G]it [P]ull" })

    -- Git diff commands
    keymap("n", "<leader>Gd", ":Gvdiffsplit<CR>", { desc = "[G]it [D]iff split" })
    keymap("n", "<leader>Gh", ":diffget //2<CR>", { desc = "Get diff from left (HEAD)" })
    keymap("n", "<leader>Gl", ":diffget //3<CR>", { desc = "Get diff from right (merge branch)" })

    -- Git log and history
    keymap("n", "<leader>GL", ":Git log --oneline<CR>", { desc = "[G]it [L]og" })
    keymap("n", "<leader>Gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })

    -- Branch operations
    keymap("n", "<leader>GB", ":Git branch<CR>", { desc = "[G]it [B]ranches" })
    keymap("n", "<leader>Go", ":Git checkout ", { desc = "[G]it checkout (type branch name)" })
    keymap("n", "<leader>Gn", ":Git checkout -b ", { desc = "[G]it [N]ew branch" })

    -- Merge and rebase
    keymap("n", "<leader>Gm", ":Git merge ", { desc = "[G]it [M]erge" })
    keymap("n", "<leader>Gr", ":Git rebase ", { desc = "[G]it [R]ebase" })

    -- Stash operations
    keymap("n", "<leader>GS", ":Git stash<CR>", { desc = "[G]it [S]tash" })
    keymap("n", "<leader>GU", ":Git stash pop<CR>", { desc = "[G]it stash pop ([U]nstash)" })
  end,
}
