process ROCNONEGATIVE {
    container params.seidr_container

    publishDir "${params.outdir}/ROC_NoNegative", mode: 'symlink'

    input:
    tuple val(sample_id), path(evaluation_sf)
    path positive_gold_standard

    output:
    path("${sample_id}.roc.tsv"), emit: roc_file

    script:
    """
    seidr roc -f -n ${evaluation_sf} -g ${positive_gold_standard} > ${sample_id}.roc.tsv
    """
}