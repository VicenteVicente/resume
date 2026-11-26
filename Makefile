# Builds the resume in English and Spanish. Run `make help` for the targets.
# Sources are in src/, everything generated (PDFs included) goes to build/.

NAME  := Vicente_Calisto_Resume
SRC   := src
BUILD := build
LANGS := EN ES
MAINS := $(foreach l,$(LANGS),$(NAME)_$(l).tex)
PDFS  := $(foreach l,$(LANGS),$(BUILD)/$(NAME)_$(l).pdf)

LATEXMK  ?= latexmk
TECTONIC ?= tectonic
FLAGS    := -pdf -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all en es watch check tectonic clean distclean help FORCE

all: $(PDFS) ## Build both PDFs into build/ (pdfLaTeX via latexmk)

# latexmk tracks dependencies itself and only reruns LaTeX when needed.
# It runs in src/ so that src/.latexmkrc applies (output to ../build).
$(BUILD)/$(NAME)_%.pdf: FORCE
	cd $(SRC) && $(LATEXMK) $(FLAGS) $(NAME)_$*.tex

en: $(BUILD)/$(NAME)_EN.pdf ## Build the English PDF only
es: $(BUILD)/$(NAME)_ES.pdf ## Build the Spanish PDF only

watch: ## Rebuild the English PDF on every save (LANG_=ES for Spanish)
	cd $(SRC) && $(LATEXMK) $(FLAGS) -pvc $(NAME)_$(or $(LANG_),EN).tex

check: all ## Fail if either resume is longer than one page
	@for log in $(PDFS:.pdf=.log); do \
	  grep -q 'Output written on .*(1 page' $$log || { echo "$$log: the resume is longer than one page"; exit 1; }; \
	done; echo "OK: every resume fits on one page"

tectonic: ## Build both PDFs with Tectonic instead of TeX Live
	@mkdir -p $(BUILD)
	@cd $(SRC) && for f in $(MAINS); do $(TECTONIC) --keep-logs -o ../$(BUILD) $$f || exit 1; done

clean: ## Remove auxiliary files, keep the PDFs
	cd $(SRC) && $(LATEXMK) -c $(MAINS)
	rm -f $(BUILD)/*.xdv

distclean: ## Remove build/ entirely
	rm -rf $(BUILD)

help:
	@grep -E '^[a-z]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  make %-10s %s\n", $$1, $$2}'
