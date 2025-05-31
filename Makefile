# Makefile for analysis report
#

## Directory vars (usually only these need changing)
rawdir = input/raw
inputdir = input/
rdir = R/
juliadir = julia/
outputdir = output/
figsdir = output/figures
tabsdir = output/tables
slidsdir = output/slides
papdir = output/paper


## See note about new grouped targets method, i.e. replacing ":" with "&:"
## https://stackoverflow.com/a/59877127/4115816

## Headline build
all: data stan main recursive evidence sensitivity paper

data: $(inputdir)climate.csv $(inputdir)priors.csv $(inputdir)df18.fst
stan: $(standir)mod-pred.stan $(standir)mod.stan $(standir)mod-anthro.stan \
 $(standir)mod-me.stan
main: $(outputdir)main/tcr.fst $(outputdir)main/gmst2100.fst \
 $(outputdir)main/gmst-pred.csv $(outputdir)main/params.csv $(outputdir)main/gmst-sim.csv
recursive: $(outputdir)recursive/tcr-rec.csv
evidence: $(outputdir)evidence/evid.csv
sensitivity: $(outputdir)sensitivity/params-alt-gmst.csv $(outputdir)sensitivity/tcr-alt-gmst.fst \
 $(outputdir)sensitivity/params-me-gmst.csv $(outputdir)sensitivity/tcr-me-gmst.fst \
 $(outputdir)sensitivity/tcr-me-forcings.fst \
 $(outputdir)sensitivity/tcr-eff1.fst $(outputdir)sensitivity/tcr-eff2.fst \
 $(outputdir)sensitivity/params-anthro.csv $(outputdir)sensitivity/tcr-anthro.fst
scc: $(outputdir)scc/scc.csv
paper: $(papdir)sceptic/sceptic.pdf $(papdir)SM/sceptic-SM.pdf
 
clean:
	rm -f $(rawdir)* $(inputdir)* $(outputdir)* $(figsdir)* $(papdir)sceptic/* $(papdir)SM/* $(perfdir)*
	
	
	
file_abbc: file_ab file_bc
    copy file_ab+file_bc file_abbc

file_ab file_bc &: file_a file_b file_c
    copy file_a+file_b file_ab
    copy file_b+file_c file_bc

file_a file_b file_c &: content
    copy content file_a
    copy content file_b
    copy content file_c

## Draw the Makefile DAG
## Requires: https://github.com/lindenb/makefile2graph
dag: makefile-dag.png
makefile-dag.png: Makefile
	make -Bnd all | make2graph | dot -Tpng -Gdpi=300 -o makefile-dag.png

## Raw Data
raw: $(rdir)00-data-raw.R
	Rscript $<
	rm Rplots.pdf

## Prep Data
$(inputdir)climate.csv: $(rdir)01-data-prep.R $(rawdir)*
	Rscript $<
	rm Rplots.pdf

$(inputdir)priors.csv: $(rdir)01-data-prep.R $(inputdir)climate.csv
	Rscript $<
	rm Rplots.pdf

$(inputdir)df18.fst: $(rdir)01-data-prep.R $(rawdir)df18.idlsave
	Rscript $<
	rm Rplots.pdf

## Results

### Main results
#results_main = $(outputdir)main/tcr.fst $(outputdir)main/gmst2100.fst \
# $(outputdir)main/gmst-pred.csv $(outputdir)main/params.csv $(outputdir)main/gmst-sim.csv
#$(results_main) &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
#	Rscript $<
#	
$(outputdir)main/tcr.fst &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)main/gmst2100.fst &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)main/gmst-pred.csv &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)main/params.csv &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)main/gmst-sim.csv &: $(rdir)02-main.R $(standir)mod-pred.stan $(inputdir)climate.csv
	Rscript $<

### Recursive results
results_recursive = $(outputdir)recursive/tcr-rec.csv
$(results_recursive) &: $(rdir)03-recursive.R $(standir)mod.stan $(inputdir)climate.csv
	Rscript $<
	
### Evidence results
results_evidence = $(outputdir)evidence/evid.csv
$(results_evidence) &: $(rdir)04-evidence.R $(standir)mod.stan $(inputdir)climate.csv \
 $(outputdir)main/gmst-sim.csv
	Rscript $<

### Sensitivity analysis results

#### a) Alt GMST series
#results_gmst_alt = $(outputdir)sensitivity/params-alt-gmst.csv $(outputdir)sensitivity/tcr-alt-gmst.fst
#$(results_gmst_alt) &: $(rdir)05-sensitivity-alt-gmst.R $(standir)mod.stan $(inputdir)climate.csv
#	Rscript $<
$(outputdir)sensitivity/params-alt-gmst.csv &: $(rdir)05-sensitivity-alt-gmst.R \
 $(standir)mod.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)sensitivity/tcr-alt-gmst.fst &: $(rdir)05-sensitivity-alt-gmst.R \
 $(standir)mod.stan $(inputdir)climate.csv
	Rscript $<

#### b) Measurement error in GMST
#results_me_gmst = $(outputdir)sensitivity/params-me-gmst.csv $(outputdir)sensitivity/tcr-me-gmst.fst
#$(results_me_gmst) &: $(rdir)05-sensitivity-me-gmst.R $(standir)mod-me.stan $(inputdir)climate.csv
#	Rscript $<
$(outputdir)sensitivity/params-me-gmst.csv &: $(rdir)05-sensitivity-me-gmst.R \
 $(standir)mod-me.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)sensitivity/tcr-me-gmst.fst &: $(rdir)05-sensitivity-me-gmst.R \
 $(standir)mod-me.stan $(inputdir)climate.csv
	Rscript $<

#### c) Measurement error in forcings
results_me_gmst = $(outputdir)sensitivity/tcr-me-forcings.fst
$(results_me_gmst) &: $(rdir)05-sensitivity-me-forcings.R $(standir)mod.stan $(inputdir)climate.csv \
 $(inputdir)df18.fst
	Rscript $<

#### d) Adjust forcing efficacies (Marvel et. al, 2016)
#results_eff = $(outputdir)sensitivity/tcr-eff1.fst $(outputdir)sensitivity/tcr-eff2.fst
#$(results_eff) &: $(rdir)05-sensitivity-eff.R $(standir)mod.stan $(inputdir)climate.csv \
# $(rawdir)rcps.csv
#	Rscript $<
$(outputdir)sensitivity/tcr-eff1.fst &: $(rdir)05-sensitivity-eff.R \
 $(standir)mod.stan $(inputdir)climate.csv $(rawdir)rcps.csv
	Rscript $<
$(outputdir)sensitivity/tcr-eff2.fst &: $(rdir)05-sensitivity-eff.R \
 $(standir)mod.stan $(inputdir)climate.csv $(rawdir)rcps.csv
	Rscript $<

#### e) Separate out anthropogenic forcings
#results_anthro = $(outputdir)sensitivity/params-anthro.csv $(outputdir)sensitivity/tcr-anthro.fst
#$(results_anthro) &: $(rdir)05-sensitivity-anthro.R $(standir)mod-anthro.stan $(inputdir)climate.csv
#	Rscript $<
$(outputdir)sensitivity/params-anthro.csv &: $(rdir)05-sensitivity-anthro.R \
 $(standir)mod-anthro.stan $(inputdir)climate.csv
	Rscript $<
$(outputdir)sensitivity/tcr-anthro.fst &: $(rdir)05-sensitivity-anthro.R \
 $(standir)mod-anthro.stan $(inputdir)climate.csv
	Rscript $<

## Social cost of carbon
$(outputdir)scc/scc.csv &: $(juliadir)scc.jl $(outputdir)main/tcr.fst
	julia $<

## Paper
$(papdir)sceptic/sceptic.pdf &: $(papdir)sceptic/sceptic.Rmd \
 $(inputdir)climate.csv $(inputdir)priors.csv \
 $(outputdir)main/params.csv $(outputdir)main/tcr.fst \
 $(outputdir)main/gmst-pred.csv $(outputdir)main/gmst2100.fst \
 $(outputdir)recursive/tcr-rec.csv $(outputdir)evidence/evid.csv \
 $(outputdir)scc/scc.csv
	Rscript -e 'rmarkdown::render("$<")'
$(papdir)SM/sceptic-SM.pdf: $(papdir)SM/sceptic-SM.Rmd $(outputdir)scc/scc.csv
	Rscript -e 'rmarkdown::render("$<")'

## Helpers
.PHONY: all clean dag data stan main recursive evidence sensitivity scc paper
.DELETE_ON_ERROR:
.SECONDARY:
