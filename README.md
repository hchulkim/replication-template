replication-template
================

This repository is my template for reproducible data analysis workflow. It employs tools from Snakemake, shell script, miniconda, poetry (from python) etc. I intend to update it as I learn more efficient workflow.

## Words of caution

While this repository has a setup guide, this should be considered as a collection of resources for the reproduble workflow. What I mean by this is that there are some parts that might not work that well. I advise you to use this template resource by just taking a subset of it. For example, I have not actually used Docker yet so anything written in this README.md about Docker is just a mere suggestion.

Also, note that I am currently using a linux laptop (to be exact, Pop!_OS which is built from Ubuntu).

## Motivation

Why do we need these tools? When you start writing huge and complicated projects, it is easy to get lost. This means you are more prone to making mistake in your data analysis. This could be very fatal to your work. Also, when your project becomes complicated, it is very likely that you do many redundant works that will cost you time. Thus, having reproducible data workflow allows us to avoid this and make your project credible and efficient.

## Workflow

Instead of giving you instructions for all of the necessary tools, softwares, etc right off the bat, I am going to follow my usual workflow when performing empiric research and tell you to install something when I start to use it in my workflow. I believe this will allow you a more consistent framework while ensuring reproducibility.

### Start of the workflow

This is just the starting part of my workflow. Normally this would mean I have something on my mind that I feel would be interesting to look into. At this stage, you will not be doing much to ensure reproducibility. This is because cost is too high. This idea might soon have a dead end. In this case, setting up all the necessary tools in advance would be just a waste of time. Thus, this stage if just where I just manually download some raw data files and do some basic analysis (i.e. plotting and regression) without putting much effort.

But still, there are somethings you could do to make your life easier in the future: 

#### Option 1: Renv package in R

1. **Use renv R-package**: "Renv" package records the versions of the R packages you use to ensure reproducibility. You can install by using this code in the R console.

```{r}
install.packages("renv")
```

2. Convert your project (you should already know what a R-project is by now!) by running this code.

```{r}
# This code basically creates three new files and directories into the project.
# 1. "renv/library" folder will contain all the packages currently used in the project. Unlike global library, this is a specific library of packages for your project.
# 2. "renv.lock" is a locfile that records metadata about all the packages used in the project. This allows us to have packages re-installed on a new machine.
# 3. ".Rprofile" is run automatically every time you start R in the project and renv uses it to configure your R session to use the project library. This ensures that once you turn on renv for a project, it stays on, until you deliberately turn it off.

renv::init()

# Info source: https://rstudio.github.io/renv/articles/renv.html
```

3. Basic process of using renv package is as follows: You periodically run `run::snapshot()` which will update the lockfile with metadata about the currently-used packages in the project. For example, you might later have to use some new package that was not updated in lock file. This will be updated to lock file if you run this code. Later other people can reproduce your current R-package environment by running `renv::restore()` which will use the metadata from the lock file to exactly install the same version of every package.

4. The only caveat is that renv package does not track the version of R itself. We will later tackle this using Docker.

#### Option 2: nix

### Mid-part of the workflow

This is a stage in your workflow where you have done significant amount of work on the research topic because you feel it is something worth looking into and there are some interesting results.

This is about time you start constructing a more consistent flow for your project. At this point, it is very unlikely that you will stop this research. Thus, ensuring reproducibility and logically consistent workflow is very important. If you later realize that your grand result was due to some minor detail you failed to notice (e.g. you should have run some code but forgot), the consequence can be fatal. 

This is when you need **Make**. **Make** is basically a tool that records your acyclic workflow to ensure reproducibility. If you want to know more about it, check out Professor Dingel's advice on [build automation](https://tradediversion.net/2019/11/06/why-your-research-project-needs-build-automation/).

1. **Install Make**: Fortunately, Make is already installed in most of ubuntu. I am not sure about Mac or Windows. In case you cannot use it in other OS, try **Snakemake**. This is Python based tool that works similar to that of Make but have much better functions. The only reason I am not using it is because I have to use conda to install it which I feel can be bit of a nuisance when using Docker later. Also, you can use **targets** which is a R package that does similar things. I will not elaborate on these since I will not be using it for my workfllow.

### TBD

### End of the workflow

This part is when you are almost finished with your workflow. You are either just periodically updating it or getting it ready for publication. This is when you should try Docker.

Docker is basically a container that packages all the necessary factors (OS, packages, dependencies, etc) into a separate environment so that anyone else not using your machine can exactly replicate it as if you have shipped your machine to their homes.

The way it works is as follows: You create a "Dockerfile" which will work as a recipe to make the necessary environment for your research project. This will create a "image" which is like a building block for running your project. Then image will give us a "container" for other people to run your project.

1. Install Docker (if you haven't installed it yet)

```console
## Set up Docker's apt repository

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Install the Docker packages (latest)
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Verify that the Docker Engine Installation is successful
sudo docker run hello-world
```

2. Create a **Dockerfile**: I have a sample Dockerfile in the repository. Check it out.

3. **TBD**

## What if I use Python or Julia?

There can be a problem if you are not just using R for analysis. This is quite common for researchers.

### TBD

## Outdated

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

11. You might consider using **Docker** to fully ensure that you have the necessary operating system environment to replicate the code. The way to pull this off might not be easy since we are using conda + poetry + docker. But there are some resources (e.g. [resource1](https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754), [resource2](https://pythonspeed.com/articles/activate-conda-dockerfile/), [resource3](https://github.com/michaeloliverx/python-poetry-docker-example), [resource4](https://stackoverflow.com/questions/55123637/activate-conda-environment-in-docker), [resource5](https://pythonspeed.com/articles/activate-conda-dockerfile/), [resource6](https://medium.com/@chadlagore/conda-environments-with-docker-82cdc9d25754)) that seem to hint that it will work. I will try it later. For now, this part seems a bit of an overkill.


## Acknowledge

I adopted most of my replication work flow from the [Riffomonas Project](https://www.youtube.com/@Riffomonas). Thank you, Pat Schloss! Also, most of my Snakemake-related materials and templates was adopted and built from [Reproducible Data Analytic Workflows with Snakemake and R](http://lachlandeer.github.io/snakemake-econ-r-tutorial) as well. Kudos to Bergmann, U, Deer, L and Langer, J!
