replication-template
================

This repository is my template for reproducible data analysis workflow. It employs tools from Snakemake, shell script, miniconda, etc. I intend to update it as I learn more efficient workflow.

## Tool setup

In order to use this workflow, we need to install and setup some programs and files. Note that the goal of the setup is to use conda to make a separate environment where we store all the packages and dependencies used in the analysis to ensure reproducibility.

1. **miniconda installation**: We need miniconda to set up separate environment to store all our necessary packages and dependencies.

```console
# Remember to first download the .sh installer from miniconda website.
# Run the following command:
$ bash <FILE_NAME>
```

2. **mamba installation**: Use conda command to install mamba which is a reimplementation of the conda package manager in C++.

```console
$ conda install -n base -c conda-forge mamba
```

3. **Make a config.yml file** for setting necessary packages and dependencies for the conda environment. Example template is in my repository. Then use following command to create the environment. 

```console
$ mamba env create -f config.yml
```

4. **Make a Snakefile**: This is used as a script that runs some bash script. We use bash scripts to run automatic command in the terminal (e.g. downloading files, etc). Snakefile allows to make set of rules to implement this in a clear, reproducible way. You need to make **snakefile**. I also have example template for the snakefile in the repository.

5. Run Snakefile to rerun your whole analysis.

## Acknowledge

I adopted most of my replication work flow from the [Riffomonas Project](https://www.youtube.com/@Riffomonas). Thank you, Pat Schloss!
