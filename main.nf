#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {PEARSON} from './modules/pearson.nf'

workflow {
    // Create input channel
    input_ch = Channel.of(
        tuple(
        file(params.expr, checkIfExists: true),
        file(params.genes, checkIfExists: true)
    ))
    
    
    // Run PEARSON process
    PEARSON(input_ch)
    
    // Optional: view the output
    PEARSON.out.sf_file.view { "PEARSON output: $it" }
}

