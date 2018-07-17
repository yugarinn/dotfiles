# Dotfiles
My system bootstrap and dotfiles. You might find one or two cool ideas regarding the bootstrap or the system configuration. Stay away from my emacs init.el file though, I have no idea what I'm doing most of the time so you could end up hurting yourself.

![IMAGE](https://imgs.xkcd.com/comics/borrow_your_laptop.png)

## Usage

```shell
git clone https://github.com/sergiouve/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

```bash
.
├── bin/
│   ├── bootstrap.sh
│   ├── configs.sh
│   └── dotfiles.sh
├── configs/
│   ├── emacs.d
│   │   ├── helpers/
│   │   ├── init.el
│   │   └── snippets/
│   ├── profile
│   ├── tmux
│   └── zshrc
├── install.sh
├── README.md
└── CHECKLIST.md
```

## Bootstrap
These files have mainly three responsabilities: install software, configure the system and link all my dotfiles. This has been written with a Fedora distro in mind, but
there shouldn't be much trouble using or porting it to another distro or even, *takes a deep breath...*, MacOS.

## Dotfiles
Mainly Emacs, bash aliases/functions and tmux configuration. Running the bin/dotfiles.sh script symlink all of them and gets them ready to use.
