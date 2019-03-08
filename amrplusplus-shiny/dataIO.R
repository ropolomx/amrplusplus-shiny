require(data.table)
require(metagenomeSeq)

load_amr_counts <- function(amr_filepath) {
    # Load the data, MEGARes annotations, and metadata
    out <- tryCatch(
        {
            newMRexperiment(read.table(amr_filepath, header=T, row.names=1, sep=',', quote = "\"",check.names = F))
        },
        error=function(e) {
            print('Error in loading of the AMR count file\nCheck file integrity')
            print(e)
            return(NULL)
        },
        warning=function(w) {
            print('Warning encountered in loading of the AMR count file')
            print(w)
            return(NULL)
        }
    )
    return(out)
}


load_amr_annotations <- function(annotations_filepath) {
    out <- tryCatch(
        {
            annotations <- data.table(read.csv(annotations_filepath, header=T, quote = "\""))
            setkey(annotations, header)
            return(annotations)
        },
        error=function(e) {
            print('Error in loading of the AMR annotation file\nCheck file integrity')
            print(e)
            return(NULL)
        },
        warning=function(w) {
            print('Warning encountered in loading of the AMR annotation file')
            print(w)
            return(NULL)
        }
    )
    return(out)
}


load_kraken_data <- function(kraken_filepath) {
    out <- tryCatch(
        {
            temp_kraken <- read.table(kraken_filepath, header=T, row.names=1, sep=',', quote="\"",check.names = F)
            kraken <- newMRexperiment(temp_kraken[rowSums(temp_kraken) > 0, ])
        },
        error=function(e) {
            print('Error in loading of the Kraken count file\nCheck file integrity')
            print(e)
            return(NULL)
        },
        warning=function(w) {
            print('Warning encountered in loading of the Kraken count file')
            print(w)
            return(NULL)
        }
    )
    return(out)
}


load_metadata <- function(metadata_filepath) {
    out <- tryCatch(
        {
            metadata <- read.csv(metadata_filepath, header=T)
            sample_column_id <- colnames(metadata)[1]
            metadata[, sample_column_id] <- make.names(metadata[, sample_column_id])
            return(metadata)
        },
        error=function(e) {
            print('Error in loading of the metadata file\nCheck file integrity')
            print(e)
            return(NULL)
        },
        warning=function(w) {
            print('Warning encountered in loading of the metadata file')
            print(w)
            return(NULL)
        }
    )
    return(out)
}


create_output_directories <- function(temp_dir,
                                      project_name,
                                      data_types,
                                      active_features,
                                      experiment_names,
                                      experiment_activity) {
    ifelse(!dir.exists(file.path(temp_dir, project_name)),
           dir.create(file.path(temp_dir, project_name)), FALSE)
    
    project_temp_dir <- paste(temp_dir, project_name, sep='/')
    
    ifelse(!dir.exists(file.path(project_temp_dir, 'Statistics')),
           dir.create(file.path(project_temp_dir, 'Statistics')), FALSE)
    
    ifelse(!dir.exists(file.path(project_temp_dir, 'Graphs')),
           dir.create(file.path(project_temp_dir, 'Graphs')), FALSE)
    
    ifelse(!dir.exists(file.path(project_temp_dir, 'Matrices')),
           dir.create(file.path(project_temp_dir, 'Matrices')), FALSE)
    
    stats_dir <- paste(project_temp_dir, 'Statistics', sep='/')
    graph_dir <- paste(project_temp_dir, 'Graphs', sep='/')
    mat_dir <- paste(project_temp_dir, 'Matrices', sep='/')
    
    if('Microbiome' %in% data_types) {
        ifelse(!dir.exists(file.path(stats_dir, 'Microbiome')),
               dir.create(file.path(stats_dir, 'Microbiome')), FALSE)
        ifelse(!dir.exists(file.path(graph_dir, 'Microbiome')),
               dir.create(file.path(graph_dir, 'Microbiome')), FALSE)
        ifelse(!dir.exists(file.path(mat_dir, 'Microbiome')),
               dir.create(file.path(mat_dir, 'Microbiome')), FALSE)
        graph_microbiome_dir <- paste(graph_dir, 'Microbiome', sep='/')
        for(f in active_features) {
            ifelse(!dir.exists(file.path(graph_microbiome_dir, f)),
                   dir.create(file.path(graph_microbiome_dir, f)), FALSE)
        }
        stats_microbiome_dir <- paste(stats_dir, 'Microbiome', sep='/')
        if(length(experiment_names) > 0) {
            for(i in 1:length(experiment_names)) {
                if(experiment_activity[[i]]) {
                    ifelse(!dir.exists(file.path(stats_microbiome_dir, experiment_names[[i]])),
                           dir.create(file.path(stats_microbiome_dir, experiment_names[[i]])), FALSE)
                }
            }
        }
    }
    if('Resistome' %in% data_types) {
        ifelse(!dir.exists(file.path(stats_dir, 'Resistome')),
               dir.create(file.path(stats_dir, 'Resistome')), FALSE)
        ifelse(!dir.exists(file.path(graph_dir, 'Resistome')),
               dir.create(file.path(graph_dir, 'Resistome')), FALSE)
        ifelse(!dir.exists(file.path(mat_dir, 'Resistome')),
               dir.create(file.path(mat_dir, 'Resistome')), FALSE)
        graph_resistome_dir <- paste(graph_dir, 'Resistome', sep='/')
        for(f in active_features) {
            ifelse(!dir.exists(file.path(graph_resistome_dir, f)),
                   dir.create(file.path(graph_resistome_dir, f)), FALSE)
        }
        stats_resistome_dir <- paste(stats_dir, 'Resistome', sep='/')
        if(length(experiment_names) > 0) {
            for(i in 1:length(experiment_names)) {
                if(experiment_activity[[i]]) {
                    ifelse(!dir.exists(file.path(stats_resistome_dir, experiment_names[[i]])),
                           dir.create(file.path(stats_resistome_dir, experiment_names[[i]])), FALSE)
                }
            }
        }
    }
    return(project_temp_dir)
}