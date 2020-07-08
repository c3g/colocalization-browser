
Web
===

1: See population methylation averages stratified by genotype for a window (user chooses SNP and genomic region to visualize, UCSC view is generated for each genotype AA/AB/BB with averaged data from all AA or AB or BB for CpGs)
2: See genetic association data for a CpG (user chooses CpG and genetic variant association scores are displayed for that CpG in a window surrounding the CpG site)
3: See all methylation sites associated with SNP (user chooses SNP and defines parameters, e.g. P-value threshold and linkage disequilibrium between top associated SNP-CpG pair vs. SNPtest-CpG pair) – this requires LD matrix

Datasets (same as population in Tomi's email)
 - CD4
 - CD14
 - CD19
 - VAT
 - Eos
 - WB
 - WB2020 (soon)

for each set:
(I am using CD4 and chr1 as example)

generate database file:

Tables
======

## 1: snp_information table:
--snp_uid (example 1:79033:A:G : chr:position:ref:alt)
--chr
--position
--snp_id (rs2462495 or chr:position if no rsId)
--aaf  (range 0-1)
--maf  (range 0-0.5)
--sample_number:

all data for this table is in CD4_genotype_MAF_chr1.gz
example
1:79033:A:G 1 79033 rs2462495 A G 0.9464 0.0536 28

## 2: genotype table:
-- snp_uid
-- genotype 

You will decide the table schema here
all data for this table is in CD4_genotype_MAF_chr1.gz

## 2: CpG_information:
-- CpG_uid: chr:CpG-C-site (same as CpG-Start-site) : example 1:15769
-- chr
-- CpG-C-site
-- meth_mean (of methylation)
-- meth_var (variance )
-- sample_number
-- from_target: (I will add this information )

data for this table is in CD4_methylation_5X_num_mean_var_chr1.gz (order is diff: num, mean, var, no from_target)
example
1:15769 1 15769 91.38 343.17 110 0 

## 3: methylation:
-- CpG_uid
-- methylation values.
data for this table is in CD4_methylation_5X_chr1.gz

## 4: sample table:
just list of samples 
-- smaple_id
-- sex

## 5: lead_snp:
-- CpG_uid
-- snp_uid
-- beta
-- t-stat
-- p-value


## 6: mQTL
-- CpG_uid
-- snp_uid
-- beta
-- t-stat
-- p-value


# difference lead_snp vs mQTL is

mQTL is CpG vs "SNP in range" (250kb or 1mb). We may have 1000s pairs.
lead_snp: just pairs with smallest p-value (1 - sverval pairs from all possible pairs)

Maybe, we only need mQTL with extra-col: is_lead_snp


# Queries

query 1:
user input: chrN and snp_position, or snpId (rsId) 

-- a: query snp_information: find full information for this snp
-- b: query CpG_information: using chr and postion (plus range) from "a", find all CpG in the range
-- c: query genotype: using "snp_uid" (from "a" ) to get genotype for this snp
-- d: query methylation: using CpG_uid (from "b" ) to get methylation. so bar plot (mean for each genotype AA, AB, BB)
-- e: query mQTL : get all p-values .....






Notes (from Romain)
===================

for each QTL, we need data for:
 - genotype (SNP) `chrom, location, snpName, ref, alt`
 - methylation (CpG) `chrom, C-location, [G-location], [...methylation-value]`


Steps from Bing:
1: Data in database: (I will provide all files)
   a: SNP information  AND genotype
   b: CpG information and  CpG methylation data. Maybe should have mQTL summary table also
   We may have data from more than one tissues.

2: From chromosome coordinates (from user's input?  for example, SNP rsId  or chrom:position),
   we will find all CpG in the range

3: If user clicks one CpG site (link), we will fetch genotype and methylation data  and then do bar
   graph.
   x: three genotype : AA, AB , BB
   y: mean of methyplation


## Questions:
 • what about the six issue types? (CD4, CD14, CD19, VAT, Eos, WB) I don't understand how these are used and when one dataset should be used over another.
 • in step 2, what is the "certain range" around the SNP that must be used? user-defined window?
 • in step 2, how precisely is that data extracted? what queries did you run on which files?


## Files:
database:    /lustre03/project/6007512/bingge/coloc/databases
genotype:    /lustre03/project/6007512/bingge/HRC_mQTL_ASM/rawFiles/genotypeFiles
methylation: /lustre03/project/6007512/bingge/HRC_mQTL_ASM/rawFiles/methMergedFiles
mQTL:        /lustre03/project/6007512/bingge/HRC_mQTL_ASM/mQTL1M/mQTL_cis_1M
lead SNP:    /lustre03/project/6007512/bingge/HRC_mQTL_ASM/mQTL1M/leadSnpFiles
