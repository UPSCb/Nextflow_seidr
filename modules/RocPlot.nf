process ROCPLOT {

    publishDir "${params.outdir}/ROC_plots", mode: 'symlink'

    input:
    path(roc_files)
    path(r_script)

    output:
    path("seidr_roc_report.html"), emit: html_report

    script:
    """
    # Run the R script to generate the report using relative path to pixi environment
    pixi run --manifest-path ${params.pixienv} \
    R -e "rmarkdown::render('${r_script}', output_file='seidr_roc_report.html')"
    """
}
