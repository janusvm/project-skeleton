# Makefile for project '<PROJECT>'
# --------------------------------------------------------------------------

# Main LaTeX files
PAPER = master
BIBFILE = ./tex/bib/bibliography.bib
STYFILE = ./janusvm.sty

# Directories
RDIR = ./R/scripts
FIGDIR = ./fig
TEXDIR = ./tex
DATADIR = ./data

# Flags
RSCRIPT_OPTS = --slave --vanilla
RSCRIPT_PKGS = --default-packages=utils,grDevices,graphics,stats,methods,<R_PKG>


# Source files -----------------------------------------------------------------

# Tex files
TEX := $(shell find $(TEXDIR) -type f -name "*.tex")

# R scripts, used for
# - downloading data
# - creating pdf figures
# - running analyses
R_DATA := $(wildcard $(RDIR)/data/*.R)
R_FIG := $(wildcard $(RDIR)/fig/*.R)
R_ANALYSIS := $(wildcard $(RDIR)/analysis/*.R)


# Output files -----------------------------------------------------------------

# Out files, indicating run status of scripts
DATA_OUT := $(R_DATA:.R=.Rout)
FIG_OUT := $(R_FIG:.R=.Rout)
ANALYSIS_OUT := $(R_ANALYSIS:.R=.Rout)
ALL_OUT := $(DATA_OUT) $(FIG_OUT) $(TEST_OUT)

# PDF figures
FIGS := $(wildcard $(FIGDIR)/*.pdf)

# Feather files
FEATHERS := $(wildcard $(DATADIR)/*.feather)


# Rules ------------------------------------------------------------------------

# Main command: view master file
view: $(PAPER).pdf
	evince $(PAPER).pdf &

# Compile main document
$(PAPER).pdf: $(PAPER).tex $(TEX) $(ALL_OUT) $(BIBFILE) $(STYFILE)
	latexmk -pdf -quiet $(PAPER)

# R script file rule
%.Rout: %.R
	Rscript $(RSCRIPT_OPTS) $(RSCRIPT_PKGS) $<
	touch $@

# Figures
$(FIGDIR)/%.pdf: $(RDIR)/fig/%.Rout

# Preamble files
$(STYFILE): $(TEXDIR)/pre/*.tex

# Shorthand commands
master: $(PAPER).pdf
data: $(DATA_OUT)
figures: $(FIG_OUT)
analysis: $(ANALYSIS_OUT)

# Install <R_PKG> package
package:
	Rscript $(RSCRIPT_OPTS) R/install_pkg.R

# Force rerun of all scripts and master file
force-run: clean-out view

# Clean up latexmk output files
clean-tex:
	rm -fv *.aux *.log *.toc *.blg *.bbl *.synctex.gz
	rm -fv *.out *.bcf *.blx.bib *.run.xml
	rm -fv *.fdb_latexmk *.fls
	rm -fv $(PAPER).pdf

# Delete out-files
clean-out:
	rm -fv $(ALL_OUT)

# Delete data files
clean-data:
	rm -fv $(FEATHERS)
	rm -fv $(DATA_OUT)

# Delete figures
clean-figs:
	rm -fv $(FIGS)
	rm -fv $(FIG_OUT)

# Delete analysis results
clean-analysis:
# TODO: add analysis output files to this rule, however those might look
	rm -fv $(ANALYSIS_OUT)

# Delete all output
clean-all: clean-tex clean-figs clean-data clean-analysis

# Set phony targets
.PHONY: view master data figures analysis package force-run \
 clean-tex clean-out clean-data clean-figs clean-analysis
