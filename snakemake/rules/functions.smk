def get_gsea_files(wildcards):
    m = Metadata[Metadata['class_file'].str.len() > 0]
    m = Metadata.query('name == @wildcards.name').gene_file.dropna().unique()[0]
    print(m)
    return(INPUT_DIR + m)

def get_gsea_class_files(wildcards):
    m = Metadata[Metadata['class_file'].str.len() > 0]
    m = Metadata.query('name == @wildcards.name').class_file.dropna().unique()[0]
    print(m)
    return(INPUT_DIR + m)

def get_gsea_contrast(wildcards):
    m = Metadata[Metadata['class_file'].str.len() > 0]
    m = Metadata.query('name == @wildcards.name').contrast.dropna().unique()[0]
    print(m)
    return(m)

def get_gsea_preranked_files(wildcards):
    m = Metadata[Metadata['class_file'].str.len() < 1]
    m = Metadata.query('name == @wildcards.name').gene_file.dropna().unique()[0]
    return(INPUT_DIR + m)

def silent_cli(silent_toggle):
    if silent_toggle:
        return("> /dev/null; ")
    else:
        return("; ")
