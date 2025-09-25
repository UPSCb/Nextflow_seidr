process NARROMI {
    container params.seidr_container

    publishDir "${params.outdir}/narromi", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("narromi.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes}| wc -l)
    narromi -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "narromi.tsv" --save-resume "narromi.xml"

    seidr import -r -z -F m -n narromi -o "narromi.sf" -i "narromi.tsv" -g ${genes} -O ${task.cpus}
    """
}
