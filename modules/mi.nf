process MI {
    container params.seidr_container

    publishDir "${params.outdir}/mi", mode: 'symlink'

    input:
    tuple path(expr), path(genes), path("mi.tsv"), path("clr.sf") 

    output:
    path("mi.sf"), emit: sf_file

    script:
    """
    seidr import -r -z -u -F lm -n MI -o "mi.sf" -i ${mi} -g ${genes} -O ${task.cpus}
    """
}
