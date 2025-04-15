{{ config(
    materialized='table',
    partition_by={
      "field": "Country",
    }
)}}

select *
from {{ ref('stg_listener_preferences') }}