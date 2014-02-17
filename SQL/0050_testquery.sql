--this query will give you the chances of being richt/poor for a 50-er, Masters degree, White and working 50 to 60 hours per week
WITH chances AS (
SELECT
	log("p_>50k" * p) AS "rich",
	log("p_<=50k" * p) AS "poor"
FROM
	"overview_age"
WHERE
	range = '50-ers'

UNION ALL

SELECT
	log("p_>50k" * p) AS "rich",
	log("p_<=50k" * p) AS "poor"
FROM
	"overview_education"
WHERE
	education LIKE '%Master%'

UNION ALL

SELECT
	log("p_>50k" * p) AS "rich",
	log("p_<=50k" * p) AS "poor"
FROM
	"overview_race"
WHERE
	race LIKE '%White%'

UNION ALL

SELECT
	log("p_>50k" * p) AS "rich",
	log("p_<=50k" * p) AS "poor"
FROM
	"overview_hours-per-week"
WHERE
	range LIKE '50-60'

), chances_combined AS(
	SELECT
		10^SUM(rich) AS rich,
		10^SUM(poor) AS poor
	FROM
		chances
)
SELECT
	1 AS rich,
	poor/rich::double precision AS poor
FROM
	chances_combined

UNION ALL

SELECT
	rich/poor::double precision  AS rich,
	1 AS poor
FROM
	chances_combined

;
