# Mi configuración de Neovim

Esta configuración de Neovim está pensada para el desarrollo en **Python** y **TypeScript**, y más concretamente con **Astro**, **React** y **NextJS**.

## Instalación

La instalación de esta configuración se realiza de esta manera:

```
git clone https://www.github.com/SantosAlarcon/nvim-config
mv .config/nvim .config/nvim.backup
mv .local/share/nvim .local/share/nvim.backup
cp -r nvim-config/nvim .config/nvim
```

La primera vez que se cargue la configuración tardará un poco porque tiene que descargar el gestor de plugins **Lazy**, seguido de los plugins que hay dentro de esta configuración.

## Plugins

+ **WhichKey:** [https://github.com/folke/which-key.nvim](https://github.com/folke/which-key.nvim)
+ **Lazy:** [https://github.com/folke/lazy.nvim](https://github.com/folke/lazy.nvim)
+ **Feline:** [https://github.com/famiu/feline.nvim](https://github.com/famiu/feline.nvim)
+ **Toggleterm:** [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
+ **Nvim-Treesitter:** [https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
