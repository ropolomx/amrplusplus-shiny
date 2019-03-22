# AMR++ Shiny: Statistics Interface for Metagenomic Resistome and Microbiome Analyses

**Citation:**

Lakin, S.M., Dean, C., Noyes, N.R., Dettenwanger, A., Spencer Ross, A., Doster, E., Rovira, P., Abdo, Z., Jones, K.L., Ruiz, J., Belk, K.E., Morley, P.S., Boucher, C. (2017)
MEGARes: an antimicrobial database for high throughput sequencing. *Nucleic Acids Res.*, 45. DOI: 10.1093/nar/gkw1009

The AMR++ suite of tools was developed to enable intuitive processing of metagenomic data surrounding the antimicrobial resistome and microbiome.  [AMR++ Nextflow](https://www.github.com/cdeanj/amrplusplus) is the bioinformatics command-line tool for processing next-generation sequencing files into analytic matrices.  The analytic matrices produced by AMR++ Nextflow are used as input into AMR++ Shiny.  Within AMR++ Shiny, you can explore your data visually and produce graphical and statistical output to streamline your metagenomic sequencing project.  Follow the steps below to get started.

## Installation

If you wish to process data locally, you can download this repository, execute the Install_Prerequisite_Packages.R script, open the server.R file in [RStudio](https://www.rstudio.com/products/rstudio/download/), select the arrow on the top bar next to "Run App", select "Run External", then click the "Run App" button to launch AMR++ Shiny in your internet browser.  It is important that you run the App externally, since it will not work if run natively in RStudio.

If you do not wish to use the automatic install script, you can download the following packages yourself in R:

  - shiny
  - shinydashboard
  - data.table
  - ggplot2
  - vegan
  - metagenomeseq

It is important that you have installed up-to-date packages and are running an R version > 3.0.0.

## Usage

AMR++ Shiny has instructions built into the App describing each step.  You will need the following files that are output from the AMR++ Nextflow pipeline (NOTE: the MEGARes annotation file must match the version of the file used in the AMR++ Nextflow pipeline):

**Resistome analysis alone:**

  - amr\_analytic\_matrix.csv
  - megares\_annotations\_vX.XX.csv
  - YourProjectMetadataFile.csv

**Microbiome analysis alone:**

  - kraken\_analytic\_matrix.csv
  - YourProjectMetadataFile.csv

**Resistome and Microbiome analyses:**

  - amr\_analytic\_matrix.csv
  - megares\_annotations\_vX.XX.csv
  - kraken\_analytic\_matrix.csv
  - YourProjectMetadataFile.csv

## Metadata File Format

The metadata file format must be a comma-separated value (.csv) format file.  It can contain as many columns as you'd like, however **the first column must contain sample IDs that match the sample IDs in the other files**.  An example of columns might be the following:

  1. SampleID
  2. LocationOfSampleCollection
  3. SampleType
  4. CollectedBy
  5. etc.

An example of the first few lines of a metadata file might be the following:

```
SampleID,LocationOfSampleCollection,SampleType,CollectedBy
Sample1,Area1,Soil,StaffMember1
Sample2,Area1,Soil,StaffMember1
Sample3,Area2,Water,SaffMember2
```

You'll then have the choice of including each of these column features in your analyses.

## Output

AMR++ Shiny outputs the following files for every analysis:

**Exploratory Analysis Files**

For each feature selected for inclusion in the analysis, the following exploratory graphs are created for each level (AMR: Class, Mechanism, Group, Gene; Microbiome: Kingdom, Phylum, Class, Order, Family, Genus, Species):

  - Alpha rarefaction barplots
  - Heatmaps
  - Barplots
  - Principal Components Analysis (first two eigenvectors)
  - Non-parametric Multidimensional Scaling (two dimensions) using Bray-Curtis distance

**Statistical Analysis Files**

For each analysis set up on the final screen, the following statistical features are produced for each level as listed above:

  - Method: Zero-inflated Gaussian Regression using expectation maximization with metagenomeSeq
  - Log-fold change
  - p-value
  - Adjusted p-value
  - Average expression
  - Contrast

## Bug Reporting and Help

Bugs can be reported on this github page under the "Issues" tab.  Please include context of what you were doing at the time of crash and an error if provided.

General use and feature requests can be submitted on the [AMR++ Suite user's Google groups page](https://groups.google.com/forum/#!forum/amrplusplus-users).






