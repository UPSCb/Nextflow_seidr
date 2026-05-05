process ROCNONEGATIVE {
    container params.seidr_container

    publishDir "${params.outdir}/ROC_NoNegative", mode: 'symlink'

    input:
    tuple (path(evaluation.sf), params.PositiveGoldStandard)

    output:
    path("backbone-$index.roc.tsv"), emit: sf_file

    script:
    """
    seidr roc -f -n ${evaluation.sf} -g ${params.PositiveGoldStandard} > roc.tsv
    """
}