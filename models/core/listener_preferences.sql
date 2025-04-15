{{ config(
    materialized='table',
    partition_by={
      "field": "loaded_time",
    }
)}}

select *
from {{ ref('stg_listener_preferences') }}