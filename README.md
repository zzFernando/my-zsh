# My ZSH Configuration

Este repositório contém minha configuração pessoal do **ZSH** com o uso de plugins e ferramentas adicionais para melhorar a experiência de terminal.

## Ferramentas Utilizadas

- **ZSH**: Um shell poderoso e interativo que substitui o Bash.
- **Oh My Zsh**: Framework para gerenciar a configuração do ZSH.
- **Starship**: Um prompt de shell altamente customizável.
- **ZSH Syntax Highlighting**: Plugin para realçar a sintaxe no terminal.
- **ZSH Autosuggestions**: Plugin para sugerir comandos com base no histórico.
- **fzf**: Fuzzy finder para procurar arquivos e comandos.

## Como Instalar

1. **Instale o ZSH**:

   ```bash
   sudo apt install zsh
   ```

2. **Instale o Oh My Zsh**:

   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Instale o Starship**:

   ```bash
   curl -sS https://starship.rs/install.sh | sh
   ```

4. **Instale o ZSH Syntax Highlighting**:

   ```bash
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

5. **Instale o ZSH Autosuggestions**:

   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
   ```

6. **Instale o fzf**:

   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
   ```

## Configuração Pessoal

Aqui está o conteúdo do arquivo `zsh.rc` para a configuração do ZSH:

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

### Explicação da Configuração

- **Tema**: O tema escolhido é o `robbyrussell`, um dos temas padrão do Oh My Zsh.
- **Plugins**:
  - `git`: Facilita o uso de comandos Git no terminal.
  - `aws`: Adiciona suporte a comandos AWS CLI.
  - `terraform`: Suporte para comandos Terraform.
  - `docker`: Adiciona autocompletar para Docker.
  - `zsh-syntax-highlighting`: Destaca comandos conforme você os digita.
  - `zsh-autosuggestions`: Sugere comandos baseados no histórico de comandos anteriores.
  - `fzf`: Adiciona funcionalidades de busca interativa.
- **Starship**: Um prompt de shell moderno e customizável.
- **Alias**: Cria o alias `update` para atualizar e limpar pacotes no Ubuntu com um único comando.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
