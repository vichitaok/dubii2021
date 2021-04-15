#!/bin/bash

#------------------------------------------------------------------------------
# Download genomes from NCBI
# Organism: Mycobacterium abscessus ssp. abscessus
#------------------------------------------------------------------------------

# folder for the downloaded genomes
mkdir -P ../GENOMES

# table exported from NCBI
table=../tables/ncbi_abscessus_ssp_abscessus_complete_scaffold2.csv

# Collect and modify the FTP URLs of the table to point to the _genomic.fna.gz files (separation in 2 blocks, then reconstruction with addition of the 2nd block)
ftpR=$(cut -f 16 -d "," ${table} | sed -r 's|(ftp://ftp.ncbi.nlm.nih.gov/genomes/all/.+/)(GCF_.+)|\1\2/\2_genomic.fna.gz|')

# Collect and modify the FTP URLs of the table to point to the _genomic.gff.gz
ftpR+=$(cut -f 16 -d "," ${table} | sed -r 's|(ftp://ftp.ncbi.nlm.nih.gov/genomes/all/.+/)(GCF_.+)|\1\2/\2_genomic.gff.gz|')

# Download the genomes using the FTP URLs created
for ftp in ${ftpR}
do
	wget ${ftp} -P ../GENOMES
done


