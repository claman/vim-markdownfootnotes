## VimFootnotes for Markdown

This is a fork of `vim-pandoc/vim-markdownfootnotes`, incorporating patches from `dmoerner/vim-markdownfootnotes` and a few of my own personal additions.

The new script inserts footnotes in the widely supported extended markdown syntax:

```markdown
Here is some text.[^1]

[^1]: Here is a note.
```

The footnote number gets determined by an automatic counter whenever a new
footnote gets inserted. The counter works with the default arabic numerals
and all other settings provided by `b:vimfootnotetype`. The automatic counter
code is based on the code for the counting of HTML footnotes in [this post by
Nick Coleman][3], adjusted slightly to work with Markdown footnotes.

The script defines three mappings:

```viml
<Leader>f " Insert a new footnote
<Leader>e " Edit existing footnote
<Leader>r " Return from footnote
```

To insert a footnote, type `<Leader>f`. A footnote mark will be inserted after the cursor. A matching footnote mark will be inserted at the end of the file. A new buffer will open in a split window at the bottom of your screen, ready to edit the new footnote. To edit an existing footnote, type `<Leader>e`, and a new buffer will open in a split window to edit the closest footnote. When you are done with either action, type `<Leader>r` to close the split and return to the main text.

## Installation

Extract to your plugins directory or use any common vim plugin manager.

```viml
" vim-plug
Plug 'vim-pandoc/vim-markdownfootnotes'

" vundle
Plugin 'vim-pandoc/vim-markdownfootnotes'
```

```bash
# pathogen
$ cd ~/.vim/bundle
$ git clone https://github.com/vim-pandoc/vim-markdownfootnotes.git
```

## Settings

None at the moment. Uses exclusively Arabic numerals (1,2, 3, etc.).

## Commands

`FootnoteAdd`: inserts footnote after closest punctuation mark, adds corresponding
mark at end of file, and opens split window at mark

`FootnoteEdit`: finds next footnote, opens split window for editing

`FootnoteReturn`: close split and return to inserted footnote

`FootnoteNextNumber`: get next available footnote number
