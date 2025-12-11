library(limma)

# -------------------------
# 1. Load Data
# -------------------------
gene_data <- read.csv("final_with_subtypes_v2.csv", header = TRUE, row.names = 1)
subtypes  <- read.csv("only_subtypes_v2.csv", header = TRUE, row.names = 1)

# Remove negative values (expression cannot be negative)
if (any(gene_data < 0)) {
  gene_data[gene_data < 0] <- 0
  cat("Negative values replaced with zero.\n")
}

# -------------------------
# 2. Design Matrix
# -------------------------
design <- model.matrix(~0 + subtypes$subtype)
colnames(design) <- c("C0", "C1", "C2", "C3", "C4")

fit <- lmFit(gene_data, design)

# -------------------------
# 3. Define Generalized Contrast List
#    Each subtype vs the other three
# -------------------------
contrast_matrix <- makeContrasts(
  C1_vs_rest = (C1 - (C0 + C2 + C3 + C4)/4),
  C2_vs_rest = (C2 - (C0 + C1 + C3 + C4)/4),
  C3_vs_rest = (C3 - (C0 + C1 + C2 + C4)/4),
  C4_vs_rest = (C4 - (C0 + C1 + C2 + C3)/4),
  levels = design
)

# Fit contrasts
results <- contrasts.fit(fit, contrast_matrix)
results <- eBayes(results)

# -------------------------
# 4. Helper Function for DEG Extraction
# -------------------------
extract_DEGs <- function(results, coef_name, gene_data, logFC_threshold = 1, p_value_threshold = 0.05) {
  
  tt <- topTable(results, coef = coef_name, number = Inf)
  
  # Filter using adj p-value
  sig <- tt[ abs(tt$logFC) > logFC_threshold & tt$adj.P.Val < p_value_threshold, ]
  
  # Gene names
  sig_genes <- rownames(sig)
  
  # Extract expression of those DEGs
  sig_expr <- t(gene_data[sig_genes, ])
  
  return(list(table = sig, expr = sig_expr))
}

# -------------------------
# 5. Extract DEGs for Each Subtype
# -------------------------
deg_C1 <- extract_DEGs(results, "C1_vs_rest", gene_data)
deg_C2 <- extract_DEGs(results, "C2_vs_rest", gene_data)
deg_C3 <- extract_DEGs(results, "C3_vs_rest", gene_data)
deg_C4 <- extract_DEGs(results, "C4_vs_rest", gene_data)

# -------------------------
# 6. Save Output DEG Expression Matrices
# -------------------------
write.csv(deg_C1$expr, "significant_genes_C1_v2.csv")
write.csv(deg_C2$expr, "significant_genes_C2_v2.csv")
write.csv(deg_C3$expr, "significant_genes_C3_v2.csv")
write.csv(deg_C4$expr, "significant_genes_C4_v2.csv")

cat("DEG extraction completed for C1, C2, C3, and C4.\n")