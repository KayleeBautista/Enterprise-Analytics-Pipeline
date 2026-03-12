# Cloud-Based Enterprise Analytics Pipeline

## Overview

This project builds an end-to-end cloud analytics pipeline using PostgreSQL, AWS RDS, Python, and Power BI. The pipeline ingests e-commerce data, transforms it into a dimensional data warehouse, and visualizes business metrics through interactive dashboards.

## Dataset

The dataset used in this project is the Brazilian Olist e-commerce dataset.

Due to GitHub file size limits, the raw dataset files are not stored in this repository.

You can download the dataset here:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

## Architecture

Python ETL --> AWS RDS PostgreSQL --> Star Schema --> Power BI


## Technologies Used

* AWS RDS (PostgreSQL)
* Python
* Pandas
* SQLAlchemy
* PostgreSQL
* Power BI
* Star Schema Data Warehouse Modeling

## Data Pipeline

1. Raw CSV data is ingested locally.
2. Python ETL processes and cleans the data.
3. Data is loaded into a PostgreSQL data warehouse hosted on AWS RDS.
4. A dimensional star schema is created for analytics.
5. Power BI connects to the warehouse to produce dashboards and business insights.

## Data Warehouse Design

The warehouse uses a star schema:

Fact Table

* fact_orders

Dimension Tables

* dim_customers
* dim_products
* dim_sellers
* dim_date

## Example Metrics

Power BI dashboards include:

* Total Revenue
* Total Orders
* Revenue Growth
* Top Products
* Customer Distribution

## Project Structure

```
cloud-analytics-pipeline
├── architecture
├── olist_enterprise_pipeline
├──────── data
├──────── etl
├──────── logs
├──────── venv
├──────── main
├──────── readme
├──────── requirements
├── power bi
├── sql
└── zipped files
```


## Key Skills Demonstrated

* Data Engineering
* ETL Development
* Cloud Data Warehousing
* Dimensional Modeling
* Business Intelligence
* SQL Optimization
* Power BI Dashboard Development

## Author

Kaylee Bautista
University of North Georgia
