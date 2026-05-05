process ROC {
    container params.seidr_container

    publishDir "${params.outdir}/ROC", mode: 'symlink'

    input:
    tuple (path(evaluation.sf), params.PositiveGoldStandard, params.NegativeGoldStandard)

    output:
    path("backbone-$index.roc.tsv"), emit: sf_file

    script:
    """
    seidr roc -f -n ${evaluation.sf} -g ${params.PositiveGoldStandard} -x ${params.NegativeGoldStandard} > roc.tsv
    """
}