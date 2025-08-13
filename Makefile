################################
# Makefile for analysis report
#
# Maintainer: HK
################################

## Directory vars (usually only these need changing)
inputdir = input/
outputdir = output/
figsdir = output/figures/
tabsdir = output/tables/
slidsdir = output/slides/
papdir = output/paper/

## Headline build
all: 
 
clean:
	rm -f $(inputdir)* $(figsdir)* $(papdir)* $(slidsdir)* $(papdir)*
	
## Helpers
.PHONY: all clean
