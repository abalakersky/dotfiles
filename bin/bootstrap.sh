#!/usr/bin/env bash
#
# Bootstrap the dotfiles installation

echo -e "Install essential packages...\n"

if [[ $(python -mplatform | grep -i fedora) ]];
then
    sudo yum install -y git tig meld ctags xclip mercurial vim \
        tmux screen source-highlight terminator dstat htop aria2 \
	    aria2 python-virtualenv python-virtualenvwrapper \
        python-flake8 glances subversion sensible-utils most pass \
        google-noto-sans-simplified-chinese-fonts google-noto-sans-traditional-chinese-fonts \
        shutter powertop tlp tlp-rdw the_silver_searcher youtube-dl

elif [[ $(python -mplatform | (grep -i ubuntu) || (grep -i LinuxMint)) ]];
then
    sudo apt-get update && sudo apt-get install -y git git-sh tig meld exuberant-ctags xclip mercurial vim \
        tmux screen source-highlight terminator ack-grep ipython ncdu pydf \
        dstat htop speedometer aria2 subversion most i3-wm i3status i3lock \
        ttf-dejavu fonts-droid fonts-cantarell youtube-dl apt-file\
        shutter powertop silversearcher-ag pass ppa-purge software-properties-common\
        libimage-exiftool-perl ranger atool python-dev zsh zsh-common


    echo -e "Install Pip...\n"
    sudo apt-get install -y python-pip
    sudo pip install --upgrade pip
    sudo pip install awscli s3cmd

#    echo -e "Installing TLP...\n"
#    sudo add-apt-repository ppa:linrunner/tlp
#    sudo apt-get update
#    sudo apt-get install tlp tlp-rdw
#    sudo apt-get install tp-smapi-dkms acpi-call-dkms

    echo -e "Update Deb packaging details...\n"
    sudo apt-file update

    echo -e "Install latest Ruby and basic gems...\n"
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable --ruby --auto-dotfiles
    source $HOME/.rvm/scripts/rvm
    gem install bundler aws-sdk pry pry-doc pry-git pry-byebug pry-rescue awesome_print

#    echo -e "Install essential Python modules...\n"
#    sudo apt-get install libpython-dev python-pip
#    sudo pip install awesome_print virtualenvwrapper flake8 Glances

#    echo -e "Installing oh-my-zsh...\n"
#    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Clone the dotfiles repository and create soft links...\n"
    mkdir $HOME/Projects
    git clone https://github.com/abalakersky/dotfiles.git $HOME/Projects/dotfiles
    $HOME/Projects/dotfiles/bin/dfm install

    echo "Update font cache...\n"
    fc-cache -vf ~/.fonts

    echo -e "Install all Vim's plugins...\n"
    vim +BundleInstall +qall

    echo -e "Done! Enjoy!\n"
fi
