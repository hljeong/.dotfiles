" fix math mode detection
" https://tex.stackexchange.com/a/412867
if !exists("g:tex_no_math")
 call TexNewMathZone("E","align",1)
endif
