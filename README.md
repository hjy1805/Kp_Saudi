# The Dissemination of Multidrug-Resistant and Hypervirulent Klebsiella pneumoniae Clones Across the Kingdom of Saudi Arabia

## Abstract

### Background:
The Gram-negative bacterium *Klebsiella pneumoniae* is a major human health threat underlying a broad range of community- and hospital-associated infections. The emergence of clonal hypervirulent strains often resistant to last-resort antimicrobial agents has become a global burden as treatment options are limited. The Kingdom of Saudi Arabia (KSA) has a dynamic and diverse population and serves as a major global tourist hub facilitating the dissemination of multidrug-resistant (MDR) strains of *K. pneumoniae*. To examine the spread of clinically relevant *Klebsiella pneumoniae* strains, we characterized the population structure and dynamics of multidrug-resistant K. pneumoniae across the KSA hospitals.

### Methods:
We conducted a large genomic survey on a Saudi Arabian collection of multidrug-resistant *K. pneumoniae* isolates from the bloodstream and urinary tract infections. The isolates were collected from 32 hospitals located in 15 major cities across the country in 2022 and 2023. We subjected 352 *K. pneumoniae* isolates to whole-genome sequencing and employed a broad range of genomic epidemiological and phylodynamic methods to analyse population structure and dynamics at high resolution. We employed an integrated short- and long-read sequencing approach to fully characterize multiple plasmids carrying resistance and virulence genes.

### Results:
Our results indicate that, despite a diverse *K. pneumoniae* population underlying hospital infections, the population is characterized by the rapid expansion of a few dominant clones, including ST096 (n=115), ST147 (n=75), ST231 (n=35), ST101 (n=30), ST11 (n=18), ST16
(n=15) and ST14 (n=12). ST2096, ST231, and ST147 clones were estimated to have formed within the past two decades and spread between hospitals across the country on an epidemiological time scale. All STs were genetically linked with globally circulating clones, particularly strains from the Middle East and South Asia. All of the major clones harboured plasmid-borne ESBLs and a range of carbapenemase genes. Plasmidome analysis revealed multiple mosaic plasmids with resistance and virulence gene cassettes, some of which were shared between the major clades and account for multidrug-resistant hypervirulent (MDR/hv) phenotype, especially in the ST2096 strains. Integration of phylodynamic data and resistance plasmid profiles showed that the acquisition of plasmids occurred on the same time scales as did the expansion of major clones across the country.

### Conclusion:
Taken together, these results indicate the dissemination of MDR and MDR-hv *K. pneumoniae* strains across the kingdom and provide evidence for pervasive plasmid sharing and horizontal gene transfer of resistance genes. The results demonstrate the independent introduction of endemic ST147, ST231, and ST101 clones into the country and highlight the clinical significance of ST2096 as an emerging clone with dual resistance and virulence risks. These results highlight the need for continuous surveillance of circulating and newly emergent strains (STs) and of their plasmidome footprints carrying MDR determinants.


## Files Descriptions

| File & folder Name                  | Description                                                                                  |
| ----------------------------------- | ---------------------------------------------------------------------------------------------|
| `Annotated_plasmid`                 | Annotated plasmid sequence in gbk format                                                     |
| `Samples_metadata.csv`              | Metadata of samples that were in-house sequenced in this study                               |
| `annotate_bakta.sh`                 | Assembled genome annotation bash script                                                      |
| `assembly_unicycler.sh`             | short-read genome assembly bash script                                                       |
| `assembly_unicycler_hybird.sh`      | Long-read hybrid genome assembly bash script                                                 |
| `assembly_qc_quast.sh`              | Genome assembly quality accession bash script                                                |
| `mapping_snippy.sh`                 | Bash script for mapping short reads against reference genome                                 |
| `run_gubbins.sh`                    | Bash script for filtering out polymorphic sites                                              |
| `run_beast2.sh`                     | Bash script for running Bayesian Evolutionary Analysis Sampling Trees 2 (BEAST2)             |
| `scan_amrfinder.sh`                 | Bash script for AMR gene & virulence factor detection by AMRFinderPlus                       |
| `typing_srst.sh`                    | Bash script for gene detection against the relevant database by srst2                        |
| `typing_Kleborate.sh`               | Bash script for multi-function profiling of Klebsiella genome by Kleborate                   |
| `profiling_metaphlan.sh`            | Bash script for profiling the sequencing reads species as QC for contamination               |
| `metadata_processing.R`             | R script for the relevant metadata processing                                                |
| `plasmid_pygenomeviz.ipynb`         | Python script for the plasmid alignment and visualisation by pyGenomeViz                     |


## Contacts
For inquiries regarding this research, please contact:

Jiayi Huang

Email: jiayi.huang@kaust.edu.sa

PhD student

Infectious Disease Epidemiology Lab

Biological and Environmental Science and Engineering (BESE) Division

King Abdullah University of Science and Technology (KAUST)

Thuwal, Saudi Arabia
