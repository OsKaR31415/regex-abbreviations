if !exists("g:regex_abbreviations#expand_symbol")
    let g:regex_abbreviations#expand_symbol = ":"
endif

" Function that is called to complete the abbreviation.
fun! CompleteAbbreviation()
    " if there is no abbreviations, then return the symbol used to abbreviate
    if !exists("b:abbreviations")
        return g:regex_abbreviations#expand_symbol
    endif
    for [regex, action] in items(b:abbreviations)
        let output = action[0]
        let del_previous_words = action[1]
        if getline('.') =~ regex
            return repeat("\<C-w>", del_previous_words) . output
        endif
    endfor
    " if there is no match
    return g:regex_abbreviations#expand_symbol
endfun

fun! AddAbbreviation(regex, output, ...)
    " add an abreviation to the abbreviations list
    " a:regex is the regex that neds to be matched
    " a:output is the string that is put when the abbreviation is expanded
    " one optionnal argument is possible. it is the number of words that will
    " be deleted before the abbreviation is written. Most of the time, you
    " want that value to be 1, because you want to delete the word want to
    " abbreviate. But the default value of the variable is 0, meaning that no
    " word will be deleted
    let delpreviousword = get(a:, 1, 0)
    if !exists("b:abbreviations")
        let b:abbreviations = {a:regex : [a:output, delpreviousword]}
    else
        let b:abbreviations[a:regex] = [a:output, delpreviousword]
    endif
endfun

" map the symbol to complete abbreviations
exe "inoremap " . g:regex_abbreviations#expand_symbol . " <C-R>=CompleteAbbreviation()<cr>"
