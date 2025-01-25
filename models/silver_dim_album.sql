with cte_all as (
    select
        h.album.youtubemusicid as youtube_id,
        h.album.spotifyId as spotifyId,
        h.album.appleMusicId as appleMusicId,
        h.album.tidalId as tidalId,
        h.album.amazonMusicId as amazonMusicId,
        h.album.qobuzId as qobuzId,
        h.album.deezerId as deezerId,
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
    select distinct *
    from
        cte_all
    order by
        reviewed_on
)

select
    youtube_id,
    spotifyId,
    appleMusicId,
    tidalId,
    amazonMusicId,
    qobuzId,
    deezerId
    album,
    artist,
    release_date,
    genres,
    wikipedia_url
from
    cte_dedup
