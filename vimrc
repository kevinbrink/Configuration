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
" gq  - reformat paragraph. Wraps liens to 80, etc.
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

" Plugins!
call plug#begin('~/.vim/plugged')

" Syntax highlighters:
Plug 'https://github.com/Keithbsmiley/swift.vim.git' " Swift
Plug 'https://github.com/kchmck/vim-coffee-script' " Coffeescript
Plug 'https://github.com/PProvost/vim-ps1.git'     " Powershell

Plug 'https://github.com/chrisbra/csv.vim.git'     " CSV magic

" Unfortunately, this plays around with the formatoptions, which tweaks our wrap
" settings
if v:version > 702
  Plug 'https://github.com/scrooloose/syntastic.git' " Syntax checker.
  " Ctags made easy:
  "Plug 'https://github.com/xolox/vim-easytags.git'
endif
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
  set statusline+=%{SyntasticStatuslineFlag()}  " Syntastic error message
endif
set statusline+=%*                            " I think highlight to the end?
set statusline+=%f                            " Relative path name
set statusline+=%=                            " Start right-aligning things here
set statusline+=%P\                             " Percentage through buffer
set statusline+=%l\ %c                        " Line and column, respectively
set laststatus=2                              " ALWAYS show statusline

if v:version > 702
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_haml_checkers = ['haml_lint']
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
  let g:syntastic_mode_map = { "mode": "active", "active_filetypes": [], "passive_filetypes": [] }
  let g:syntastic_python_checkers = ['flake8']
  let g:syntastic_python_flake8_args='--config=/Users/Kevin/Code/cfps-app/source/flake8.config'
  let g:syntastic_ruby_checkers = ['rubocop']
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

"set wrapmargin=0

" This makes it so that existing tabs look like 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2

set lazyredraw " to avoid scrolling problems

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
  au FileType python set sw=4 sts=4 ts=4
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
highlight Search ctermbg=91 cterm=bold
highlight DiffChange term=bold ctermbg=234
highlight DiffAdd term=bold ctermbg=74 guibg=LightBlue
highlight Visual term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
highlight CursorLine ctermbg=237 cterm=none
highlight ColorColumn ctermbg=236
highlight MatchParen ctermbg=238
highlight PmenuSel ctermfg=256 ctermbg=016
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
:noremap k <Down>
:noremap l <Up>
:noremap ; <Right>
:noremap <S-k> <PageDown>
:noremap <S-l> <PageUp>

" Have some tab-related shortcuts "

":noremap <C-t> :tabnew<CR>
:noremap <S-f> gT
:noremap <S-j> gt

" Shorcuts to save or quit "

" :noremap <C-q> :q<CR>
" :noremap <C-s> :w!<CR>

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

" Resizing windows. "

:noremap <C-u> :wincmd <<CR>
:noremap <C-p> :wincmd ><CR>
:noremap <C-o> :wincmd -<CR>
:noremap <C-i> :wincmd +<CR>

"set listchars=tab:>-,trail:·,eol:$
nnoremap <silent> <F5> :set nolist!<CR>

" Stolen from Yanick's configuration: "
set history=1000

set title

" Set up completion customization (Activate with ctrl-n)
"set completeopt=longest,menuone

set number


""" FUNCTIONS: """

""" USED FUNCTIONS: """

" This function toggles the textwidth between 80 and 999
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

function MakeTransactionTestCase()
    :%s/from django\.test import TestCase/from django.test import TransactionTestCase\rfrom common.config.models import GlobalSettings/
    :%s/\(class.*\)(TestCase)/\1(TransactionTestCase)/
    :%s/\(\s\+\)\(def set.*(self):\)/\1\2\r\1\1GlobalSettings.objects.set('WEATHER_SERVICE_TIMEOUT', 900)\rGlobalSettings.objects.set('LOG_SUCCESSFUL_RECORDS', False)/
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
