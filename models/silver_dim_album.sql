with cte_all as (
    select
        h.album.youtubemusicid as youtube_id,
        h.album.spotifyid as spotify_id,
        h.album.applemusicid as apple_music_id,
        h.album.tidalid as tidal_id,
        h.album.amazonmusicid as amazon_music_id,
        h.album.qobuzid as qobuz_id,
        h.album.deezerid as deezer_id,
        h.album.name as album,
        h.album.artist,
        h.album.releasedate as release_date,
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
    spotify_id,
    apple_music_id,
    tidal_id,
    amazon_music_id,
    qobuz_id,
    deezer_id,
    album,
    artist,
    release_date,
    wikipedia_url
from
    cte_dedup
