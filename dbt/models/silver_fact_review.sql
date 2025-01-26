with cte_all as (
    select
        h.album.youtubemusicid as youtube_id,
        h.rating as my_rating,
        h.globalrating as global_rating,
        h.generatedat as reviewed_on,
        load_timestamp
    from
        {{ ref('bronze_albums') }} lateral view explode(history) as h
    order by
        load_timestamp desc
),

cte_dedup as (
    select *
    from (
        select
            ca.*,
            row_number()
                over (
                    partition by ca.youtube_id
                    order by ca.load_timestamp desc
                )
            as rn
        from cte_all as ca
    ) as sub
    where rn = 1
)

select
    youtube_id,
    my_rating,
    global_rating,
    cast(reviewed_on as date) as review_date
from
    cte_dedup
