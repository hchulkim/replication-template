replication-template
================

This repository is my template for reproducible data analysis workflow. It employs tools from Snakemake, shell script, miniconda, poetry (from python) etc. I intend to update it as I learn more efficient workflow.

## Words of caution

While this repository has a setup guide, this should be considered as a collection of resources for the reproduble workflow. What I mean by this is that there are some parts that might not work that well. I advise you to use this template resource by just taking a subset of it. For example, I have not used Docker yet so anything written in this README.md about Docker is just a mere suggestion. Also, there might be some issues as I use conda, poetry, snakemake altogether. So far there has not been an issue at least on my end but you can never be sure. What I am doing below is basically creating virtual environment using conda (mamba) and use config.yml to get specific version of base R, R packages and Python. Then I use poetry to install and record python packages I am using. I am trying to use poetry because conda cannot keep track of the dependences of the dependencies and packages from pip. For now I do not have separate poetry package in config.yml because I heard from somewhere that this could create issues. 

## Motivation

Why do we need these tools? When you start writing huge and complicated projects, it is easy to get lost. This means you are more prone to making mistake in your data analysis. This could be very fatal to your work. Also, when your project becomes complicated, it is very likely that you do many redundant works that will cost you time. Thus, having reproducible data workflow allows us to avoid this and make your project credible and efficient.

## Tool setup

In order to use this workflow, we need to install and setup some programs and files. Note that the goal of the setup is to use conda to make a separate environment where we store all the packages and dependencies used in the analysis to ensure reproducibility.

1. **miniconda installation**: We need miniconda to set up separate environment to store all our necessary packages and dependencies in R (and also python version).

```console
# Remember to first download the .sh installer from miniconda website.
# Run the following command:
$ bash <FILE_NAME>
```

2. **mamba installation**: Use conda command to install mamba which is a reimplementation of the conda package manager in C++. From now on, we will always use mamba command instead of conda command except for "conda activate."

```console
$ conda install -n base -c conda-forge mamba
```

3. **Make a config.yml file** for setting necessary packages and dependencies for the conda environment. Example template is in my repository. Then use following command to create the environment. 

```console
$ mamba env create -f config.yml
```

4. **Activate the conda environment**

```console
$ conda activate <ENVIRONMENT_NAME>
```

5. **Run "poetry init" in the project directory to get the necessary package versions and dependencies for python packages**:

```console
# go to the project directory and use the command below to set up poetry:
$ poetry init

# you can add new packages using the following code:
$ poetry add <PACKAGE_NAME>

# if other people want to use the correct versions and dependencies for the python packages, they can use following code to have it installed from lock file:
$ poetry install
```

6. **Make some bash files for automation**: Use bash files to download some files from the web, etc. I also have an example template for the bash file in the repository.

7. **Make a Snakefile**: This is used as a script that runs some bash script. We use bash scripts to run automatic command in the terminal (e.g. downloading files, etc). Snakefile allows to make set of rules to implement this in a clear, reproducible way. Snakefile can also run R scripts or other programming scripts. To do this, you need to make **snakefile**. I also have an example template for the snakefile in the repository.

8. Check if the Snakefile is well defined using the code below:

```console
# Use one of these two code
$ snakemake --dry-run <RULE>
$ snakemake -np <RULE>
```

9. **Run Snakefile** using the code below to rerun your whole analysis. (If you need more information about how to run Snakefile, try Reproducible Data Analytic Workflows site linked in the Acknowledgement).

```console
$ snakemake --cores 1
```

10. **Make DAG graph** using the following code:

```console
$ snakemake --dag targets | dot -Tpng > dag.png
```

11. You might consider using **Docker** to fully ensure that you have the necessary operating system environment to replicate the code. The way to pull this off might not be easy since we are using conda + poetry + docker. But there are some resources (e.g. [resource1](https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754), [resource2](https://pythonspeed.com/articles/activate-conda-dockerfile/), [resource3](https://github.com/michaeloliverx/python-poetry-docker-example)) that seems to hint that it will work. I will try it later. For now, this part seems a bit of an overkill.


## Acknowledge

I adopted most of my replication work flow from the [Riffomonas Project](https://www.youtube.com/@Riffomonas). Thank you, Pat Schloss! Also, most of my Snakemake-related materials and templates was adopted and built from [Reproducible Data Analytic Workflows with Snakemake and R](http://lachlandeer.github.io/snakemake-econ-r-tutorial) as well. Kudos to Bergmann, U, Deer, L and Langer, J!
