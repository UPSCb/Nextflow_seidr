#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {PEARSON} from './modules/pearson.nf'

include {SPEARMAN} from './modules/spearman.nf'

include {MI} from './modules/mi.nf'

include {CLR} from './modules/clr.nf'

include {ARACNE} from './modules/aracne.nf'

include {GENIE3} from './modules/genie3.nf'

include {LLR} from './modules/llr.nf'

include {NARROMI} from './modules/narromi.nf'

include {PCOR} from './modules/pcor.nf'

include {PLSNET} from './modules/plsnet.nf'

include {TIGRESS} from './modules/tigress.nf'

include {AGGREGATE} from './modules/aggregate.nf'

include {HARDTHRESHOLD} from './modules/hardthreshold.nf'

include {BACKBONE} from './modules/backbone.nf'

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

    HARDTHRESHOLD(AGGREGATE.out)

    // Create channel with thresholds for parallel backbone processing
    threshold_ch = channel.of(
        [2.33, 1],
        [2.05, 2], 
        [1.88, 3],
        [1.75, 4],
        [1.64, 5],
        [1.55, 6],
        [1.48, 7],
        [1.41, 8],
        [1.34, 9],
        [1.28, 10]
    )
    .combine(AGGREGATE.out)
    .map { threshold, index, aggregated_sf -> 
        tuple(threshold, index, aggregated_sf)
    }
    
    BACKBONE(threshold_ch)


}