Outdated (Just for reference)
========================
1. **miniconda installation**: We need miniconda to set up a separate environment to store all our necessary packages and dependencies in R (and also python version).

```console
# Remember to first download the .sh installer from miniconda website.
# Run the following command:
$ bash <FILE_NAME>
```

2. **mamba installation**: Use conda command to install mamba which is a reimplementation of the conda package manager in C++. From now on, we will always use mamba command instead of conda command except for "conda activate."

```console
$ conda install -n base -c conda-forge mamba
```

3. **Make a config.yml file** for setting necessary packages and dependencies for the conda environment. Example template is in my repository. Then use the following command to create the environment. 

```console
$ mamba env create -f config.yml
```

4. **Activate the conda environment**

```console
$ conda activate <ENVIRONMENT_NAME>
```

5. **Run "poetry init" in the project directory to get the necessary package versions and dependencies for python packages**:

```console
# Go to the project directory and use the command below to set up poetry:
$ poetry init

# You can add new packages using the following code:
$ poetry add <PACKAGE_NAME>

# If other people want to use the correct versions and dependencies for the python packages, they can use the following code to have it installed from the lock file:
$ poetry install
```

6. **Make some bash files for automation**: Use bash files to download some files from the web, etc. I also have an example template for the bash file in the repository.

7. **Make a Snakefile**: This is used as a script that runs some bash script. We use bash scripts to run automatic commands in the terminal (e.g. downloading files, etc). Snakefile allows to make a set of rules to implement this in a clear, reproducible way. Snakefile can also run R scripts or other programming scripts. To do this, you need to make **snakefile**. I also have an example template for the snakefile in the repository.

8. Check if the Snakefile is well-defined using the code below:

```console
# Use one of these two code
$ snakemake --dry-run <RULE>
$ snakemake -np <RULE>
```

9. **Run Snakefile** using the code below to rerun your whole analysis. (If you need more information about how to run Snakefile, try the Reproducible Data Analytic Workflows site linked in the Acknowledgement).

```console
$ snakemake --cores 1
```

10. **Make DAG graph** using the following code:

```console
$ snakemake --dag targets | dot -Tpng > dag.png
```

11. You might consider using **Docker** to fully ensure that you have the necessary operating system environment to replicate the code. The way to pull this off might not be easy since we are using conda + poetry + docker. But there are some resources (e.g. [resource1](https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754), [resource2](https://pythonspeed.com/articles/activate-conda-dockerfile/), [resource3](https://github.com/michaeloliverx/python-poetry-docker-example), [resource4](https://stackoverflow.com/questions/55123637/activate-conda-environment-in-docker), [resource5](https://pythonspeed.com/articles/activate-conda-dockerfile/), [resource6](https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754)) that seem to hint that it will work. I will try it later. For now, this part seems a bit of an overkill.
