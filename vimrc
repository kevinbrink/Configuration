" This is the vimrc of Kevin Brink. It sets up my happy settings, but isn't for
" the faint of heart; it does some crazy things, like remapping your navigation
" keys! 
:set ruler
"execute pathogen#infect()
syntax on
"filetype plugin indent on
set nowrap
" This is awesome. Auto-wraps lines to 80
"set wrap
"set textwidth=80

" These are some helpful tips for reformatting code: 

" V=  - select text, then reformat with =
" =   - will correct alignment of code
" ==  - one line; 
" gq  - reformat paragraph
" Options to change how automatic formatting is done:

" :set formatoptions (default "tcq")
"  - t - textwidth
"  - c - comments (plus leader -- see :help comments)
"  - q - allogw 'gq' to work
"  - n - numbered lists
"  - 2 - keep second line indent
"  - 1 - single letter words on next line

"set wrapmargin=0

" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd   " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set ignorecase    " Do case insensitive matching
set smartcase   " Do smart case matching
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a    " Enable mouse usage (all modes)

" Make undos persistent "

set undofile
set undodir=~/.vim/undo/
set undolevels=1000
set undoreload=10000

set hlsearch

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Set colorscheme "
if &diff
  colorscheme evening
else
  colorscheme elflord
endif

" Set tab-settings

set expandtab
"set autoindent
" set cindent
set smartindent

" Not sure exactly how these all work yet
" set softtabstop=4
set shiftwidth=4
" This makes it so that existing tabs look like 4 spaces
set tabstop=4 

" Set it so that the cursor is always in the middle of the page vertically "
set scrolloff=9999

" Scroll smoothly horizontally "

set sidescroll=1
set sidescrolloff=15

" Map some more handy navigation keys "

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

:noremap <F4> :set hlsearch! hlsearch?<CR>

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

" This is supposed change % to match if/else/else if/endifs as well as ( )

"runtime /usr/share/vim/addons/plugin/matchit.vim

" Bash-style completion
"set wildmenu
"set wildmode=list:longest

set ruler

set number

"set listchars=tab:>-,trail:·,eol:$
nmap <silent> <F5> :set nolist!<CR>

"set t_Co=256
"let g:solarized_termcolors=256

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
