SELECT
    movie_year,
    COUNT(movie_title) AS total_de_filmes,

    ROUND(AVG(rating)::numeric, 2) AS nota_media,
    MIN(rating) AS nota_minima,
    MAX(rating) AS nota_maxima


FROM
    {{ ref('stg_movies') }}
GROUP BY
    movie_year
ORDER BY
    movie_year DESC