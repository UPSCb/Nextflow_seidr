process SPEARMAN {
    container params.seidr_container

    publishDir "${params.outdir}/spearman", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("spearman.sf"), emit: sf_file

    script:
    """
    correlation -m spearman  -i ${expr} -g ${genes} -o "spearman.tsv" 

    seidr import -r -z -u -A -F lm -n SPEARMAN -o "spearman.sf" -i "spearman.tsv" -g ${genes} -O ${task.cpus}
    """
}
