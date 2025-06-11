with source_data as (

    SELECT
        "MOVIES"    AS movie_title,
        "YEAR"      AS raw_movie_year,
        "GENRE"     AS genre,
        "RATING"    AS rating,
        "VOTES"     AS votes
    FROM
        {{ source('raw_data_source', 'movies') }}
    
),

cleaned as (

    SELECT
        movie_title,
        genre,
        rating,

        substring(raw_movie_year from '\d{4}')::integer AS movie_year,

        CAST(REPLACE(votes::text, ',', '') AS INTEGER) AS votes_count
        
    FROM
        source_data
)

-- Para garantir que só teremos anos validos.
SELECT * FROM cleaned
WHERE 
    movie_year IS NOT NULL
    AND rating IS NOT NULL
    AND genre IS NOT NULL AND genre != ''
    AND votes_count IS NOT NULL