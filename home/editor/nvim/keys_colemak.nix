{ ... }:
let
  remap = key: to: {
    inherit key;
    action = to;
    mode = [ "n" "v" ];
    noremap = false;
  };
  nremap = key: to: {
    inherit key;
    action = to;
    mode = [ "n" ];
    noremap = false;
  };
  nmap = key: to: {
    inherit key;
    action = to;
    mode = [ "n" ];
  };
  imap = key: to: {
    inherit key;
    action = to;
    mode = [ "i" ];
  };
  vmap = key: to: {
    inherit key;
    action = to;
    mode = [ "v" ];
  };
in {
  programs.nvf.settings.vim.keymaps = [
    # HJKL rebinds
    (remap "N" "K")
    (remap "n" "gj")
    (remap "E" "J")
    (remap "e" "l")
    (remap "k" "nzz")
    (remap "K" "Nzz")
    (remap "l" "gk")
    (remap "E" "$")
    (remap "H" "0")
    (remap "N" "L")
    (remap "<C-d>" "<C-d>zz")
    # split navigation
    (nremap "<C-h>" ":wincmd h<CR>")
    (nremap "<C-n>" ":wincmd j<CR>")
    (nremap "<C-l>" ":wincmd k<CR>")
    (nremap "<C-e>" ":wincmd l<CR>")
    # tab navigation
    (nremap "<leader>1" "1gt")
    (nremap "<leader>2" "2gt")
    (nremap "<leader>3" "3gt")
    (nremap "<leader>4" "4gt")
    (nremap "<leader>5" "5gt")
    (nremap "<leader>6" "6gt")
    (nremap "<leader>7" "7gt")
    (nremap "<leader>8" "8gt")
    (nremap "<leader>9" "9gt")
    (nremap "<C-w>" ":bd")
    (nremap "<C-s>" ":w<CR>")

    # split resizing
    (nmap "<A_l>" ":res +5<CR>")
    (nmap "<A_n>" ":res -5<CR>")
    (nmap "<A_h>" ":vertical resize -5<CR>")
    (nmap "<A_e>" ":vertical resize +5<CR>")

    (nmap "G" "Gzz")

    # semicolon escaping
    (imap ";;" ":")
    (imap ";e" ";<esc>a")
    (imap ";n" ";<esc>")
    (imap ";o" ";<esc>o")
    {
      key = "<F8>";
      # TODO: lua code
      action = ":set hlsearch! hlsearch?<CR>";
      # TODO: +in command mode "c"
      mode = [ "n" ];
    }

    # clipboard
    (imap "<C-z>" ''<esc>l"+pi'')
    (nmap "<C-z>" ''"+P'')
    (vmap "<C-c>" ''"+y'')
  ];
}
