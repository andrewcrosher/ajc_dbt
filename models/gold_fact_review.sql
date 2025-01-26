select
    da.album as `Album`,
    da.artist as `Artist`,
    cast(da.release_date as int) as `Release Year`,
    dg.genres as `Genres`,
    fr.my_rating as `My Rating`,
    fr.global_rating as `Global Rating`,
    cast(
        (fr.my_rating / fr.global_rating) * 100 as decimal(5, 2)
    ) as `My Relative Rating`,
    fr.review_date as `Review Date`,
    da.wikipedia_url as `Wikipedia Link`
from
    {{ ref('silver_fact_review') }} as fr
inner join
    {{ ref("silver_dim_album") }} as da
    on fr.youtube_id = da.youtube_id
inner join
    {{ ref("silver_dim_genre") }} as dg
    on fr.youtube_id = dg.youtube_id
order by
    fr.review_date desc
