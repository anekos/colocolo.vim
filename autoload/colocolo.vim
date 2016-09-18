let s:save_cpo = &cpo
set cpo&vim


function! s:get_colorschemes() abort
  return map(
  \   split(
  \     globpath(&runtimepath, 'colors/*.vim'),
  \     '\n'
  \   ),
  \   "fnamemodify(v:val, ':t:s?\.vim$??')"
  \ )
endfunction

function! s:get_random_osyo(n) abort
  return ('0x'.sha256(reltimestr(reltime()))[:7]) % a:n
endfunction

function! s:choice(lst) abort
  return a:lst[s:get_random_osyo(len(a:lst))]
endfunction

function! s:initialize() abort
  if !exists('s:colors')
    let s:colors = s:get_colorschemes()
  endif
endfunction

function! colocolo#start(...) abort
  call s:initialize()

  let l:interval = get(a:, 1, 0)

  if l:interval <= 0
    return colocolo#change()
  endif

  if exists('s:timer')
    call timer_stop(s:timer)
  endif

  let s:timer = timer_start(l:interval, function('colocolo#change'), {'repeat': -1})
endfunction

function! colocolo#change(...) abort
  call s:initialize()

  silent! execute 'colorscheme' s:choice(s:colors)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
