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

" Unfortunately, this plays around with the formatoptions, which tweaks our wrap
" settings
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

"TODO: Plug 'https://github.com/tpope/vim-surround'
"TODO: Plug 'https://github.com/tpope/vim-surround'
"TODO: ECLIM
"TODO: EMMET - Easy html population
"TODO: Sleuth
"TODO: Unimpaired
"Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.sh --clang-completer' } " Add fancy autocomplete

call plug#end()

" Specific settings for syntastic; recommended settings:

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_ruby_checkers = ['rubocop']

" Skip to next error (Using syntastic)
:map 'n :lnext <CR>
:map 'N :lprevious <CR>
:map 's :SyntasticCheck <CR>

" Always split windows vertical when using Gdiff
set diffopt+=vertical

""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global textwidth value
let desired_text_width=100

set ruler
"execute pathogen#infect()
syntax on
set nowrap " Change the DISPLAY of the text to wrap
" Auto-wrap lines
let &textwidth=desired_text_width

"set wrapmargin=0

" This makes it so that existing tabs look like 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

set lazyredraw " to avoid scrolling problems

if has("autocmd")
  " Vim jumps to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Automatically detect indentation rules and plugins
  " TODO: Is this any better? Doubt it filetype plugin indent on
  au FileType python set textwidth=9999
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
endif

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

" Make undos persistent "

set undofile
set undodir=~/.vim/undo/
set undolevels=1000
set undoreload=10000

set hlsearch

" You can set up different colours for all sorts of different highlights here:
highlight Search ctermbg=91 cterm=bold
highlight DiffChange term=bold ctermbg=245
highlight DiffAdd term=bold ctermbg=74 guibg=LightBlue
highlight Visual term=standout ctermfg=4 ctermbg=248 guifg=DarkBlue guibg=Grey
highlight CursorLine ctermbg=237 cterm=none
highlight ColorColumn ctermbg=236
" highlight ErrorMsg ctermbg=
" highlight DiffAdd ctermbg=
" highlight Todo ctermbg=

" Highlight the current line
set cul

" Highlight columns past the maximum column
let &colorcolumn=join(range(desired_text_width + 1,999),",")

" Don't save session options
set ssop-=options

" If we want the yank command to copy to the system clipboard:
" set clipboard=unnamed,unnamedplus


" TODO: Setup a GOOD colorscheme for both of these things!
" Set colorscheme "
"if &diff
"  colorscheme delek
"else
"  colorscheme evening
"  "colorscheme elflord
"endif
"colorscheme ir_black
" TODO: molokai for java and ruby
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

" Map some navigation keys. This is where everyone else will start going crazy

:map j <Left>
:map k <Down>
:map l <Up>
:map ; <Right>
:map <S-k> <PageDown>
:map <S-l> <PageUp>

" Have some tab-related shortcuts "

:noremap <C-t> :tabnew<CR>
:noremap <S-f> gT
:noremap <S-j> gt

" Shorcuts to save or quit "

:noremap <C-q> :q<CR>
:noremap <C-s> :w!<CR>

" This maps 'W' to saving with sudo

"ca W w !sudo tee "%"

:noremap <F4> :set hlsearch! hlsearch?<CR>

" Toggle textwidth
:noremap <S-t> :call ToggleTextWidth()<CR>

" Toggle indentation
:noremap <S-y> :call ToggleIndent()<CR>

" Toggle comments
map <C-c> <plug>NERDCommenterInvert

" Run rubocop (Miralaw)
let g:vimrubocop_keymap = 0
nmap -r :RuboCop<CR>

" Diff all open windows in current tab
nmap -d :call DiffAll()<CR>

" Toggle paste setting
:map <S-p> :call InvPaste()<CR>

" Window-related shortcuts "

:noremap <C-n> :vnew<CR>
:noremap <silent> <C-k> <c-w><Down>
:noremap <silent> <C-l> <c-w><Up>
:noremap <silent> <C-f> <c-w><Left>
:noremap <silent> <C-j> <c-w><Right>

" Resizing windows. "

:map <C-u> :wincmd <<CR>
:map <C-p> :wincmd ><CR>
:map <C-o> :wincmd -<CR>
:map <C-i> :wincmd +<CR>

" Stolen from Yanick's configuration: "
set history=1000

set title

" Set up completion customization (Activate with ctrl-n)
"set completeopt=longest,menuone

set number

"set listchars=tab:>-,trail:·,eol:$
nmap <silent> <F5> :set nolist!<CR>

" Function to change all html codes into their symbol representatives "

function CleanUp()
  %s/&gt;/>/g
  %s/&lt;/</g
  %s/&quot;/"/g
  %s/&#39;/'/g
  diffupdate
endfunction

function TidyJson() 
  %s/\[/\[\r\t\t/g
  %s/{/{\r\t\t\t\t/g
  %s/\(},\)/\r\t\t\1\r\t\t/g
  %s/\(}[^,]\)/\r\t\t\1/g
  %s/\]/\r\]/g
endfunction

function FixCComments()
  %s/\/\/\(.*\)/\/*\1 *\//
endfunction

" This function should automatically increment
" a group of lines of numbers

function! Incr()
    leta=line('.')-line("'<")
    letc=virtcol("'<")
    ifa>0
        execute'normal!'.c.'|'.a."\<C-a>"
    endif
    normal`<
endfunction
vnoremap <C-a> :call Incr()<CR>

" Simple function to insert the runat="server" to all asp tags in an aspx file
" NOTE: Will only match certain formats of asp tags. For example:
"        <asp:TextBox ID="firstNameTextBox" /> | Matches
"        <asp:TextBox ID="lastNameTextBox" /> | Matches
"        <asp:TextBox ID="birthdayTextBox" /> | Matches
"        <asp:DropDownList ID="personTypeDropDownList" > | Matches
"            <asp:ListItem Text="Student" /> | Matches
"            <asp:ListItem Text="Staff" /> | Matches 
"        </asp:DropDownList> | Doesn't match
"        <asp:DropDownList/> | Matches
"        <asp:TextBox ID="phoneNumberTextBox" /> | Matches
"        <asp:TextBox ID="programOfStudyTextBox" /> | Matches

function Runat()
    %s/\(<asp:.\{-}\)\s*\(\/\{-}>\)/\1 runat="server"\2/g
endfunction

" This function toggles the textwidth between 80 and 999
function ToggleTextWidth()
    if &l:textwidth ># g:desired_text_width + 1
        echom "Setting textwidth to " . g:desired_text_width
        let &textwidth=g:desired_text_width
    else
        echom "Setting textwidth to 999"
        set textwidth=999
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

" Custom function to toggle HTML comments; shouldn't need now that we're using 
" plugins

function CommentHtml()
    let line=getline(".")
    if line =~ "<!--" && line =~ "-->"
        " Start and end of html comment
        s/<!--\(.\{-}\)-->/\1
    elseif line =~ "<!--"
        s/<!--//
        " Start html comment
    elseif line =~ "-->"
        s/-->//
        " End html comment
    else
        " No HTML comment; add it
        s/^\(.*\)$/<!--\1-->
    endif
endfunction

function TableToDiv()
    " Eliminate tbody and tr
    %s/<\/*tbody>\n//g
    %s/<\/*tr>\n//g
    " Replace TD with divs
    %s/<td>/<div class="nav-option">/g
    %s/<\/td>/<\/div>/g
    " Remove ending anchor tags
    %s/<\/a>//g
    "Add them back in right before the div closes
    %s/<\/div>/<\/a><\/div>/g
    "Replace table with DIV
    %s/table/div
    " Wrap all other text in a paragraph
    %s/<\/h2>\zs\n\ze/\r<p>/g
    %s/<\/a/<\/p><\/a/g
    " Delete useless P tags
    %s/<p>[^A-Za-z0-9\|\n]*<\/p>//g
endfunction

function InsertAnchors()
    " This creates an array (a) that contains all of the starting anchor tags
    let a=[] | %s/<a.\{-\}>/\=add(a,submatch(0))[-1]/g
    1 " Jump back to the first line
    " Have to do the first match first...
    s/^<span/\=a[0] . '<span'
    " Start the loop variable
    let i = 1
    while i < len(a)
        " Prepend the first match of <span> (on a newline) with the anchor
        s/\_.\{-\}\n\zs<span\ze/\=a[i] + '<span' " Not certain that this is actually working
        
        " Maybe simplify a bit:
        " s/[^>]*<span\ze/\=a[i]<span

        " Decrement i
        let i += 1
    endwhile
endfunction

function UnMinify()
    %s/{/{\r\t/g
    %s/}/\r}\r/g
    %s/\zs;\ze[^\s]/;\r\t/g
endfunction

function Minify()
    %s/\n//g
    %s/\t//g
endfunction

function Blogify()
    %s/^/<p>/
    %s/$/<\/p>/
    %s/'/’/g
endfunction

function CleanData()
    %s/('/\r\t(\r\t\t'/g
    %s/),/\r\t),/g
    %s/', '/'\r\t\t\t : '/g
endfunction

"  This is a function to replace all numbers (including words!) into "NORMALIZEDNUMBER".
"  It was useful when trying to create a training data set for NLP at Miralaw
function NormalizeNumbers()
    " Decimal-based numbers:
    %s/^\d\+\(,\d\+\)*\(\/\d\+\)*\(\.\d\+\)*\t/NORMALIZEDNUMBER\t/g
    " Word-based numbers. Matches stuff like "seventeen" and "thirty-six"
    %s/^\(\(twen\|thir\|for\|fif\|six\|seven\|eigh\|nine\)ty-\)\?\(zero\|one\|two\|three\|five\|ten\|eleven\|twelve\|\(\(thir\|fif\)\(ty\|teen\)\)\|\(four\|six\|seven\|nine\)\(ty\|teen\)\?\|eight\(y\|een\)\?\|twenty\|hundred\|thousand\|million\|billion\|trillion\)\t/NORMALIZEDNUMBER\t/gi
endfunction

function SetupAnnotation()
    :diffthis
    :vnew<CR>
    s/^.*$/\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r----------/
    set nonumber nowrap
endfunction


" Functiion to align the type of sentence to the left and normalize it. More Miralaw
function AlignLeft()
    %s/"\?\(.\{-}\)"\?\t\(.*\)/\2\t\1
    %s/^Spousal Payment/SSP
    %s/^Income/SALARY
    %s/^Expenses/UNKNOWN
    %s/^Shared Capital Assets/UNKNOWN
    %s/^Personal Capital Assets/UNKNOWN
    %s/^Debt/UNKNOWN
    %s/^Unknown/UNKNOWN
    %s/^Other/UNKNOWN
endfunction

" Function to take a table for child support calculation, and turn it into a CSV 
" in the format:
" Lower income bound    Base amount Percentage on > Lower Income Bound

function CreateCSV()
    %s/\s\+\(\d\+\)\s\+\(\d\+\.\d\+\)\s\+\(\d\+\)$/,\1,\2
    %s/\(^\d\+\)[^,]*/\1
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

function HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
endfunction

function ShowDiff()
    :vnew<CR>
    :read !git diff --cached
    set syntax=git
endfunction

" Some misc stuff for Miralaw Project, under the resolve pillar, to update the
" progress meters using javascript, when we are recording which fields impact
" which forms, this helped me to format the yml file

" Add the data attributes for impacted forms
" :\(.*\)/:\1,\r                  input_html: { data: { previous_value: @divorce_application_form\.\1 || '',\r                                        impacted_forms: t('impacted_forms_for_field.\1') } }

" Once we copy data from a spreadsheet into the yml file, this helps to
" format it
function CleanYML()
    %s/\(\w\+\)\(.*\)/    \1:\r\2
    %s/−/-/g
    %s/^-/      -/g
    %s/\(\S\+\)-/\1\r      -/g
    %s/^.*\(-.*\).*/      \1
endfunction

function DiffAll()
    :windo diffthis
endfunction

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

set fo=tcq
