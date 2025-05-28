CREATE OR REPLACE TABLE `bigquery-course-452915.spotify_project.tracks_analytics2` AS
SELECT
  -- Keep core track info
  id,
  name,
  popularity,
  
  -- Convert duration from ms to minutes
  ROUND(duration_ms / 60000.0, 2) AS duration_min,

  -- Parse artist names: take first one and remove brackets/quotes
  REGEXP_REPLACE(REGEXP_EXTRACT(artists, r"'(.*?)'"), r"[\[\]']", "") AS main_artist,

  release_date,

  -- Audio features
  danceability,
  energy,
  key,
  loudness,
  mode,
  speechiness,
  acousticness,
  instrumentalness,
  liveness,
  valence,
  tempo,
  time_signature,

  -- Tempo category
  CASE
    WHEN tempo < 90 THEN 'slow'
    WHEN tempo BETWEEN 90 AND 130 THEN 'medium'
    ELSE 'fast'
  END AS tempo_category,

  -- Extract year from release date
  SAFE_CAST(SUBSTR(CAST(release_date AS STRING), 1, 4) AS INT64) AS release_year

FROM
  bigquery-course-452915.spotify_project.tracks

-- Optional filters to clean weird/missing values
WHERE
  popularity IS NOT NULL
  AND tempo IS NOT NULL
  AND duration_ms IS NOT NULL
  AND release_date IS NOT NULL






/* Tempo Kategorisine Göre Ortalama Popülerlik */
SELECT
  tempo_category,
  AVG(popularity) AS avg_popularity
FROM
  `spotify_project.tracks_analytics`
GROUP BY tempo_category
ORDER BY avg_popularity DESC


/* Yıllara Göre Şarkı Sayısı */

SELECT
  EXTRACT(YEAR FROM 
    CASE
      WHEN REGEXP_CONTAINS(release_date, r'^\d{4}-\d{2}-\d{2}$') THEN PARSE_DATE('%Y-%m-%d', release_date)
      WHEN REGEXP_CONTAINS(release_date, r'^\d{4}-\d{2}$') THEN PARSE_DATE('%Y-%m-%d', CONCAT(release_date, '-01'))
      WHEN REGEXP_CONTAINS(release_date, r'^\d{4}$') THEN PARSE_DATE('%Y-%m-%d', CONCAT(release_date, '-01-01'))
      ELSE NULL
    END
  ) AS release_year,
  COUNT(*) AS track_count
FROM `spotify_project.tracks_analytics`
WHERE release_date IS NOT NULL
GROUP BY release_year
ORDER BY release_year


/*Track başına ortalama popülerlik */ 
SELECT 
  AVG(popularity) AS avg_popularity
FROM 
  `spotify_project.tracks_analytics`


/* Yıllara göre çıkmış track sayısı*/
SELECT 
  SAFE_CAST(SUBSTR(release_date, 1, 4) AS INT64) AS release_year,
  COUNT(*) AS track_count
FROM 
  `spotify_project.tracks_analytics`
GROUP BY release_year
ORDER BY release_year

/*  Tempo kategorisine göre ortalama popülerlik*/

SELECT 
  tempo_category,
  AVG(popularity) AS avg_popularity
FROM 
  `spotify_project.tracks_analytics`
GROUP BY tempo_category


/*Moda (fashion tag) göre ortalama popülerlik*/ 
SELECT 
  mode,
  AVG(popularity) AS avg_popularity
FROM 
  `spotify_project.tracks_analytics`
GROUP BY mode


/* Danceability vs Popularity korelasyonu*/
SELECT 
  danceability, 
  popularity
FROM 
  `spotify_project.tracks_analytics`
WHERE 
  danceability IS NOT NULL AND popularity IS NOT NULL



/* Energy vs Popularity scatter verisi*/
SELECT 
  energy,
  popularity
FROM 
  `spotify_project.tracks_analytics`
WHERE 
  energy IS NOT NULL AND popularity IS NOT NULL


/* Yıllara göre ortalama dans edilebilirlik*/

SELECT 
  SAFE_CAST(SUBSTR(release_date, 1, 4) AS INT64) AS release_year,
  AVG(danceability) AS avg_danceability
FROM 
  `spotify_project.tracks_analytics`
GROUP BY release_year
ORDER BY release_year



/*Tempo category başına track sayısı*/
SELECT 
  tempo_category,
  COUNT(*) AS total_tracks
FROM 
  `spotify_project.tracks_analytics`
GROUP BY tempo_category


/* Speechiness > 0.33 olan track'ler*/
SELECT 
  name, 
  speechiness,
  popularity
FROM 
  `spotify_project.tracks_analytics`
WHERE 
  speechiness > 0.33
ORDER BY popularity DESC
LIMIT 50


