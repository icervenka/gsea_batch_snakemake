# TODO delete the gsea created folders after running
# TODO download gmt and chip files if necessary
#

import pandas as pd
import glob
import os
from snakemake.shell import shell
from snakemake.utils import validate, min_version
from snakemake.io import load_configfile
import pprint

##### set minimum snakemake version #####
min_version("5.7.0")

##### load config and sample sheets #####
configfile: "config.yaml"
#validate(config, schema="snakemake/schema/config.schema.yaml")

##### load constants and functions #####
include: "snakemake/rules/common.smk"
include: "snakemake/rules/functions.smk"

# TODO implement
# if config["use_local"]:
GMT_PATH = config['gmt_path']
CHIP_PATH = config['chip_path']
# else:
#     GMT_PATH = GMT_FTP_PREFIX
#     CHIP_PATH = CHIP_FTP_PREFIX


##### load remaining pipleline rules #####
include: "snakemake/rules/gsea_preranked.smk"
# include: "snakemake/rules/gsea.smk"


##### load metadata #####
# metadata
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
gene_sets_expanded = expand(GMT_PATH + "{gene_set}" + GMT_SUFFIX, gene_set=gene_sets)

##### top level snakemake rule #####
rule all:
    input:
        #get_gsea_output_files,
        get_gsea_preranked_output_files
