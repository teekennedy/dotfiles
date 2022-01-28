" Settings for python files

" Only execute this script once for the current buffer
if exists("b:python_ftplugin_loaded")
  finish
endif
let b:python_ftplugin_loaded = 1

nmap <leader>i call CocActionAsync('codeAction', 'pyright.organizeimports')

let cwd_pyenv_versions = exists('cwd_pyenv_versions') ? cwd_pyenv_versions : {}

" Pyenv integration block
if executable('pyenv')
  " Function to get the current pyenv version
  function GetPyenvVersion()
    let cwd = getcwd()
    if has_key(g:cwd_pyenv_versions, cwd)
      echo 'using cached'
      return g:cwd_pyenv_versions[cwd]
    else
      " Get current python version name from system command
      let pyenv_version = system('pyenv version-name')
      " Remove trailing newline
      let pyenv_version = substitute(pyenv_version, '\n$', '', '')
      let g:cwd_pyenv_versions[cwd] = pyenv_version
      return pyenv_version
    endif
  endfunction

  " Pyright can pick up binaries from the current pyenv installation ONLY IF the
  " PYENV_VERSION environment variable is set.
  let $PYENV_VERSION = GetPyenvVersion()
endif
