--TODO: catch when log =0
--TODO: comment on views
DROP VIEW IF EXISTS "overview_workclass" CASCADE;
CREATE VIEW "overview_workclass" AS (
	SELECT
		a.workclass,
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		workclass,
		b.numrec
);

DROP VIEW IF EXISTS "overview_education" CASCADE;
CREATE VIEW "overview_education" AS (
	SELECT
		a.education,
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		education,
		b.numrec
);

DROP VIEW IF EXISTS "overview_marital_status" CASCADE;
CREATE VIEW "overview_marital_status" AS (
	SELECT
		a."marital-status",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"marital-status",
		b.numrec
);

DROP VIEW IF EXISTS "overview_occupation" CASCADE;
CREATE VIEW "overview_occupation" AS (
	SELECT
		a."occupation",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"occupation",
		b.numrec
);

DROP VIEW IF EXISTS "overview_relationship" CASCADE;
CREATE VIEW "overview_relationship" AS (
	SELECT
		a."relationship",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"relationship",
		b.numrec
);

DROP VIEW IF EXISTS "overview_race" CASCADE;
CREATE VIEW "overview_race" AS (
	SELECT
		a."race",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"race",
		b.numrec
);

DROP VIEW IF EXISTS "overview_sex" CASCADE;
CREATE VIEW "overview_sex" AS (
	SELECT
		a."sex",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"sex",
		b.numrec
);

DROP VIEW IF EXISTS "overview_native-country" CASCADE;
CREATE VIEW "overview_native-country" AS (
	SELECT
		a."native-country",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"native-country",
		b.numrec
);

DROP VIEW IF EXISTS "overview_income" CASCADE;
CREATE VIEW "overview_income" AS (
	SELECT
		a."income",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"income",
		b.numrec
);

--education-num is continous, but we only go up to 16
DROP VIEW IF EXISTS "overview_education_num" CASCADE;
CREATE VIEW "overview_education_num" AS (
	SELECT
		a."education-num",
		count(a.*),
		b.numrec,count(a.*)::double precision/b.numrec AS p,
		count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
	FROM 
		adults as a,
		(SELECT COUNT(*) AS numrec FROM adults) AS b
	GROUP BY
		"education-num",
		b.numrec
);

--now do the continous columns
DROP VIEW IF EXISTS "overview_age" CASCADE;
CREATE VIEW "overview_age" AS (
	SELECT
		'0-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age<10) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'10-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=10 AND age<20) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'20-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=20 AND age<30) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'30-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=30 AND age<40) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'40-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=40 AND age<50) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'50-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=50 AND age<60) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'60-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=60 AND age<70) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'70-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=70 AND age<80) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'90-ers'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=90 AND age<100) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
);

DROP VIEW IF EXISTS "overview_hours_per_week" CASCADE;
CREATE VIEW "overview_hours_per_week" AS (
	SELECT
		'0-10'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week"<10) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'10-20'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=10 AND "hours-per-week"<20) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'20-30'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=20 AND "hours-per-week"<30) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'30-40'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=30 AND "hours-per-week"<40) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'50-60'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=50 AND "hours-per-week"<60) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'60-70'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=60 AND "hours-per-week"<70) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'70-80'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=70 AND "hours-per-week"<80) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	UNION ALL
	SELECT
		'80+'::varchar(16) AS range,
		a.count AS "count",
		b.numrec,a.count::double precision/b.numrec AS p,
		CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=80) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
);

--We could also do the other columns, but I don't really know what they are meaning
