These files comprise the old (now non functional) www.mozart-oz.org website.
Edits here will take some time to pass through the caching layer, but will change the live site.
No other uploads are required, simply change this repository.

Web hosting is provided by [Github Pages](http://pages.github.com/).
Page layout was hard-coded using [Bootstrap 2.3](getbootstrap.com/2.3.2)

# How the site works

The git repository's master branch is converted to HTML by [Github Pages](http://pages.github.com/)
in a preconfigured service fashion, built on the [Jekyll](http://jekyllrb.com/) static website processor.
Jekyll is written in the Ruby, but all you need to update the site is English, eyes, and a keyboard.


# Editing the site

This section describes the plain-text markup formats used in producing the site, and the simple procedures for updating the site, including convenient online editing via Github.

## Online web-based editing (try this first)

For small textual changes you can perform online editing through the Github
website. Viewing the page of interest's source file and click "Edit".
This brings up an in-browser text editor, and a preview tab for some file formats.
This allows you to modify the website without needing to understand git.


## Source file format

The site is written in Markdown, Textile and HTML (in order of decreasing convenience).
Markdown is used as much as possible for content-pages, which are expected to be updated by many users, but layouts are in HTML and are not expected to be modified very often.
Some HTML content exists where it was copied directly from the Mozart 1 site. Textile might be used for new content containing complex HTML elements such as tables, but it sometimes seems simpler to use HTML.

- .md files are [Markdown](http://daringfireball.net/projects/markdown/basics) formatted
- .textile files use [Textile](http://en.wikipedia.org/wiki/Textile_(markup_language)), also see [RedCloth docs](http://redcloth.org/textile)
- .html files are served as-is, though do undergo [Liquid preprocessing](http://jekyllrb.com/docs/variables/) if the [YAML frontmatter](http://jekyllrb.com/docs/frontmatter/) is included

If you do not have a text editor which recognises these formats you might like to
try [Textmate 2](http://macromates.com/download) for Mac OS, or the cross-platform [Sublime Text 2](sublimetext.com/2).

### Character encoding

Save all files as UTF-8 unicode WITHOUT BOM. Including a BOM will crash the compilation engine.


## Offline editing (a little harder)

If making major changes to the site it is recommended to make them offline, on
your computer, and check things work correctly and look ok before uploading
to the main site.

In order to modify and view the pages on your computer you should use git as
normal (clone the repository, commit local changes, then push to the
github remote's master branch).

### To run Jekyll on your machine:

0. Have ruby (1.8.7 or preferably newer) installed, ruby -v
1. (sudo) gem install bundler
2. (sudo) bundle install
3. bundle exec jekyll serve --watch

http://jekyllrb.com/docs/usage/

