# The code here is from https://github.com/apriha/lineage

from lineage import Lineage
l = Lineage()
jim = l.create_individual('jim', 'AncestryDNA-dad.txt')
joann = l.create_individual('joann', 'AncestryDNA-mom.txt')

# Note: the next command requires the file genetic_map_HapMapII_GRCh37.tar.gz which is supposed to automatically be loaded into
# the [user]/resources directory.  However, this seems to be an obsolete file that has been archived.  I had to download it
# into that directory manually from ftp://ftp.ncbi.nlm.nih.gov/hapmap/recombination/2011-01_phaseII_B37/genetic_map_HapMapII_GRCh37.tar.gz
# Once it was there, the function didn't need to look for it online any more.  It was able to get the other file it needed (cytoBand_hg19.txt.gz)
one_chrom_shared_dna, two_chrom_shared_dna, one_chrom_shared_genes, two_chrom_shared_genes = l.find_shared_dna(jim, joann, cM_threshold=0.75, snp_threshold=1100)

# The output is in the [user]/output directory in the form of a csv file with data on the chromosome overlap and a png diagram of the chromosomes

# Here is the command to find common genes.  I think it also overwrites the same common DNA files:
# one_chrom_shared_dna, two_chrom_shared_dna, one_chrom_shared_genes, two_chrom_shared_genes = l.find_shared_dna(jim, joann, shared_genes=True)
