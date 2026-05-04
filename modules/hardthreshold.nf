process AGGREGATE {
    container params.seidr_container

    publishDir "${params.outdir}/hardthreshold", mode: 'symlink'

    input:
    path("aggregated.sf")

    output:
    path("filtered_HT.sf"), emit: sf_file

    script:
    def input_files = sf_files.collect { it.name }.join(' ')
    """
    seidr threshold -f --in-file ${input} -m 0.1 -M 0.9 -o $3 thresholded.tsv 2> thresholded.err
    THRES=$(grep -oP "Suggested threshold: [0-9]+\.[0-9]+" thresholded.err | sed 's/Suggested threshold: //g')
    seidr view --binary -t $THRES ${input} -o ${sf_file} 
    """
    
}
