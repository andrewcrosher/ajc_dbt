with cte_all as (
  select
    h.album.youtubeMusicId as youtube_id,
    h.album.name as album,
    h.album.artist as artist,
    h.album.releaseDate as release_date,
    h.album.wikipediaUrl as wikipedia_url,
    h.generatedAt as reviewed_on
  from
    {{ ref('bronze_albums') }} lateral view explode(history) as h
  order by
    load_timestamp desc
)

, cte_dedup as (
  select 
    distinct *
  from 
    cte_all
  order by
    reviewed_on
)

select
  youtube_id
  , album
  , artist
  , release_date
  , wikipedia_url
from
  cte_dedup