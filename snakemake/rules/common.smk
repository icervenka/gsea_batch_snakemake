GSEA_PATH="snakemake/gsea_cli/gsea-cli.sh"
# GMT_PATH="/shared/msigdb_7.1/gmt/"
# CHIP_PATH="/shared/msigdb_7.1/chip/"
GMT_FTP_PREFIX="ftp.broadinstitute.org://pub/gsea/gene_sets/"
GMT_SUFFIX=".v7.5.1.symbols.gmt"
CHIP_FTP_PREFIX="ftp.broadinstitute.org://pub/gsea/annotations_versioned/"
INPUT_DIR="input/"
TEMP_DIR="temp/"
LOG_DIR="logs/"
BENCHMARK_DIR=LOG_DIR+"benchmarks/"
REPORT_OUTDIR="reports/"
GSEA_OUTDIR_PATTERN = "Gsea"
GSEA_PRERANKED_OUTDIR_PATTERN = "GseaPreranked"

GSEA_MONTHS = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "sep",
                "oct", "nov", "dec"]
