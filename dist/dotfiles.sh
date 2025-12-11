#!/bin/bash

cat > ~/.config/nvim/lua/config/options.lua << 'EOT'
vim.opt.relativenumber = true
EOT

cat > ~/.config/nvim/lua/config/keymaps.lua << 'EOT'
-- 1. Define the map function FIRST
local map = vim.keymap.set

-- 2. NOW we can use it

-- Move Lines (VS Code Style with Alt+Arrows)
-- Normal Mode
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })

-- Insert Mode
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

-- Visual Mode
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


-- (Optional) If you also want to keep the Alt+j/k mappings:
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
EOT

cat > ~/.config/yazi/theme.toml << 'EOT'
[mgr]
cwd = { fg = "#94e2d5" }

hovered         = { fg = "#1e1e2e", bg = "#cba6f7" }
preview_hovered = { fg = "#1e1e2e", bg = "#cdd6f4" }

find_keyword  = { fg = "#f9e2af", italic = true }
find_position = { fg = "#f5c2e7", bg = "reset", italic = true }

marker_copied   = { fg = "#a6e3a1", bg = "#a6e3a1" }
marker_cut      = { fg = "#f38ba8", bg = "#f38ba8" }
marker_marked   = { fg = "#94e2d5", bg = "#94e2d5" }
marker_selected = { fg = "#cba6f7", bg = "#cba6f7" }

count_copied   = { fg = "#1e1e2e", bg = "#a6e3a1" }
count_cut      = { fg = "#1e1e2e", bg = "#f38ba8" }
count_selected = { fg = "#1e1e2e", bg = "#cba6f7" }

border_symbol = "│"
border_style  = { fg = "#7f849c" }

syntect_theme = "~/.config/yazi/Catppuccin-mocha.tmTheme"

[tabs]
active   = { fg = "#1e1e2e", bg = "#cdd6f4", bold = true }
inactive = { fg = "#cdd6f4", bg = "#45475a" }

[mode]
normal_main = { fg = "#1e1e2e", bg = "#cba6f7", bold = true }
normal_alt  = { fg = "#cba6f7", bg = "#313244"}

select_main = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }
select_alt  = { fg = "#a6e3a1", bg = "#313244"}

unset_main  = { fg = "#1e1e2e", bg = "#f2cdcd", bold = true }
unset_alt   = { fg = "#f2cdcd", bg = "#313244"}

[status]
sep_left  = { open = "", close = "" }
sep_right = { open = "", close = "" }

progress_label  = { fg = "#ffffff", bold = true }
progress_normal = { fg = "#89b4fa", bg = "#45475a" }
progress_error  = { fg = "#f38ba8", bg = "#45475a" }

perm_type  = { fg = "#89b4fa" }
perm_read  = { fg = "#f9e2af" }
perm_write = { fg = "#f38ba8" }
perm_exec  = { fg = "#a6e3a1" }
perm_sep   = { fg = "#7f849c" }

[input]
border   = { fg = "#cba6f7" }
title    = {}
value    = {}
selected = { reversed = true }

[pick]
border   = { fg = "#cba6f7" }
active   = { fg = "#f5c2e7" }
inactive = {}

[confirm]
border     = { fg = "#cba6f7" }
title      = { fg = "#cba6f7" }
content    = {}
list       = {}
btn_yes    = { reversed = true }
btn_no     = {}

[cmp]
border = { fg = "#cba6f7" }

[tasks]
border  = { fg = "#cba6f7" }
title   = {}
hovered = { underline = true }

[which]
mask            = { bg = "#313244" }
cand            = { fg = "#94e2d5" }
rest            = { fg = "#9399b2" }
desc            = { fg = "#f5c2e7" }
separator       = "  "
separator_style = { fg = "#585b70" }

[help]
on      = { fg = "#94e2d5" }
run     = { fg = "#f5c2e7" }
desc    = { fg = "#9399b2" }
hovered = { bg = "#585b70", bold = true }
footer  = { fg = "#cdd6f4", bg = "#45475a" }

[notify]
title_info  = { fg = "#94e2d5" }
title_warn  = { fg = "#f9e2af" }
title_error = { fg = "#f38ba8" }

[filetype]
rules = [
	# Media
	{ mime = "image/*", fg = "#94e2d5" },
	{ mime = "{audio,video}/*", fg = "#f9e2af" },

	# Archives
	{ mime = "application/*zip", fg = "#f5c2e7" },
	{ mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}", fg = "#f5c2e7" },

	# Documents
	{ mime = "application/{pdf,doc,rtf}", fg = "#a6e3a1" },

	# Fallback
	{ name = "*", fg = "#cdd6f4" },
	{ name = "*/", fg = "#cba6f7" }
]

[spot]
border = { fg = "#cba6f7" }
title  = { fg = "#cba6f7" }
tbl_cell = { fg = "#cba6f7", reversed = true }
tbl_col = { bold = true }

[icon]
files = [
  { name = "kritadisplayrc", text = "", fg = "#cba6f7" },
  { name = ".gtkrc-2.0", text = "", fg = "#f5e0dc" },
  { name = "bspwmrc", text = "", fg = "#313244" },
  { name = "webpack", text = "󰜫", fg = "#74c7ec" },
  { name = "tsconfig.json", text = "", fg = "#74c7ec" },
  { name = ".vimrc", text = "", fg = "#a6e3a1" },
  { name = "gemfile$", text = "", fg = "#313244" },
  { name = "xmobarrc", text = "", fg = "#f38ba8" },
  { name = "avif", text = "", fg = "#7f849c" },
  { name = "fp-info-cache", text = "", fg = "#f5e0dc" },
  { name = ".zshrc", text = "", fg = "#a6e3a1" },
  { name = "robots.txt", text = "󰚩", fg = "#6c7086" },
  { name = "dockerfile", text = "󰡨", fg = "#89b4fa" },
  { name = ".git-blame-ignore-revs", text = "", fg = "#fab387" },
  { name = ".nvmrc", text = "", fg = "#a6e3a1" },
  { name = "hyprpaper.conf", text = "", fg = "#74c7ec" },
  { name = ".prettierignore", text = "", fg = "#89b4fa" },
  { name = "rakefile", text = "", fg = "#313244" },
  { name = "code_of_conduct", text = "", fg = "#f38ba8" },
  { name = "cmakelists.txt", text = "", fg = "#cdd6f4" },
  { name = ".env", text = "", fg = "#f9e2af" },
  { name = "copying.lesser", text = "", fg = "#f9e2af" },
  { name = "readme", text = "󰂺", fg = "#f5e0dc" },
  { name = "settings.gradle", text = "", fg = "#585b70" },
  { name = "gruntfile.coffee", text = "", fg = "#fab387" },
  { name = ".eslintignore", text = "", fg = "#585b70" },
  { name = "kalgebrarc", text = "", fg = "#89b4fa" },
  { name = "kdenliverc", text = "", fg = "#89b4fa" },
  { name = ".prettierrc.cjs", text = "", fg = "#89b4fa" },
  { name = "cantorrc", text = "", fg = "#89b4fa" },
  { name = "rmd", text = "", fg = "#74c7ec" },
  { name = "vagrantfile$", text = "", fg = "#6c7086" },
  { name = ".Xauthority", text = "", fg = "#fab387" },
  { name = "prettier.config.ts", text = "", fg = "#89b4fa" },
  { name = "node_modules", text = "", fg = "#f38ba8" },
  { name = ".prettierrc.toml", text = "", fg = "#89b4fa" },
  { name = "build.zig.zon", text = "", fg = "#fab387" },
  { name = ".ds_store", text = "", fg = "#45475a" },
  { name = "PKGBUILD", text = "", fg = "#89b4fa" },
  { name = ".prettierrc", text = "", fg = "#89b4fa" },
  { name = ".bash_profile", text = "", fg = "#a6e3a1" },
  { name = ".npmignore", text = "", fg = "#f38ba8" },
  { name = ".mailmap", text = "󰊢", fg = "#fab387" },
  { name = ".codespellrc", text = "󰓆", fg = "#a6e3a1" },
  { name = "svelte.config.js", text = "", fg = "#fab387" },
  { name = "eslint.config.ts", text = "", fg = "#585b70" },
  { name = "config", text = "", fg = "#7f849c" },
  { name = ".gitlab-ci.yml", text = "", fg = "#fab387" },
  { name = ".gitconfig", text = "", fg = "#fab387" },
  { name = "_gvimrc", text = "", fg = "#a6e3a1" },
  { name = ".xinitrc", text = "", fg = "#fab387" },
  { name = "checkhealth", text = "󰓙", fg = "#89b4fa" },
  { name = "sxhkdrc", text = "", fg = "#313244" },
  { name = ".bashrc", text = "", fg = "#a6e3a1" },
  { name = "tailwind.config.mjs", text = "󱏿", fg = "#74c7ec" },
  { name = "ext_typoscript_setup.txt", text = "", fg = "#fab387" },
  { name = "commitlint.config.ts", text = "󰜘", fg = "#94e2d5" },
  { name = "py.typed", text = "", fg = "#f9e2af" },
  { name = ".nanorc", text = "", fg = "#313244" },
  { name = "commit_editmsg", text = "", fg = "#fab387" },
  { name = ".luaurc", text = "", fg = "#89b4fa" },
  { name = "fp-lib-table", text = "", fg = "#f5e0dc" },
  { name = ".editorconfig", text = "", fg = "#f5e0dc" },
  { name = "justfile", text = "", fg = "#7f849c" },
  { name = "kdeglobals", text = "", fg = "#89b4fa" },
  { name = "license.md", text = "", fg = "#f9e2af" },
  { name = ".clang-format", text = "", fg = "#7f849c" },
  { name = "docker-compose.yaml", text = "󰡨", fg = "#89b4fa" },
  { name = "copying", text = "", fg = "#f9e2af" },
  { name = "go.mod", text = "", fg = "#74c7ec" },
  { name = "lxqt.conf", text = "", fg = "#89b4fa" },
  { name = "brewfile", text = "", fg = "#313244" },
  { name = "gulpfile.coffee", text = "", fg = "#f38ba8" },
  { name = ".dockerignore", text = "󰡨", fg = "#89b4fa" },
  { name = ".settings.json", text = "", fg = "#6c7086" },
  { name = "tailwind.config.js", text = "󱏿", fg = "#74c7ec" },
  { name = ".clang-tidy", text = "", fg = "#7f849c" },
  { name = ".gvimrc", text = "", fg = "#a6e3a1" },
  { name = "nuxt.config.cjs", text = "󱄆", fg = "#a6e3a1" },
  { name = "xsettingsd.conf", text = "", fg = "#fab387" },
  { name = "nuxt.config.js", text = "󱄆", fg = "#a6e3a1" },
  { name = "eslint.config.cjs", text = "", fg = "#585b70" },
  { name = "sym-lib-table", text = "", fg = "#f5e0dc" },
  { name = ".condarc", text = "", fg = "#a6e3a1" },
  { name = "xmonad.hs", text = "", fg = "#f38ba8" },
  { name = "tmux.conf", text = "", fg = "#a6e3a1" },
  { name = "xmobarrc.hs", text = "", fg = "#f38ba8" },
  { name = ".prettierrc.yaml", text = "", fg = "#89b4fa" },
  { name = ".pre-commit-config.yaml", text = "󰛢", fg = "#fab387" },
  { name = "i3blocks.conf", text = "", fg = "#f5e0dc" },
  { name = "xorg.conf", text = "", fg = "#fab387" },
  { name = ".zshenv", text = "", fg = "#a6e3a1" },
  { name = "vlcrc", text = "󰕼", fg = "#fab387" },
  { name = "license", text = "", fg = "#f9e2af" },
  { name = "unlicense", text = "", fg = "#f9e2af" },
  { name = "tmux.conf.local", text = "", fg = "#a6e3a1" },
  { name = ".SRCINFO", text = "󰣇", fg = "#89b4fa" },
  { name = "tailwind.config.ts", text = "󱏿", fg = "#74c7ec" },
  { name = "security.md", text = "󰒃", fg = "#bac2de" },
  { name = "security", text = "󰒃", fg = "#bac2de" },
  { name = ".eslintrc", text = "", fg = "#585b70" },
  { name = "gradle.properties", text = "", fg = "#585b70" },
  { name = "code_of_conduct.md", text = "", fg = "#f38ba8" },
  { name = "PrusaSlicerGcodeViewer.ini", text = "", fg = "#fab387" },
  { name = "PrusaSlicer.ini", text = "", fg = "#fab387" },
  { name = "procfile", text = "", fg = "#7f849c" },
  { name = "mpv.conf", text = "", fg = "#1e1e2e" },
  { name = ".prettierrc.json5", text = "", fg = "#89b4fa" },
  { name = "i3status.conf", text = "", fg = "#f5e0dc" },
  { name = "prettier.config.mjs", text = "", fg = "#89b4fa" },
  { name = ".pylintrc", text = "", fg = "#7f849c" },
  { name = "prettier.config.cjs", text = "", fg = "#89b4fa" },
  { name = ".luacheckrc", text = "", fg = "#89b4fa" },
  { name = "containerfile", text = "󰡨", fg = "#89b4fa" },
  { name = "eslint.config.mjs", text = "", fg = "#585b70" },
  { name = "gruntfile.js", text = "", fg = "#fab387" },
  { name = "bun.lockb", text = "", fg = "#f5e0dc" },
  { name = ".gitattributes", text = "", fg = "#fab387" },
  { name = "gruntfile.ts", text = "", fg = "#fab387" },
  { name = "pom.xml", text = "", fg = "#313244" },
  { name = "favicon.ico", text = "", fg = "#f9e2af" },
  { name = "package-lock.json", text = "", fg = "#313244" },
  { name = "build", text = "", fg = "#a6e3a1" },
  { name = "package.json", text = "", fg = "#f38ba8" },
  { name = "nuxt.config.ts", text = "󱄆", fg = "#a6e3a1" },
  { name = "nuxt.config.mjs", text = "󱄆", fg = "#a6e3a1" },
  { name = "mix.lock", text = "", fg = "#7f849c" },
  { name = "makefile", text = "", fg = "#7f849c" },
  { name = "gulpfile.js", text = "", fg = "#f38ba8" },
  { name = "lxde-rc.xml", text = "", fg = "#9399b2" },
  { name = "kritarc", text = "", fg = "#cba6f7" },
  { name = "gtkrc", text = "", fg = "#f5e0dc" },
  { name = "ionic.config.json", text = "", fg = "#89b4fa" },
  { name = ".prettierrc.mjs", text = "", fg = "#89b4fa" },
  { name = ".prettierrc.yml", text = "", fg = "#89b4fa" },
  { name = ".npmrc", text = "", fg = "#f38ba8" },
  { name = "weston.ini", text = "", fg = "#f9e2af" },
  { name = "gulpfile.babel.js", text = "", fg = "#f38ba8" },
  { name = "i18n.config.ts", text = "󰗊", fg = "#7f849c" },
  { name = "commitlint.config.js", text = "󰜘", fg = "#94e2d5" },
  { name = ".gitmodules", text = "", fg = "#fab387" },
  { name = "gradle-wrapper.properties", text = "", fg = "#585b70" },
  { name = "hypridle.conf", text = "", fg = "#74c7ec" },
  { name = "vercel.json", text = "▲", fg = "#f5e0dc" },
  { name = "hyprlock.conf", text = "", fg = "#74c7ec" },
  { name = "go.sum", text = "", fg = "#74c7ec" },
  { name = "kdenlive-layoutsrc", text = "", fg = "#89b4fa" },
  { name = "gruntfile.babel.js", text = "", fg = "#fab387" },
  { name = "compose.yml", text = "󰡨", fg = "#89b4fa" },
  { name = "i18n.config.js", text = "󰗊", fg = "#7f849c" },
  { name = "readme.md", text = "󰂺", fg = "#f5e0dc" },
  { name = "gradlew", text = "", fg = "#585b70" },
  { name = "go.work", text = "", fg = "#74c7ec" },
  { name = "gulpfile.ts", text = "", fg = "#f38ba8" },
  { name = "gnumakefile", text = "", fg = "#7f849c" },
  { name = "FreeCAD.conf", text = "", fg = "#f38ba8" },
  { name = "compose.yaml", text = "󰡨", fg = "#89b4fa" },
  { name = "eslint.config.js", text = "", fg = "#585b70" },
  { name = "hyprland.conf", text = "", fg = "#74c7ec" },
  { name = "docker-compose.yml", text = "󰡨", fg = "#89b4fa" },
  { name = "groovy", text = "", fg = "#585b70" },
  { name = "QtProject.conf", text = "", fg = "#a6e3a1" },
  { name = "platformio.ini", text = "", fg = "#fab387" },
  { name = "build.gradle", text = "", fg = "#585b70" },
  { name = ".nuxtrc", text = "󱄆", fg = "#a6e3a1" },
  { name = "_vimrc", text = "", fg = "#a6e3a1" },
  { name = ".zprofile", text = "", fg = "#a6e3a1" },
  { name = ".xsession", text = "", fg = "#fab387" },
  { name = "prettier.config.js", text = "", fg = "#89b4fa" },
  { name = ".babelrc", text = "", fg = "#f9e2af" },
  { name = "workspace", text = "", fg = "#a6e3a1" },
  { name = ".prettierrc.json", text = "", fg = "#89b4fa" },
  { name = ".prettierrc.js", text = "", fg = "#89b4fa" },
  { name = ".Xresources", text = "", fg = "#fab387" },
  { name = ".gitignore", text = "", fg = "#fab387" },
  { name = ".justfile", text = "", fg = "#7f849c" },
]
exts = [
  { name = "otf", text = "", fg = "#f5e0dc" },
  { name = "import", text = "", fg = "#f5e0dc" },
  { name = "krz", text = "", fg = "#cba6f7" },
  { name = "adb", text = "", fg = "#94e2d5" },
  { name = "ttf", text = "", fg = "#f5e0dc" },
  { name = "webpack", text = "󰜫", fg = "#74c7ec" },
  { name = "dart", text = "", fg = "#585b70" },
  { name = "vsh", text = "", fg = "#7f849c" },
  { name = "doc", text = "󰈬", fg = "#585b70" },
  { name = "zsh", text = "", fg = "#a6e3a1" },
  { name = "ex", text = "", fg = "#7f849c" },
  { name = "hx", text = "", fg = "#fab387" },
  { name = "fodt", text = "", fg = "#74c7ec" },
  { name = "mojo", text = "", fg = "#fab387" },
  { name = "templ", text = "", fg = "#f9e2af" },
  { name = "nix", text = "", fg = "#74c7ec" },
  { name = "cshtml", text = "󱦗", fg = "#585b70" },
  { name = "fish", text = "", fg = "#585b70" },
  { name = "ply", text = "󰆧", fg = "#7f849c" },
  { name = "sldprt", text = "󰻫", fg = "#a6e3a1" },
  { name = "gemspec", text = "", fg = "#313244" },
  { name = "mjs", text = "", fg = "#f9e2af" },
  { name = "csh", text = "", fg = "#585b70" },
  { name = "cmake", text = "", fg = "#cdd6f4" },
  { name = "fodp", text = "", fg = "#fab387" },
  { name = "vi", text = "", fg = "#f9e2af" },
  { name = "msf", text = "", fg = "#89b4fa" },
  { name = "blp", text = "󰺾", fg = "#89b4fa" },
  { name = "less", text = "", fg = "#45475a" },
  { name = "sh", text = "", fg = "#585b70" },
  { name = "odg", text = "", fg = "#f9e2af" },
  { name = "mint", text = "󰌪", fg = "#a6e3a1" },
  { name = "dll", text = "", fg = "#11111b" },
  { name = "odf", text = "", fg = "#f38ba8" },
  { name = "sqlite3", text = "", fg = "#f5e0dc" },
  { name = "Dockerfile", text = "󰡨", fg = "#89b4fa" },
  { name = "ksh", text = "", fg = "#585b70" },
  { name = "rmd", text = "", fg = "#74c7ec" },
  { name = "wv", text = "", fg = "#74c7ec" },
  { name = "xml", text = "󰗀", fg = "#fab387" },
  { name = "markdown", text = "", fg = "#cdd6f4" },
  { name = "qml", text = "", fg = "#a6e3a1" },
  { name = "3gp", text = "", fg = "#fab387" },
  { name = "pxi", text = "", fg = "#89b4fa" },
  { name = "flac", text = "", fg = "#6c7086" },
  { name = "gpr", text = "", fg = "#cba6f7" },
  { name = "huff", text = "󰡘", fg = "#585b70" },
  { name = "json", text = "", fg = "#f9e2af" },
  { name = "gv", text = "󱁉", fg = "#585b70" },
  { name = "bmp", text = "", fg = "#7f849c" },
  { name = "lock", text = "", fg = "#bac2de" },
  { name = "sha384", text = "󰕥", fg = "#7f849c" },
  { name = "cobol", text = "⚙", fg = "#585b70" },
  { name = "cob", text = "⚙", fg = "#585b70" },
  { name = "java", text = "", fg = "#f38ba8" },
  { name = "cjs", text = "", fg = "#f9e2af" },
  { name = "qm", text = "", fg = "#74c7ec" },
  { name = "ebuild", text = "", fg = "#45475a" },
  { name = "mustache", text = "", fg = "#fab387" },
  { name = "terminal", text = "", fg = "#a6e3a1" },
  { name = "ejs", text = "", fg = "#f9e2af" },
  { name = "brep", text = "󰻫", fg = "#a6e3a1" },
  { name = "rar", text = "", fg = "#fab387" },
  { name = "gradle", text = "", fg = "#585b70" },
  { name = "gnumakefile", text = "", fg = "#7f849c" },
  { name = "applescript", text = "", fg = "#7f849c" },
  { name = "elm", text = "", fg = "#74c7ec" },
  { name = "ebook", text = "", fg = "#fab387" },
  { name = "kra", text = "", fg = "#cba6f7" },
  { name = "tf", text = "", fg = "#585b70" },
  { name = "xls", text = "󰈛", fg = "#585b70" },
  { name = "fnl", text = "", fg = "#f9e2af" },
  { name = "kdbx", text = "", fg = "#a6e3a1" },
  { name = "kicad_pcb", text = "", fg = "#f5e0dc" },
  { name = "cfg", text = "", fg = "#7f849c" },
  { name = "ape", text = "", fg = "#74c7ec" },
  { name = "org", text = "", fg = "#94e2d5" },
  { name = "yml", text = "", fg = "#7f849c" },
  { name = "swift", text = "", fg = "#fab387" },
  { name = "eln", text = "", fg = "#7f849c" },
  { name = "sol", text = "", fg = "#74c7ec" },
  { name = "awk", text = "", fg = "#585b70" },
  { name = "7z", text = "", fg = "#fab387" },
  { name = "apl", text = "⍝", fg = "#fab387" },
  { name = "epp", text = "", fg = "#fab387" },
  { name = "app", text = "", fg = "#45475a" },
  { name = "dot", text = "󱁉", fg = "#585b70" },
  { name = "kpp", text = "", fg = "#cba6f7" },
  { name = "eot", text = "", fg = "#f5e0dc" },
  { name = "hpp", text = "", fg = "#7f849c" },
  { name = "spec.tsx", text = "", fg = "#585b70" },
  { name = "hurl", text = "", fg = "#f38ba8" },
  { name = "cxxm", text = "", fg = "#74c7ec" },
  { name = "c", text = "", fg = "#89b4fa" },
  { name = "fcmacro", text = "", fg = "#f38ba8" },
  { name = "sass", text = "", fg = "#f38ba8" },
  { name = "yaml", text = "", fg = "#7f849c" },
  { name = "xz", text = "", fg = "#fab387" },
  { name = "material", text = "󰔉", fg = "#f38ba8" },
  { name = "json5", text = "", fg = "#f9e2af" },
  { name = "signature", text = "λ", fg = "#fab387" },
  { name = "3mf", text = "󰆧", fg = "#7f849c" },
  { name = "jpg", text = "", fg = "#7f849c" },
  { name = "xpi", text = "", fg = "#fab387" },
  { name = "fcmat", text = "", fg = "#f38ba8" },
  { name = "pot", text = "", fg = "#74c7ec" },
  { name = "bin", text = "", fg = "#45475a" },
  { name = "xlsx", text = "󰈛", fg = "#585b70" },
  { name = "aac", text = "", fg = "#74c7ec" },
  { name = "kicad_sym", text = "", fg = "#f5e0dc" },
  { name = "xcstrings", text = "", fg = "#74c7ec" },
  { name = "lff", text = "", fg = "#f5e0dc" },
  { name = "xcf", text = "", fg = "#585b70" },
  { name = "azcli", text = "", fg = "#6c7086" },
  { name = "license", text = "", fg = "#f9e2af" },
  { name = "jsonc", text = "", fg = "#f9e2af" },
  { name = "xaml", text = "󰙳", fg = "#585b70" },
  { name = "md5", text = "󰕥", fg = "#7f849c" },
  { name = "xm", text = "", fg = "#74c7ec" },
  { name = "sln", text = "", fg = "#6c7086" },
  { name = "jl", text = "", fg = "#7f849c" },
  { name = "ml", text = "", fg = "#fab387" },
  { name = "http", text = "", fg = "#89b4fa" },
  { name = "x", text = "", fg = "#89b4fa" },
  { name = "wvc", text = "", fg = "#74c7ec" },
  { name = "wrz", text = "󰆧", fg = "#7f849c" },
  { name = "csproj", text = "󰪮", fg = "#585b70" },
  { name = "wrl", text = "󰆧", fg = "#7f849c" },
  { name = "wma", text = "", fg = "#74c7ec" },
  { name = "woff2", text = "", fg = "#f5e0dc" },
  { name = "woff", text = "", fg = "#f5e0dc" },
  { name = "tscn", text = "", fg = "#7f849c" },
  { name = "webmanifest", text = "", fg = "#f9e2af" },
  { name = "webm", text = "", fg = "#fab387" },
  { name = "fcbak", text = "", fg = "#f38ba8" },
  { name = "log", text = "󰌱", fg = "#cdd6f4" },
  { name = "wav", text = "", fg = "#74c7ec" },
  { name = "wasm", text = "", fg = "#585b70" },
  { name = "styl", text = "", fg = "#a6e3a1" },
  { name = "gif", text = "", fg = "#7f849c" },
  { name = "resi", text = "", fg = "#f38ba8" },
  { name = "aiff", text = "", fg = "#74c7ec" },
  { name = "sha256", text = "󰕥", fg = "#7f849c" },
  { name = "igs", text = "󰻫", fg = "#a6e3a1" },
  { name = "vsix", text = "", fg = "#6c7086" },
  { name = "vim", text = "", fg = "#a6e3a1" },
  { name = "diff", text = "", fg = "#45475a" },
  { name = "drl", text = "", fg = "#eba0ac" },
  { name = "erl", text = "", fg = "#f38ba8" },
  { name = "vhdl", text = "󰍛", fg = "#a6e3a1" },
  { name = "🔥", text = "", fg = "#fab387" },
  { name = "hrl", text = "", fg = "#f38ba8" },
  { name = "fsi", text = "", fg = "#74c7ec" },
  { name = "mm", text = "", fg = "#74c7ec" },
  { name = "bz", text = "", fg = "#fab387" },
  { name = "vh", text = "󰍛", fg = "#a6e3a1" },
  { name = "kdb", text = "", fg = "#a6e3a1" },
  { name = "gz", text = "", fg = "#fab387" },
  { name = "cpp", text = "", fg = "#74c7ec" },
  { name = "ui", text = "", fg = "#6c7086" },
  { name = "txt", text = "󰈙", fg = "#a6e3a1" },
  { name = "spec.ts", text = "", fg = "#74c7ec" },
  { name = "ccm", text = "", fg = "#f38ba8" },
  { name = "typoscript", text = "", fg = "#fab387" },
  { name = "typ", text = "", fg = "#89dceb" },
  { name = "txz", text = "", fg = "#fab387" },
  { name = "test.ts", text = "", fg = "#74c7ec" },
  { name = "tsx", text = "", fg = "#585b70" },
  { name = "mk", text = "", fg = "#7f849c" },
  { name = "webp", text = "", fg = "#7f849c" },
  { name = "opus", text = "", fg = "#6c7086" },
  { name = "bicep", text = "", fg = "#74c7ec" },
  { name = "ts", text = "", fg = "#74c7ec" },
  { name = "tres", text = "", fg = "#7f849c" },
  { name = "torrent", text = "", fg = "#94e2d5" },
  { name = "cxx", text = "", fg = "#74c7ec" },
  { name = "iso", text = "", fg = "#f2cdcd" },
  { name = "ixx", text = "", fg = "#74c7ec" },
  { name = "hxx", text = "", fg = "#7f849c" },
  { name = "gql", text = "", fg = "#f38ba8" },
  { name = "tmux", text = "", fg = "#a6e3a1" },
  { name = "ini", text = "", fg = "#7f849c" },
  { name = "m3u8", text = "󰲹", fg = "#f38ba8" },
  { name = "image", text = "", fg = "#f2cdcd" },
  { name = "tfvars", text = "", fg = "#585b70" },
  { name = "tex", text = "", fg = "#45475a" },
  { name = "cbl", text = "⚙", fg = "#585b70" },
  { name = "flc", text = "", fg = "#f5e0dc" },
  { name = "elc", text = "", fg = "#7f849c" },
  { name = "test.tsx", text = "", fg = "#585b70" },
  { name = "twig", text = "", fg = "#a6e3a1" },
  { name = "sql", text = "", fg = "#f5e0dc" },
  { name = "test.jsx", text = "", fg = "#74c7ec" },
  { name = "htm", text = "", fg = "#fab387" },
  { name = "gcode", text = "󰐫", fg = "#6c7086" },
  { name = "test.js", text = "", fg = "#f9e2af" },
  { name = "ino", text = "", fg = "#74c7ec" },
  { name = "tcl", text = "󰛓", fg = "#585b70" },
  { name = "cljs", text = "", fg = "#74c7ec" },
  { name = "tsconfig", text = "", fg = "#fab387" },
  { name = "img", text = "", fg = "#f2cdcd" },
  { name = "t", text = "", fg = "#74c7ec" },
  { name = "fcstd1", text = "", fg = "#f38ba8" },
  { name = "out", text = "", fg = "#45475a" },
  { name = "jsx", text = "", fg = "#74c7ec" },
  { name = "bash", text = "", fg = "#a6e3a1" },
  { name = "edn", text = "", fg = "#74c7ec" },
  { name = "rss", text = "", fg = "#fab387" },
  { name = "flf", text = "", fg = "#f5e0dc" },
  { name = "cache", text = "", fg = "#f5e0dc" },
  { name = "sbt", text = "", fg = "#f38ba8" },
  { name = "cppm", text = "", fg = "#74c7ec" },
  { name = "svelte", text = "", fg = "#fab387" },
  { name = "mo", text = "∞", fg = "#7f849c" },
  { name = "sv", text = "󰍛", fg = "#a6e3a1" },
  { name = "ko", text = "", fg = "#f5e0dc" },
  { name = "suo", text = "", fg = "#6c7086" },
  { name = "sldasm", text = "󰻫", fg = "#a6e3a1" },
  { name = "icalendar", text = "", fg = "#313244" },
  { name = "go", text = "", fg = "#74c7ec" },
  { name = "sublime", text = "", fg = "#fab387" },
  { name = "stl", text = "󰆧", fg = "#7f849c" },
  { name = "mobi", text = "", fg = "#fab387" },
  { name = "graphql", text = "", fg = "#f38ba8" },
  { name = "m3u", text = "󰲹", fg = "#f38ba8" },
  { name = "cpy", text = "⚙", fg = "#585b70" },
  { name = "kdenlive", text = "", fg = "#89b4fa" },
  { name = "pyo", text = "", fg = "#f9e2af" },
  { name = "po", text = "", fg = "#74c7ec" },
  { name = "scala", text = "", fg = "#f38ba8" },
  { name = "exs", text = "", fg = "#7f849c" },
  { name = "odp", text = "", fg = "#fab387" },
  { name = "dump", text = "", fg = "#f5e0dc" },
  { name = "stp", text = "󰻫", fg = "#a6e3a1" },
  { name = "step", text = "󰻫", fg = "#a6e3a1" },
  { name = "ste", text = "󰻫", fg = "#a6e3a1" },
  { name = "aif", text = "", fg = "#74c7ec" },
  { name = "strings", text = "", fg = "#74c7ec" },
  { name = "cp", text = "", fg = "#74c7ec" },
  { name = "fsscript", text = "", fg = "#74c7ec" },
  { name = "mli", text = "", fg = "#fab387" },
  { name = "bak", text = "󰁯", fg = "#7f849c" },
  { name = "ssa", text = "󰨖", fg = "#f9e2af" },
  { name = "toml", text = "", fg = "#585b70" },
  { name = "makefile", text = "", fg = "#7f849c" },
  { name = "php", text = "", fg = "#7f849c" },
  { name = "zst", text = "", fg = "#fab387" },
  { name = "spec.jsx", text = "", fg = "#74c7ec" },
  { name = "kbx", text = "󰯄", fg = "#6c7086" },
  { name = "fbx", text = "󰆧", fg = "#7f849c" },
  { name = "blend", text = "󰂫", fg = "#fab387" },
  { name = "ifc", text = "󰻫", fg = "#a6e3a1" },
  { name = "spec.js", text = "", fg = "#f9e2af" },
  { name = "so", text = "", fg = "#f5e0dc" },
  { name = "desktop", text = "", fg = "#45475a" },
  { name = "sml", text = "λ", fg = "#fab387" },
  { name = "slvs", text = "󰻫", fg = "#a6e3a1" },
  { name = "pp", text = "", fg = "#fab387" },
  { name = "ps1", text = "󰨊", fg = "#6c7086" },
  { name = "dropbox", text = "", fg = "#6c7086" },
  { name = "kicad_mod", text = "", fg = "#f5e0dc" },
  { name = "bat", text = "", fg = "#a6e3a1" },
  { name = "slim", text = "", fg = "#fab387" },
  { name = "skp", text = "󰻫", fg = "#a6e3a1" },
  { name = "css", text = "", fg = "#89b4fa" },
  { name = "xul", text = "", fg = "#fab387" },
  { name = "ige", text = "󰻫", fg = "#a6e3a1" },
  { name = "glb", text = "", fg = "#fab387" },
  { name = "ppt", text = "󰈧", fg = "#f38ba8" },
  { name = "sha512", text = "󰕥", fg = "#7f849c" },
  { name = "ics", text = "", fg = "#313244" },
  { name = "mdx", text = "", fg = "#74c7ec" },
  { name = "sha1", text = "󰕥", fg = "#7f849c" },
  { name = "f3d", text = "󰻫", fg = "#a6e3a1" },
  { name = "ass", text = "󰨖", fg = "#f9e2af" },
  { name = "godot", text = "", fg = "#7f849c" },
  { name = "ifb", text = "", fg = "#313244" },
  { name = "cson", text = "", fg = "#f9e2af" },
  { name = "lib", text = "", fg = "#11111b" },
  { name = "luac", text = "", fg = "#74c7ec" },
  { name = "heex", text = "", fg = "#7f849c" },
  { name = "scm", text = "󰘧", fg = "#f5e0dc" },
  { name = "psd1", text = "󰨊", fg = "#7f849c" },
  { name = "sc", text = "", fg = "#f38ba8" },
  { name = "scad", text = "", fg = "#f9e2af" },
  { name = "kts", text = "", fg = "#6c7086" },
  { name = "svh", text = "󰍛", fg = "#a6e3a1" },
  { name = "mts", text = "", fg = "#74c7ec" },
  { name = "nfo", text = "", fg = "#f9e2af" },
  { name = "pck", text = "", fg = "#7f849c" },
  { name = "rproj", text = "󰗆", fg = "#a6e3a1" },
  { name = "rlib", text = "", fg = "#fab387" },
  { name = "cljd", text = "", fg = "#74c7ec" },
  { name = "ods", text = "", fg = "#a6e3a1" },
  { name = "res", text = "", fg = "#f38ba8" },
  { name = "apk", text = "", fg = "#a6e3a1" },
  { name = "haml", text = "", fg = "#f5e0dc" },
  { name = "d.ts", text = "", fg = "#fab387" },
  { name = "razor", text = "󱦘", fg = "#585b70" },
  { name = "rake", text = "", fg = "#313244" },
  { name = "patch", text = "", fg = "#45475a" },
  { name = "cuh", text = "", fg = "#7f849c" },
  { name = "d", text = "", fg = "#f38ba8" },
  { name = "query", text = "", fg = "#a6e3a1" },
  { name = "psb", text = "", fg = "#74c7ec" },
  { name = "nu", text = ">", fg = "#a6e3a1" },
  { name = "mov", text = "", fg = "#fab387" },
  { name = "lrc", text = "󰨖", fg = "#f9e2af" },
  { name = "pyx", text = "", fg = "#89b4fa" },
  { name = "pyw", text = "", fg = "#89b4fa" },
  { name = "cu", text = "", fg = "#a6e3a1" },
  { name = "bazel", text = "", fg = "#a6e3a1" },
  { name = "obj", text = "󰆧", fg = "#7f849c" },
  { name = "pyi", text = "", fg = "#f9e2af" },
  { name = "pyd", text = "", fg = "#f9e2af" },
  { name = "exe", text = "", fg = "#45475a" },
  { name = "pyc", text = "", fg = "#f9e2af" },
  { name = "fctb", text = "", fg = "#f38ba8" },
  { name = "part", text = "", fg = "#94e2d5" },
  { name = "blade.php", text = "", fg = "#f38ba8" },
  { name = "git", text = "", fg = "#fab387" },
  { name = "psd", text = "", fg = "#74c7ec" },
  { name = "qss", text = "", fg = "#a6e3a1" },
  { name = "csv", text = "", fg = "#a6e3a1" },
  { name = "psm1", text = "󰨊", fg = "#7f849c" },
  { name = "dconf", text = "", fg = "#f5e0dc" },
  { name = "config.ru", text = "", fg = "#313244" },
  { name = "prisma", text = "", fg = "#6c7086" },
  { name = "conf", text = "", fg = "#7f849c" },
  { name = "clj", text = "", fg = "#a6e3a1" },
  { name = "o", text = "", fg = "#45475a" },
  { name = "mp4", text = "", fg = "#fab387" },
  { name = "cc", text = "", fg = "#f38ba8" },
  { name = "kicad_prl", text = "", fg = "#f5e0dc" },
  { name = "bz3", text = "", fg = "#fab387" },
  { name = "asc", text = "󰦝", fg = "#6c7086" },
  { name = "png", text = "", fg = "#7f849c" },
  { name = "android", text = "", fg = "#a6e3a1" },
  { name = "pm", text = "", fg = "#74c7ec" },
  { name = "h", text = "", fg = "#7f849c" },
  { name = "pls", text = "󰲹", fg = "#f38ba8" },
  { name = "ipynb", text = "", fg = "#fab387" },
  { name = "pl", text = "", fg = "#74c7ec" },
  { name = "ads", text = "", fg = "#f5e0dc" },
  { name = "sqlite", text = "", fg = "#f5e0dc" },
  { name = "pdf", text = "", fg = "#585b70" },
  { name = "pcm", text = "", fg = "#6c7086" },
  { name = "ico", text = "", fg = "#f9e2af" },
  { name = "a", text = "", fg = "#f5e0dc" },
  { name = "R", text = "󰟔", fg = "#6c7086" },
  { name = "ogg", text = "", fg = "#6c7086" },
  { name = "pxd", text = "", fg = "#89b4fa" },
  { name = "kdenlivetitle", text = "", fg = "#89b4fa" },
  { name = "jxl", text = "", fg = "#7f849c" },
  { name = "nswag", text = "", fg = "#a6e3a1" },
  { name = "nim", text = "", fg = "#f9e2af" },
  { name = "bqn", text = "⎉", fg = "#6c7086" },
  { name = "cts", text = "", fg = "#74c7ec" },
  { name = "fcparam", text = "", fg = "#f38ba8" },
  { name = "rs", text = "", fg = "#fab387" },
  { name = "mpp", text = "", fg = "#74c7ec" },
  { name = "fdmdownload", text = "", fg = "#94e2d5" },
  { name = "pptx", text = "󰈧", fg = "#f38ba8" },
  { name = "jpeg", text = "", fg = "#7f849c" },
  { name = "bib", text = "󱉟", fg = "#f9e2af" },
  { name = "vhd", text = "󰍛", fg = "#a6e3a1" },
  { name = "m", text = "", fg = "#89b4fa" },
  { name = "js", text = "", fg = "#f9e2af" },
  { name = "eex", text = "", fg = "#7f849c" },
  { name = "tbc", text = "󰛓", fg = "#585b70" },
  { name = "astro", text = "", fg = "#f38ba8" },
  { name = "sha224", text = "󰕥", fg = "#7f849c" },
  { name = "xcplayground", text = "", fg = "#fab387" },
  { name = "el", text = "", fg = "#7f849c" },
  { name = "m4v", text = "", fg = "#fab387" },
  { name = "m4a", text = "", fg = "#74c7ec" },
  { name = "cs", text = "󰌛", fg = "#585b70" },
  { name = "hs", text = "", fg = "#7f849c" },
  { name = "tgz", text = "", fg = "#fab387" },
  { name = "fs", text = "", fg = "#74c7ec" },
  { name = "luau", text = "", fg = "#89b4fa" },
  { name = "dxf", text = "󰻫", fg = "#a6e3a1" },
  { name = "download", text = "", fg = "#94e2d5" },
  { name = "cast", text = "", fg = "#fab387" },
  { name = "qrc", text = "", fg = "#a6e3a1" },
  { name = "lua", text = "", fg = "#74c7ec" },
  { name = "lhs", text = "", fg = "#7f849c" },
  { name = "md", text = "", fg = "#cdd6f4" },
  { name = "leex", text = "", fg = "#7f849c" },
  { name = "ai", text = "", fg = "#f9e2af" },
  { name = "lck", text = "", fg = "#bac2de" },
  { name = "kt", text = "", fg = "#6c7086" },
  { name = "bicepparam", text = "", fg = "#7f849c" },
  { name = "hex", text = "", fg = "#6c7086" },
  { name = "zig", text = "", fg = "#fab387" },
  { name = "bzl", text = "", fg = "#a6e3a1" },
  { name = "cljc", text = "", fg = "#a6e3a1" },
  { name = "kicad_dru", text = "", fg = "#f5e0dc" },
  { name = "fctl", text = "", fg = "#f38ba8" },
  { name = "f#", text = "", fg = "#74c7ec" },
  { name = "odt", text = "", fg = "#74c7ec" },
  { name = "conda", text = "", fg = "#a6e3a1" },
  { name = "vala", text = "", fg = "#585b70" },
  { name = "erb", text = "", fg = "#313244" },
  { name = "mp3", text = "", fg = "#74c7ec" },
  { name = "bz2", text = "", fg = "#fab387" },
  { name = "coffee", text = "", fg = "#f9e2af" },
  { name = "cr", text = "", fg = "#f5e0dc" },
  { name = "f90", text = "󱈚", fg = "#585b70" },
  { name = "jwmrc", text = "", fg = "#6c7086" },
  { name = "c++", text = "", fg = "#f38ba8" },
  { name = "fcscript", text = "", fg = "#f38ba8" },
  { name = "fods", text = "", fg = "#a6e3a1" },
  { name = "cue", text = "󰲹", fg = "#f38ba8" },
  { name = "srt", text = "󰨖", fg = "#f9e2af" },
  { name = "info", text = "", fg = "#f9e2af" },
  { name = "hh", text = "", fg = "#7f849c" },
  { name = "sig", text = "λ", fg = "#fab387" },
  { name = "html", text = "", fg = "#fab387" },
  { name = "iges", text = "󰻫", fg = "#a6e3a1" },
  { name = "kicad_wks", text = "", fg = "#f5e0dc" },
  { name = "hbs", text = "", fg = "#fab387" },
  { name = "fcstd", text = "", fg = "#f38ba8" },
  { name = "gresource", text = "", fg = "#f5e0dc" },
  { name = "sub", text = "󰨖", fg = "#f9e2af" },
  { name = "ical", text = "", fg = "#313244" },
  { name = "crdownload", text = "", fg = "#94e2d5" },
  { name = "pub", text = "󰷖", fg = "#f9e2af" },
  { name = "vue", text = "", fg = "#a6e3a1" },
  { name = "gd", text = "", fg = "#7f849c" },
  { name = "fsx", text = "", fg = "#74c7ec" },
  { name = "mkv", text = "", fg = "#fab387" },
  { name = "py", text = "", fg = "#f9e2af" },
  { name = "kicad_sch", text = "", fg = "#f5e0dc" },
  { name = "epub", text = "", fg = "#fab387" },
  { name = "env", text = "", fg = "#f9e2af" },
  { name = "magnet", text = "", fg = "#45475a" },
  { name = "elf", text = "", fg = "#45475a" },
  { name = "fodg", text = "", fg = "#f9e2af" },
  { name = "svg", text = "󰜡", fg = "#fab387" },
  { name = "dwg", text = "󰻫", fg = "#a6e3a1" },
  { name = "docx", text = "󰈬", fg = "#585b70" },
  { name = "pro", text = "", fg = "#f9e2af" },
  { name = "db", text = "", fg = "#f5e0dc" },
  { name = "rb", text = "", fg = "#313244" },
  { name = "r", text = "󰟔", fg = "#6c7086" },
  { name = "scss", text = "", fg = "#f38ba8" },
  { name = "cow", text = "󰆚", fg = "#fab387" },
  { name = "gleam", text = "", fg = "#f5c2e7" },
  { name = "v", text = "󰍛", fg = "#a6e3a1" },
  { name = "kicad_pro", text = "", fg = "#f5e0dc" },
  { name = "liquid", text = "", fg = "#a6e3a1" },
  { name = "zip", text = "", fg = "#fab387" },
]
EOT

cat > ~/.config/hypr/bindings.conf << 'EOT'
$terminal = uwsm app -- $TERMINAL

bindd = SUPER, L, Hyprlock, exec, hyprlock
bindd = SUPER SHIFT, L, Screensaver, exec, omarchy-launch-screensaver
bindd = SUPER, return, Terminal, exec, $terminal --working-directory="$(omarchy-cmd-terminal-cwd)"
bindd = SUPER, E, File manager, exec, $terminal yazi
bindd = SUPER SHIFT, E, File manager, exec, uwsm app -- nautilus --new-window
bindd = SUPER, W, Browser, exec, flatpak run app.zen_browser.zen
bindd = SUPER SHIFT, W, Private Browser, exec, flatpak run app.zen_browser.zen --private-window
bindd = SUPER, S, Music, exec, omarchy-launch-or-focus spotify
bindd = SUPER, T, Activity, exec, $terminal -e btop
bindd = SUPER SHIFT, T, Mission Center, exec, flatpak run io.missioncenter.MissionCenter
# bindd = SUPER, M, Minecraft, exec, java -jar /home/eshayat/Documents/minecraft.jar
bindd = SUPER, O, Obsidian, exec, omarchy-launch-or-focus obsidian "uwsm app -- obsidian -disable-gpu --enable-wayland-ime"
bindd = SUPER, C, Code Editor, exec, code
# bindd = SUPER, Z, Zed, exec, zed
# bindd = SUPER, A, Steam, exec, steam
bindd = SUPER, G, Gapless, exec, flatpak run com.github.neithern.g4music
bindd = SUPER, D, Discord, exec, flatpak run com.discordapp.Discord
EOT

cat > ~/.config/hypr/hypridle.conf << 'EOT'
general {
    lock_cmd = omarchy-lock-screen                          # lock screen and 1password
    before_sleep_cmd = loginctl lock-session                # lock before suspend.
    after_sleep_cmd = hyprctl dispatch dpms on              # to avoid having to press a key twice to turn on the display.
    inhibit_sleep = 3                                       # wait until screen is locked
}

listener {
    timeout = 300                                              # 5min
    on-timeout = pidof hyprlock || omarchy-launch-screensaver  # start screensaver (if we haven't locked already)
}

listener {
    timeout = 1800                       # 30min
    on-timeout = loginctl lock-session # lock screen when timeout has passed
}

# listener {
#      timeout = 330                                             # 5.5min
#      on-timeout = hyprctl dispatch dpms off                    # screen off when timeout has passed
#      on-resume = hyprctl dispatch dpms on && brightnessctl -r  # screen on when activity is detected
# }
EOT

cat > ~/.config/hypr/hyprlock.conf << 'EOT'
source = $HOME/.config/omarchy/current/theme/mocha.conf

animations {
    enabled = true
}

$accent = $text
$accentAlpha = $textAlpha
$font = JetBrainsMono Nerd Font ExtraBold

# GENERAL
general {
  hide_cursor = true
}

# BACKGROUND
background {
  monitor =
  path = $HOME/.config/omarchy/current/background
  blur_passes = 3
  color = $text
}

# TIME
label {
  monitor =
  text = $TIME12
  color = $text
  font_size = 120
  font_family = CaskaydiaMono Nerd Font ExtraBold
  position = 0, -150
  halign = center
  valign = top
}

# DATE
label {
  monitor =
  text = cmd[update:43200000] date +"%A, %d %B %Y"
  color = $text
  font_size = 25
  font_family = CaskaydiaMono Nerd Font ExtraBold
  position = 0, -420
  halign = center
  valign = top
}

# INPUT FIELD
input-field {
  monitor =
  size = 300, 60
  outline_thickness = 4
  dots_size = 0.2
  dots_spacing = 0.2
  dots_center = true
  outer_color = $text
  inner_color = $crust
  font_color = $text
  fade_on_empty = false
  placeholder_text = <span foreground="##$accentAlpha">$USER</span>
  hide_input = false
  check_color = $accent
  fail_color = $red
  fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
  capslock_color = $yellow
  position = 0, -800
  halign = center
  valign = top
}
EOT

cat > ~/.config/hypr/input.conf << 'EOT'
input {
  kb_layout = us
  # kb_options = compose:caps

  # Change speed of keyboard repeat
  repeat_rate = 40
  repeat_delay = 600

  # Start with numlock on by default
  numlock_by_default = true

  # Increase sensitity for mouse/trackpack (default: 0)
  # sensitivity = 0.35

  touchpad {
    # Use natural (inverse) scrolling
    natural_scroll = true

 # Use two-finger clicks for right-click instead of lower-right corner
    clickfinger_behavior = true

    # Control the speed of your scrolling
    scroll_factor = 0.2
  }
}

# Scroll faster in the terminal
windowrule = scrolltouchpad 1.5, tag:terminal

# Enable touchpad gestures for changing workspaces
# See https://wiki.hyprland.org/Configuring/Gestures/
gesture = 3, horizontal, workspace
EOT

cat > ~/.config/hypr/looknfeel.conf << 'EOT'
# Change the default Omarchy look'n'feel

# https://wiki.hyprland.org/Configuring/Variables/#general
general {
    # No gaps between windows
     gaps_in = 2
     gaps_out = 4

    # Use master layout instead of dwindle
    # layout = master
}

# https://wiki.hyprland.org/Configuring/Variables/#decoration
decoration {
    # Use round window corners
     rounding = 8
       # Set the opacity for the focused (active) window
    active_opacity = 0.99

    # Set the opacity for unfocused (inactive) windows
    inactive_opacity = 0.9
}

# https://wiki.hypr.land/Configuring/Dwindle-Layout/
dwindle {
    # Avoid overly wide single-window layouts on wide screens
    # single_window_aspect_ratio = 1 1
}
EOT

cat > ~/.config/hypr/mocha.conf << 'EOT'
$rosewater = rgb(f5e0dc)
$rosewaterAlpha = f5e0dc

$flamingo = rgb(f2cdcd)
$flamingoAlpha = f2cdcd

$pink = rgb(f5c2e7)
$pinkAlpha = f5c2e7

$mauve = rgb(cba6f7)
$mauveAlpha = cba6f7

$red = rgb(f38ba8)
$redAlpha = f38ba8

$maroon = rgb(eba0ac)
$maroonAlpha = eba0ac

$peach = rgb(fab387)
$peachAlpha = fab387

$yellow = rgb(f9e2af)
$yellowAlpha = f9e2af

$green = rgb(a6e3a1)
$greenAlpha = a6e3a1

$teal = rgb(94e2d5)
$tealAlpha = 94e2d5

$sky = rgb(89dceb)
$skyAlpha = 89dceb

$sapphire = rgb(74c7ec)
$sapphireAlpha = 74c7ec

$blue = rgb(89b4fa)
$blueAlpha = 89b4fa

$lavender = rgb(b4befe)
$lavenderAlpha = b4befe

$text = rgb(cdd6f4)
$textAlpha = cdd6f4

$subtext1 = rgb(bac2de)
$subtext1Alpha = bac2de

$subtext0 = rgb(a6adc8)
$subtext0Alpha = a6adc8
$overlay2 = rgb(9399b2)
$overlay2Alpha = 9399b2

$overlay1 = rgb(7f849c)
$overlay1Alpha = 7f849c

$overlay0 = rgb(6c7086)
$overlay0Alpha = 6c7086

$surface2 = rgb(585b70)
$surface2Alpha = 585b70

$surface1 = rgb(45475a)
$surface1Alpha = 45475a

$surface0 = rgb(313244)
$surface0Alpha = 313244

$base = rgb(1e1e2e)
$baseAlpha = 1e1e2e

$mantle = rgb(181825)
$mantleAlpha = 181825

$crust = rgb(11111b)
$crustAlpha = 11111b
EOT

cat > ~/.config/fastfetch/config.jsonc << 'EOT'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "file",
    "source": "~/.config/omarchy/branding/arch_mini.txt",
    "color": { "1": "green" },
    "padding": {
      "top": 0,
      "right": 6,
      "left": 2
    }
  },
  "modules": [
    "break",
   {
      "type": "command",
      "key": "\udb82\udcc7 OS",
      "keyColor": "green",
      "text": "version=$(omarchy-version); echo \"Arch Linux $version\""
    },
    {
      "type": "cpu",
      "key": "│ ├",
      "showPeCoreCount": true,
      "keyColor": "green"
    },
    {
      "type": "disk",
      "key": "│ ├󰋊",
      "keyColor": "green"
    },
    {
      "type": "memory",
      "key": "│ ├",
      "keyColor": "green"
    },
    {
      "type": "uptime",
      "key": "│ ├󱫐",
      "keyColor": "green"
    },
    {
      "type": "packages",
      "key": "│ ├󰏖",
      "keyColor": "green"
    },
    {
      "type": "command",
      "key": "└ └󰸌",
      "keyColor": "green",
      "text": "theme=$(omarchy-theme-current); echo -e \"$theme \\e[38m●\\e[37m●\\e[36m●\\e[35m●\\e[34m●\\e[33m●\\e[32m●\\e[31m●\""
    },
]
}
EOT

cat > ~/.config/fish/config.fish << 'EOT'
zoxide init fish | source
zoxide init fish --cmd cd | source

set -gx PATH $PATH /home/eshayat/.spicetify

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set -gx PATH $HOME/.local/bin $PATH

alias q exit

alias update "sudo pacman -Syu && yay -Syu"

alias ff fastfetch

alias cls clear

alias fishconfig "nvim ~/.config/fish/config.fish"

alias minecraft "java -jar /home/eshayat/Documents/minecraft.jar"

alias mc "java -jar /home/eshayat/Documents/minecraft.jar"

alias python python3

function ls
    eza -l --git --icons --header $argv
end

alias init 'git init'
alias add 'git add .'
alias branch 'git branch -M main'
alias push 'git push -u origin main'

function commit
    git commit -m "$argv"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
EOT

cat > ~/.config/fish/functions/fish_prompt.fish << 'EOT'
# name: Default
# author: Eshayat

function fish_prompt --description 'Write out the simple ➜ ~ prompt'
    set -l normal (set_color normal)

    # ➜ symbol in a color (e.g., blue)
    set -l arrow_color (set_color green)

    set -l pwd_color (set_color green)

    echo -n -s $arrow_color "➜" $normal " " $pwd_color (prompt_pwd) $normal " "
end
EOT

cat > ~/.config/ghostty/config << 'EOT'
# Dynamic theme colors
config-file = ?"~/.config/omarchy/current/theme/ghostty.conf"

# Looks
theme = Catppuccin Mocha

# Font
font-family = "Cascadia Code PL"
font-style = semibold
font-size = 9
font-feature = +liga, +dlig, +calt

# Window
window-padding-x = 14
window-padding-y = 14
confirm-close-surface=false
resize-overlay = never

# Cursor stlying
cursor-style = "bar"
cursor-style-blink = false
shell-integration-features = no-cursor

# Keyboard bindings
keybind = f11=toggle_fullscreen
keybind = ctrl+k=toggle_command_palette
keybind = ctrl+w=close_tab
keybind = ctrl+v=paste_from_clipboard
keybind = ctrl+a=select_all
keybind = ctrl+t=new_tab
keybind = ctrl+tab=next_tab
keybind = ctrl+shift+tab=previous_tab
keybind = ctrl+l=clear_screen
EOT

cat > ~/.XCompose << 'EOT'
include "%H/.local/share/omarchy/default/xcompose"

# Identification
<Multi_key> <space> <n> : "Eshayat Al-Wasiu"
<Multi_key> <space> <e> : "eshayat.wasiu@gmail.com"
<Multi_key> <space> <p> : "01946113366"
EOT

cat > ~/.config/waybar/config.jsonc << 'EOT'
{
  "reload_style_on_change": true,
  "layer": "top",
  "position": "top",
  "spacing": 0,
  "height": 26,
  "modules-left": ["clock" ,"custom/screenrecording-indicator", "custom/update"],
  "modules-center": [
    "custom/omarchy", "hyprland/workspaces",
  ],
  "modules-right": [
    "group/tray-expander",
    "bluetooth",
    "network",
    "pulseaudio",
    "battery",
  ],
  "hyprland/workspaces": {
    "on-click": "activate",
    "format": "{icon}",
    "format-icons": {
      // "default": "",
      // "1": "<b>一</b>",
      // "2": "<b>二</b>",
      // "3": "<b>三</b>",
      // "4": "<b>四</b>",
      // "5": "<b>五</b>",
      // "6": "<b>六</b>",
      // "7": "<b>七</b>",
      // "8": "<b>八</b>",
      // "9": "<b>九</b>",
      // "10": "<b>十</b>",
      // "active": "󱓻",
      "active": "<span font='12'>󰮯</span>",
      "empty": "<span font='8'></span>",
      "default": "󰊠",
    },
    "persistent-workspaces": {
      "1": [],
      "2": [],
      "3": [],
      "4": [],
      "5": [],
    },
  },
  "custom/omarchy": {
    "format": "<span>\udb82\udcc7</span>",
    "on-click": "omarchy-menu",
    "on-click-right": "xdg-terminal-exec",
    "tooltip-format": "Omarchy Menu\n\nSuper + Alt + Space"
  },
  "custom/update": {
    "format": "",
    "exec": "omarchy-update-available",
    "on-click": "omarchy-launch-floating-terminal-with-presentation omarchy-update",
    "tooltip-format": "Omarchy update available",
    "signal": 7,
    "interval": 21600
  },

  "cpu": {
    "interval": 5,
    "format": "󰍛",
    "on-click": "omarchy-launch-or-focus-tui btop"
  },
  "clock": {
    "interval": 1,
    "format": "{:L%I:%M:%S %p} ",
    "format-alt": "{:L%A | %B %d (%Y)} ",
    "tooltip": false,
    "on-click-right": "omarchy-launch-floating-terminal-with-presentation omarchy-tz-select"
  },
  "network": {
    "format-icons": ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"],
    "format": "{icon}",
    "format-wifi": "{icon}",
    "format-ethernet": "󰀂",
    "format-disconnected": "󰤮",
    "tooltip-format-wifi": "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
    "tooltip-format-ethernet": "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
    "tooltip-format-disconnected": "Disconnected",
    "interval": 3,
    "spacing": 1,
    "on-click": "omarchy-launch-wifi"
  },
  "battery": {
    "format": "{capacity}% {icon}",
    "format-discharging": "{icon}",
    "format-charging": "{icon}",
    "format-plugged": "",
    "format-icons": {
      "charging": ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
      "default": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
    },
    "format-full": "󰂅",
    "tooltip-format-discharging": "{power:>1.0f}W↓ {capacity}%",
    "tooltip-format-charging": "{power:>1.0f}W↑ {capacity}%",
    "interval": 5,
    "on-click": "omarchy-menu power",
    "states": {
      "warning": 20,
      "critical": 10
    }
  },
  "bluetooth": {
    "format": "",
    "format-disabled": "󰂲",
    "format-connected": "󰂱",
    "format-no-controller": "",
    "tooltip-format": "Devices connected: {num_connections}",
    "on-click": "omarchy-launch-bluetooth"
  },
  "pulseaudio": {
    "format": "{icon}",
    "on-click": "omarchy-launch-or-focus-tui wiremix",
    "on-click-right": "pamixer -t",
    "tooltip-format": "Playing at {volume}%",
    "scroll-step": 5,
    "format-muted": "",
    "format-icons": {
      "default": ["", "", ""]
    }
  },
  "group/tray-expander": {
    "orientation": "inherit",
    "drawer": {
      "transition-duration": 600,
      "children-class": "tray-group-item"
    },
    "modules": ["custom/expand-icon", "tray"]
  },
  "custom/expand-icon": {
    "format": "",
    "tooltip": false
  },
  "custom/screenrecording-indicator": {
    "on-click": "omarchy-cmd-screenrecord",
    "exec": "$OMARCHY_PATH/default/waybar/indicators/screen-recording.sh",
    "signal": 8,
    "return-type": "json"
  },
  "tray": {
    "icon-size": 12,
    "spacing": 17
  }
}
EOT

cat > ~/.config/waybar/style.css << 'EOT'
@import "../omarchy/current/theme/waybar.css";

* {
    background-color: transparent;
    color: #cdd6f4;
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: "CaskaydiaMono Nerd Font";
    font-size: 14px;
    font-weight: 900;
}

.modules-left {
    margin: 4px 6px;
    padding: 4px;
    border-radius: 8px;
}

.modules-center {
    margin: 4px 6px;
    padding: 4px 8px 4px 4px;
    border-radius: 8px;
}

.modules-right {
    margin: 4px 6px;
    padding: 4px 4px 4px 11px;
    border-radius: 8px;
}

#workspaces button {
    all: initial;
    padding: 0 6px;
    margin: 0 1.5px;
    min-width: 9px;
}

#workspaces button.empty {
    opacity: 0.5;
}

#tray,
#cpu,
#battery,
#network,
#bluetooth,
#pulseaudio,
#custom-omarchy,
#custom-screenrecording-indicator,
#custom-update {
    min-width: 12px;
    margin: 0 7.5px;
}

#custom-expand-icon {
    margin-right: 7px;
}

tooltip {
    padding: 2px;
}

#custom-update {
    font-size: 10px;
}

#clock {
    margin-left: 8.75px;
}

.hidden {
    opacity: 0;
}

#custom-screenrecording-indicator {
    min-width: 12px;
    margin-left: 8.75px;
    font-size: 10px;
}
EOT

cat > ~/.config/walker/config.toml << 'EOT'
force_keyboard_focus = true                                                 # forces keyboard forcus to stay in Walker
close_when_open = true                                                      # close walker when invoking while already opened
selection_wrap = true                                                       # wrap list if at bottom or top
click_to_close = true                                                       # closes walker if clicking outside of the main content area
global_argument_delimiter = "#"                                             # query: firefox#https://benz.dev => part after delimiter will be ignored when querying. this should be the same as in the elephant config
exact_search_prefix = "'"                                                   # disable fuzzy searching
theme = "omarchy-default"                                                   # theme to use
disable_mouse = false                                                       # disable mouse (on input and list only)
additional_theme_location = "~/.local/share/omarchy/default/walker/themes/"

[modules.clipboard]
# detail_panel_width = 0 
hide_detail_panel = true

[shell]
anchor_top = true
anchor_bottom = true
anchor_left = true
anchor_right = true

[placeholders]
"default" = { input = " Search...", list = "No Results" } # placeholders for input and empty list, key is the providers name, so f.e. "desktopapplications" or "menus:other"

[keybinds]
close = ["Escape"]
next = ["Down"]
previous = ["Up"]
toggle_exact = ["ctrl e"]
resume_last_query = ["ctrl r"]
quick_activate = []

[providers]
default = [
  "desktopapplications",
  "menus",
  "websearch",
] # providers to be queried by default
empty = ["desktopapplications"] # providers to be queried when query is empty
max_results = 50 # global max results

[providers.sets] # define your own defaults/empty sets of providers
[providers.max_results_provider] # define max results per provider in here

[[providers.prefixes]]
prefix = "/"
provider = "providerlist"

[[providers.prefixes]]
prefix = "."
provider = "files"

[[providers.prefixes]]
prefix = ":"
provider = "symbols"

[[providers.prefixes]]
prefix = "="
provider = "calc"

[[providers.prefixes]]
prefix = "@"
provider = "websearch"

[[providers.prefixes]]
prefix = "$"
provider = "clipboard"

[providers.actions] # This will be MERGED/OVEWRITTEN with what the user specifies
dmenu = [{ action = "select", default = true, bind = "Return" }]

providerlist = [
  { action = "activate", default = true, bind = "Return", after = "ClearReload" },
]

bluetooth = [
  { action = "find", global = true, bind = "ctrl f", after = "AsyncClearReload" },
  { action = "trust", bind = "ctrl t", after = "AsyncReload" },
  { action = "untrust", bind = "ctrl t", after = "AsyncReload" },
  { action = "pair", bind = "Return", after = "AsyncReload" },
  { action = "remove", bind = "ctrl d", after = "AsyncReload" },
  { action = "connect", bind = "Return", after = "AsyncReload" },
  { action = "disconnect", bind = "Return", after = "AsyncReload" },
]

archlinuxpkgs = [
  { action = "install", bind = "Return", default = true },
  { action = "remove", bind = "Return" },
]

calc = [
  { action = "copy", default = true, bind = "Return" },
  { action = "delete", bind = "ctrl d", after = "AsyncReload" },
  { action = "save", bind = "ctrl s", after = "AsyncClearReload" },
]

websearch = [
  { action = "search", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

desktopapplications = [
  { action = "start", default = true, bind = "Return" },
  { action = "start:keep", label = "open+next", bind = "shift Return", after = "KeepOpen" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "AsyncReload" },
  { action = "pin", bind = "ctrl p", after = "AsyncReload" },
  { action = "unpin", bind = "ctrl p", after = "AsyncReload" },
  { action = "pinup", bind = "ctrl n", after = "AsyncReload" },
  { action = "pindown", bind = "ctrl m", after = "AsyncReload" },
]

files = [
  { action = "open", default = true, bind = "Return" },
  { action = "opendir", label = "open dir", bind = "ctrl Return" },
  { action = "copypath", label = "copy path", bind = "ctrl shift c" },
  { action = "copyfile", label = "copy file", bind = "ctrl c" },
]

todo = [
  { action = "save", default = true, bind = "Return", after = "ClearReload" },
  { action = "delete", bind = "ctrl d", after = "ClearReload" },
  { action = "active", bind = "Return", after = "ClearReload" },
  { action = "inactive", bind = "Return", after = "ClearReload" },
  { action = "done", bind = "ctrl f", after = "ClearReload" },
  { action = "clear", bind = "ctrl x", after = "ClearReload", global = true },
]

runner = [
  { action = "run", default = true, bind = "Return" },
  { action = "runterminal", label = "run in terminal", bind = "shift Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

symbols = [
  { action = "run_cmd", label = "select", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

unicode = [
  { action = "run_cmd", label = "select", default = true, bind = "Return" },
  { action = "erase_history", label = "clear hist", bind = "ctrl h", after = "Reload" },
]

clipboard = [
  { action = "copy", default = true, bind = "Return" },
  { action = "remove", bind = "ctrl d", after = "ClearReload" },
  { action = "remove_all", global = true, label = "clear", bind = "ctrl shift d", after = "ClearReload" },
  { action = "toggle_images", global = true, label = "toggle images", bind = "ctrl i", after = "ClearReload" },
  { action = "edit", bind = "ctrl o" },
]

[builtins.applications]
launch_prefix = "uwsm app -- "
hidden = false


[builtins.custom_commands]
hidden = false


[[builtins.custom_commands.entries]]
label = "RED PILL"
command = "alacritty -e redpill"
keywords = ["redpill","backup","restore","hyprland"]
icon = ""
EOT

cat > ~/.config/swayosd/style.css << 'EOT'
@import "../omarchy/current/theme/swayosd.css";

window {
  border-radius: 0;
  opacity: 0.97;
  border: 2px solid @border-color;

  background-color: @background-color;
}

label {
  font-family: "CaskaydiaMono Nerd Font";
  font-size: 11pt;

  color: @label;
}

image {
  color: @image;
}

progressbar {
  border-radius: 0;
}

progress {
  background-color: @progress;
}
EOT

echo '
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
████                     ████                     ████
████                     ████                     ████
████    █████████████████████         ████████    ████
████    █████████████████████         ████████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████████████                              ████    ████
████████████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ██████████████████████████████████████    ████
████    ██████████████████████████████████████    ████
████                     ████                     ████
████                     ████                     ████
█████████████████████████████     ████████████████████
█████████████████████████████     ████████████████████
' > ~/.config/omarchy/branding/about.txt

echo '
                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `
' > ~/.config/omarchy/branding/arch.txt

cat > ~/.config/omarchy/branding/arch_mini.txt << 'EOT'

        /\
       /  \
      /    \
     /      \
    /   ,,   \
   /   |  |   \
  /_-''    ''-_\
EOT

echo '
 ______    
/\  ___\   
\ \  __\   
 \ \_____\ 
  \/_____/ 
           
 ______    
/\  ___\   
\ \___  \  
 \/\_____\ 
  \/_____/ 
           
 __  __    
/\ \_\ \   
\ \  __ \  
 \ \_\ \_\ 
  \/_/\/_/
' > ~/.config/omarchy/branding/esh.txt

echo '
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
████                     ████                     ████
████                     ████                     ████
████    █████████████████████         ████████    ████
████    █████████████████████         ████████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████████████                              ████    ████
████████████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ██████████████████████████████████████    ████
████    ██████████████████████████████████████    ████
████                     ████                     ████
████                     ████                     ████
█████████████████████████████     ████████████████████
█████████████████████████████     ████████████████████
' > ~/.config/omarchy/branding/omarchy.txt

echo '
   ▄████████    ▄████████    ▄█    █▄       ▄████████ ▄██   ▄      ▄████████     ███     
  ███    ███   ███    ███   ███    ███     ███    ███ ███   ██▄   ███    ███ ▀█████████▄ 
  ███    █▀    ███    █▀    ███    ███     ███    ███ ███▄▄▄███   ███    ███    ▀███▀▀██ 
 ▄███▄▄▄       ███         ▄███▄▄▄▄███▄▄   ███    ███ ▀▀▀▀▀▀███   ███    ███     ███   ▀ 
▀▀███▀▀▀     ▀███████████ ▀▀███▀▀▀▀███▀  ▀███████████ ▄██   ███ ▀███████████     ███     
  ███    █▄           ███   ███    ███     ███    ███ ███   ███   ███    ███     ███     
  ███    ███    ▄█    ███   ███    ███     ███    ███ ███   ███   ███    ███     ███     
  ██████████  ▄████████▀    ███    █▀      ███    █▀   ▀█████▀    ███    █▀     ▄████▀   
' > ~/.config/omarchy/branding/screensaver.txt

echo '
                 ▄▄▄
 ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
███   ███  ███   ███   ███ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
███   ███  ███   ███   ███ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
███   ███  ███   ███   ███  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
 ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀
                                       ███   █▀
' > ~/.config/omarchy/branding/screensaver_og.txt

echo '
exec-once = ollama serve
' >> ~/.local/share/omarchy/default/hypr/autostart.conf

cat > ~/.local/share/omarchy/default/hypr/windows.conf << 'EOT'
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
windowrule = suppressevent maximize, class:.*

# Just dash of opacity by default
windowrule = opacity 0.9 0.87, class:.*

# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

# App-specific tweaks
source = ~/.local/share/omarchy/default/hypr/apps.conf
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/clipboard.conf << 'EOT'
bindd = SUPER, V, Clipboard manager, exec, omarchy-launch-walker -m clipboard
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/utilities.conf << 'EOT'
# Only display the OSD on the currently focused monitor
$osdclient = swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"

# Laptop multimedia keys for volume and LCD brightness (with OSD)
bindeld = ,XF86AudioRaiseVolume, Volume up, exec, $osdclient --output-volume raise
bindeld = ,XF86AudioLowerVolume, Volume down, exec, $osdclient --output-volume lower
bindeld = ,XF86AudioMute, Mute, exec, $osdclient --output-volume mute-toggle
bindeld = ,XF86AudioMicMute, Mute microphone, exec, $osdclient --input-volume mute-toggle
bindeld = ,XF86MonBrightnessUp, Brightness up, exec, $osdclient --brightness raise
bindeld = ,XF86MonBrightnessDown, Brightness down, exec, $osdclient --brightness lower

bindeld = SUPER, page_up, Brightness up, exec, $osdclient --brightness raise
bindeld = SUPER, page_down, Brightness down, exec, $osdclient --brightness lower

# Precise 1% multimedia adjustments with Alt modifier
bindeld = ALT, XF86AudioRaiseVolume, Volume up precise, exec, $osdclient --output-volume +1
bindeld = ALT, XF86AudioLowerVolume, Volume down precise, exec, $osdclient --output-volume -1
bindeld = ALT, XF86MonBrightnessUp, Brightness up precise, exec, $osdclient --brightness +1
bindeld = ALT, XF86MonBrightnessDown, Brightness down precise, exec, $osdclient --brightness -1

# Requires playerctl
bindld = , XF86AudioNext, Next track, exec, $osdclient --playerctl next
bindld = , XF86AudioPause, Pause, exec, $osdclient --playerctl play-pause
bindld = , XF86AudioPlay, Play, exec, $osdclient --playerctl play-pause
bindld = , XF86AudioPrev, Previous track, exec, $osdclient --playerctl previous

# Switch audio output with Super + Mute
bindld = SUPER, XF86AudioMute, Switch audio output, exec, omarchy-cmd-audio-switch
' > ~/.local/share/omarchy/default/hypr/bindings/media.conf
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf << 'EOT'
# Close windows
bindd = SUPER, Q, Close active window, killactive,
bindd = CTRL ALT, DELETE, Close all Windows, exec, omarchy-hyprland-window-close-all

# Control tiling
bindd = SUPER, J, Toggle split, togglesplit, # dwindle
bindd = SUPER, P, Pseudo window, pseudo, # dwindle
bindd = SUPER, F, Toggle floating, togglefloating,
bindd = SUPER SHIFT, F, Force full screen, fullscreen, 0
bindd = SUPER CTRL, F, Tiled full screen, fullscreenstate, 0 2
bindd = SUPER ALT, F, Full width, fullscreen, 1

# Move focus with SUPER + arrow keys
bindd = SUPER, LEFT, Move focus left, movefocus, l
bindd = SUPER, RIGHT, Move focus right, movefocus, r
bindd = SUPER, UP, Move focus up, movefocus, u
bindd = SUPER, DOWN, Move focus down, movefocus, d

# Switch workspaces with SUPER + [0-9]
bindd = SUPER, code:10, Switch to workspace 1, workspace, 1
bindd = SUPER, code:11, Switch to workspace 2, workspace, 2
bindd = SUPER, code:12, Switch to workspace 3, workspace, 3
bindd = SUPER, code:13, Switch to workspace 4, workspace, 4
bindd = SUPER, code:14, Switch to workspace 5, workspace, 5
bindd = SUPER, code:15, Switch to workspace 6, workspace, 6
bindd = SUPER, code:16, Switch to workspace 7, workspace, 7
bindd = SUPER, code:17, Switch to workspace 8, workspace, 8
bindd = SUPER, code:18, Switch to workspace 9, workspace, 9
bindd = SUPER, code:19, Switch to workspace 10, workspace, 10

# Move active window to a workspace with SUPER + SHIFT + [0-9]
bindd = SUPER SHIFT, code:10, Move window to workspace 1, movetoworkspace, 1
bindd = SUPER SHIFT, code:11, Move window to workspace 2, movetoworkspace, 2
bindd = SUPER SHIFT, code:12, Move window to workspace 3, movetoworkspace, 3
bindd = SUPER SHIFT, code:13, Move window to workspace 4, movetoworkspace, 4
bindd = SUPER SHIFT, code:14, Move window to workspace 5, movetoworkspace, 5
bindd = SUPER SHIFT, code:15, Move window to workspace 6, movetoworkspace, 6
bindd = SUPER SHIFT, code:16, Move window to workspace 7, movetoworkspace, 7
bindd = SUPER SHIFT, code:17, Move window to workspace 8, movetoworkspace, 8
bindd = SUPER SHIFT, code:18, Move window to workspace 9, movetoworkspace, 9
bindd = SUPER SHIFT, code:19, Move window to workspace 10, movetoworkspace, 10

# TAB between workspaces
bindd = SUPER, TAB, Next workspace, workspace, e+1
bindd = SUPER SHIFT, TAB, Previous workspace, workspace, e-1
bindd = SUPER CTRL, TAB, Former workspace, workspace, previous

# Swap active window with the one next to it with SUPER + SHIFT + arrow keys
bindd = SUPER SHIFT, LEFT, Swap window to the left, swapwindow, l
bindd = SUPER SHIFT, RIGHT, Swap window to the right, swapwindow, r
bindd = SUPER SHIFT, UP, Swap window up, swapwindow, u
bindd = SUPER SHIFT, DOWN, Swap window down, swapwindow, d

# Cycle through applications on active workspace
bindd = ALT, TAB, Cycle to next window, cyclenext
bindd = ALT SHIFT, TAB, Cycle to prev window, cyclenext, prev
bindd = ALT, TAB, Reveal active window on top, bringactivetotop
bindd = ALT SHIFT, TAB, Reveal active window on top, bringactivetotop

# Resize active window
bindd = SUPER, code:20, Expand window left, resizeactive, -100 0    # - key
bindd = SUPER, code:21, Shrink window left, resizeactive, 100 0     # = key
bindd = SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 -100
bindd = SUPER SHIFT, code:21, Expand window down, resizeactive, 0 100

# Scroll through existing workspaces with SUPER + scroll
bindd = SUPER, mouse_down, Scroll active workspace forward, workspace, e+1
bindd = SUPER, mouse_up, Scroll active workspace backward, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindmd = SUPER, mouse:272, Move window, movewindow
bindmd = SUPER, mouse:273, Resize window, resizewindow

# Toggle groups
bindd = SUPER CTRL, G, Toggle window grouping, togglegroup
bindd = SUPER ALT, G, Move active window out of group, moveoutofgroup

# Join groups
bindd = SUPER ALT, LEFT, Move window to group on left, moveintogroup, l
bindd = SUPER ALT, RIGHT, Move window to group on right, moveintogroup, r
bindd = SUPER ALT, UP, Move window to group on top, moveintogroup, u
bindd = SUPER ALT, DOWN, Move window to group on bottom, moveintogroup, d

# Navigate a single set of grouped windows
bindd = SUPER ALT, TAB, Next window in group, changegroupactive, f
bindd = SUPER ALT SHIFT, TAB, Previous window in group, changegroupactive, b

# Scroll through a set of grouped windows with SUPER + ALT + scroll
bindd = SUPER ALT, mouse_down, Next window in group, changegroupactive, f
bindd = SUPER ALT, mouse_up, Previous window in group, changegroupactive, b

# Activate window in a group by number
bindd = SUPER ALT, 1, Switch to group window 1, changegroupactive, 1
bindd = SUPER ALT, 2, Switch to group window 2, changegroupactive, 2
bindd = SUPER ALT, 3, Switch to group window 3, changegroupactive, 3
bindd = SUPER ALT, 4, Switch to group window 4, changegroupactive, 4
bindd = SUPER ALT, 5, Switch to group window 5, changegroupactive, 5
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/tiling.conf << 'EOT'
# This is now a deprecated file meant for those who did not wish to learn the latest Omarchy hotkeys.
# Do not make changes here, but bring them to tiling-v2.conf instead.

# Close windows
bindd = SUPER, Q, Close active window, killactive,
bindd = CTRL ALT, DELETE, Close all Windows, exec, omarchy-hyprland-window-close-all

# Control tiling
bindd = SUPER, J, Toggle split, togglesplit, # dwindle
bindd = SUPER, P, Pseudo window, pseudo, # dwindle
bindd = SUPER SHIFT, V, Toggle floating, togglefloating,
bindd = SHIFT, F11, Force full screen, fullscreen, 0
bindd = ALT, F11, Full width, fullscreen, 1

# Move focus with SUPER + arrow keys
bindd = SUPER, LEFT, Move focus left, movefocus, l
bindd = SUPER, RIGHT, Move focus right, movefocus, r
bindd = SUPER, UP, Move focus up, movefocus, u
bindd = SUPER, DOWN, Move focus down, movefocus, d

# Switch workspaces with SUPER + [0-9]
bindd = SUPER, code:10, Switch to workspace 1, workspace, 1
bindd = SUPER, code:11, Switch to workspace 2, workspace, 2
bindd = SUPER, code:12, Switch to workspace 3, workspace, 3
bindd = SUPER, code:13, Switch to workspace 4, workspace, 4
bindd = SUPER, code:14, Switch to workspace 5, workspace, 5
bindd = SUPER, code:15, Switch to workspace 6, workspace, 6
bindd = SUPER, code:16, Switch to workspace 7, workspace, 7
bindd = SUPER, code:17, Switch to workspace 8, workspace, 8
bindd = SUPER, code:18, Switch to workspace 9, workspace, 9
bindd = SUPER, code:19, Switch to workspace 10, workspace, 10

# Move active window to a workspace with SUPER + SHIFT + [0-9]
bindd = SUPER SHIFT, code:10, Move window to workspace 1, movetoworkspace, 1
bindd = SUPER SHIFT, code:11, Move window to workspace 2, movetoworkspace, 2
bindd = SUPER SHIFT, code:12, Move window to workspace 3, movetoworkspace, 3
bindd = SUPER SHIFT, code:13, Move window to workspace 4, movetoworkspace, 4
bindd = SUPER SHIFT, code:14, Move window to workspace 5, movetoworkspace, 5
bindd = SUPER SHIFT, code:15, Move window to workspace 6, movetoworkspace, 6
bindd = SUPER SHIFT, code:16, Move window to workspace 7, movetoworkspace, 7
bindd = SUPER SHIFT, code:17, Move window to workspace 8, movetoworkspace, 8
bindd = SUPER SHIFT, code:18, Move window to workspace 9, movetoworkspace, 9
bindd = SUPER SHIFT, code:19, Move window to workspace 10, movetoworkspace, 10

# TAB between workspaces
bindd = SUPER, TAB, Next workspace, workspace, e+1
bindd = SUPER SHIFT, TAB, Previous workspace, workspace, e-1
bindd = SUPER CTRL, TAB, Former workspace, workspace, previous

# Swap active window with the one next to it with SUPER + SHIFT + arrow keys
bindd = SUPER SHIFT, LEFT, Swap window to the left, swapwindow, l
bindd = SUPER SHIFT, RIGHT, Swap window to the right, swapwindow, r
bindd = SUPER SHIFT, UP, Swap window up, swapwindow, u
bindd = SUPER SHIFT, DOWN, Swap window down, swapwindow, d

# Cycle through applications on active workspace
bindd = ALT, TAB, Cycle to next window, cyclenext
bindd = ALT SHIFT, TAB, Cycle to prev window, cyclenext, prev
bindd = ALT, TAB, Reveal active window on top, bringactivetotop
bindd = ALT SHIFT, TAB, Reveal active window on top, bringactivetotop

# Resize active window
bindd = SUPER, code:20, Expand window left, resizeactive, -100 0    # - key
bindd = SUPER, code:21, Shrink window left, resizeactive, 100 0     # = key
bindd = SUPER SHIFT, code:20, Shrink window up, resizeactive, 0 -100
bindd = SUPER SHIFT, code:21, Expand window down, resizeactive, 0 100

# Scroll through existing workspaces with SUPER + scroll
bindd = SUPER, MOUSE_DOWN, Scroll active workspace forward, workspace, e+1
bindd = SUPER, MOUSE_UP, Scroll active workspace backward, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindmd = SUPER, mouse:272, Move window, movewindow
bindmd = SUPER, mouse:273, Resize window, resizewindow
EOT

cat > ~/.local/share/omarchy/default/hypr/bindings/utilities.conf << 'EOT'
# Menus
bindd = SUPER, SPACE, Launch apps, exec, omarchy-launch-walker
bindd = SUPER CTRL, E, Emoji picker, exec, omarchy-launch-walker -m symbols
bindd = SUPER ALT, SPACE, Omarchy menu, exec, omarchy-menu
bindd = SUPER, ESCAPE, Power menu, exec, omarchy-menu system
bindld = , XF86PowerOff, Power menu, exec, omarchy-menu system
bindd = SUPER, K, Show key bindings, exec, omarchy-menu-keybindings
bindd = , XF86Calculator, Calculator, exec, gnome-calculator

# Aesthetics
bindd = SUPER SHIFT, SPACE, Toggle top bar, exec, omarchy-toggle-waybar
bindd = SUPER CTRL, SPACE, Next background in theme, exec, omarchy-theme-bg-next
bindd = SUPER SHIFT CTRL, SPACE, Pick new theme, exec, omarchy-menu theme
bindd = SUPER, BACKSPACE, Toggle window transparency, exec, hyprctl dispatch setprop "address:$(hyprctl activewindow -j | jq -r '.address')" opaque toggle
bindd = SUPER SHIFT, BACKSPACE, Toggle workspace gaps, exec, omarchy-hyprland-workspace-toggle-gaps

# Notifications
bindd = SUPER, COMMA, Dismiss last notification, exec, makoctl dismiss
bindd = SUPER SHIFT, COMMA, Dismiss all notifications, exec, makoctl dismiss --all
bindd = SUPER CTRL, COMMA, Toggle silencing notifications, exec, makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send "Silenced notifications" || notify-send "Enabled notifications"

# Toggle idling
bindd = SUPER CTRL, I, Toggle locking on idle, exec, omarchy-toggle-idle

# Toggle nightlight
bindd = SUPER CTRL, N, Toggle nightlight, exec, omarchy-toggle-nightlight

# Control Apple Display brightness
bindd = CTRL, F1, Apple Display brightness down, exec, omarchy-cmd-apple-display-brightness -5000
bindd = CTRL, F2, Apple Display brightness up, exec, omarchy-cmd-apple-display-brightness +5000
bindd = SHIFT CTRL, F2, Apple Display full brightness, exec, omarchy-cmd-apple-display-brightness +60000

# Captures
bindd = SUPER SHIFT, R, Screenrecording, exec, omarchy-menu screenrecord
bind = SUPER SHIFT, S, exec, hyprshot -m region
bindd = SUPER SHIFT, C, Color picking, exec, pkill hyprpicker || hyprpicker -a

# File sharing
bindd = SUPER ALT, S, Share, exec, omarchy-menu share

# Waybar-less information
bindd = SUPER CTRL, T, Show time, exec, notify-send "    $(date +"%A %I:%M %p  —  %d %B")"
bindd = SUPER CTRL, B, Show battery remaining, exec, notify-send "󰁹    Battery is at $(omarchy-battery-remaining)%"
EOT
