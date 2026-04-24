process AGGREGATE {
    container params.seidr_container

    publishDir "${params.outdir}/aggregate", mode: 'symlink'

    input:
    path(sf_files)

    output:
    path("aggregated.sf"), emit: sf_file

    script:
    def input_files = sf_files.collect { it.name }.join(' ')
    """
    seidr aggregate -f -O ${task.cpus} ${input_files}
    """
    
}
