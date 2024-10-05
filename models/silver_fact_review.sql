with cte_all as (
    select
        h.album.youtubemusicid as youtube_id,
        h.rating as my_rating,
        h.globalrating as global_rating,
        h.generatedat as reviewed_on
    from
        {{ ref('bronze_albums') }} lateral view explode(history) as h
    order by
        load_timestamp desc
),

cte_dedup as (
    select distinct *
    from
        cte_all
    order by
        reviewed_on
)

select
    youtube_id,
    my_rating,
    global_rating,
    cast(reviewed_on as date) as review_date
from
    cte_dedup
