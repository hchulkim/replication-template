###This is some examples for using kableExtra package. 

## Load the package
library(kableExtra)

## You need these latex packages to make it work smoothly:
# header-includes:
#   - \usepackage{booktabs}
# - \usepackage{longtable}
# - \usepackage{array}
# - \usepackage{multirow}
# - \usepackage{wrapfig}
# - \usepackage{float}
# - \usepackage{colortbl}
# - \usepackage{pdflscape}
# - \usepackage{tabu}
# - \usepackage{threeparttable}
# - \usepackage{threeparttablex}
# - \usepackage[normalem]{ulem}
# - \usepackage{makecell}
# - \usepackage{xcolor}

## Main setup for getting latex output with no table environment

kbl(mtcars[1:10, 1:6], format = "latex", booktabs = T) |> 
  kable_styling() |> 
  pack_rows("Group 1", 4, 7) |> 
  pack_rows("Group 2", 8, 10) %>% 
  gsub("\\\\begin\\{table\\}|\\\\end\\{table\\}", "", .)

## Some extra examples. For more, check the pdf.

dt <- mtcars[1:5, 1:6]
kbl(dt)
kbl(dt, booktabs = T) |> 
  kable_styling(latex_options = "striped")


kbl(dt, format = "latex", booktabs = T) %>%
  kable_styling(full_width = T) %>%
  column_spec(1, width = "8cm")

# long_dt <- rbind(mtcars, mtcars)
kbl(dt, booktabs = T) |> 
  add_header_above(c(" ", "Group 1" = 3, "Group 2" = 3))
# kbl(dt, format = "latex", booktabs = T) |> 
#   add_header_above(c(" ", "Group 1" = 3, "Group 2" = 2))


kbl(df, format = "latex", booktabs = T, caption = "Longtable") %>%
  add_header_above(c(" ", "Group 1" = 5, "Group 2" = 6)) %>%
  kable_styling(latex_options = c("repeat_header"))

kbl(dt, booktabs = T) %>%
  kable_styling(font_size = 7)

text_tbl <- data.frame(
  Items = c("Item 1", "Item 2", "Item 3"),
  Features = c(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vehicula tempor ex. Morbi malesuada", 
    "In eu urna at magna luctus rhoncus quis in nisl. Fusce in velit varius, posuere risus et, cursus au",
    "Vivamus venenatis egestas eros ut tempus. Vivamus id est nisi. Aliquam molestie erat et sollicitudi")
)

kbl(text_tbl, booktabs = T) %>%
kable_styling(full_width = F) %>%
column_spec(1, bold = T, color = "red") %>%
column_spec(2, width = "30em")

kbl(dt, booktabs = T) %>%
  kable_styling("striped", full_width = F) %>%
  column_spec(7, border_left = T, bold = T) %>%
  row_spec(1, strikeout = T) %>%
  row_spec(3:5, bold = T, color = "white", background = "black")

kbl(dt, format = "latex",booktabs = T) %>%
  kable_styling("striped", full_width = F) %>%
  column_spec(7, border_left = T, bold = T) %>%
  row_spec(1, strikeout = T) %>%
  row_spec(3:5, bold = T, color = "white", background = "black")



