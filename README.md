# Replication template

This part should contain following information:

1. Documentation: A README document is included, containing a Data Availability Statement, listing all software and hardware dependencies and requirements (including the expected run time), and explaining how to reproduce the research results. The README follows the schema provided by the Social Science Data Editors’ template README
2. Data availability statement: A Data Availability Statement is provided with detailed enough information such that an independent researcher can replicate the steps needed to access the original data, including any limitations and the expected monetary and time cost of data access.
3. Location: Data and programs are archived by the authors in the repositories deemed acceptable by the journal.
4. Citation: All data used in the paper are cited.
5. License: A license specifies the terms of use of code and data in the replication package. The license allows for replication by researchers unconnected to the original parties.
6. Omissions: The README clearly indicates any omission of the required parts of the package due to legal requirements or limitations or other approved agreements.

## README Checklist

- [ ] Data Availability and Provenance Statements
  - [ ] Statement about Rights
  - [ ] License for Data (optional, but recommended)
  - [ ] Details on each Data Source
- [ ] Dataset list
- [ ] Computational requirements
  - [ ] Software Requirements
  - [ ] Controlled Randomness (as necessary)
  - [ ] Memory, Runtime, and Storage Requirements
- [ ] Description of programs/code
  - [ ] License for Code (Optional, but recommended)
- [ ] Instructions to Replicators
  - [ ] Details (as necessary)
- [ ] List of tables and programs
- [ ] References (Optional, but recommended)

# Information on overall replication workflow

This is a replication template (or empirical analysis template) for me.

## Summary

0. Workflow
1. Requirements
2. Setup
3. Folders
4. Files
5. Leveraging on Github Capabilities
6. Writing
7. Journal Submissions
8. Principles

## 0. Workflow

When starting research, you should consider logistics between 2 or 3 components:

- Dropbox folder
- local folder
- (optional) Overleaf

### Dropbox folder (data)

This is your folder for hosting data. It is nice to have Dropbox as the folder for your data because data becomes too large to just host it on your local folder.

### local folder (main machine)

This is your main folder for analysis. You should put everything other than data in the local folder.

### (optional) Overleaf

Sometimes this is useful for collaborating and writing papers. But you should do this only if you have premium subscription so you can use the Dropbox syncing feature.

### coding workflow

0. Set git in local folder.
1. Use symlink to link Dropbox data folder to `input` file in the local folder. This allows you to use data as if you have them in your local folder.
2. Use symlink to link Overleaf `output` folder to `output` file in the local folder. This allows you to access output results in the overleaf (Only if you have premium subscription).
3. Overall flow: Do all the analysis in the local folder and use git to record them. Write reports/papers in the overleaf.

## 1. Requirements

This workflow requires:
- [Bash](https://www.gnu.org/software/bash/) [Free]
- [R](https://www.r-project.org/) [Free]
- [Julia](https://julialang.org/) [Free]
- [Python](https://www.python.org) [Free] 
- [LaTeX](https://www.latex-project.org) [Free]

Other great languages and softwares may also be used.
- [Stata](https://www.stata.com) [Licensed]
- [Matlab](https://www.mathworks.com/products/matlab) [Licensed]

For now, it is only adapted for Linux or OSX (Apple) environments. But feel free to adapt it to Windows.

#### Dependency management

It is important to set up dependency management for the programming languages we use for replication and reproducibility. Here are lists of management program that I use:

- `R`: I use `renv` package.
- `Julia`: I just use `Pkg`.

## 2. Folders

##### `src`

- This folder contains all the code that builds data and performs analyses.
- All intermediary data results should be redirected into `input/temp`.
- All final data results should be redirected into `input/proc`.
- All output tables and figures should be redirected into `output/tables` and `output/figures` respectively.
- Keep the names of the code files clear and easy to understand. Try to number them as well.
  
##### `input`

- A folder that contains all the input data.
- Has subfolders `raw`, `temp`, `proc`, which contain raw data, intermediary data, and processed data (ready for analysis).
  
##### `output`

- A folder that contains all the outputs.
- Has subfolders that contain figures and tables.
- `slides` subfolder contains slides for presentation.
- `paper` subfolder contains working paper.

## 3. Leveraging on Github capabilities

- Use issues as tasks. Track it all on a project board named "Tasks".
	- Add tags to tasks to track progress by area. Some template tags included: `build`, `analysis`, `writing`, `review`, `enhancement`, `bug`.
- Name commits following [conventional notation](https://www.conventionalcommits.org).
- Add forward-looking tags and milestones to plan and version work.
	- These help marking relevant releases, such as a minimum viable product (MVP), a paper submission, or a talk.
	- Use [semantic versioning](https://semver.org/) for naming, e.g. `v0.1`, `v1.0.2`.
- Only modify files via pull requests. Use closing keywords to close issues.
