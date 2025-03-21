# Replication template

This is a replication template (or empirical analysis templatee) for me.

## Folder structure information

1. `code`: This is a folder where I put my codes.
2. `doc': This is a folder where I put my documents. This is usually for short reports. FYI, it uses `Quarto` to render html and pdf files.
3. `input`: This is a folder where I put my data. Inside, there are few subfolders. `raw` folder is where I put my raw data. `temp` folder is where I put my intermediate data which has been pre-processed from `raw`. `proc` folder is where I put my final data ready to be used in analysis.
4. `lit`: This is a folder where I put my literature.
5. `output`: This is a folder where I put my outputs. Inside, there are few subfolders.`figures` and `tables` folders have figures and tables results I use for my paper. `paper` folder has my working paper document. `slides` folder has my presentation slides.
6. `ref`: This is a folder where I put some miscellaneous stuffs for reference.

You can ignore other folders. But don't erase them. They are important but they do not serve any specific purpose.

## Dependencies management

- `R`: I use `renv` package.
- `Python`: I use `poetry` package.
- `Julia`: I just use `Pkg`.
