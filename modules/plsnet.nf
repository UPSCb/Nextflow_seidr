process PLSNET {
    container params.seidr_container

    publishDir "${params.outdir}/plsnet", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("plsnet.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes} | wc -l)
    
    plsnet -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "plsnet.tsv" --save-resume "plsnet.xml"

    seidr import -r -z -F m -n PLSNET -o "plsnet.sf" -i "plsnet.tsv" -g ${genes} -O ${task.cpus}
    
    """
}
