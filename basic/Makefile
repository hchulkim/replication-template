# Makefile for analysis report
#

.PHONY: all clean

all: output/tables/processed_data.rds


output/tables/processed_data.rds: input/data/raw_data.rds input/code/test.R
	cd input/code && Rscript test.R

clean:
	rm -f output/tables/*
