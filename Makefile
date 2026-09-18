# Detect source files in all languages
LANGS := en fr
SOURCES := $(foreach lang,$(LANGS),$(wildcard $(lang)/*/*.typ))

# Map source files to the output files
PDFS := $(patsubst %.typ,build/%.pdf,$(SOURCES))

.PHONY: all clean dirs init-placeholders

all: dirs $(PDFS)

dirs:
	@mkdir -p $(foreach lang,$(LANGS),build/$(lang))

# Compile sheets. Rebuilds if template.typ changes.
build/%.pdf: %.typ template.typ
	mkdir -p `dirname $@`
	typst compile --root . $< $@

clean:
	rm -rf build/
