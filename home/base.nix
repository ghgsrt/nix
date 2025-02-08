{dotfiles, ...}:{

 xdg = {
   configFile."zsh/".source = "${dotfiles}/.config/zsh/";
   configFile."tmux/tmux.conf".source = "${dotfiles}/.tmux.conf";
   configFile."nvim/".source = "${dotfiles}/.config/nvim/";
   configFile."foot/".source = "${dotfiles}/.config/foot/";
   configFile."sway/".source = "${dotfiles}/.config/sway/";
   configFile."waybar/".source = "${dotfiles}/.config/waybar/";
   configFile."gtk-4.0/".source = "${dotfiles}/.config/gtk-4.0/";
   configFile."starship.toml".source = "${dotfiles}/starship.toml";
 };

 xdg.userDirs.desktop = "$HOME/";

  home.sessionVariables = {
    ZDOTDIR = "${config.xdg.configHome}/zsh";
    SHARE = "$HOME/.nix-profile/share";
  };
}
