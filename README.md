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

## dotfiles
Either copy the dorfiles or create symlins:
```
ln -sv ~/git/dotfiles/.zshrc ~
ln -sv ~/git/dotfiles/.vimrc ~
ln -sv ~/git/dotfiles/.gitconfig ~
```
