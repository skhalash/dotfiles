# dotfiles

## brew
Install (or update) brew as well as a handful of standard packages (go, kubectl, helm etc.).
```
cd brew
./brew.sh
```

## iTerm2
Install a terminal emulator for OSX (which is a much better solution as the standard OSX terminal)
```
cd iterm2
./iterm2.sh
```

## oh-my-zsh
```
cd ohmyzsh
./install.sh
```

## vim
Vim 8 package manager is used.
```
ln -s ~/git/dotfiles/vim ~/.vim
```

## dotfiles
```
ln -sv ~/git/dotfiles/.zshrc ~
ln -sv ~/git/dotfiles/.gitconfig ~
```
