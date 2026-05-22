process HARDTHRESHOLD {
    container params.seidr_container

    publishDir "${params.outdir}/hardthreshold", mode: 'copy'

    input:
    path(aggregated_sf)

    output:
    path("filtered_HT.sf"), emit: sf_file

    script:
    """
    seidr threshold -f --in-file ${aggregated_sf} -m 0.1 -M 0.9 -o thresholded.tsv 2> thresholded.err
    THRES=\$(grep -oP "Suggested threshold: [0-9]+\\.[0-9]+" thresholded.err | sed 's/Suggested threshold: //g')
    seidr view --binary -t \$THRES ${aggregated_sf} -o filtered_HT.sf 
    """
    
}
