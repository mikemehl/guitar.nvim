global nvim_create_buf: function(boolean, boolean): number
global nvim_open_win:   function(number, boolean, table): number
global nvim_win_hide:   function(number): nil

global record vim
  record log
    record levels
      DEBUG: any
      ERROR: any
      INFO: any
      TRACE: any
      WARN: any
      OFF: any
    end
  end
  notify_once: function (string, any): nil
end
