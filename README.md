# LinkedIn Job Analysis Dashboard

## 📌 Project Overview

The **LinkedIn Job Analysis Dashboard** is a data analytics project designed to analyze LinkedIn job postings and identify hiring trends, salary patterns, job types, locations, experience levels, and in-demand technical skills.

The project follows an end-to-end data analytics workflow:

**LinkedIn Dataset → Python → Pandas → Data Cleaning → CSV → Power BI → Power Query + DAX → Interactive Dashboard**

## 🛠️ Tools & Technologies

### Python
Used for data preprocessing, cleaning, transformation, and preparing the dataset for analysis.

### Pandas
Used to load the dataset, handle missing values, remove duplicates, clean columns, transform data, and generate the final cleaned CSV.

### Jupyter Notebook
Used as the development environment to perform data cleaning and analysis step-by-step using Python.

### CSV
Used to store the cleaned dataset and transfer the prepared data from Python to Power BI.

### MySQL
Used as an optional database layer for storing job-posting data and performing SQL-based analysis.

### Power Query
Used in Power BI to transform, format, and prepare the dataset before creating visualizations.

### Power BI
Used to build the interactive dashboard and visualize hiring, salary, and skill-related insights.

### DAX
Used to create calculated measures, KPIs, job counts, salary calculations, and skill-related metrics in Power BI.

## 📊 Dashboard Pages

### 1. Hiring Analysis
- Total Job Postings
- Jobs by Experience Level
- Jobs by Work Type
- Remote vs On-site Jobs
- Jobs by Location
- Job Domain Distribution

### 2. Salary Analysis
- Average Compensation
- Compensation by Job Level
- Compensation by Job Domain
- Salary Distribution
- Work Type vs Compensation

### 3. Skills & Career Analysis
- In-demand Technical Skills
- Python Jobs
- SQL Jobs
- Excel Jobs
- Power BI Jobs
- Tableau Jobs
- AWS Jobs
- Java Jobs
- Skills by Experience Level

## 🔄 Project Workflow

```text
LinkedIn Job Dataset
        ↓
     Python
        ↓
     Pandas
        ↓
Data Cleaning & Transformation
        ↓
    Cleaned CSV
        ↓
     Power BI
        ↓
   Power Query
        ↓
      DAX
        ↓
3-Page Interactive Dashboard
