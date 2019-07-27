echo "Installing Homebrew"

if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Homebrew Packages

cd ~
echo "Installing packages and casks"

brew update
brew upgrade
brew bundle install --file=~/dotfiles/Brewfile
brew cleanup