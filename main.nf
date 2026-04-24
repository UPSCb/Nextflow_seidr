workflow {
    // Create input channel
    input_ch = channel.of(
        tuple(
            file(params.expr, checkIfExists: true),
            file(params.genes, checkIfExists: true)
        )
    )
    
    // Run networks and import process
    PEARSON(input_ch)
    SPEARMAN(input_ch)
    CLR(input_ch)
    MI(input_ch.combine(CLR.out))
    ARACNE(input_ch.combine(CLR.out))
    GENIE3(input_ch)
    LLR(input_ch)
    NARROMI(input_ch)
    PCOR(input_ch)
    PLSNET(input_ch)
    TIGRESS(input_ch)
    
    // Collect all outputs and pass to AGGREGATE
    all_sf_files = PEARSON.out
        .mix(
            SPEARMAN.out,
            MI.out,
            ARACNE.out,
            GENIE3.out,
            LLR.out,
            NARROMI.out,
            PCOR.out,
            PLSNET.out,
            TIGRESS.out
        )
        .collect()
    
    AGGREGATE(all_sf_files)
}