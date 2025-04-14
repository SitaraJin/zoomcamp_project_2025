{{
    config(
        materialized='view'
    )
}}

SELECT 
        User_ID,
        Age,
        {{ get_age_range_desc('Age') }} as age_range,
        Country,
        Streaming_Platform,
        Top_Genre,
        Minutes_Streamed_Per_Day,
        Number_of_Songs_Liked,
        Most_Played_Artist,
        Subscription_Type,
        Listening_Time,
        Discover_Weekly_Engagement,
        Repeat_Song_Rate
    {{ source('staging','Listener_Preferences') }}

-- dbt build --select <model_name> --vars '{"is_test_run": false}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}