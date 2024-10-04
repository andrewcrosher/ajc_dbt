with cte_all as (
  select
    h.album.youtubeMusicId as youtube_id,
    h.album.name as album,
    h.album.artist as artist,
    h.rating as my_rating,
    h.globalRating as global_rating,
    h.generatedAt as reviewed_on
  from
    {{ ref('bronze_albums') }} lateral view explode(history) as h
  order by
    load_timestamp desc
)

select distinct *
from cte_all
order by reviewed_on
