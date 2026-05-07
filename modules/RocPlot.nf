process ROCPLOT {

    publishDir "${params.outdir}/ROC_plots", mode: 'symlink'

    input:
    path(roc_files)

    output:
    path("seidr_roc_report.html"), emit: html_report

    script:
    """
    # Run the R script to generate the report
    pixi run --manifest-path /pfs/proj/nobackup/fs/projnb10/hpc2nstor2025-133/try_nextflow_seidr/pixi_rocplot \
    R -e "rmarkdown::render('${projectDir}/src/R/seidrRoc.R', output_file='seidr_roc_report.html')"
    """
}
