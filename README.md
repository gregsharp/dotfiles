dotfiles
========

Greg's dotfiles

git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

git clone git://github.com/gregsharp/dotfiles.git $HOME/.homesick/repos/dotfiles


How to commit changes
=====================
homeshick cd dotfiles
git commit -m "Message"
git push origin master
