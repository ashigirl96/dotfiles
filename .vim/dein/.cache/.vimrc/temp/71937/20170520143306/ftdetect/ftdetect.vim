" Vim plugin ftdetects
" Language:     Microsoft C#
" Maintainer:   Kian Ryan (kian@orangetentacle.co.uk)
" Last Change:  2015 Apr 27

" Set msproj file extensions
au BufNewFile,BufRead *.cs compiler msbuild
au BufNewFile,BufRead *.proj compiler msbuild | set filetype=xml
au BufNewFile,BufRead *.csproj compiler msbuild | set filetype=xml
au BufNewFile,BufRead *.sln compiler msbuild | set filetype=xml
au BufNewFile,BufRead *.cshtml compiler msbuild | set filetype=cshtml.html syntax=cshtml
au BufNewFile,BufRead *.aspx compiler msbuild | set filetype=aspx.html syntax=aspx
au BufNewFile,BufRead *.ascx compiler msbuild | set filetype=aspx.html syntax=aspx
au BufNewFile,BufRead *.master compiler msbuild | set filetype=aspx.html syntax=aspx

function! s:DetectJS()
    if getline(1) =~# '^#!.*/bin/\(env\s\+\)\?node\>'
        setfiletype javascript
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectJS()
" We take care to preserve the user's fileencodings and fileformats,
" because those settings are global (not buffer local), yet we want
" to override them for loading Go files, which are defined to be UTF-8.
let s:current_fileformats = ''
let s:current_fileencodings = ''

" define fileencodings to open as utf-8 encoding even if it's ascii.
function! s:gofiletype_pre(type)
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  let &l:filetype = a:type
endfunction

" restore fileencodings as others
function! s:gofiletype_post()
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction

au BufNewFile *.go setfiletype go | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.go call s:gofiletype_pre("go")
au BufReadPost *.go call s:gofiletype_post()

au BufNewFile *.s setfiletype asm | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.s call s:gofiletype_pre("asm")
au BufReadPost *.s call s:gofiletype_post()

au BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl

" vim: sw=2 ts=2 et
