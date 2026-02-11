{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".text = ''
    theme "dankcolors"

    default_layout "default"

    pane_frames true
    simplified_ui false

    copy_on_select false
    scroll_buffer_size 10000
  '';
}
