process ARACNE {
    container params.seidr_container

    publishDir "${params.outdir}/aracne", mode: 'symlink'

    input:
    tuple path(expr), path(genes), path("mi.tsv"), path("clr.sf")

    output:
    path("ARACNE.sf"), emit: sf_file

    script:
    """
    NUM=\$(sed 's/\\t/\\n/g' ${genes}| wc -l)
    mi -m ARACNE -M "mi.tsv" -O ${task.cpus} -B \$NUM -i ${expr} -g ${genes}  -o "aracne.tsv" --save-resume "aracne.xml"

    seidr import -r -z -u -F lm -n ARACNE -o "aracne.sf" -i "aracne.tsv" -g ${genes} -O ${task.cpus}
    """
}
