#!/usr/bin/env bash
#
# Bootstrap the dotfiles installation

echo -e "Install essential packages...\n"

if [[ $(lsb_release -is | grep -i fedora) ]];
then
    sudo yum install -y git tig meld ctags xclip mercurial vim \
        tmux screen source-highlight terminator dstat htop aria2 \
	    aria2 python-virtualenv python-virtualenvwrapper \
        python-flake8 glances subversion sensible-utils most pass \
        google-noto-sans-simplified-chinese-fonts google-noto-sans-traditional-chinese-fonts \
        shutter powertop tlp tlp-rdw the_silver_searcher youtube-dl

elif [[ $(lsb_release -is | (grep -i ubuntu) || (grep -i linuxmint)) ]];
then
    sudo apt-get update && sudo apt-get install -y git git-sh tig exuberant-ctags mercurial vim \
        tmux screen ack-grep ncdu pydf dstat htop subversion most apt-file\
        powertop silversearcher-ag pass ppa-purge software-properties-common\
        libimage-exiftool-perl ranger atool python python-dev zsh zsh-common

    echo "Clone the dotfiles repository and create soft links...\n"
    mkdir $HOME/Projects
    mkdir -p $HOME/Development/go-projects
    git clone https://github.com/abalakersky/dotfiles.git $HOME/Projects/dotfiles
    $HOME/Projects/dotfiles/bin/dfm install

    echo -e "Installing Ubuntu Make\n"
    sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
    sudo apt-get -y update && sudo apt-get -y install ubuntu-make
    umake go ~/.local/share/umake/go/go-lang

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

    echo "Update font cache...\n"
    fc-cache -vf ~/.fonts

    source ~/.profile
    source ~/.bashrc

    echo -e "Install all Vim's plugins...\n"
    vim +BundleInstall +qall
    reset
    source ~/.profile
    source ~/.bashrc
    vim +GoInstallBinaries +qall

#    echo "Install GO language"
#    wget -qO- https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
#    sudo tar -C /usr/local -xzf go1.6.2.linux-amd64.tar.gz

    echo -e "Done! Enjoy!\n"
fi
