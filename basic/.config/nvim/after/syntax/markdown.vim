" fix underline highlighting
" https://stackoverflow.com/a/34448277
syntax match markdownError "\w\@<=\w\@="

" fix nested list highlighting
" https://vi.stackexchange.com/a/33254
syn match markdownListMarker "\%(\t\| \{0,10\}\)[-*+]\%(\s\+\S\)\@=" contained
