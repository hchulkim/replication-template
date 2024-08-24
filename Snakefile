## Snakemake - Replication Template
##
## Hyoungchul Kim (ref:https://lachlandeer.github.io/snakemake-econ-r-tutorial/target-rules.html)


# --- Final Target Rule --- #

rule solow_target:
    input:
        intermediate = "out/analysis/model_solow_subset_intermediate.rds",
        nonoil       = "out/analysis/model_solow_subset_nonoil.rds",
        oecd         = "out/analysis/model_solow_subset_oecd.rds"

# --- OLS Rules --- #

rule solow_intermediate:
    input:
        script   = "src/analysis/estimate_ols_model.R",
        data     = "out/data/mrw_complete.csv",
        model    = "src/model-specs/model_solow.json",
        subset   = "src/data-specs/subset_intermediate.json"
    output:
        estimate = "out/analysis/model_solow_subset_intermediate.rds",
    shell:
        "Rscript {input.script} \
            --data {input.data} \
            --model {input.model} \
            --subset {input.subset} \
            --out {output.estimate}"

rule solow_nonoil:
    input:
        script   = "src/analysis/estimate_ols_model.R",
        data     = "out/data/mrw_complete.csv",
        model    = "src/model-specs/model_solow.json",
        subset   = "src/data-specs/subset_nonoil.json"
    output:
        estimate = "out/analysis/model_solow_subset_nonoil.rds",
    shell:
        "Rscript {input.script} \
            --data {input.data} \
            --model {input.model} \
            --subset {input.subset} \
            --out {output.estimate}"

rule solow_oecd:
    input:
        script   = "src/analysis/estimate_ols_model.R",
        data     = "out/data/mrw_complete.csv",
        model    = "src/model-specs/model_solow.json",
        subset   = "src/data-specs/subset_oecd.json"
    output:
        estimate = "out/analysis/model_solow_subset_oecd.rds",
    shell:
        "Rscript {input.script} \
            --data {input.data} \
            --model {input.model} \
            --subset {input.subset} \
            --out {output.estimate}"


# --- Data Management --- #

rule gen_regression_vars:
    input:
        script = "src/data-management/gen_reg_vars.R",
        data   = "out/data/mrw_renamed.csv"
    output:
        data   = "out/data/mrw_complete.csv"
    shell:
        "Rscript {input.script} \
            --data {input.data} \
            --out {output.data}"

rule rename_vars:
    input:
        script = "src/data-management/rename_variables.R",
        data   = "src/data/mrw.dta"
    output:
        data = "out/data/mrw_renamed.csv"
    shell:
        "Rscript {input.script} \
            --data {input.data} \
            --out {output.data}"


# --- Clean Rules --- #

rule clean:
    shell:
        "rm -rf out/*"

rule clean_data:
    shell:
        "rm -rf out/data/*"

rule clean_analysis:
    shell:
        "rm -rf out/analysis/*"
