if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/ashigirl96/.vimrc', '/Users/ashigirl96/.vim/dein/dein.toml', '/Users/ashigirl96/.vim/dein/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/ashigirl96/.vim/dein'
let g:dein#_runtime_path = '/Users/ashigirl96/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/ashigirl96/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/ashigirl96/.vim,/Users/ashigirl96/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/Users/ashigirl96/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/ashigirl96/.vim/after,/Users/ashigirl96/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/ashigirl96/.vim/bundle/jedi-vim/'
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['neocomplete.vim'])
