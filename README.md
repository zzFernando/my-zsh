# My ZSH Configuration

This repository contains my personal **ZSH** configuration with additional plugins and tools to enhance the terminal experience.

## Tools Used

- **ZSH**: A powerful and interactive shell that replaces Bash.
- **Oh My Zsh**: Framework for managing ZSH configuration.
- **Starship**: A highly customizable shell prompt.
- **ZSH Syntax Highlighting**: Plugin to highlight syntax in the terminal.
- **ZSH Autosuggestions**: Plugin to suggest commands based on history.
- **fzf**: Fuzzy finder for searching files and commands.

## Automated Installation (Recommended) 🚀

Run the automated installation script that sets everything up for you:

```bash
git clone https://github.com/YOUR_USERNAME/my-zsh.git
cd my-zsh
./install.sh
```

The script will automatically:
- ✅ Detect your operating system (Linux/macOS)
- ✅ Install ZSH
- ✅ Install Oh My Zsh
- ✅ Install Starship
- ✅ Install all necessary plugins
- ✅ Configure .zshrc
- ✅ Set ZSH as the default shell

After installation, run `exec zsh` or logout/login to activate.

## Manual Installation

If you prefer to install manually, follow these steps:

1. **Install ZSH**:

   ```bash
   sudo apt install zsh
   ```

2. **Install Oh My Zsh**:

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Install Starship**:

   ```bash
   curl -sS https://starship.rs/install.sh | sh
   ```

4. **Install ZSH Syntax Highlighting**:

   ```bash
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

5. **Install ZSH Autosuggestions**:

   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
   ```

6. **Install fzf**:

   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
   ```

7. **Copy the configuration**:

   ```bash
   cp zsh.rc ~/.zshrc
   ```

## Personal Configuration

Here is the content of the `zsh.rc` file for ZSH configuration:

```bash
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    aws
    terraform
    docker
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias update="sudo apt -y update ; sudo apt -y full-upgrade ; sudo apt -y autoremove ; sudo apt -y autoclean"
```

### Configuration Explanation

- **Theme**: The chosen theme is `robbyrussell`, one of Oh My Zsh's default themes.
- **Plugins**:
  - `git`: Facilitates the use of Git commands in the terminal.
  - `aws`: Adds support for AWS CLI commands.
  - `terraform`: Support for Terraform commands.
  - `docker`: Adds autocomplete for Docker.
  - `zsh-syntax-highlighting`: Highlights commands as you type them.
  - `zsh-autosuggestions`: Suggests commands based on previous command history.
  - `fzf`: Adds interactive search functionality.
- **Starship**: A modern and customizable shell prompt.
- **Alias**: Creates the `update` alias to update and clean packages on Ubuntu with a single command.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
