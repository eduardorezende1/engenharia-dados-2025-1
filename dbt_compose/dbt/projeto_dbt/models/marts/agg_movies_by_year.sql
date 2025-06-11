SELECT
    movie_year,
    COUNT(movie_title) AS total_de_filmes
FROM
    {{ ref('stg_movies') }}
GROUP BY
    movie_year
ORDER BY
    movie_year DESC