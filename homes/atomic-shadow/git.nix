{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Abhishek Kumar Ray";
    userEmail = "atomic7002@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@gitlab.com:".insteadOf = "gl:";
        "git@codeberg.org:".insteadOf = "cb:";
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };
    };
  };
}
