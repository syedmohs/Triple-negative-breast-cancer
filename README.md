## RUN SHEET — Complete Pipeline

This run sheet describes how to execute the full end-to-end workflow for:

- Dataset preparation & subtype clustering  
- Differential expression (DE) analysis  
- Machine learning model development & SHAP-based interpretation  

---

## 1. Dataset Preparation & Subtype Assignment

**Script:** `Dataset preparation.ipynb`

### Steps Performed
- Load combined gene expression matrix  
- Train–test split  
- Feature standardization using `StandardScaler`  
- K-means clustering (`k = 4`)  
- Assign subtypes:
  - **C1–C4**: TNBC molecular subtypes  
  - **C0**: Non-TNBC samples  
- Save clustered train/test matrices and metadata to:
  - `clustering_output.pkl`

---

## 2. TNBC Subtyping

**Script:** `Subtyping.ipynb`

- Loads clustering outputs  
- Finalizes TNBC subtype assignments for downstream analysis  

---

## 3. Differential Expression (DE) Analysis

**Script:** `DEG.R`

### Steps Performed
- Construct `limma` design matrix  
- Perform subtype-vs-rest contrasts:
  - C1 vs rest  
  - C2 vs rest  
  - C3 vs rest  
  - C4 vs rest  
- Extract differentially expressed genes (DEGs) using:
  - `|logFC| > 1`  
  - `adj.p < 0.05`  
- Save DEG expression matrices for machine learning  

---

## 4. Machine Learning Model Development & Interpretation

**Script:** `Model Development.ipynb`

### Steps Performed
- Combine all DEG files using column-wise union  
- Remove highly correlated features (`> 0.80`)  
- Recursive Feature Elimination (RFE) to select top **50 features**  
- Train models using **stratified 5-fold cross-validation**  
- Evaluate performance on a held-out test set  
- Compute **SHAP values** for model interpretability  

---

## Execution Order

Run the scripts in the following order:

1. `Dataset preparation.ipynb`  
2. `Subtyping.ipynb`  
3. `DEG.R`  
4. `Model Development.ipynb`  

---

## Datasets

The datasets could not be uploaded due to large file size constraints. They can be downloaded from the **Gene Expression Omnibus (GEO)**:

- `GSE18864`  
- `GSE65194`  
- `GSE95700`  
- `GSE76275`  
- `GSE58812`  
- `GSE83937`  

