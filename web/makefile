# makefile
# needs
#  * GNU make (http://gnuwin32.sourceforge.net/packages/make.htm)
#  * pandoc (http://johnmacfarlane.net/pandoc/)

# =    recursive variable
# :=   simply expanded variable
SRC = src/
WEB = public_html/

# $(wildcard _) lists all files matching the given path
MD_FILES := $(wildcard $(SRC)*.md)
# substitutes pattern
HTML_FILES := $(patsubst $(SRC)%.md,$(WEB)%.html,$(MD_FILES))
STYLE:=github-markdown.css

# build tool: pandoc (http://johnmacfarlane.net/pandoc/)
MATHJAXCDN = http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML
TEMPLATE=default.html5
PANDOC = pandoc --from=markdown --to=html5 --standalone --smart --section-divs --mathjax=$(MATHJAXCDN) -V lang=en --template=$(TEMPLATE)

# this is so that make does not expect website file to be actually created
.PHONY : website
website: $(HTML_FILES)

# $@ is target, $< is source
# target: source

# .html files
$(WEB)index.html: $(SRC)index.md $(STYLE) $(TEMPLATE)
	$(PANDOC) $< -o $@ --css=$(STYLE)

$(WEB)%.html: $(SRC)%.md $(STYLE) $(TEMPLATE)
	$(PANDOC) $< -o $@ --css=$(STYLE) --metadata backtoindex


