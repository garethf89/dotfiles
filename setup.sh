#!/bin/bash
set -euo pipefail

# Display message 'Setting up your Mac...'
echo "Setting up Mac..."
sudo -v

echo "XCode Install"

if ! xcode-select --print-path &> /dev/null; then

    xcode-select --install

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

# Homebrew
./brew.sh

# Create Sites directory
echo "Creating a Sites directory"
mkdir -p $HOME/Sites

# Node
echo "Installing Global NPM Stuff"
yarn global add nodemon
yarn global add jest

# Generate SSH key
# echo "Generating SSH keys"
# ssh-keygen -t rsa

# echo "Copied SSH key to clipboard - You can now add it to Github"
# pbcopy < ~/.ssh/id_rsa.pub
# open 'https://github.com/account/ssh'

# set up osx defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
sh ./osx.sh

sh ./git.sh

sh ./symlinks.sh

# Complete
echo "Installation Complete"