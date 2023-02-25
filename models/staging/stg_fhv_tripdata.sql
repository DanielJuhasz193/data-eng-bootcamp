{{ config(materialized="view") }}

with tripdata as (select * from {{ source("staging", "fhv_taxi_data_2019") }})
select
    -- identifiers
    dispatching_base_num as dispatching_base_num,
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    cast(pulocationid as integer) as pu_location_id,
    cast(dolocationid as integer) as do_location_id,
    sr_flag as sr_flag,
    affiliated_base_number as affiliated_base_number

from tripdata

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var("is_test_run", default=true) %} limit 100 {% endif %}
