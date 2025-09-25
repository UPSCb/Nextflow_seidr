process PCOR {
    container params.seidr_container

    publishDir "${params.outdir}/pcor", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("pcor.sf"), emit: sf_file

    script:
    """
    pcor  -i ${expr} -g ${genes} -o "pcor.tsv"
    seidr import -r -z -u -A -F lm -n PCOR -o "pcor.sf" -i pcor.tsv -g ${genes} -O ${task.cpus}
    """
}
