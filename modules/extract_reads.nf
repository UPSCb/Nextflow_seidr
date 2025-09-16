process EXTRACT_READS {
    container params.samtools_container
    
    input:
    tuple path(bam_file), path(bai_file), val(region)

    output:
    tuple val("${bam_file.baseName}_${region}"), path("${bam_file.baseName}_${region}_R1.fastq"), path("${bam_file.baseName}_${region}_R2.fastq"), emit: extracted_reads

    script:
    def read1_suffix = params.read_naming == "1_2" ? "R1" : "forward"
    def read2_suffix = params.read_naming == "1_2" ? "R2" : "reverse"
    """
    # Ensure the index is in the same directory as the BAM file
    if [ ! -e "${bam_file}.bai" ]; then
        ln -s ${bai_file} ${bam_file}.bai
    fi
    # Extract only properly paired reads within the region
    samtools view -F 4 -h ${bam_file} ${region} | \
    samtools fastq -1 ${bam_file.baseName}_${region}_${read1_suffix}.fastq \
                   -2 ${bam_file.baseName}_${region}_${read2_suffix}.fastq \
                   -0 /dev/null -s /dev/null -n
    """
}
