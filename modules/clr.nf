process CLR {
    container params.seidr_container

    publishDir "${params.outdir}/clr", mode: 'symlink'

    input:
    tuple path(expr), path(genes)

    output:
    tuple path("mi.tsv"), path("clr.sf"), emit: tuple

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes}| wc -l)
    mi -m CLR -M "mi.tsv" -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes} -o "clr.tsv" --save-resume "clr.xml"

    seidr import -r -z -u -F lm -n CLR -o "clr.sf" -i "clr.tsv" -g ${genes} -O ${task.cpus}
    """
}
