process BACKBONE {
    container params.seidr_container

    publishDir "${params.outdir}/backbone", mode: 'copy'

    input:
    tuple val(threshold), val(index), path(aggregated_sf)

    output:
    path("backbone-${index}-percent.sf"), emit: sf_file

    script:
    """
    seidr backbone -f -F ${threshold} -o backbone-${index}-percent.sf ${aggregated_sf}
    """
}