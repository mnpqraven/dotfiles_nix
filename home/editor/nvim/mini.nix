_:
let
  on = {
    enable = true;
  };
in
{
  programs.nvf.settings.vim.mini = {
    ai = on;
    trailspace = on;
    bracketed = on;
    surround = {
      enable = true;
      setupOpts = {
        mappings = {
          add = "ys";
          delete = "ds";
          replace = "cs";
          find = "yf";
          find_left = "yF";
          highlight = "yh";
          update_n_lines = "yn";
        };
        n_lines = 1000;
      };
    };
    pairs = on;
    diff = {
      enable = true;
      setupOpts.view.style = "sign";
    };
    hipatterns = on;
    notify = on;
    splitjoin = on;
    icons = on;
    move = {
      enable = true;
      setupOpts.mappings = {
        left = "<left>";
        right = "<right>";
        down = "<down>";
        up = "<up>";
        line_left = "<left>";
        line_right = "<right>";
        line_down = "<down>";
        line_up = "<up>";
      };
    };
    align = on;
    bufremove = on;
  };
}
