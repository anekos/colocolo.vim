let s:save_cpo = &cpo
set cpo&vim


if !exists('g:i_am_not_pika_beast')
  augroup ColoColo
    autocmd!
    autocmd VimEnter * call colocolo#start(10)
  augroup END
endif

command! -nargs=? -bar ColoColo call colocolo#start(<args>)


let &cpo = s:save_cpo
unlet s:save_cpo
