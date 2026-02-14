# macos-updater
A shell script for updating macOS and some web development tools (npm, pip, ...). This scripts provides an easy way to keep all your software components up-to-date without running several update processes.

## Supported applications
- [macOS](https://support.apple.com/de-de/HT201541) (The operating system itself)
- [brew](https://github.com/Homebrew/brew) and [brew cask](https://github.com/Homebrew/homebrew-cask)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [npm](https://github.com/npm/npm) (NodeJS Package Manager)

## Installation
Clone the repository:
```sh
git clone https://github.com/mpk-software/macos-updater.git
cd macos-updater
```

Run the shell script to start the update process:
```sh
./update-macos.sh
```

## Contributing
Please feel free to add additional update commands which are usually used in macOS web development environments by creating a [pull request](https://github.com/mpk-software/macos-updater/pulls).
