library(tidyverse)
library(modelsummary)
library(fixest)


est1 = feols(Ozone ~ i(Month) / Wind + Temp, data = airquality)
#> NOTE: 37 observations removed because of NA values (LHS: 37).
est2 = feols(Ozone ~ i(Month, Wind) + Temp | Month, data = airquality)

# Assume the following dictionary:
dict = c("Month::5"="May", "Month::6"="Jun", "Month::7"="Jul",
         "Month::8"="Aug", "Month::9"="Sep")

# set my custom latex style
style_lines = style.tex(depvar.title = "",
                        model.title="", 
                        var.title="\\midrule",
                        line.top = "\\toprule", line.bottom = "\\bottomrule",
                        fixef.title="\\midrule", fixef.suffix=" FE",
                        stats.title="\\midrule",
                        tablefoot.value="")

# save etable
etable(est1, est2, dict = dict,        
       style.tex = style_lines,
       digits = "r2", drop = "Constant", fitstat = ~ n + r2,
       signif.code = c("***"=0.01, "**"=0.05, "*"=0.1),
       order = "Temp",
       extralines = list("_Lorem" = c("lorem1", "lorem2")),
       tex = TRUE,
       replace = TRUE,
       file= "reg.tex")

