# Replication template

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

### Dropbox folder (main machine)

This is your main folder for research. You should have everything related to research including code scripts, data, outputs, paper, slides, etc. It is nice to have Dropbox as the main folder for your research because data becomes too large to just host it on your local folder.

### local folder (sub machine)

This is your folder for sub machine. When you are traveling or in some other places, it is hard to use the main machine. Thus, you should put the code and data in the local folder.

### (optional) Overleaf

Sometimes this is useful for collaborating and writing papers.

### coding workflow

0. Set git in Dropbox folder.
1. Use the git to clone it into local folder.
2. Manually copy data from Dropbox to local folder.
3. **ONLY** modify Dropbox folder from your main machine! In local folder, you should only copy data from Dropbox folder or copy `data/temp` results to Dropbox.
4. Use git to share analysis from local folder to Dropbox.
5. **CODING flow**: (0) Copy raw data from Dropbox to local if there is an update; (1) git pull; (2) git commit; (3) git push; (4) copy `data/temp` results to Dropbox (if in local folder); (5) do git pull, commit, and push for Dropbox; (6) `make copy_paste` for overleaf (in Dropbox).
6. **After modifying from Overleaf (After you are all done with coding in Dropbox)**: (1) copy `output` folder to Dropbox folder; (2) git pull, commit, and push.

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
- `Python`: I use `poetry` package.
- `Julia`: I just use `Pkg`.

## 2. Setup

1. Create or join a cloud folder (e.g. on Dropbox or Drive) where large non-versioned files will reside.
2. Clone this repository to a local folder *outside* the cloud folder.

You're good to go. This repository is now ready for the standard workflow described below.

## 3. Folders

##### `code`

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

#### `lit`

- A folder that contains literature.

##### `ref`

- A folder that contains reference materials.

## 4. Files

##### `Dockerfile`

- Builds the necessary environment to run the analysis on any computer.
- In essence, it **ships my computer environment setup to your computer.**

##### `Makefile`

- Automates the whole paper construction.
- Runs everything in a pre-specified order, from beginning (building data sets) to end (compiling `.tex` files).
- Keeps clear what should be run when.

##### `renv.lock`, `pyproject.toml`, `poetry.lock`, `Project.toml`, `Manifest.toml`

- Files related to dependency management.

## 5. Leveraging on Github capabilities

- Use issues as tasks. Track it all on a project board named "Tasks".
	- Add tags to tasks to track progress by area. Some template tags included: `build`, `analysis`, `writing`, `review`, `enhancement`, `bug`.
- Name commits following [conventional notation](https://www.conventionalcommits.org).
- Add forward-looking tags and milestones to plan and version work.
	- These help marking relevant releases, such as a minimum viable product (MVP), a paper submission, or a talk.
	- Use [semantic versioning](https://semver.org/) for naming, e.g. `v0.1`, `v1.0.2`.
- Only modify files via pull requests. Use closing keywords to close issues.

## 6. Writing

All writing should be done within the repository to preserve versioning and consistency.

## 7. Journal Submissions

Use this folder and Github for working on reviewing drafts (e.g. after a Revise and Resubmit request).

Flow:
1. Centralize all numbered comments in one document uploaded to `output/paper/comments.txt`.
2. Assign comments to issues with clear tasks described in text. Assign issues to people, add tags, add milestone for "journal resubmission", etc. Add issue numbers below each review comment so that it can be tracked 1:1.
3. Work on issues, add sentences/paragraphs together with commit messages describing changes made to code and writing.
4. When all is done, set a tag for the release and send it off for the journal.

Use tags: `review`, `build`, `analysis`, `writing`, `negative replies`.

## 8. Principles

- For each new project, start (i) a structured versioned folder, (ii) a task manager project, and (iii) a set of slides.
	1. Copy this folder and use a version control system (e.g. [Git](https://git-scm.com/)).
		* Keep track of multiple authors' edits.
		* No more `report_final_v3.2b_ST_toDelete.tex`.
		* Use branching to work simultaneously on code.
	2. Use Github's issues and projects as a task management system. (For other tools, see [ClickUp](https://clickup.com/), [2Do](https://www.2doapp.com/), [Asana](https://asana.com), [Trello](https://trello.com/), and [JIRA](https://www.atlassian.com/software/jira)).
		* Your email inbox is not a task manager.
		* Tasks should be actionable atoms.
		* Set priorities, assignments, due dates, etc.
		* Only one person should be ultimately responsible for each task.
		* Do regular reviews and cleaning.
	3. Slides
		* Containing the current (summarized) version of the paper.
		* Update it continuously. It will discipline your work.
- Use a good text editor (I recommend [Visual Studio Code](https://code.visualstudio.com/) or [vim](http://www.vim.org/)).
- Use a modern and flexible communication tool (see [Discord](https://discord.com/) or [Slack](https://slack.com)).
- Use a good reference/citation manager.
- Keep documentation lean and clean.
- Keep this folder organized. Your future self thanks your present effort.
