This website is written in a mixture of the Markdown, Textile and HTML markup
languages (in order of increasing complexity, increasing tag-soup, and
decreasing user-friendliness).

It is processed by the Jekyll static website processor, written in the Ruby 
programming language.

# Editing the site

There are two suggested ways to modify the site. Both are quite easy.

## Online web-based editing

For small textual changes you can perform online editing through the Github
website by viewing the source file for the page you are interested in and 
clicking "Edit". This allows you to modify and commit the remote repository's 
files directly without using git.

## Offline editing

If making major changes to the site it is recommended to make them offline, on
your computer, and check things work correctly and look ok before uploading
to the main site. 

In order to modify and view the pages on your computer you should use git as 
normal (clone the repository, commit local changes, then push to the 
github remote's master branch).

### To run Jekyll on your machine

0. Have ruby (1.8.7 or preferably newer) installed, ruby -v
1. (sudo) gem install bundler
2. (sudo) bundle install
3. bundle exec jekyll serve --watch

http://jekyllrb.com/docs/usage/



# File formats

- .md files are markdown formatted, see http://daringfireball.net/projects/markdown/basics
- .textile files use textile, see http://redcloth.org/textile or http://en.wikipedia.org/wiki/Textile_(markup_language)
- .html files are served as-is, though do undergo liquid preprocessing if the yaml frontmatter is included

If you do not have a text editor which recognises these formats you might like to
try [Textmate 2](http://macromates.com/download) for Mac OS, or the cross-platform [Sublime Text 2](sublimetext.com/2).

# Character encoding

Save all files as UTF-8 unicode WITHOUT BOM.
