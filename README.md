# LunarVimConfig

This repo contains my configuration for
[LunarVim](https://www.lunarvim.org/).
The focus was to create an IDE for Julia, although
it can be adapted to any other language by installing the appropriate plugins.

[This blog post](https://medium.com/coffee-in-a-klein-bottle/vim-for-julia-another-look-1dc4265bb49b)
is reposted here and presents a quick overview on how to use
LunarVim and set it up for Julia.


---

![LunarVim](./figures/lunarvim.png)
# Vim for Julia - Another Look
## LunarVim as a Julia IDE
In the past, I wrote on how to use Vim for Julia. Recently, I've changed my setup and I've been using the new and amazing LunarVim. Here is a brief tutorial on how to setup Vim (actually Neovim) as your Julia IDE.
### Introducing LunarVim
The first question to be answered is, what is LunarVim? Presto!

LunarVim is an opinionated, extensible, and fast IDE layer for Neovim >= 0.5.0. LunarVim takes advantage of the latest Neovim features such as Treesitter and Language Server Protocol support.

In simpler words, it's a series of default configurations for Neovim that makes it even more amazing. The first requirement to use LunarVim is to install Neovim with version at least 0.5. Unfortunately, the sudo apt install neovim will not work (at the time I'm writing this), because the version installed will be lower than the required one.

An easy way to install a proper version is to add the PPA for the unstable version and install it. Here are the easy steps:
```julia
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```
To install LunarVim, just run:
```
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```
By running the command lvim in your terminal, LunarVim should start! You can always add alias vim = "lvim" to your .bashrc , to run LunarVim instead of vim.

### Setting up Julia

Now that you've got LunarVim working, let's setup the Julia language. This is actually surprisingly simple. In your terminal, run the following:
```
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
```
This installs the Language Server Protocol (LSP) for Julia, i.e. the auto-completion functionally for Julia. Now, every time you open a ".jl" file, just wait a bit and the LSP will start.

Next, let's install the Julia-Vim package that will enable us using Unicode, thus, by writing something like \alpha and pressing tab, we'll get the alpha Unicode, which is allowed in Julia. To do this, go to your LunarVim configurations file, which can be accessed by running lvim in the terminal and selecting the Configuration option. Another way is to open the configuration file directly, which is ~/.config/lvim/config.lua .

Inside the configuration, there is a place where you can easily install any plugin you want. Just navigate to where the "- - Additional Plugins" is. Originally, everything should be commented. Just uncomment the necessary lines, and write {"JuliaEditorSupport/julia-vim"} and save. This will prompt the installation of the plugging. Take a look at the figure below.


![LunarVim](./figures/configlunar.png)

This is what your configuration should look like to install Julia-Vim. Note that you can add any other plugins you like.

(*update for new LunarVim 0.6*)

Finally, you have to create a file `~/.config/lvim/ftplugin/julia.lua` with the following line to start the language server when opening Julia files.
```lua
local opts = {} 
-- re-use common lsp configurations (keybindings, buffer-highlight and cmp integration)
opts = require("lvim.lsp").get_common_opts() 
require('lspconfig').julials.setup(opts)
```

**Word of Caution!**

Since Vim is inside your terminal, you need your terminal to have a font with Unicode enabled. I suggest you install JuliaMono, a beautiful font created for Julia :D. Once the font is installed, just go into your terminal configuration and change to it.

Even with Unicode font enabled, in my notebook, the Julia-Vim was still freezing after pressing Tab without any text. To solve this issue, I wrote the following two commands in my LunarVim configuration:

```
vim.cmd("let g:latex_to_unicode_tab = 'off'")
vim.cmd("let g:latex_to_unicode_keymap = 1")
```
![LunarVim](./figures/configlunar2.png)

Screenshot of my own configuration file.Now everything should be working beautifully!
**Your new LunarVim IDE for Julia is ready to be used.**

---

###  Fast Course on LunarVim + Julia
You can now read the documentation on LunarVim to better understand some of the default settings. But, I'll give some tips on how LunarVim works, and how to use it with Julia to run your code. Here is a (very) fast course on some of the main commands for LunarVim:

![LunarVim](./figures/lunarvimcommand.png)

* In LunarVim, your <leader> is the space , hence, many short cuts will be composed of pressing "space" followed by something else. Here is where LunarVim comes shining. If you just press "space" and wait a bit. A menu will pop-up from below, showing possible commands.

![LunarVim](./figures/lunarmenu.png)

* LunarVim comes with "NerdCommenter" plugin, which allows you to navigate with a menu. Just press `<space>+e`;
* In the "NerdCommenter" in normal mode, press `<shift>+r` to reload the navigation menu, hence, any new created file will now show;
* Press `d` to delete the file under the cursor, `y` to copy it, and `a` to create ("append") a new file.

![LunarVim](./figures/bufferlunar.png)

* Once you open another file, a buffer is created and shown in the top of the screen . You can click on the tab to change buffers, or you can press shift+h or shift+l to change buffers.

![LunarVim](./figures/julialunar.png)

* Press ctrl+w to see the commands related to splitting screen and moving between screens. You can press ctrl+ h,l,j,k to move between windows.

![LunarVim](./figures/highlight.png)

* As in regular Vim, you can press / to start searching and then space+h clears the highlighted terms in the search.

![LunarVim](./figures/tipjulia.png)

* When you open a Julia file, you just need to wait a bit for the LSP to start working. Once the LSP is loaded, auto-completion will be working, and many other helpful features, such as visualizing the docstring of a function. For that, press g and a window will pop-up with many shortcuts related to the LSP. For example, you can press g + p to take a peek at the docstring and g + d to actually open the function definition in another buffer. Look the figures below.

![LunarVim](./figures/repljulia.png)

* Lastly, you can press ctrl+t to open and minimize a floating terminal. Once this is done, you can run the Julia REPL and copy/paste every line of code you want to run.

* Press `<space>+f+t` to search for a text in any files in the file tree;
* Press `<space>+l+p+d` to open the docstring for a function;
* Press `shift + k` to also open the documentation (**very useful**).

There are many other helpful commands. Check-out the documentation on LunarVim or try them out by yourself to learn more. Hope this was helpful.

## More on Julia

### LSP Instatiation
There are some extra information necessary to properly setup Julia with Neovim.
Besides the command to install the LanguageServer, as shown below:
```
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
```
It's important to point out that the LSP will load the information
on packages based on the project you are in. For example, if you
create a directory `MyCode/`, with a `Project.toml` and a `Manifest.toml` file,
then the LSP will load only the autocompletion and documentation
for packages installed in this environment.

If no environment project is found, the LSP will probably
load based on you global configuration, which will probably be on
`~/.julia/environments/v1.6/` (if you are using v1.6).
You can check from where your LSP is loading by looking the file `~/.cache/nvim/lsp.log`,
which will show what's running.

### Speed-up the LSP loading time
You might note that takes some annoying seconds for the LSP to start with Julia.
This can be improved with a compiled image via `PackageCompiler`. This method
is due to (Fredrik Ekre)[https://github.com/fredrikekre].

First, we must add the following lines inside our `~/.config/lvim/config.lua`:
```lua
require'lspconfig'.julials.setup{
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
            new_config.cmd[1] = julia
        end
    end
}
```
This is telling our LSP to run from `~/.julia/environments/nvim-lspconfig/bin/julia`.
At the moment, there is nothing in this location. But the next steps will
create an image and the Julia executable to run this image.

Inside the folder `~/.julia/environments/nvim-lspconfig/`, create the file
`Makefile` as the one inside this Github repository (the file is inside the `speed-lsp` folder).
Then, move  inside the `~/.julia/environments/nvim-lspconfig/` folder and run `make` command.
At some point some Julia example code will open inside your terminal. Just save and close the
file. After that, just wait for the image to be created. You are done!
Now your LSP should be loading almost immediately. Although, it might take some time
for the autocompletion on packages to work. The time of loading will depend on how
many packages you have installed in your environment.

<!-- You can check this by pressing Space, then "l" and then "i" (once you -->
<!-- press Space, the menu will show up. You have to navigate to "LSP" and then "Info"). -->
<!-- Once you do this, the information on the LSP will  -->

## *EXTRA*

### Using Latex on LunarVim

Besides Julia, you might want to write Latex with LunarVim.
To do so, install the `vimtex` plugin (it's already in the configurations).

Some extra notes on the configuration.
Lsp comes with several pre-set configurations, which
might be quite annoying. For example,
when altering `latex` files, there will be
snippets to things like `.` or `,`, which
autocompletes every time you press Enter.
Thus, this configuration line
`lvim.builtin.cmp.confirm_opts.select = false`
alters this behaviour to leave Enter as "skip line" as default.

<!-- one can manually disable them by going to -->
<!-- `~/.local/share/lunarvim/site/pack/packer/start/friendly-snippets/snippets` -->
<!-- and commenting out the referred snippet. -->

When enabling autopairs, another annoying configuration is the completion for '$'
which doesn't allow you to properly delete the dollar sign.
You can go to
`~/.local/share/lunarvim/lvim/lua/core/autopairs.lua`, and comment
the line `:with_del(cond.not_after_regex_check "xx") -- disable  add newline when press <cr>`.
Note that autopairs also causes problems with the previous configuration
line that fixes the autocompletion on Latex. You might wish to not use autopairs all together,
or (as I  did), comment the lines related to Latex and the Enter autocompletion on autopairs.
My modified `autopairs.lua` can be found in this GitHub repo.

One might be interested in using different compilation
engines for Latex. For example, you might want to use lualatex.
For this, write `%! TeX program = lualatex` in the top of the main Latex file.
Then, `vimtex` will use lualatex.

### Useful shortcuts
It's not always clear every shortcut you might need. Here is a list
of some unusual yet useful shortcuts:

#### Coding
* `Shift + k` - Opens the documentation for a function;

#### Floating terminal
* `Ctrl+\+n` - When inside the floating terminal, if you press this you will go to Normal mode;


#### Latex
* `\+l` - When in a Latex file, the `\` is what `vimtex` calls `<localleader>`. The `\+l` is the default shortcut to many of `vimtex`commands;
* `\+l+e` - This runs the `:VimtexErros` which toggles the bottom menu that pops-up when compiling the Latex script;

#### Explorer - NerdTree
* `shift+r` inside the explorer - Updates the explorer to show changes that happened, such as new files and folders;
* `a` inside the explorer - Creates new file;
* `d` inside the explorer - Deletes file;
* `r` inside the explorer - Renames file.

### Spell checks
By default, the spell check is probably disabled. You can start
it by running the command `:set spell`. In the configuration file,
I created a shortcut using `<F2>`, so pressing F2 will
either enable or disable the spelling check. Besides
English, you might be interested in having spelling using
other languages. In my case, I added support for
Portuguese.

(Working method)
Besides the shortcuts, you'll need to download the `.spl` file for your native language.
For example, if you want to install the portuguese spell checker, then just
enter into LunarVim and use the command `:set spelllang=pt`. Once you do this, LunarVim
will check whether you have the `.spl` file, and in case you don't have it, it will ask
whether you want to download it. Just accept it and wait for the download. The file will
be saved at `~/.local/share/nvim/runtime/spell/`. You might get a message saying that
the download failed, but check the folder, cause it might actually have worked.
Once this is done, you are ready.
In the configurations I added the shortcut `<F3>` for Portuguese and `<F4>`
for English. Hence, you can quickly change between both, while `<F2>` toggles the spell checker.


(Old)
I've downloaded the file `pt.utf-8.spl` from
`http://ftp.vim.org/pub/vim/runtime/spell/pt.utf-8.spl`
and placed the file inside `~/.local/share/nvim/site/spell`.
Using the command `:set spelllang=pt`, you change
the language to Portuguese. Again,
in the configurations
I added the shortcut `<F3>` for Portuguese and `<F4>`
for English. Hence, you can quickly change between both.
