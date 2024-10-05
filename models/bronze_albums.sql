select *
from {{ source('albums', 'ajc_albums') }}
