with cte_all as (
    select
        h.album.youtubemusicid as youtube_id,
        h.album.name as album,
        h.album.artist,
        h.album.releasedate as release_date,
        h.album.genres,
        h.album.wikipediaurl as wikipedia_url,
        h.generatedat as reviewed_on
    from
        {{ ref('bronze_albums') }} lateral view explode(history) as h
    order by
        load_timestamp desc
),

cte_dedup as (
    select distinct genres
    from
        cte_all
)

select
    genres,
    row_number() over (order by genres) as id
from
    cte_dedup
