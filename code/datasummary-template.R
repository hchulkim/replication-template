library(tidyverse)
library(modelsummary)
library(fixest)


# define custom statistic
MinMax <- function(x) paste0('[', min(x, na.rm = TRUE), ', ', max(x, na.rm = TRUE), ']')


# Generate LaTeX output
output_tex <- datasummary(mpg + cyl ~ Factor(vs) * (mean + sd + MinMax), 
                          data = mtcars, 
                          align = 'lcccccc',
                          output = "latex")

datasummary(mpg + cyl ~ Factor(vs) * (mean + sd + MinMax), 
            data = mtcars,
            align = 'lcccccc')


# Convert the output to a single character string
output_tex <- paste(output_tex, collapse = "\n")

# Remove \begin{table} and \end{table}
output_tex_cleaned <- str_replace(output_tex, "(?s)\\\\begin\\{table\\}.*?\\\\begin\\{tblr\\}", "\\\\begin{tblr}")
output_tex_cleaned <- str_replace(output_tex_cleaned, "(?s)\\\\end\\{tblr\\}.*?\\\\end\\{table\\}", "\\\\end{tblr}")

# Write to a file
writeLines(output_tex_cleaned, "summary_output.tex")
