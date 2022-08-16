def get_gsea_output_files(wildcards):
    return(expand(LOG_DIR + "{name}/{gene_set}/gsea.completed",
    name=gsea_names,
    gene_set=config['genesets']))

checkpoint gsea:
    input:
        gene_file=get_gsea_files,
        class_file=get_gsea_class_files,
        gene_set=config['gmt_path'] + "{gene_set}" + GMT_SUFFIX
    output:
        LOG_DIR + "{name}/{gene_set}/gsea.completed"
    params:
        contrast=get_gsea_contrast,
        collapse=config['collapse'],
        chipfile=config['chip_path']+config['chipfile'],
        zip_report=config['zip_report'],
        create_svgs=config['create_svgs'],
        num_markers=config['num_markers'],
        plot_top_pathways=config['plot_top_pathways'],
        metric=config['metric'],
        scoring_scheme=config['scoring_scheme']['gsea'],
        mode=config['mode'],
        norm=config['norm'],
        nperm=config['nperm'],
        permute=config['permute'],
        max_set_size=config['max_set_size'],
        min_set_size=config['min_set_size'],
        median=config['median'],
        sort=config['sort'],
        order=config['order'],
        include_only_symbols=config['include_only_symbols']
    threads:
        1
    # benchmark:
    #     BENCHMARK_DIR + "{name}_{gene_set}_benchmark.txt"
    run:
        silent = silent_cli(config['silent'])
        shell(
            config['gsea_path'] + " GSEA "
            "-res {input.gene_file} "
            "-cls {input.class_file}#{params.contrast} "
            "-gmx {input.gene_set} "
            "-collapse {params.collapse} "
            "-chip {params.chipfile} "
            "-out " + REPORT_OUTDIR + "{wildcards.name}/ "
            "-rpt_label {params.contrast}_{wildcards.gene_set} "
            "-num {params.num_markers} "
            "-plot_top_x {params.plot_top_pathways} "
            "-zip_report {params.zip_report} "
            "-create_svgs {params.create_svgs} "
            "-metric {params.metric} "
            "-scoring_scheme {params.scoring_scheme} "
            "-mode {params.mode} "
            "-norm {params.norm} "
            "-nperm {params.nperm} "
            "-permute {params.permute} "
            "-set_max {params.max_set_size} "
            "-set_min {params.min_set_size} "
            "-sort {params.sort} "
            "-order {params.order} "
            "-include_only_symbols {params.include_only_symbols} "
            "-median {params.median} "
            "{silent} "
            "touch {output} "
        )
