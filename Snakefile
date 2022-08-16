# TODO benchmarks for GSEA don't accept contrast parameter in filename

import pandas as pd
import glob
import os
from snakemake.shell import shell
from snakemake.utils import validate, min_version
from snakemake.io import load_configfile

##### set minimum snakemake version #####
min_version("5.7.0")

##### load config and sample sheets #####
configfile: "config.yaml"
#validate(config, schema="snakemake/schema/config.schema.yaml")

##### load constants and functions #####
include: "snakemake/rules/common.smk"
include: "snakemake/rules/functions.smk"

##### load remaining pipleline rules #####
include: "snakemake/rules/gsea.smk"
include: "snakemake/rules/gsea_preranked.smk"

##### load metadata #####
Metadata = pd.read_table(config["metadata"], dtype=str)
Metadata = Metadata.fillna('')
# validate(Metadata, schema="snakemake/schema/metadata.schema.yaml")

try:
    os.mkdir(REPORT_OUTDIR)
except OSError as e:
    print(e)

gsea_names = Metadata[Metadata['class_file'].str.len() > 0].name.dropna()
gsea_preranked_names = Metadata[Metadata['class_file'].str.len() < 1].name.dropna()
gene_sets = config['genesets']

##### top level snakemake rule #####
rule all:
    input:
        get_gsea_output_files,
        get_gsea_preranked_output_files

# delete the output directory that GSEA creates automatically
onsuccess:
    paths = []
    for month in GSEA_MONTHS:
        paths += glob.glob(month + "[0-3][0-9]")
    for item in paths:
        try:
            os.rmdir(item)
        except OSError as error:
            print(error)
