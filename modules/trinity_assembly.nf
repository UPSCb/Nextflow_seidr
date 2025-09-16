process TRINITY_ASSEMBLY {
    errorStrategy = 'ignore'
    container params.trinity_container
    
    publishDir "${params.outdir}/trinity", mode: 'copy'

    input:
    tuple val(sample_id), path(reads1), path(reads2)

    output:
    path "${sample_id}_trinity_out_dir"

    script:
    """
    Trinity --seqType fq --left ${reads1} --right ${reads2} \
            --max_memory 10G --CPU ${task.cpus} \
            --output ${sample_id}_trinity_out_dir
    """
}