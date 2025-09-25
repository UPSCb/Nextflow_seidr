process PEARSON {
    container params.seidr_container

    publishDir "${params.outdir}/pearson", mode: 'symlink'

    input:
    tuple(path(expr), path(genes))

    output:
    path("pearson.sf"), emit: sf_file

    script:
    """
    correlation -m pearson  -i ${expr} -g ${genes} -o "pearson.tsv" 

    seidr import -r -z -u -A -F lm -n PEARSON -o "pearson.sf" -i "pearson.tsv" -g ${genes} -O ${task.cpus}
    """
}
