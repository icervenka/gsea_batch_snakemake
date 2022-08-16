def get_gsea_preranked_output_files(wildcards):
    return(expand(LOG_DIR + "{name}/{gene_set}/gsea_preranked.completed",
    name=gsea_preranked_names,
    gene_set=config['genesets']))

rule gsea_preranked:
    input:
        gene_file=get_gsea_preranked_files,
        gene_set=config['gmt_path'] + "{gene_set}" + GMT_SUFFIX
    output:
        LOG_DIR + "{name}/{gene_set}/gsea_preranked.completed"
    params:
        collapse=config['collapse'],
        chipfile=config['chip_path']+config['chipfile'],
        scoring_scheme=config['scoring_scheme']['gsea_preranked'],
        plot_top_pathways=config['plot_top_pathways'],
        norm=config['norm'],
        nperm=config['nperm'],
        max_set_size=config['max_set_size'],
        min_set_size=config['min_set_size'],
        make_sets=config['make_sets'],
        include_only_symbols=config['include_only_symbols'],
        create_svgs=config['create_svgs'],
        zip_report=config['zip_report'],
        mode=config['mode']
    threads:
        1
    # benchmark:
    #     BENCHMARK_DIR + "{name}_{gene_set}_benchmark.txt"
    run:
        silent = silent_cli(config['silent'])
        shell(
            config['gsea_path'] + " GSEAPreranked "
            "-rnk {input.gene_file} "
            "-gmx {input.gene_set} "
            "-collapse {params.collapse} "
            "-chip {params.chipfile} "
            "-out " + REPORT_OUTDIR + "{wildcards.name}/ "
            "-rpt_label {wildcards.gene_set} "
            "-scoring_scheme {params.scoring_scheme} "
            "-plot_top_x {params.plot_top_pathways} "
            "-norm {params.norm} "
            "-nperm {params.nperm} "
            "-set_max {params.max_set_size} "
            "-set_min {params.min_set_size} "
            "-make_sets {params.make_sets} "
            "-include_only_symbols {params.include_only_symbols} "
            "-create_svgs {params.create_svgs} "
            "-zip_report {params.zip_report} "
            "-mode {params.mode} "
            "{silent} "
            "touch {output} "
        )
