📌 RUN SHEET — Complete Pipeline

This run-sheet describes how to execute the full workflow for:

Dataset preparation & subtype clustering

Differential expression (DE) analysis

Machine learning model development & SHAP

✅ 1. Dataset Preparation & Subtype Assignment

Script: Dataset preparation for combining.ipynb
Inputs:

final.csv

final_non.csv

Outputs:

final_with_subtypes_v2.csv

only_subtypes_v2.csv

clustering_output.pkl

Steps performed:

Load combined gene expression matrix

Train–test split

Standardization (StandardScaler)

K-means clustering (k = 4)

Assign subtypes: C1–C4, and non-TNBC as C0

Save clustered train/test matrices + metadata to clustering_output.pkl

✅ 2. Differential Expression (DE) Analysis

Script: DEG_extraction.R
Inputs:

final_with_subtypes_v2.csv

only_subtypes_v2.csv

Outputs (per subtype):

significant_genes_C1_v2.csv

significant_genes_C2_v2.csv

significant_genes_C3_v2.csv

significant_genes_C4_v2.csv

Steps performed:

limma design matrix setup

Subtype-vs-rest contrasts (C1, C2, C3, C4)

Extraction of DEGs: |logFC| > 1, adj.p < 0.05

Save DEG expression matrices for ML

✅ 3. Machine Learning Model Development

Script: Model Development_v2.ipynb
Inputs:

clustering_output.pkl

significant_genes_C1_v2.csv

significant_genes_C2_v2.csv

significant_genes_C3_v2.csv

significant_genes_C4_v2.csv

Outputs:

Trained ML models (RF, SVM, DT, XGB)

Cross-validated metrics (accuracy, sensitivity, specificity, precision)

Test-set confusion matrix

SHAP summary plots (Random Forest)

Steps performed:

Combine all DEG files (column-union)

Drop correlated features (>0.80)

RFE feature selection (n = 50)

Train models with stratified 5-fold CV

Evaluate on held-out test set

Compute SHAP values for feature interpretation
