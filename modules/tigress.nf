process TIGRESS {
    container params.seidr_container

    publishDir "${params.outdir}/tigress", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("tigress.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes} | wc -l)

    tigress -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "tigress.tsv" --save-resume "tigress.xml"

    seidr import -r -z -F m -n TIGRESS -o "tigress.sf" -i "tigress.tsv" -g ${genes} -O ${task.cpus}
    
    """
}
