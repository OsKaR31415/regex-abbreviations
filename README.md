# regex-abbreviations

This vim plugin allows you to define "abbreviations" that depend on a regex matching or not.

## Precisions

The abbreviations are "expanded" (executed if you prefer) when typing a caracter (you have to define it).
But, when that caracter is typed, the abbreviation isn't always executed : it only does if the current line matches the regex that corresponds to the abbreviation.
If no abbreviation matches, typing the caracter only writes that caracter.

So this plugin's abbreviations need two things : the regex that makes the condition, and the text sent when the caracter is pressed if the regex matches the line.

The function to define abbreviations provides a more convenient way to make a word to be replaced with a text : it allows you to tell the number of word that will be deleted (backwards) before the text of the abbreviation is sent (as an equivalent, you could put some `<C-W>` at the beginning of that text).

Note : the abbreviations are defined buffer-wise, so you can make them different by filetype or any condition.

## Example

first you need to set the character that starts the abbreviation.

You have to set it with the variable `g:regex_abbreviations#expand_symbol`.
For example, I use `:` to expand the abbreviations, so my `.vimrc` contains :
```vim
let g:regex_abbreviations#expand_symbol = ":"
```

Then let's say that you want to abbreviate `fun` to `function`. You must use the function `g:regex_abbreviations#expand_symbol` :
```vim
call AddAbbreviation("fun$", "ction")
```

Here you can see that, if at any moment i type `fun` at the end of a line (that matches `fun$`), and then i type my expand symbol, the symbol will be replaced by `ction`, so `function` is written.

## Example 2

If you prefer to use an abbreviation that isn't the beginning of the expanded text, you need to use the optionnal argument of `AddAbrevviation`.
That argument controls how many words are deleted before expanding. For example, if you wand to abbreviate `tx ex te` to `text expanding test`, then you must use :
```vim
call AddAbbreviation("tx ex te$", "text expanding test", 3)
```
Here, i used 3 because i want to delete `te`, `ex` and `tx`, which are 3 words before the cursor.

## Warning

The regex matching is **for the whole line**, so it works from everywhere in the line, but the expantion will be done even if the regex only matches **any part of the line**. This is why I have put a `$` in the end of my regexes : to ensure that the pattern i want to match isn't followed by anything.

# Installation

Just use your favorite plugin manager as usually.
example with Vundle :
```vim
Plugin 'OsKaR31415/regex-abbreviations'
```

Then you **have to** set the variable `g:regex_abbreviations#expand_symbol`, because it has no default value :

```vim
let g:regex_abbreviations#expand_symbol = ":" " put here whatever symbol you want
```


# More ideas

Here is an example with java/c/c++ `for` loop :
You can obviously make a classic abbreviation, but you could also make the equivalent of placeholders in snippets (once you got the `for` structure, pressing again the key jumps to the next place where you want to write)
```vim
call AddAbbreviation("^ *for$", "for (;;)\<esc>F(a", 1) " this writes a for loop
call AddAbbreviation("^ *for *(.*;.*;.*) *{$", "\<left>\<esc>f;a") " this goes to the next placeholder (after the next ;)
```

As you can see in that example, you can make vim to perform any command, even complex ones. So possibilities are quite endless

# Notes

There is no vim-help for the moment. Mostly because i did not learned how to do it. If the plugin gets a little bit of views, i'll quickly consider doing it.

This is a very light and simple plugin, i even encourage you to read its code (it's only 40 lines) to really understand it.




