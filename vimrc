" This is the vimrc of Kevin Brink. It sets up my happy settings, but isn't for
" the faint of heart; it does some crazy things, like remapping your navigation
" keys!

" This is just a good spot to dump some vim shortcuts that I have to keep looking up:
" g- : When working with vim undo branches, this goes to the last change,
"      regardless of where it is in the tree
" g+ : Goes forward through the undo tree
" earlier : Goes back a specified COUNT or TIME. For example:
"   earlier 10 : Goes back 10 changes
"   earlier 1h : Goes back to the buffer as it was an hour ago
" later : Goes forward to a count or time
"
"  Folds:
"  zM = globally close all folds
"  zR = globally open all folds
"  zf = create a fold from selection
"
" These are some helpful tips for reformatting code:

" V=  - select text, then reformat with =. Fixes indentation
" =   - will correct alignment of code
" ==  - one line;
" gq  - reformat paragraph. Wraps lines to 80, etc.
"
" :0 put - puts the yanked text at the beginning of a file (line 0)
"
" :tabm [n] - move the tab to a place within the session
"
" :mksession session.vim - Makes a session, including yanked text and opened
"                          files
" :vim -S session.vim    - Reopens that session
"
" Options to change how automatic formatting is done:

" :set formatoptions (default "tcq")
"  - t - textwidth
"  - c - comments (plus leader -- see :help comments)
"  - q - allogw 'gq' to work
"  - n - numbered lists
"  - 2 - keep second line indent
"  - 1 - single letter words on next line
"
" Moving around windows / tabs:
"   -         tabm[#]: Moves a tab to a specific place within the current session
"   - Ctrl-W + [HJKL]: Moves the window all the way left/down/up/right
"
"   To copy selected text to system clipboard:
"       `:w !pbcopy`
"
" # How to use mapping:
" * map = map this key, but *use recursive evaluation*
" * noremap = map this key, but *don't use recursive evaluation*. Use this basically always
"
" * Type :help map-overview for what all the modes are
"
" General thoughts about what functionality I need in a code editor:
"
" * Code / syntax highlighting
"   * Syntastic?
" * Quick jump to files
"   * Perhaps achievable simply by using Vim sessions or 'vim -p `find . -name "*.js"`' or the like
"   * Command-T
" * Git integration; view diff, blame, etc.
" * Autocomplete
"   * YouCompleteMe?
" * Setting / clearing breakpoints
" * Custom functions / macros. Perhaps best sourced into a different file?
" * Tabbing / splitting

set shell=/bin/bash

" Plugins!
call plug#begin('~/.vim/plugged')

" Syntax highlighters:
Plug 'https://github.com/Keithbsmiley/swift.vim.git' " Swift
Plug 'https://github.com/kchmck/vim-coffee-script' " Coffeescript
Plug 'https://github.com/PProvost/vim-ps1.git'     " Powershell
Plug 'https://github.com/pangloss/vim-javascript.git' " Babel, jsx
Plug 'https://github.com/mxw/vim-jsx.git'

Plug 'https://github.com/chrisbra/csv.vim.git'     " CSV magic

Plug 'https://github.com/scrooloose/syntastic.git' " Syntax checker.
Plug 'https://github.com/tpope/vim-fugitive.git' " Git commands
Plug 'https://github.com/godlygeek/tabular'

" Options for commenting plugins:

Plug 'scrooloose/nerdcommenter'
Plug 'https://github.com/tomtom/tcomment_vim.git'
Plug 'https://github.com/tpope/vim-commentary.git'

Plug 'https://github.com/ervandew/supertab'

" Ruby style guide
Plug 'https://github.com/ngmy/vim-rubocop'
" Handy rails shortucts
Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/wincent/command-t'
Plug 'https://github.com/mbbill/undotree'

Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/vim-scripts/LargeFile.git'
Plug 'rust-lang/rust.vim'

"TODO: Plug 'https://github.com/tpope/vim-surround'
"TODO: Plug 'https://github.com/tpope/vim-surround'
"TODO: ECLIM
"TODO: EMMET - Easy html population
"TODO: Sleuth
"TODO: Unimpaired
"Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.sh --clang-completer' } " Add fancy autocomplete

call plug#end()

" Specific settings for syntastic; recommended settings:

set statusline+=%#warningmsg#                 " Not even sure what this is
if v:version > 702
  "set statusline+=%{SyntasticStatuslineFlag()}  " Syntastic error message
endif
set statusline+=%*                            " I think highlight to the end?
set statusline+=%f                            " Relative path name
set statusline+=%=                            " Start right-aligning things here
set statusline+=%P\                             " Percentage through buffer
set statusline+=%l\ %c                        " Line and column, respectively
if has("statusline")
  " This should display the file encoding in the right-hand area
   set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
 endif
set laststatus=2                              " ALWAYS show statusline
set backspace=2

if v:version > 702
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_haml_checkers = ['haml_lint']
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
  "let g:syntastic_javascript_eslint_args='-c /Users/Kevin/.map_eslintrc'
  let g:syntastic_mode_map = { "mode": "active", "active_filetypes": [], "passive_filetypes": ["markdown", "md"] }
  let g:syntastic_python_checkers = ['flake8']
  let g:syntastic_python_flake8_args='--config=/Users/Kevin/Code/cfps-app/source/flake8.config'
  let g:syntastic_ruby_checkers = ['rubocop']


  " see :h syntastic-config-makeprg
  "let g:syntastic_java_javac_
endif

" Skip to next error (Using syntastic)
:noremap 'n :lnext <CR>
:noremap 'N :lprevious <CR>
:noremap 's :SyntasticCheck <CR>

" Reset the default CommandT mappings
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
"let g:CommandTAcceptSelectionSplitMap = '<leader>s'
"let g:CommandTAcceptSelectionVSplitMap = '<leader>n'
let g:CommandTFileScanner = "git"

" Set up netrw styles:
let g:netrw_liststyle = 3
let g:netrw_banner=0
let g:netrw_browse_split = 4 " Probably want 3 instead

" Always split windows vertical when using Gdiff
set diffopt+=vertical

""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global textwidth value
if &diff
  let desired_text_width=999
else
  let desired_text_width=100
endif

set ruler
"execute pathogen#infect()
syntax on
set nowrap " Change the DISPLAY of the text to wrap
" Auto-wrap lines
let &textwidth=desired_text_width
set display+=lastline

"set wrapmargin=0

" This makes it so that existing tabs look like 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2

set lazyredraw " to avoid scrolling problems

set title

if has("autocmd")
  " Vim jumps to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Automatically detect indentation rules and plugins
  " TODO: Is this any better? Doubt it filetype plugin indent on
  "au FileType python set textwidth=9999
  " Format XML when it's the correct filetype
  au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
  " This will retain folds when re-opening. TODO: But doesn't work right now.
  " Erg.
  "autocmd BufWinLeave .* mkview
  "autocmd BufWinEnter .* silent loadview 
  au FileType ruby setl sw=2 sts=2 ts=2
  au FileType haml setl sw=2 sts=2 ts=2
  au FileType scss setl sw=2 sts=2 ts=2
  au FileType coffee setl sw=2 sts=2 ts=2
  au FileType yml setl sw=2 sts=2 ts=2
  au FileType rs set syntax=c
  au FileType js set sw=2 sts=2 ts=2
  au FileType javascript set sw=2 sts=2 ts=2
  au FileType python set sw=4 sts=4 ts=4
  au FileType markdown set wrap lbr nolist
  au FileType markdown noremap k gj
  au FileType markdown noremap l gk
  au FileType markdown noremap 0 g^
  au FileType markdown noremap $ g$
  au FileType markdown set nonumber
  au FileType markdown set tw=999
  " Make the terminal display what we're doing depending on what kind of file we have open
  au FileType * set titlestring=Editor
  au FileType markdown set titlestring=Notes
  au FileType markdown let &colorcolumn=join(range(999 + 1,999),",")
  au FileType markdown set maxmempattern=16472536
  au FileType java set sw=4 ts=4 sts=4
endif

set noro

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd   " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase    " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
"set mouse=a    " Enable mouse usage (all modes)

set hlsearch

" Set up the short message system
set shortmess=f  " Simple shortcut
set shortmess+=l " Simple shortcut
set shortmess+=n " Simple shortcut
set shortmess+=x " Simple shortcut
set shortmess+=t " Simple shortcut
set shortmess+=T " Simple shortcut
set shortmess+=o " Overwrite message for writing a file
set shortmess+=O " Message for reading a file overwrites any previous message
set shortmess+=A " Don't give the "ATTENTION" message when existing swap file

" Nice tab-completion when opening files
set wildmenu
set wildmode=full

" You can set up different colours for all sorts of different highlights here:
" ctermbg / ctermfg is for powershell
highlight Search ctermbg=91 cterm=bold
highlight DiffChange cterm=italic ctermbg=DarkMagenta ctermfg=Black
highlight DiffAdd cterm=bold ctermbg=2 guibg=LightBlue
highlight DiffText ctermbg=4
highlight DiffDelete cterm=underline ctermbg=1 guibg=LightBlue
highlight Visual term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
highlight CursorLine ctermbg=237 cterm=none
highlight ColorColumn ctermbg=236
highlight MatchParen ctermbg=238
highlight PmenuSel ctermfg=256 ctermbg=016
" CTERM COLOURS:
"   0 = black
"   1 = red
"   2 = green
"   3 = yellow
" set termguicolors
" highlight ErrorMsg ctermbg=
" highlight DiffAdd ctermbg=
" highlight Todo ctermbg=

" Highlight the current line
set cul

" Don't save session options
set ssop-=options

" If we want the yank command to copy to the system clipboard:
" set clipboard=unnamed,unnamedplus


" Set colorscheme "
"if &diff
"  colorscheme delek
"else
"  colorscheme evening
"  "colorscheme elflord
"endif
"colorscheme ir_black
" TODO: molokai for java and ruby?
" NOTE: Instead, just use this terminal colorscheme:
" https://github.com/lysyi3m/osx-terminal-themes/blob/master/schemes/Broadcast.terminal

" Set tab-settings

set expandtab
set autoindent " Better than smart / cindent

" Set it so that the cursor is always in the middle of the page vertically "
set scrolloff=9999

" Scroll smoothly horizontally "

set sidescroll=1
set sidescrolloff=15

" Keep folds
set sessionoptions+=folds

let mapleader = "\<Space>"

" Map some navigation keys. This is where everyone else will start going crazy

:noremap j <Left>
:noremap k <down>
:noremap l <Up>
:noremap ; <Right>
:noremap <S-k> <PageDown>
:noremap <S-l> <PageUp>

" Have some tab-related shortcuts "

":noremap <C-t> :tabnew<CR>
:noremap <S-f> gT
:noremap <S-j> gt

" Shorcuts to save, copy, or quit
" Note that this magic probably relies on whatever maddness 'Command-T' does to make <Space> behave
" like a modifier key. Probably won't work without that, I'd guess

" Copy probably only works on Mac...
:noremap <Space>f :w !pbcopy<CR><CR>
:noremap <Space>j :w<CR>
" We want to delete the buffer instead of _just_ closing the file. This cleans up swap files at the
" same time (I think)
:noremap <Space>q :q<CR>
:noremap <Space>g :call GetSet()<CR>
:noremap <Space>r :call RefreshCode()<CR>
:noremap <Space>b :call SetBreakpoint()<CR>
:noremap <Space>x :call ClearBreakpoint()<CR>
:noremap <Space>t :tab sb 

" This maps 'W' to saving with sudo

"ca W w !sudo tee "%"

:noremap <F4> :set hlsearch! hlsearch?<CR>

" Toggle textwidth
:noremap <S-t> :call ToggleTextWidth()<CR>

"" Clear current search
":nnoremap #space->c :let @/ = ""

" Toggle indentation
:noremap <S-y> :call ToggleIndent()<CR>

" Toggle comments
map <C-c> <plug>NERDCommenterInvert

" Run rubocop (Miralaw)
let g:vimrubocop_keymap = 0
nnoremap -r :RuboCop<CR>

" Diff all open windows in current tab
nnoremap -d :call DiffAll()<CR>

" Toggle paste setting
:noremap <S-p> :call InvPaste()<CR>
:noremap <S-o> "0p

" Window-related shortcuts "

:noremap <C-n> :vnew<CR>
:noremap <silent> <C-k> <c-w><Down>
:noremap <silent> <C-l> <c-w><Up>
:noremap <silent> <C-f> <c-w><Left>
:noremap <silent> <C-j> <c-w><Right>
:tnoremap <silent> <C-k> <c-w><Down>
:tnoremap <silent> <C-l> <c-w><Up>
:tnoremap <silent> <C-f> <c-w><Left>
:tnoremap <silent> <C-j> <c-w><Right>

" Resizing windows. "

:noremap <C-u> :wincmd <<CR>
:noremap <C-p> :wincmd ><CR>
:noremap <C-o> :wincmd -<CR>
:noremap <C-i> :wincmd +<CR>

"set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <F5> :set nolist!<CR>

" Stolen from Yanick's configuration: "
set history=1000

" Set up completion customization (Activate with ctrl-n)
"set completeopt=longest,menuone

set number

" Reload files whose mode has changed
set autoread

" Define a breakpoint sign
sign define breakpoint text=*

""" FUNCTIONS: """

""" USED FUNCTIONS: """

 "This function toggles the textwidth between 80 and 999
function ToggleTextWidth()
    if &l:textwidth ># g:desired_text_width + 1
        echom "Setting textwidth to " . g:desired_text_width
        let &textwidth=g:desired_text_width
        if v:version < 703
          return
        endif
        let &colorcolumn=join(range(g:desired_text_width + 1,999),",")
    else
        echom "Setting textwidth to 999"
        set textwidth=999
        if v:version < 703
          return
        endif
        let &colorcolumn=join(range(999 + 1,999),",")
    endif
    set ruler
endfunction

" This function toggles the indentation between 4 and 2
function ToggleIndent()
    if &l:sw ># 2
        echom "Setting indent to 2"
        setl sw=2 sts=2 ts=2
    else
        echom "Setting indent to 4"
        setl sw=4 sts=4 ts=4
    endif
    set ruler
endfunction

function InvPaste()
    if &l:paste == 0
        " Currently off
        set paste
        echom "Setting paste to ON; formatoptions = " . &l:formatoptions
    else
        " Currently on
        set nopaste
        set fo=tcq " Need to reset format options
        echom "Setting paste to OFF; formatoptions = " . &l:formatoptions
    endif
endfunction

function ShowDiff()
    :vnew<CR>
    :read !git diff --cached
    set syntax=git
    execute "normal! gg\<C-w>\<Right>ggC"
endfunction

function DiffAll()
    :windo diffthis
endfunction


" Function to tidy up files such as HTML, XML, and JSON. Currently only supports HTML though:
function Tidy()
    " TODO: If filetype == html...
    :s/<[^>]*>/\r&\r/g
    :g/^$/d
endfunction

function JMeterThat()
    :%s/\([^:]\+\): \(.*\)$/              <elementProp name="\1" elementType="HTTPArgument">\r                <boolProp name="HTTPArgument.always_encode">false<\/boolProp>\r                <stringProp name="Argument.value">\2<\/stringProp>\r                <stringProp name="Argument.metadata">=<\/stringProp>\r                <boolProp name="HTTPArgument.use_equals">true<\/boolProp>\r                <stringProp name="Argument.name">\1<\/stringProp>\r              <\/elementProp>
endfunction

function GetSet()
    ":g/private \([^ ]\+\) \(m_\)\?\(\w\+\)\(.*\);\(.*\)/private \1 \2\3\4;\5\r\r    public \1 get\u\3() {\r        return \2\3;\r    }\r\r    public void set\u\3(\1 \2\3) {\r        this.\2\3 = \2\3;\r    }
    :s/private \(.\+\) \(m_\)\?\(\w\+\)\(.*\);\(.*\)/private \1 \2\3\4;\5\r\r    public \1 get\u\3() {\r        return \2\3;\r    }\r\r    public void set\u\3(\1 \3) {\r        this.\2\3 = \3;\r    }
endfunction

function CloseRight()
    .+1,$tabdo :q
endfunction

function BufferListToFiles()
    %s/^.\{\-\}"/"/
    %s/"\s\+line.*/"
    %s/"\s\+line.*/"
    %s/"\[No Name\]"\n//g
    sort
endfunction

" Encode all the things
function HtmlEncode()
    :%s/¡/\&iexcl;/g
    :%s/¿/\&#0191;/g
    :%s/À/\&#0192;/g
    :%s/Á/\&#0193;/g
    :%s/Â/\&#0194;/g
    :%s/Ã/\&#0195;/g
    :%s/Ä/\&#0196;/g
    :%s/Å/\&#0197;/g
    :%s/Æ/\&#0198;/g
    :%s/Ç/\&#0199;/g
    :%s/È/\&#0200;/g
    :%s/É/\&#0201;/g
    :%s/Ê/\&#0202;/g
    :%s/Ë/\&#0203;/g
    :%s/Ì/\&#0204;/g
    :%s/Í/\&#0205;/g
    :%s/Î/\&#0206;/g
    :%s/Ï/\&#0207;/g
    :%s/Ð/\&#0208;/g
    :%s/Ñ/\&#0209;/g
    :%s/Ò/\&#0210;/g
    :%s/Ó/\&#0211;/g
    :%s/Ô/\&#0212;/g
    :%s/Õ/\&#0213;/g
    :%s/Ö/\&#0214;/g
    :%s/×/\&#0215;/g
    :%s/Ø/\&#0216;/g
    :%s/Ù/\&#0217;/g
    :%s/Ú/\&#0218;/g
    :%s/Û/\&#0219;/g
    :%s/Ü/\&#0220;/g
    :%s/Ý/\&#0221;/g
    :%s/Þ/\&#0222;/g
    :%s/ß/\&#0223;/g
    :%s/à/\&#0224;/g
    :%s/á/\&#0225;/g
    :%s/â/\&#0226;/g
    :%s/ã/\&#0227;/g
    :%s/ä/\&#0228;/g
    :%s/å/\&#0229;/g
    :%s/æ/\&#0230;/g
    :%s/ç/\&#0231;/g
    :%s/è/\&#0232;/g
    :%s/é/\&#0233;/g
    :%s/ê/\&#0234;/g
    :%s/ë/\&#0235;/g
    :%s/ì/\&#0236;/g
    :%s/í/\&#0237;/g
    :%s/î/\&#0238;/g
    :%s/ï/\&#0239;/g
    :%s/ð/\&#0240;/g
    :%s/ñ/\&#0241;/g
    :%s/ò/\&#0242;/g
    :%s/ó/\&#0243;/g
    :%s/ô/\&#0244;/g
    :%s/õ/\&#0245;/g
    :%s/ö/\&#0246;/g
    :%s/÷/\&#0247;/g
    :%s/ø/\&#0248;/g
    :%s/ù/\&#0249;/g
    :%s/ú/\&#0250;/g
    :%s/û/\&#0251;/g
    :%s/ü/\&#0252;/g
    :%s/ý/\&#0253;/g
    :%s/þ/\&#0254;/g
    :%s/ÿ/\&#0255;/g
    :%s/‑/\&#8209;/g
endfunction

let g:last_refreshed = localtime()
let g:refresh_all = 1
function RefreshCode()
    " Get the current, active buffer
    " Figure out if it's console or portal; if it's neither, get the current docker container
    " running. Fail if both or neither are running
    let need_compile = 0
    let bufpath = expand('%:p')
    let project = GetProject(bufpath)
    if len(project) > 0
        echom "Processing " . project . " project"
        " Get all of the active buffers
        let buflist = []
        if g:refresh_all
            for i in range(tabpagenr('$'))
               call extend(buflist, tabpagebuflist(i + 1))
            endfor
        else
            call add(buflist, bufnr("%"))
        endif
        for bufnum in buflist
            let filepath = bufname(bufnum)
            echom "Processing filepath: " . filepath
            " We have a few specific file paths that we do _not_ want to process
            if filepath =~ 'AMSconsole' || filepath =~ 'AMS Utilities'
                echom "    Skipping file, as it's part of our blacklist"
            else
                " Check to see when this file was last 'used' or viewed inside of VIM, as this is a
                " pretty decent shortcut to see whether or not we should really update it
                " Perhaps a more complete way would be to keep a dictionary of all buffers to their
                " corresponding `changedtick` values every time we run this command, and only update
                " those files that have a larger `changedtick` than the last time we ran it
                let bufinfo = getbufinfo(bufnum)[0]
                if bufinfo.lastused > g:last_refreshed && bufinfo.changedtick > 0
                    " Only care about those that are absolutely referenced, as this tends to indicate source
                    " files we've modified, and ignore portal files
                    if filepath =~ '.java$'
                        let need_compile = 1
                        " Backend java source file
                        let file_name = matchstr(filepath, '\w\+\.java')
                        let file_dir = matchstr(filepath, 'com\/.\{-\}\(\/\w\+\.java\)\@=')
                        if len(file_dir) > 0
                            echom "    Processed file_name to be :".file_name
                            echom "    Processed file_dir to be :".file_dir
                            echom "    Trying to copy...."

                            " Make destination directory
                            call system('docker exec ' . project . ' bash -c "mkdir -p /workspace/hot_reload/input/' . file_dir . '"')
                            call system('docker cp "' . filepath . '" ' . project . ':/workspace/hot_reload/input/' . file_dir . '/' . file_name)
                        else
                            echom "    Could not parse file_dir; skipping"
                        endif
                    elseif filepath =~ '.js$' || filepath =~ '.xhtml$' || filepath =~ '.css$' || filepath =~ '.xml$'
                        let file_end = matchstr(filepath, '\(.*/ams-' . project . '/src/main/webapp/\)\@<=.*')
                        echom "    Processed file_end to be :".file_end
                        echom "    Trying to copy...."

                        call system('docker cp "' . filepath . '" ' . project . ':/usr/share/tomcat/webapps/' . project . '/' . file_end)
                    else
                        echom "    Unsupported filetype: ".filepath
                    endif
                else
                    echom "    Skipping file, as it hasn't been used recently (" . g:last_refreshed . " >= " . bufinfo.lastused . "), number of changes = " . bufinfo.changedtick
                endif
            endif
        endfor
        if need_compile
            " Compile
            echom "Compiling..."
            echom system('docker exec ' . project . ' bash -c "sh /workspace/hot_reload.sh"')
            if v:shell_error
                echom "Failed; exiting..."
	            let g:last_refreshed = localtime()
                return
            else
                echom "Done"
            endif
        endif
        " Reload webapp
        echom "Reloading webapp..."
        echom system('docker exec ' . project . ' bash -c "touch /usr/share/tomcat/webapps/' . project . '/WEB-INF/web.xml"')
    else
        " Not sure which project we're working with
        echom "Not sure which project we're working with; exiting..."
    endif
    " Update timestamp
	let g:last_refreshed = localtime()
endfunction

" Function to handle logging statements
let g:breakpoint_num=1
function SetBreakpoint()
    " Figure out which project we're working on
    let bufpath = expand('%:p')
    if bufpath =~ '\.java$'
        let line_number = line('.')
        let file_name = matchstr(bufpath, '\w\+\(\.java$\)\@=')
        let package_name = matchstr(getline(1), '\(package \)\@<=.*\(;.*\)\@=')
        call AddBreakpointForPath('C:\Users\kevin.brink\Code\GSCM\jdb.breakpoints', package_name, file_name, line_number, bufpath)
        " For old console / portal work:
        "let project = GetProject(bufpath)
        "if len(project) > 0
        "    let line_number = line('.')
        "    let file_name = matchstr(bufpath, '\w\+\(\.java$\)\@=')
        "    let package_name = matchstr(getline(1), '\(package \)\@<=.*\(;.*\)\@=')
        "    call AddBreakpointForProject(project, package_name, file_name, line_number, bufpath)
        "else
        "    echom "Not sure which project we're working with; exiting..."
        "endif
    else
        echom "Not a java file; exiting..."
    endif

    " let curr_line_number = line(".")
    " let curr_line_content = getline(curr_line_number)
    " call setline(curr_line_number, 'System.out.println("     LOG: ' . g:logging_count . '");')
    " call append(curr_line_number, curr_line_content)
    " let g:logging_count += 1
endfunction

function AddBreakpointForProject(project, package_name, file_name, line_number, bufpath)
    call AddBreakpointForPath('C:\Users\kevin.brink\Code\ams-' . a:project . '-docker-wrapper\extra-files\jdb.breakpoints', package_name, file_name, line_number, bufpath)
endfunction

function AddBreakpointForPath(breakpoint_file, package_name, file_name, line_number, bufpath)
    call system('echo "stop at ' . a:package_name . '.' . a:file_name . ':' . a:line_number . '" >> "' . a:breakpoint_file . '"')

    " Do we want a quickfix list? :shrug:
    "call system('echo "' . a:bufpath . ':' . a:line_number . ':breakpoint set" >> "C:\Users\kevin.brink\Code\ams-' . a:project . '-docker-wrapper\extra-files\breakpoints.quickfix.list"')
    "cgetfile 'c:/Users/kevin.brink/Code/ams-' . a:project . '-docker-wrapper/extra-files/breakpoints.quickfix.list'

    execute 'sign place '.g:breakpoint_num.' line='.a:line_number.' name=breakpoint group=breakpoints'

    let g:breakpoint_num += 1
    "echom "Successfully added breakpoint ✓"
endfunction

function ClearBreakpoint()
    " Figure out which project we're working on
    let bufpath = expand('%:p')
    if bufpath =~ '\.java$'
        call RemoveBreakpointForPath('C:\Users\kevin.brink\Code\GSCM\jdb.breakpoints', bufpath)
        " For old console / portal work:
        "let project = GetProject(bufpath)
        "if len(project) > 0
        "    call RemoveBreakpointForProject(project, bufpath)
        "else
        "    " Not sure which project we're working with
        "    echom "Not sure which project we're working with; exiting..."
        "endif
    else
        echom "Not a java file; exiting..."
    endif

    " :%s/^System\.out\.println.*\n//g
endfunction

function RemoveBreakpointForProject(project, bufpath)
    call RemoveBreakpointForPath('C:\Users\kevin.brink\Code\ams-' . a:project . '-docker-wrapper\extra-files\jdb.breakpoints', bufpath)
endfunction

function RemoveBreakpointForPath(breakpoint_file, bufpath)
    " First, see if this exact line in this buffer has a sign (and thus a breakpoint)
    let line_number = line('.')
    let buffer = bufnr("%")
    let existing_signs = sign_getplaced(buffer, {'group':'breakpoints', 'lnum':line_number})[0]['signs']

    if len(existing_signs) > 0
        " Get the necessary variables
        let package_name = matchstr(getline(1), '\(package \)\@<=.*\(;.*\)\@=')
        let file_name = matchstr(a:bufpath, '\w\+\(\.java$\)\@=')

        " Clear out the specific breakpoint; we add it a few times because depending on how the
        " running instance of JDB is going, it might have several copies of this same breakpoint
        call system('echo "clear ' . package_name . '.' . file_name . ':' . line_number . '" >> "' . a:breakpoint_file . '"')
        call system('echo "clear ' . package_name . '.' . file_name . ':' . line_number . '" >> "' . a:breakpoint_file . '"')
        call system('echo "clear ' . package_name . '.' . file_name . ':' . line_number . '" >> "' . a:breakpoint_file . '"')

        call sign_unplace('breakpoints', {'id': existing_signs[0]['id'], buffer: buffer})
        echom "Successfully cleared breakpoint ✓"
    else
        " Clear out entire file
        call system('echo -n "" > "' . a:breakpoint_file . '"')
        
        sign unplace * group=breakpoints
        
        " Do we want a quickfix list? :shrug:
        "call system('echo -n "" > "C:\Users\kevin.brink\Code\ams-' . a:project . '-docker-wrapper\extra-files\breakpoints.quickfix.list"')
        "cfile c:/Users/kevin.brink/Code/ams-' . a:project . '-docker-wrapper/extra-files/breakpoints.quickfix.list
        ":cw
        echom "Successfully cleared breakpoints ✓"
    endif
endfunction

function GetProject(bufpath)
    if a:bufpath =~ 'ams-console'
        return 'console'
    elseif a:bufpath =~ 'ams-portal'
        return 'portal'
    else
        let docker_container = system('docker ps -q --filter name=console')
        " If we retrieved anything, we assume console is running
        if len(docker_container) > 0
            return 'console'
        else
            let docker_container = system('docker ps -q --filter name=portal')
            if len(docker_container) > 0
                return 'portal'
            endif
        endif
    endif
endfunction

function ConvertReturnToValidatorError()
    %s/\(\s\+\)return \(.*\);/\1String message = ValidatorUtils.buildErrorMessage(parameter, parentParameter, index, \2);\r\1throw new ValidatorException(new FacesMessage(FacesMessage.SEVERITY_ERROR, message, message));
endfunction

function ConvertLogToPrints()
    %s/^\(\s\+\)logger\.\(\w\+\)(\(.*\));/\1System.out.println("\2: " + \3);/g
endfunction

function ConvertPrintToLogs()
    %s/^\(\s\+\)System.out.println("\(.\{-}\): " + \(.*\));/\1logger.\2(\3);/g
endfunction

function! CleanSql() range
    execute a:firstline.','.a:lastline.'s/\n//g'
    execute a:firstline.'s/\(\,\|LEFT JOIN\|AND\|\<OR\>\|WHERE\|ORDER BY\|\<ON\>\|GROUP BY\)/\1\r    /g'
    "execute a:firstline.','.a:lastline.'s/\(\s*\)\(.*\))/\1\2\r)\r/g'
endfunction

""" LEGACY, UN-USED (But maybe someday helpful?): """

"" Function to change all html codes into their symbol representatives "
"
"function CleanUp()
"  %s/&gt;/>/g
"  %s/&lt;/</g
"  %s/&quot;/"/g
"  %s/&#39;/'/g
"  diffupdate
"endfunction
"
"function TidyJson()
"  %s/\[/\[\r\t\t/g
"  %s/{/{\r\t\t\t\t/g
"  %s/\(},\)/\r\t\t\1\r\t\t/g
"  %s/\(}[^,]\)/\r\t\t\1/g
"  %s/\]/\r\]/g
"endfunction
"
"function FixCComments()
"  %s/\/\/\(.*\)/\/*\1 *\//
"endfunction
"
"" This function should automatically increment
"" a group of lines of numbers
"
"function! Incr()
"    leta=line('.')-line("'<")
"    letc=virtcol("'<")
"    ifa>0
"        execute'normal!'.c.'|'.a."\<C-a>"
"    endif
"    normal`<
"endfunction
"vnoremap <C-a> :call Incr()<CR>
"
"" Simple function to insert the runat="server" to all asp tags in an aspx file
"" NOTE: Will only match certain formats of asp tags. For example:
""        <asp:TextBox ID="firstNameTextBox" /> | Matches
""        <asp:TextBox ID="lastNameTextBox" /> | Matches
""        <asp:TextBox ID="birthdayTextBox" /> | Matches
""        <asp:DropDownList ID="personTypeDropDownList" > | Matches
""            <asp:ListItem Text="Student" /> | Matches
""            <asp:ListItem Text="Staff" /> | Matches 
""        </asp:DropDownList> | Doesn't match
""        <asp:DropDownList/> | Matches
""        <asp:TextBox ID="phoneNumberTextBox" /> | Matches
""        <asp:TextBox ID="programOfStudyTextBox" /> | Matches
"
"function Runat()
"    %s/\(<asp:.\{-}\)\s*\(\/\{-}>\)/\1 runat="server"\2/g
"endfunction
"
"" Custom function to toggle HTML comments; shouldn't need now that we're using 
"" plugins
"
"function CommentHtml()
"    let line=getline(".")
"    if line =~ "<!--" && line =~ "-->"
"        " Start and end of html comment
"        s/<!--\(.\{-}\)-->/\1
"    elseif line =~ "<!--"
"        s/<!--//
"        " Start html comment
"    elseif line =~ "-->"
"        s/-->//
"        " End html comment
"    else
"        " No HTML comment; add it
"        s/^\(.*\)$/<!--\1-->
"    endif
"endfunction
"
"function TableToDiv()
"    " Eliminate tbody and tr
"    %s/<\/*tbody>\n//g
"    %s/<\/*tr>\n//g
"    " Replace TD with divs
"    %s/<td>/<div class="nav-option">/g
"    %s/<\/td>/<\/div>/g
"    " Remove ending anchor tags
"    %s/<\/a>//g
"    "Add them back in right before the div closes
"    %s/<\/div>/<\/a><\/div>/g
"    "Replace table with DIV
"    %s/table/div
"    " Wrap all other text in a paragraph
"    %s/<\/h2>\zs\n\ze/\r<p>/g
"    %s/<\/a/<\/p><\/a/g
"    " Delete useless P tags
"    %s/<p>[^A-Za-z0-9\|\n]*<\/p>//g
"endfunction
"
"function InsertAnchors()
"    " This creates an array (a) that contains all of the starting anchor tags
"    let a=[] | %s/<a.\{-\}>/\=add(a,submatch(0))[-1]/g
"    1 " Jump back to the first line
"    " Have to do the first match first...
"    s/^<span/\=a[0] . '<span'
"    " Start the loop variable
"    let i = 1
"    while i < len(a)
"        " Prepend the first match of <span> (on a newline) with the anchor
"        s/\_.\{-\}\n\zs<span\ze/\=a[i] + '<span' " Not certain that this is actually working
"        
"        " Maybe simplify a bit:
"        " s/[^>]*<span\ze/\=a[i]<span
"
"        " Decrement i
"        let i += 1
"    endwhile
"endfunction
"
"function UnMinify()
"    %s/{/{\r\t/g
"    %s/}/\r}\r/g
"    %s/\zs;\ze[^\s]/;\r\t/g
"endfunction
"
"function Minify()
"    %s/\n//g
"    %s/\t//g
"endfunction
"
"function Blogify()
"    %s/^/<p>/
"    %s/$/<\/p>/
"    %s/'/’/g
"endfunction
"
"function CleanData()
"    %s/('/\r\t(\r\t\t'/g
"    %s/),/\r\t),/g
"    %s/', '/'\r\t\t\t : '/g
"endfunction
"
""  This is a function to replace all numbers (including words!) into "NORMALIZEDNUMBER".
""  It was useful when trying to create a training data set for NLP at Miralaw
"function NormalizeNumbers()
"    " Decimal-based numbers:
"    %s/^\d\+\(,\d\+\)*\(\/\d\+\)*\(\.\d\+\)*\t/NORMALIZEDNUMBER\t/g
"    " Word-based numbers. Matches stuff like "seventeen" and "thirty-six"
"    %s/^\(\(twen\|thir\|for\|fif\|six\|seven\|eigh\|nine\)ty-\)\?\(zero\|one\|two\|three\|five\|ten\|eleven\|twelve\|\(\(thir\|fif\)\(ty\|teen\)\)\|\(four\|six\|seven\|nine\)\(ty\|teen\)\?\|eight\(y\|een\)\?\|twenty\|hundred\|thousand\|million\|billion\|trillion\)\t/NORMALIZEDNUMBER\t/gi
"endfunction
"
"function SetupAnnotation()
"    :diffthis
"    :vnew<CR>
"    s/^.*$/\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r----------/
"    set nonumber nowrap
"endfunction
"
"
"" Functiion to align the type of sentence to the left and normalize it. More Miralaw
"function AlignLeft()
"    %s/"\?\(.\{-}\)"\?\t\(.*\)/\2\t\1
"    %s/^Spousal Payment/SSP
"    %s/^Income/SALARY
"    %s/^Expenses/UNKNOWN
"    %s/^Shared Capital Assets/UNKNOWN
"    %s/^Personal Capital Assets/UNKNOWN
"    %s/^Debt/UNKNOWN
"    %s/^Unknown/UNKNOWN
"    %s/^Other/UNKNOWN
"endfunction
"
"" Function to take a table for child support calculation, and turn it into a CSV 
"" in the format:
"" Lower income bound    Base amount Percentage on > Lower Income Bound
"
"function CreateCSV()
"    %s/\s\+\(\d\+\)\s\+\(\d\+\.\d\+\)\s\+\(\d\+\)$/,\1,\2
"    %s/\(^\d\+\)[^,]*/\1
"endfunction
"
"function HandleURI()
"    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
"    echo s:uri
"    if s:uri != ""
"        exec "!open \"" . s:uri . "\""
"    else
"        echo "No URI found in line."
"    endif
"endfunction
"
"" Some misc stuff for Miralaw Project, under the resolve pillar, to update the
"" progress meters using javascript, when we are recording which fields impact
"" which forms, this helped me to format the yml file
"
"" Add the data attributes for impacted forms
"" :\(.*\)/:\1,\r                  input_html: { data: { previous_value: @divorce_application_form\.\1 || '',\r                                        impacted_forms: t('impacted_forms_for_field.\1') } }
"
"" Once we copy data from a spreadsheet into the yml file, this helps to
"" format it
"function CleanYML()
"    %s/\(\w\+\)\(.*\)/    \1:\r\2
"    %s/−/-/g
"    %s/^-/      -/g
"    %s/\(\S\+\)-/\1\r      -/g
"    %s/^.*\(-.*\).*/      \1
"endfunction

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

set fo=tcq

" Items that require VIM 7.3 go down here:

if v:version < 703
  finish
endif

" Make undos persistent "
set undofile
set undodir=~/.vim/undo/
set undolevels=1000
set undoreload=10000

" Highlight columns past the maximum column
let &colorcolumn=join(range(desired_text_width + 1,999),",")

let g:LargeFile=10

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
lang en_US.UTF-8
