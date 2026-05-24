# config.nu

# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
# # Prompt configuration


alias py = python3
alias pipi = pip install
alias pipli = pip list
alias pipr = pip uninstall
alias reqs = pip freeze > requirements.txt
alias uvr = uv run

alias ff = fastfetch

alias .. = cd ..
alias ... = cd ../..
alias ~ = cd ~
alias la = ls -a

alias update = doas pacman -Syu
alias ins = doas pacman -S

alias cls = clear
alias clea = clear
alias grep = grep --color=auto
alias df = df -h
alias feh = feh --geometry 800x600+200+200
alias clock = tty-clock -b -c -C 7

alias cltg = rm file* tgnet.dat userconfing.xml


$env.config.color_config = {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: white
    empty: white
    bool: light_cyan
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: white
    record: white
    list: white
    closure: white
    glob: cyan_bold
    block: white
    hints: dark_gray
    search_result: { bg: red fg: white }
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: white
    shape_custom: white
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: white
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
    shape_garbage: {
        fg: white
        bg: red
        attr: b
    }
}

$env.config.show_banner = false

$env.config.edit_mode = "vi"

# $env.LS_COLORS = "di=37:fi=37:ex=31:*.toml=33"
$env.LS_COLORS = (vivid generate modus-vivendi)

$env.PROMPT_COMMAND = {
    let bold = "\e[1m"
    let white = "\e[38;2;255;255;255m"
    let reset = "\e[0m"
    $"($bold)($white)λ> ($reset)"
}

$env.PROMPT_COMMAND_RIGHT = {||
    (pwd | path basename)
}
const pi = 3.1415926535897932

const exp = 2.7182818284590452
