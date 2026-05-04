process BACKBONE {
    container params.seidr_container

    publishDir "${params.outdir}/hardthreshold", mode: 'symlink'

    input:
    path("aggregated.sf")

    output:
    path("backbone.*"), emit: sf_files

    script:
    def input_files = sf_files.collect { it.name }.join(' ')
    """
    seidr threshold -f --in-file ${input} -m 0.1 -M 0.9 -o $3 ${tsv_file} 
    thresholds=( 2.33 2.05 1.88 1.75 1.64 1.55 1.48 1.41 1.34 1.28 )

    # process the argument
    
    for i in {0..9}; do
    j=$(expr $i + 1)
    seidr backbone -f -F ${thresholds[$i]} -o ./backbone-${j}-percent.sf ${input} 
    done
    """
    
}
