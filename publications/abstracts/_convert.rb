# this ruby 1.9+ script converts html bibligraphy pages from the mozart 1 page to markdown files by stripping out html tags while preserving spacing, links and page title

def convert_ahref_to_md(string) 
  string.gsub!(%r{<a href="([^"]*)">([^<]*)</a>}, '[\\2](\\1)')
end


def convert_php_title_to_header(string)
  string.gsub!(/\s*<\?php pslab_bibheader\("([^"]*)"\); \?>/, 
'---
layout: default
title: "\\1"
---
'
)
end

def strip_php(string)
  string.gsub!(/<\?php [^\?]*\?>/, '')
end

def convert_italics(string)
  string.gsub!(/<i>(.*)<\/i>/, '*\\1*')
end

def strip_latex_quotes(string)
  string.gsub!(/``([^']*)''/, '"\\1"')
end

def strip_tags(string)
  string.gsub!(/<\/p>/, "\n\n")
  string.gsub!(/(?:<[^>]*>)?/, '')
end

# str = '<a href="http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/BetaReductionConstraints.ps.gz">Postscript</a>'
# convert_ahref_to_md(str)
# puts str

Dir.glob('*.html') do |filename|
  
  File.open(filename, 'rb:ISO-8859-1:utf-8') do |in_file|
    puts "reading in #{in_file.external_encoding}"

    File.open(File.basename(filename, '.html')+".md", 'w:utf-8') do |out_file|
      puts "writing out #{out_file.external_encoding}"

      str = in_file.read
      convert_php_title_to_header(str)
      convert_ahref_to_md(str)
      strip_latex_quotes(str)
      strip_php(str)
      convert_italics(str)
      strip_tags(str)
      out_file.write str
    end
  end
end


# str = <<HEREDOC
# <?php include("/services/mozart/httpd/html/pslab.php"); ?>
# 
# <?php pslab_bibheader("Beta Reduction Constraints"); ?>
# <div class=margin>
# <p class=paperyear>2001</p>
# <p class=paperauthor>Manuel Bodirsky</p>
# <menu class=paperlinks>
# <li><p><a href="http://www.ps.uni-sb.de/PapersOz/ProgrammingSysLab/BetaReductionConstraints.ps.gz">Postscript</a><li><p><a href="http://www.ps.uni-sb.de/PapersOz/abstracts/BetaReductionConstraints.bib">BibTeX Entry</a>
# </menu>
# </div>
# <p>
# This thesis investigates languages that partially describe lambda terms.
# In particular, beta reduction constraints are introduced,
# which express that one lambda term beta-reduces to another.
# We investigate the <i>expressive power of beta reduction</i> constraints
# by relating them to parallelism constraints,
# and give applications of beta reduction constraints
# in semantical underspecification of computational linguistics.
# </p>
# <!--PATCH HERE-->
# <?php pslab_footer("Webmaster"); ?>
# 
# HEREDOC
# convert_php_title_to_header(str)
# convert_ahref_to_md(str)
# strip_php(str)
# convert_italics(str)
# strip_tags(str)
# puts str