WITH BIKE AS (

select 
    distinct
    start_statio_id AS station_id,
    start_station_name,
    start_lat,
    start_lng
from {{ ref('stg_bike') }}
WHERE RIDE_ID != 'ride_id'
)

select *
from BIKE