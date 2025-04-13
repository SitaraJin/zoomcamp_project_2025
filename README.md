# Project Data Engineering Zoomcamp 2025

This repository contains my final project for the Data Engineering Zoomcamp cohort 2025 taught by DataTalksClub. The course's repository can be found [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main).

## Objective

The objective of the final project is to build an end-to-end data pipeline with a chosen dataset. It should contaiin the following items:

- Select a dataset
- Create a pipeline to load the data into a datalake
- Create a pipeline to move the data into a data warehouse
- Transform the data in the data warehouse
- Build a dashboard to visualize the data

## Technologies used

The following technologies will be used:

- IaC: Terraform
- Cloud: GCP
- Workflow orchestation: Kestra
- Data Lake: Google Cloud Storage
- Data Warehouse: Google BigQuery
- Data transformation: DBT
- Visualization: Metabase

## Problem description

This project will use the dataset " Global Music Streaming Trends & Listener Insights", that can be found [here](https://www.kaggle.com/datasets/atharvasoundankar/global-music-streaming-trends-and-listener-insights/data)). This is an open source dataset found in Kaggle.

The idea is to build a data pipeline that will extract the data and prepare it for a visualization in Metabase. This way we will be able to analyze listener demographics, streaming habits, genre preferences, and engagement metrics.

The project can be summarized as follows:

1. Build the needed infrastructure using Terraform
2. Ingest dataset into GCS from the given link using Kestra
3. Transfer dataset from GCS to BigQuery using Kestra
4. Transform data in Bigquery using dbt
5. Visualize data in dashboard using Metabase

## Setup

1. Create a new project in GCP.
2. Go to IAM & Admin > Service Accounts, and create a new service account
3. Create a new json key for the service account

Additionally, the following must be done:

- Under IAM & Admin > IAM, add the following roles to the newly created service account: Storage Admin + Storage Object Admin + BigQuery Admin

## Terraform

In this part all the necessary infrastructure will be created:

- GCS bucket
- Big Query dataset

Before running terraform, you must modify the file `variables.tf` to your personal details.

Run `terraform init` to initialize terraform. Then run `terraform apply` to build the infrastructure. When this is done, GCS bucket and Big Query Dataset will be created in the GCP project.  
To destroy them, run `terraform destroy`.

## Kestra

This part is needed to extract data and save it in GCS and Big Query.

The Pipeline of extracting the data, loading the data into GCS and moving the data into Big Query as follows:

### KV_setup

The flow `gcp_kv_setup` is responsible of configuring the keys andvariables needed by GCP.

### Data extract

The task `extract` in the flow named `data_load_to_gcp` is responsible of extracting the data from kaggle. It uses the curl to download the dataset and then unzip it.

### Data Exporting

The task `upload_to_gcs` in the flow named `data_load_to_gcp` is responsible of saving the dataset in a Google Cloud Storage bucket. It saves a file called `Global_Music_Streaming_Listener_Preferences.csv` inside the bucket `zoomcamp_project`.

## Data Warehouse in Big Query

Once the dataset is already in a bucket in GCS, we can create and external table in Google Big Query as our Data Warehouse, then process the values ​​in the column names that do not meet the requirements, and finally generate a table partitioned by loaded date in BigQuery, you can see the whole process in the task `load_to_bigquery` of the flow named `data_load_to_gcp`

## Transformations in DBT

This part is developed on DBT Cloud. The instructions to set up a DBT Cloud account and setup it with Big Query can be found [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md).

Open the dbt project and run the job so that the dbt pipeline is executed. When executed, you will get the final table `listener_preferences` in the production database and also some staging views in the staging database. The field Subscription_Type is set as the partition, which is suitable for scenarios where analysis based on subscription type is often required.

## Visualization in metabse

You can use the metabase locally to create visualizations.

```
docker run -d -p 3000:3000 --name metabase metabase/metabase
```

The final visualization report is exported to pdf, you can check here.
