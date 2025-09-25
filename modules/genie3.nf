process GENIE3 {
    container params.seidr_container

    publishDir "${params.outdir}/genie3", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("genie3.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes}| wc -l)
    genie3 -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "genie3.tsv" --save-resume "genie3.xml"

    seidr import -r -z -F m -n GENIE3 -o "genie3.sf" -i "genie3.tsv" -g ${genes} -O 4
    """
}
