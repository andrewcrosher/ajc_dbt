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
    da.wikipedia_url as `Wikipedia Link`,
    concat(substring(da.release_date, 1, 3), '0s') as `Release Decade`
from
    {{ ref('silver_fact_review') }} as fr
inner join
    {{ ref("silver_dim_album") }} as da
    on fr.wikipedia_url = da.wikipedia_url
inner join
    {{ ref("silver_dim_genre") }} as dg
    on fr.wikipedia_url = dg.wikipedia_url
order by
    fr.review_date desc
