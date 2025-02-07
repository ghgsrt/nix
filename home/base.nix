{dotfiles, ...}:{

 xdg = {
   configFile."tmux/tmux.conf".source = "${dotfiles}/.tmux.conf";
   configFile."nvim/".source = "${dotfiles}/nvim/";
   configFile."sway/".source = "${dotfiles}/sway/";
   configFile."waybar/".source = "${dotfiles}/waybar/";
   configFile."gtk-4.0/".source = "${dotfiles}/gtk-4.0/";
   configFile."starship.toml".source = "${dotfiles}/starship.toml";
 };

 xdg.userDirs.desktop = "$HOME/";
}
