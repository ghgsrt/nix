{dotfiles, ...}:{

 xdg = {
   configFile."tmux/tmux.conf".source = "${dotfiles}/tmux.conf";
   configFile."nvim/".source = "${dotfiles}/nvim/";
   configFile."sway/".source = "${dotfiles}/sway/";
   configFile."waybar/".source = "${dotfiles}/waybar/";
   configFile."gtk-4.0/".source = "${dotfiles}/gtk-4.0/";
 };

 xdg.userDirs.desktop = "$HOME/";
}
