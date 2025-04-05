_:
let indent = 2;
in {
  programs.nvf.settings.vim.options = {
    # TODO: clean old/unneeded keys
    guicursor = "a:block";
    updatetime = 50;
    timeoutlen = 500;
    encoding = "utf-8";
    is = true;
    showmode = false;
    compatible = false;
    number = true;
    spell = false;
    showcmd = false;
    ruler = false;
    cursorcolumn = true;
    cursorline = true;
    hlsearch = false;
    incsearch = true;
    cmdheight = 1;
    foldmethod = "manual";
    foldlevel = 99;
    scrolloff = 8;
    wildmenu = true;
    shell = "zsh";
    relativenumber = true;
    colorcolumn = "80";
    textwidth = 79;
    splitbelow = true;
    splitright = true;
    laststatus = 3;

    tabstop = indent;
    shiftwidth = indent;
    foldcolumn = "1";
    expandtab = true;
    linespace = 0;
    history = 1000;
    lbr = true;
    smartindent = true;
    conceallevel = 2;
    concealcursor = "c";

    showbreak = "↪";
    # TODO: list and listchars
    mouse = "a";
  };
}

# TODO:
# vim.cmd([[
# if exists('+termguicolors')
#   let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
#   let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
#   set termguicolors
# endif
# ]])
# -- WHITESPACE
# vim.api.nvim_create_autocmd({ "BufWritePre" }, { command = "%s/\\s\\+$//e" })
# -- COMPILER
# vim.g.rust_recommended_style = 0
# vim.api.nvim_create_autocmd(
#     { "BufRead", "BufNewFile" },
#     { pattern = { "*.rs", "Cargo.toml", "Cargo.lock" }, command = "compiler cargo" })
# vim.api.nvim_create_autocmd(
#     { "BufRead", "BufNewFile" },
#     {
#         pattern = { "*.rs", "Cargo.toml", "Cargo.lock", "*.lua" },
#         callback = function()
#             vim.opt.tabstop    = 4
#             vim.opt.shiftwidth = 4
#         end
#     })
# vim.api.nvim_create_autocmd(
#     { "BufRead", "BufNewFile" },
#     {
#         pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.mjs", "*.cjs" },
#         callback = function()
#             vim.opt.tabstop    = 2
#             vim.opt.shiftwidth = 2
#         end
#     })
#
