# Project template
This is a pipeline to make and evaluate gene regulation networks using seidr (https://www.cell.com/heliyon/fulltext/S2405-8440(23)04018-5?uuid=uuid%3Ae1885a2a-a3fb-44fe-8226-31c065b2807e)

## How to

To use it for your project, first of all set your input files in the nf-params.json file,
or make them starting from a dds file and metadata information, using the script "src/R/Seidr_preparation.r".

After that, you can obtain the network by simply running "run_seidr.sh".

One of the inputs is a Gold Standard file with a list of genes that are expected to be co-expressed. If you do not have such a file, you can make it by running emapper on the proteome of your organism (http://eggnog-mapper.embl.de/) and using as expected corerulated genes all the genes sharing the same KEGG pathway.


