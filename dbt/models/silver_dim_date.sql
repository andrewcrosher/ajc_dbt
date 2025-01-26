{{
    config(
        materialized = "table"
    )
}}

{{ dbt_date.get_date_dimension("1900-01-01", "2099-12-31") }}
