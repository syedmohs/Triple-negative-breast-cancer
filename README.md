RUN SHEET — Complete Pipeline

This run-sheet describes how to execute the full workflow for:

Dataset preparation & subtype clustering

Differential expression (DE) analysis

Machine learning model development & SHAP



1. Dataset Preparation & Subtype Assignment

Script: Dataset preparation.ipynb

Steps performed:

Load combined gene expression matrix
  Train–test split
  Standardization (StandardScaler)
  K-means clustering (k = 4)
  Assign subtypes: C1–C4, and non-TNBC as C0
  Save clustered train/test matrices + metadata to clustering_output.pkl

2. TNBC subtyping
Script: Subtyping.ipynb

3. Differential Expression (DE) Analysis

Script: DEG.R

Steps performed:

  limma design matrix setup

  Subtype-vs-rest contrasts (C1, C2, C3, C4)

  Extraction of DEGs: |logFC| > 1, adj.p < 0.05

  Save DEG expression matrices for ML

4. Machine Learning Model Development

Script: Model Development.ipynb

Steps performed:

  Combine all DEG files (column-union)

  Drop correlated features (>0.80)

  RFE feature selection (n = 50)

  Train models with stratified 5-fold CV

  Evaluate on held-out test set

  Compute SHAP values for feature interpretation

1. Run "Dataset preparation.ipynb"
2. Run "Subtyping.ipynb"
3. Run "DEG.R"
4. Run "Model Development.ipynb"

  
