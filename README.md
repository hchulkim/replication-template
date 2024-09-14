replication-template
================

This repository is my template for reproducible data analysis workflow. It employs tools from Snakemake, shell script, miniconda, poetry (from python) etc. I intend to update it as I learn more efficient workflow.

## Words of caution

While this repository has a setup guide, this should be considered as a collection of resources for the reproducible workflow. What I mean by this is that some parts might not work that well. I advise you to use this template resource by just taking a subset of it. For example, I have not used Docker yet so anything written in this README.md about Docker is just a mere suggestion.

Also, note that I am currently using a linux laptop (to be exact, Pop!_OS which is built from Ubuntu).

## Motivation

Why do we need these tools? When you start writing huge and complicated projects, it is easy to get lost. This means you are more prone to making mistakes in your data analysis. This could be very fatal to your work. Also, when your project becomes complicated, you likely do many redundant works that will cost you time. Thus, having a reproducible data workflow allows us to avoid this and make your project credible and efficient.

## Workflow

Instead of giving you instructions for all of the necessary tools, software, etc right off the bat, I am going to follow my usual workflow when performing empiric research and tell you to install something when I start to use it in my workflow. I believe this will allow you a more consistent framework while ensuring reproducibility.

### Start of the workflow

This is just the starting part of my workflow. Normally this would mean I have something on my mind that I feel would be interesting to look into. At this stage, you will not be doing much to ensure reproducibility. This is because the cost is too high. This idea might soon have a dead end. In this case, setting up all the necessary tools in advance would be just a waste of time. Thus, this stage if just where I just manually download some raw data files and do some basic analysis (i.e. plotting and regression) without putting much effort.

But still, there are some things you could do to make your life easier in the future: 

#### Option 1: Renv package in R

1. **Use renv R-package**: "Renv" package records the versions of the R packages you use to ensure reproducibility. You can install by using this code in the R console.

```{r}
install.packages("renv")
```

2. Convert your project (you should already know what an R-project is by now!) by running this code.

```{r}
# This code creates three new files and directories in the project.
# 1. "renv/library" folder will contain all the packages currently used in the project. Unlike the global library, this is a specific library of packages for your project.
# 2. "renv.lock" is a lock file that records metadata about all the packages used in the project. This allows us to have packages re-installed on a new machine.
# 3. ".Rprofile" is run automatically every time you start R in the project and renv uses it to configure your R session to use the project library. This ensures that once you turn on renv for a project, it stays on, until you deliberately turn it off.

renv::init()

# Info source: https://rstudio.github.io/renv/articles/renv.html
```

3. The Basic process of using renv package is as follows: You periodically run `run::snapshot()` which will update the lock file with metadata about the currently-used packages in the project. For example, you might later have to use some new package that was not updated in lock file. This will be updated to lock file if you run this code. Later other people can reproduce your current R-package environment by running `renv::restore()` which will use the metadata from the lock file to exactly install the same version of every package.

4. The only caveat is that renv package does not track the version of R itself. We will later tackle this using Docker.

#### Option 2: nix

TBD as I don't think I need to go this far for now.

### Mid-part of the workflow

This is a stage in your workflow where you have done a significant amount of work on the research topic because you feel it is something worth looking into and there are some interesting results.

This is about time you start constructing a more consistent flow for your project. At this point, it is very unlikely that you will stop this research. Thus, ensuring reproducibility and logically consistent workflow is very important. If you later realize that your grand result was due to some minor detail you failed to notice (e.g. you should have run some code but forgot), the consequence can be fatal. 

This is when you need **Make**. **Make** is a tool that records your acyclic workflow to ensure reproducibility. If you want to know more about it, check out Professor Dingel's advice on [build automation](https://tradediversion.net/2019/11/06/why-your-research-project-needs-build-automation/).

1. **Install Make**: Fortunately, Make is already installed in most of ubuntu. I am not sure about Mac or Windows. In case you cannot use it in another OS, try **Snakemake**. This is a Python-based tool that works similar to that of Make but has much better functions. The only reason I am not using it is because I have to use conda to install it which I feel can be a bit of a nuisance when using Docker later. Also, you can use **targets** which is a R package that does similar things. I will not elaborate on these since I will not be using them for my workflow.

2. **Create Makefile**: You use Makefile to set up the pipeline to perform your research process. I have provided two Makefile templates you can use in this repository. To run the Makefile, you simply type `Make` in the console.

### End of the workflow

This part is when you are almost finished with your workflow. You are either just periodically updating it or getting it ready for publication. This is when you should try Docker.

Docker is a container that packages all the necessary factors (OS, packages, dependencies, etc) into a separate environment so that anyone else not using your machine can exactly replicate it as if you have shipped your machine to their homes.

The way it works is as follows: You create a "Dockerfile" which will work as a recipe to make the necessary environment for your research project. This will create an "image" which is like a building block for running your project. The image will give us a "container" for other people to run your project.

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

2. Create a **Dockerfile**: I have a sample Dockerfile in the repository. Check it out. I will not thoroughly explain what each command means in the Dockerfile. You can check out some manuals online.  Also, you might need to run the code below  since sometimes OS like Linux needs to have some system dependencies installed. Check this website for reference: [ref](https://packagemanager.posit.co/client/#/). 

```console
RUN apt-get update && apt-get install -y \
    libglpk-dev \
    libxml2-dev
```

3. **Build Docker image**

```console
sudo docker build --network=host --tag <PROJECT_NAME>:VERSION .
```

4. **Run Docker image**

```console
sudo docker run -it --rm <PROJECT_NAME>:VERSION
```

5. Some useful docker commands

```console
# check cached docker images
sudo docker images

# check docker containers that are running
sudo docker ps

# remove the docker image
sudo docker rmi <IMAGE_NAME>

# remove all dangling images and caches (do it periodically to save space)
sudo docker system prune
```

## What if I use Python or Julia?

There can be a problem if you are not just using R for analysis. This is quite common for researchers. This is not a problem; we can install Python and Julia using Dockerfile. You can check how to do this using the Dockerfile template on this repository.

## Example

For simple trial and error, I made a basic folder that contains a basic template to use Docker and run Make. Use the method above to build and run Docker images. Also, you will be able to create a simple rds file by running Make.

## Acknowledge

I adopted most of my replication workflow from the [Riffomonas Project](https://www.youtube.com/@Riffomonas). Thank you, Pat Schloss! Also, most of my Snakemake-related materials and templates were adopted and built from [Reproducible Data Analytic Workflows with Snakemake and R](http://lachlandeer.github.io/snakemake-econ-r-tutorial) as well. Kudos to Bergmann, U, Deer, L and Langer, J! Kudos to Professor Dingel as well as I have learn so much from his website on build automation. 
