process LLR {
    container params.seidr_container

    publishDir "${params.outdir}/llr-ensemble", mode: 'symlink'

    input:
    tuple(path(expr), path(genes)) 

    output:
    path("llr-ensemble.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes}| wc -l)
    llr-ensemble -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "llr-ensemble.tsv" --save-resume "llr-ensemble.xml"

    seidr import -r -z -F m -n llr-ensemble -o "llr-ensemble.sf" -i "llr-ensemble.tsv" -g ${genes} -O 4
    """
}
