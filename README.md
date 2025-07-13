# Principal Component Analysis (PCA) and Multidimensional Scaling (MDS) Report

## Author
Izabela Gula  
AGH University of Science and Technology, Kraków  
Informatics and Econometrics  

## Overview
This project presents a comprehensive analysis of socio-economic data for Polish counties (excluding cities with county rights) from 2022, sourced from the Polish Central Statistical Office (GUS). The study employs two advanced statistical techniques: **Principal Component Analysis (PCA)** and **Multidimensional Scaling (MDS)**, to reduce dimensionality, visualize relationships, and identify key patterns in the data.

## Key Features
- **Data Description**: The dataset includes 314 observations (counties) and 6 variables:
  - `X1`: Housing units completed per 1000 inhabitants.
  - `X2`: Population density (inhabitants per km²).
  - `X3`: Newly registered businesses in the REGON database.
  - `X4`: Number of workplace accident victims.
  - `X5`: Registered unemployment rate.
  - `X6`: Natural population movement (births, deaths, marriages, divorces).
  
- **Methodologies**:
  - **PCA**: Used to transform correlated variables into linearly uncorrelated principal components. The first two components explained **94% of the variance**, with the first component capturing uniform contributions from all variables and the second highlighting housing and population movement.
  - **MDS**: Applied to visualize county similarities/differences in reduced dimensions. Both **classical MDS** and **Sammon mapping** were tested, with Sammon achieving better fit (STRESS = 0.01 vs. 0.14 for classical MDS).

- **Results**:
  - Counties were grouped into 4 clusters based on socio-economic characteristics (e.g., urban vs. rural, industrial vs. agricultural).
  - Visualizations focused on West Pomeranian Voivodeship counties for clarity.

## Repository Contents
- `PCA_report.pdf`: Full project report (in Polish only).  
- Code (not included in the report but available upon request): R scripts for PCA (`procomp()`), MDS (`cmdscale()`), and data preprocessing.

## Key Insights
- **PCA**: The first principal component uniformly represented all variables, while the second emphasized housing and demographic trends.
- **MDS**: Highlighted disparities between urbanized (e.g., Police County) and rural counties, with Sammon mapping providing superior local structure preservation.
- **Cluster Analysis**: Identified distinct regional profiles (e.g., industrial hubs, tourist areas, agricultural regions).

## Limitations
- **PCA**: Sensitive to unit differences (required standardization) and large datasets challenge visualization.
- **MDS**: Computationally intensive; higher dimensions improved fit but complicated interpretation.

---
*Note: The report is available only in Polish. For questions or collaborations, please reach out.*
