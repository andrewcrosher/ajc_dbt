with cte_all as (
    select
        h.album.wikipedia_url as wikipedia_url,
        h.album.genres,
        h.album.subgenres,
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

select *
from cte_dedup
