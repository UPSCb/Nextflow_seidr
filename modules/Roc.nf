process ROC {
    container params.seidr_container

    publishDir "${params.outdir}/ROC", mode: 'copy'

    input:
    tuple val(sample_id), path(evaluation_sf)
    path positive_gold_standard
    path negative_gold_standard

    output:
    path("${sample_id}.roc.tsv"), emit: roc_file

    script:
    """
    seidr roc -f -n ${evaluation_sf} -g ${positive_gold_standard} -x ${negative_gold_standard} > ${sample_id}.roc.tsv
    """
}