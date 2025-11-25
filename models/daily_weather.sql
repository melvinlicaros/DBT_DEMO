WITH daily_weather as (

select 
    date(time) AS daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
from {{ source('demo', 'weather') }}

),

daily_weather_agg AS (

select
    daily_weather,
    weather,
    ROUND(avg(temp),2) AS avg_temp,
    ROUND(avg(pressure),2) AS avg_pressure,
    ROUND(avg(humidity),2) AS avg_humidity,
    ROUND(avg(clouds),2) AS avg_clouds
from daily_weather
group by daily_weather, weather
qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY COUNT(weather) desc) = 1
)

select *
from daily_weather_agg