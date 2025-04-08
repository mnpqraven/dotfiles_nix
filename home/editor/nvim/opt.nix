_: let
  indent = 2;
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
    mouse = "a";
  };
}
