# Load necessary libraries
library(tidyverse)  # For data manipulation and visualization
library(readxl)     # For reading Excel files

# --- Batch 1 Data Processing ---

# Read and clean the coverage data
map_coverage <- read_tsv("./coverage.tsv")

# Read and clean the assembly quality control data
assembly_qc <- read_tsv("./assembly_qc_table.tsv")

# Read and process MLST results, retaining the sample tag
mlst <- read_tsv("./MOH_Klebsiella_mlst_result.tsv") %>%
  separate(FILE, into = c("text1", "tag", "text3", "text4"), sep = "/", remove = TRUE) %>%
  select(-c("text1", "text3", "text4"))

# Process CARD genes data, pivoting for easier analysis
card_genes <- read_tsv("./CARD_result.tsv") %>%
  select(Sample, gene) %>%
  pivot_wider(names_from = gene, values_from = gene, values_fn = length, values_fill = 0)

# Read and process ENA run information, extract sample tags
ena_run <- read_csv("./runs.csv") %>%
  separate(alias, into = c("text1", "text2", "tag"), sep = "-", remove = TRUE) %>%
  select(-c("text1", "text2")) %>%
  rename(run = id)

# Read and process NCBI accession data
ncbi_acc <- read_tsv("./assembly_accession.tsv") %>%
  select(Accession, Sample_Name) %>%
  rename(NCBI_assembly_acc = Accession)

# Combine all datasets into a master file for batch 1
cov_assqc_mlst_run_ncbi_card <- left_join(forward_size, reverse_size, by = "tag") %>%
  left_join(map_coverage, by = "tag") %>%
  left_join(assembly_qc, by = "tag") %>%
  left_join(mlst, by = "tag") %>%
  left_join(ena_run, by = "tag") %>%
  left_join(ncbi_acc, by = c("tag" = "Sample_Name")) %>%
  left_join(card_genes_pivot, by = c("tag" = "Sample")) %>%
  write_csv("./MOH_Klebsiella_Blood_seq_meta_ena_ncbi.csv")

# Read and process forward and reverse size data
forward_size <- read_tsv("./forward_size.txt") %>%
  separate(file, into = c("text1", "tag", "text3"), sep = "/", remove = TRUE) %>%
  select(-c("text1", "text3")) %>%
  rename(forward_size = size) %>%
  relocate(tag)

reverse_size <- read_tsv("./reverse_size.txt") %>%
  separate(file, into = c("text1", "tag", "text3"), sep = "/", remove = TRUE) %>%
  select(-c("text1", "text3")) %>%
  rename(reverse_size = size)

# --- Batch 2 Data Processing ---

# Read and clean the coverage data for batch 2
map_coverage <- read_tsv("./coverage.tsv")

# Read and process assembly quality control data
assembly_qc <- read_tsv("./assembly_qc_table.tsv")

# Read and process ENA run data for batch 2, with different alias format
ena_run <- read_csv("./runs.csv") %>%
  separate(alias, into = c("text1", "text2", "tag", "text3"), sep = "-", remove = TRUE) %>%
  select(-c("text1", "text2")) %>%
  unite("tag", tag:text3, sep = "-", remove = TRUE, na.rm = TRUE) %>%
  rename(run = id)

# Combine map coverage and ENA run data for batch 2
test <- left_join(map_coverage, ena_run, by = "tag")

# --- Combine Metadata ---

# Read and combine metadata with ENA and GenBank information
metadata <- read_csv("./Klebsiella_Blood_Metadata_kleborate_9Nov.csv")
ena_run <- read_csv("./ENA_acc.csv") %>%
  separate(alias, into = c("text1", "text2", "tag", "text3"), sep = "-", remove = TRUE) %>%
  select(-c("text1", "text2")) %>%
  unite("tag", tag:text3, sep = "-", remove = TRUE, na.rm = TRUE) %>%
  rename(run = id) %>%
  select(run, tag)

genbank <- read_excel("Workflow-Report_Sheet_Progress.xlsx", sheet = "MOH-Kp-Blood") %>%
  select(ID, `Genbank Accession`) %>%
  rename(genbank_acc = `Genbank Accession`)

metadata_ena_gbk <- left_join(metadata, ena_run, by = c("Sample_ID" = "tag")) %>%
  left_join(genbank, by = c("Sample_ID" = "ID"))

# Process pathogen data and filter based on BioSample information
pathogen_sra <- read_tsv("./PDG000000012.1626.metadata.tsv")
pathogen_pds <- read_tsv("./isolates.tsv")

# Combine pathogen data and filter for relevant BioSamples
pathogen_sra_pds <- left_join(pathogen_sra, pathogen_pds, by = c("target_acc" = "Isolate")) %>%
  rename(SNP_cluster = `SNP cluster`) %>%
  filter(!BioSample %in% c(genbank$genbank_acc))

# Combine metadata with pathogen data and filter as needed
metadata_ena_gbk_pds <- left_join(metadata_ena_gbk, pathogen_pds, by = c("genbank_acc" = "BioSample")) %>%
  select(-c(Strain, `Isolate identifiers`, Serovar, `Isolation source`, `Isolation type`))

# Generate a summary of internal and external SNP clusters
pds_list_internal <- metadata_ena_gbk_pds %>%
  group_by(SNP_cluster) %>%
  summarise(count = n()) %>%
  drop_na()

external_meta <- pathogen_sra_pds %>%
  filter(SNP_cluster %in% pds_list_internal$SNP_cluster) %>%
  filter(!Run %in% c("NULL"))

pds_list_external <- external_meta %>%
  group_by(SNP_cluster) %>%
  summarise(count = n())

# Write external metadata to file
write_tsv(external_meta, "./kp_blood_external_metadata.tsv")

# --- Worksheet Editing ---

# Read and clean the workflow data
workflow <- read_excel("Workflow-Report_Sheet_Progress.xlsx", sheet = "MOH-Kp-Blood")

# Combine workflow data with size and coverage data
tidy_workflow <- left_join(workflow, forward_size, by = c("ID" = "tag")) %>%
  left_join(reverse_size, by = c("ID" = "tag")) %>%
  left_join(map_coverage, by = c("ID" = "tag")) %>%
  left_join(metadata, by = c("ID" = "Sample_ID")) %>%
  left_join(ena_run, by = c("ID" = "tag"))

# Write the tidy workflow to a CSV file
write_csv(tidy_workflow, "./tidy_workflow.csv")
