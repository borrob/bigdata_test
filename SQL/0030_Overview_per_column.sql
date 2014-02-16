--TODO: catch when log =0
--TODO: comment on views
DROP VIEW IF EXISTS "overview_workclass" CASCADE;
CREATE VIEW "overview_workclass" AS (
	WITH tmp AS (
		--group by the workclass and return the counts and the change p
		SELECT
			a.workclass,
			count(a.*),
			b.numrec,
			count(a.*)::double precision/b.numrec AS p,
			count(a.*)::double precision/b.numrec * log(count(a.*)::double precision/b.numrec) AS p_log_p
		FROM 
			adults as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
		GROUP BY
			workclass,
			b.numrec
	)
	SELECT
		--group by workclass and add info on recordcount, chances, the >50l chance and the conditonal entropy
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,workclass FROM adults) AS b
	WHERE
		tmp.workclass=b.workclass
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp.workclass, tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_education" CASCADE;
CREATE VIEW "overview_education" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,education FROM adults) AS b
	WHERE
		tmp.education=b.education
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp.education, tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_marital-status" CASCADE;
CREATE VIEW "overview_marital-status" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"marital-status" FROM adults) AS b
	WHERE
		tmp."marital-status"=b."marital-status"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."marital-status", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_occupation" CASCADE;
CREATE VIEW "overview_occupation" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"occupation" FROM adults) AS b
	WHERE
		tmp."occupation"=b."occupation"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."occupation", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_relationship" CASCADE;
CREATE VIEW "overview_relationship" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"relationship" FROM adults) AS b
	WHERE
		tmp."relationship"=b."relationship"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."relationship", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_race" CASCADE;
CREATE VIEW "overview_race" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"race" FROM adults) AS b
	WHERE
		tmp."race"=b."race"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."race", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_sex" CASCADE;
CREATE VIEW "overview_sex" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"sex" FROM adults) AS b
	WHERE
		tmp."sex"=b."sex"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."sex", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);

DROP VIEW IF EXISTS "overview_native-country" CASCADE;
CREATE VIEW "overview_native-country" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"native-country" FROM adults) AS b
	WHERE
		tmp."native-country"=b."native-country"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."native-country", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
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
DROP VIEW IF EXISTS "overview_education-num" CASCADE;
CREATE VIEW "overview_education-num" AS (
	WITH tmp AS (
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
	)
	SELECT
		tmp.*,
		count(b.*)::double precision/tmp.count AS "p_>50k",
		(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
		-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
		tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
	FROM
		tmp,
		(SELECT income,"education-num" FROM adults) AS b
	WHERE
		tmp."education-num"=b."education-num"
	AND
		b.income LIKE '%>%'
	GROUP BY
		tmp."education-num", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
);
--now do the continous columns
--we group them manually
DROP VIEW IF EXISTS "overview_age" CASCADE;
CREATE VIEW "overview_age" AS (
	WITH tmp AS (
		SELECT
			'0-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age<10) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	),"10-ers" AS (
		SELECT
			tmp.*,
			count(b.*)::double precision/tmp.count AS "p_>50k",
			(1-count(b.*)::double precision/tmp.count) AS "p_<=50k",
			-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "h_conditional",
			tmp.p*-(count(b.*)::double precision/tmp.count * log(count(b.*)::double precision/tmp.count) + ((tmp.count-count(b.*)::double precision)/tmp.count * log((tmp.count - count(b.*))::double precision/tmp.count)) ) AS "p_h_conditional"
		FROM
			tmp,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <10
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp."range", tmp.count, tmp.p,tmp.numrec, tmp."p_log_p"
	), tmp2 AS (
		SELECT
			'10-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=10 AND age<20) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	),"20-ers" AS (
		SELECT
			tmp2.*,
			count(b.*)::double precision/tmp2.count AS "p_>50k",
			(1-count(b.*)::double precision/tmp2.count) AS "p_<=50k",
			-(count(b.*)::double precision/tmp2.count * log(count(b.*)::double precision/tmp2.count) + ((tmp2.count-count(b.*)::double precision)/tmp2.count * log((tmp2.count - count(b.*))::double precision/tmp2.count)) ) AS "h_conditional",
			tmp2.p*-(count(b.*)::double precision/tmp2.count * log(count(b.*)::double precision/tmp2.count) + ((tmp2.count-count(b.*)::double precision)/tmp2.count * log((tmp2.count - count(b.*))::double precision/tmp2.count)) ) AS "p_h_conditional"
		FROM
			tmp2,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <20 AND b."age">=10
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp2."range", tmp2.count, tmp2.p,tmp2.numrec, tmp2."p_log_p"
	), tmp3 AS (
		SELECT
			'20-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=20 AND age<30) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	),"30-ers" AS (
		SELECT
			tmp3.*,
			count(b.*)::double precision/tmp3.count AS "p_>50k",
			(1-count(b.*)::double precision/tmp3.count) AS "p_<=50k",
			-(count(b.*)::double precision/tmp3.count * log(count(b.*)::double precision/tmp3.count) + ((tmp3.count-count(b.*)::double precision)/tmp3.count * log((tmp3.count - count(b.*))::double precision/tmp3.count)) ) AS "h_conditional",
			tmp3.p*-(count(b.*)::double precision/tmp3.count * log(count(b.*)::double precision/tmp3.count) + ((tmp3.count-count(b.*)::double precision)/tmp3.count * log((tmp3.count - count(b.*))::double precision/tmp3.count)) ) AS "p_h_conditional"
		FROM
			tmp3,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <30 AND b."age">=20
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp3."range", tmp3.count, tmp3.p,tmp3.numrec, tmp3."p_log_p"
	), tmp4 AS (
		SELECT
			'30-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=30 AND age<40) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "40-ers" AS (
		SELECT
			tmp4.*,
			count(b.*)::double precision/tmp4.count AS "p_>50k",
			(1-count(b.*)::double precision/tmp4.count) AS "p_<=50k",
			-(count(b.*)::double precision/tmp4.count * log(count(b.*)::double precision/tmp4.count) + ((tmp4.count-count(b.*)::double precision)/tmp4.count * log((tmp4.count - count(b.*))::double precision/tmp4.count)) ) AS "h_conditional",
			tmp4.p*-(count(b.*)::double precision/tmp4.count * log(count(b.*)::double precision/tmp4.count) + ((tmp4.count-count(b.*)::double precision)/tmp4.count * log((tmp4.count - count(b.*))::double precision/tmp4.count)) ) AS "p_h_conditional"
		FROM
			tmp4,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <40 AND b."age">=30
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp4."range", tmp4.count, tmp4.p,tmp4.numrec, tmp4."p_log_p"
	), tmp5 AS (
		SELECT
			'40-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=40 AND age<50) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "50-ers" AS (
		SELECT
			tmp5.*,
			count(b.*)::double precision/tmp5.count AS "p_>50k",
			1-count(b.*)::double precision/tmp5.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp5.count * log(count(b.*)::double precision/tmp5.count) + ((tmp5.count-count(b.*)::double precision)/tmp5.count * log((tmp5.count - count(b.*))::double precision/tmp5.count)) ) AS "h_conditional",
			tmp5.p*-(count(b.*)::double precision/tmp5.count * log(count(b.*)::double precision/tmp5.count) + ((tmp5.count-count(b.*)::double precision)/tmp5.count * log((tmp5.count - count(b.*))::double precision/tmp5.count)) ) AS "p_h_conditional"
		FROM
			tmp5,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <50 AND b."age">=40
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp5."range", tmp5.count, tmp5.p,tmp5.numrec, tmp5."p_log_p"
	), tmp6 AS (
		SELECT
			'50-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=50 AND age<60) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "60-ers" AS (
		SELECT
			tmp6.*,
			count(b.*)::double precision/tmp6.count AS "p_>50k",
			1-count(b.*)::double precision/tmp6.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp6.count * log(count(b.*)::double precision/tmp6.count) + ((tmp6.count-count(b.*)::double precision)/tmp6.count * log((tmp6.count - count(b.*))::double precision/tmp6.count)) ) AS "h_conditional",
			tmp6.p*-(count(b.*)::double precision/tmp6.count * log(count(b.*)::double precision/tmp6.count) + ((tmp6.count-count(b.*)::double precision)/tmp6.count * log((tmp6.count - count(b.*))::double precision/tmp6.count)) ) AS "p_h_conditional"
		FROM
			tmp6,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <60 AND b."age">=50
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp6."range", tmp6.count, tmp6.p,tmp6.numrec, tmp6."p_log_p"
	), tmp7 AS (
		SELECT
			'60-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=60 AND age<70) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "70-ers" AS (
		SELECT
			tmp7.*,
			count(b.*)::double precision/tmp7.count AS "p_>50k",
			1-count(b.*)::double precision/tmp7.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp7.count * log(count(b.*)::double precision/tmp7.count) + ((tmp7.count-count(b.*)::double precision)/tmp7.count * log((tmp7.count - count(b.*))::double precision/tmp7.count)) ) AS "h_conditional",
			tmp7.p*-(count(b.*)::double precision/tmp7.count * log(count(b.*)::double precision/tmp7.count) + ((tmp7.count-count(b.*)::double precision)/tmp7.count * log((tmp7.count - count(b.*))::double precision/tmp7.count)) ) AS "p_h_conditional"
		FROM
			tmp7,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <70 AND b."age">=60
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp7."range", tmp7.count, tmp7.p,tmp7.numrec, tmp7."p_log_p"
	), tmp8 AS (
		SELECT
			'70-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
			FROM
				(SELECT COUNT(*) AS count FROM adults WHERE age>=70 AND age<80) as a,
				(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "80-ers" AS (
		SELECT
			tmp8.*,
			count(b.*)::double precision/tmp8.count AS "p_>50k",
			1-count(b.*)::double precision/tmp8.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp8.count * log(count(b.*)::double precision/tmp8.count) + ((tmp8.count-count(b.*)::double precision)/tmp8.count * log((tmp8.count - count(b.*))::double precision/tmp8.count)) ) AS "h_conditional",
			tmp8.p*-(count(b.*)::double precision/tmp8.count * log(count(b.*)::double precision/tmp8.count) + ((tmp8.count-count(b.*)::double precision)/tmp8.count * log((tmp8.count - count(b.*))::double precision/tmp8.count)) ) AS "p_h_conditional"
		FROM
			tmp8,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age" <80 AND b."age">=70
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp8."range", tmp8.count, tmp8.p,tmp8.numrec, tmp8."p_log_p"
	), tmp9 AS (
		SELECT
			'90-ers'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE age>=90 AND age<100) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "90-ers" AS (
		SELECT
			tmp9.*,
			count(b.*)::double precision/tmp9.count AS "p_>50k",
			1-count(b.*)::double precision/tmp9.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp9.count * log(count(b.*)::double precision/tmp9.count) + ((tmp9.count-count(b.*)::double precision)/tmp9.count * log((tmp9.count - count(b.*))::double precision/tmp9.count)) ) AS "h_conditional",
			tmp9.p*-(count(b.*)::double precision/tmp9.count * log(count(b.*)::double precision/tmp9.count) + ((tmp9.count-count(b.*)::double precision)/tmp9.count * log((tmp9.count - count(b.*))::double precision/tmp9.count)) ) AS "p_h_conditional"
		FROM
			tmp9,
			(SELECT income,"age" FROM adults) AS b
		WHERE
			b."age">=80
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp9."range", tmp9.count, tmp9.p,tmp9.numrec, tmp9."p_log_p"
	)
	SELECT * FROM "10-ers"
	UNION ALL
	SELECT * FROM "20-ers"
	UNION ALL
	SELECT * FROM "30-ers"
	UNION ALL
	SELECT * FROM "40-ers"
	UNION ALL
	SELECT * FROM "50-ers"
	UNION ALL
	SELECT * FROM "60-ers"
	UNION ALL
	SELECT * FROM "70-ers"
	UNION ALL
	SELECT * FROM "80-ers"
	UNION ALL
	SELECT * FROM "90-ers"
);

DROP VIEW IF EXISTS "overview_hours-per-week" CASCADE;
CREATE VIEW "overview_hours-per-week" AS (
	WITH tmp1 AS (
		SELECT
			'0-10'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week"<10) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "0-10" AS (
		SELECT
			tmp1.*,
			count(b.*)::double precision/tmp1.count AS "p_>50k",
			1-count(b.*)::double precision/tmp1.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp1.count * log(count(b.*)::double precision/tmp1.count) + ((tmp1.count-count(b.*)::double precision)/tmp1.count * log((tmp1.count - count(b.*))::double precision/tmp1.count)) ) AS "h_conditional",
			tmp1.p*-(count(b.*)::double precision/tmp1.count * log(count(b.*)::double precision/tmp1.count) + ((tmp1.count-count(b.*)::double precision)/tmp1.count * log((tmp1.count - count(b.*))::double precision/tmp1.count)) ) AS "p_h_conditional"
		FROM
			tmp1,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=0 AND b."hours-per-week"<10
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp1."range", tmp1.count, tmp1.p,tmp1.numrec, tmp1."p_log_p"
	), tmp2 AS (
		SELECT
			'10-20'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=10 AND "hours-per-week"<20) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "10-20" AS (
		SELECT
			tmp2.*,
			count(b.*)::double precision/tmp2.count AS "p_>50k",
			1-count(b.*)::double precision/tmp2.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp2.count * log(count(b.*)::double precision/tmp2.count) + ((tmp2.count-count(b.*)::double precision)/tmp2.count * log((tmp2.count - count(b.*))::double precision/tmp2.count)) ) AS "h_conditional",
			tmp2.p*-(count(b.*)::double precision/tmp2.count * log(count(b.*)::double precision/tmp2.count) + ((tmp2.count-count(b.*)::double precision)/tmp2.count * log((tmp2.count - count(b.*))::double precision/tmp2.count)) ) AS "p_h_conditional"
		FROM
			tmp2,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=10 AND b."hours-per-week"<20
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp2."range", tmp2.count, tmp2.p,tmp2.numrec, tmp2."p_log_p"
	), tmp3 AS (
		SELECT
			'20-30'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=20 AND "hours-per-week"<30) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "20-30" AS (
		SELECT
			tmp3.*,
			count(b.*)::double precision/tmp3.count AS "p_>50k",
			1-count(b.*)::double precision/tmp3.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp3.count * log(count(b.*)::double precision/tmp3.count) + ((tmp3.count-count(b.*)::double precision)/tmp3.count * log((tmp3.count - count(b.*))::double precision/tmp3.count)) ) AS "h_conditional",
			tmp3.p*-(count(b.*)::double precision/tmp3.count * log(count(b.*)::double precision/tmp3.count) + ((tmp3.count-count(b.*)::double precision)/tmp3.count * log((tmp3.count - count(b.*))::double precision/tmp3.count)) ) AS "p_h_conditional"
		FROM
			tmp3,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=20 AND b."hours-per-week"<30
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp3."range", tmp3.count, tmp3.p,tmp3.numrec, tmp3."p_log_p"
	), tmp4 AS (
		SELECT
			'30-40'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=30 AND "hours-per-week"<40) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "30-40" AS (
		SELECT
			tmp4.*,
			count(b.*)::double precision/tmp4.count AS "p_>50k",
			1-count(b.*)::double precision/tmp4.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp4.count * log(count(b.*)::double precision/tmp4.count) + ((tmp4.count-count(b.*)::double precision)/tmp4.count * log((tmp4.count - count(b.*))::double precision/tmp4.count)) ) AS "h_conditional",
			tmp4.p*-(count(b.*)::double precision/tmp4.count * log(count(b.*)::double precision/tmp4.count) + ((tmp4.count-count(b.*)::double precision)/tmp4.count * log((tmp4.count - count(b.*))::double precision/tmp4.count)) ) AS "p_h_conditional"
		FROM
			tmp4,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=30 AND b."hours-per-week"<40
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp4."range", tmp4.count, tmp4.p,tmp4.numrec, tmp4."p_log_p"
	), tmp5 AS (
		SELECT
			'40-50'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=40 AND "hours-per-week"<50) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "40-50" AS (
		SELECT
			tmp5.*,
			count(b.*)::double precision/tmp5.count AS "p_>50k",
			1-count(b.*)::double precision/tmp5.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp5.count * log(count(b.*)::double precision/tmp5.count) + ((tmp5.count-count(b.*)::double precision)/tmp5.count * log((tmp5.count - count(b.*))::double precision/tmp5.count)) ) AS "h_conditional",
			tmp5.p*-(count(b.*)::double precision/tmp5.count * log(count(b.*)::double precision/tmp5.count) + ((tmp5.count-count(b.*)::double precision)/tmp5.count * log((tmp5.count - count(b.*))::double precision/tmp5.count)) ) AS "p_h_conditional"
		FROM
			tmp5,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=40 AND b."hours-per-week"<50
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp5."range", tmp5.count, tmp5.p,tmp5.numrec, tmp5."p_log_p"
	), tmp6 AS (
		SELECT
			'50-60'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=50 AND "hours-per-week"<60) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "50-60" AS (
		SELECT
			tmp6.*,
			count(b.*)::double precision/tmp6.count AS "p_>50k",
			1-count(b.*)::double precision/tmp6.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp6.count * log(count(b.*)::double precision/tmp6.count) + ((tmp6.count-count(b.*)::double precision)/tmp6.count * log((tmp6.count - count(b.*))::double precision/tmp6.count)) ) AS "h_conditional",
			tmp6.p*-(count(b.*)::double precision/tmp6.count * log(count(b.*)::double precision/tmp6.count) + ((tmp6.count-count(b.*)::double precision)/tmp6.count * log((tmp6.count - count(b.*))::double precision/tmp6.count)) ) AS "p_h_conditional"
		FROM
			tmp6,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=50 AND b."hours-per-week"<60
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp6."range", tmp6.count, tmp6.p,tmp6.numrec, tmp6."p_log_p"
	), tmp7 AS (
		SELECT
			'60-70'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=60 AND "hours-per-week"<70) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "60-70" AS (
		SELECT
			tmp7.*,
			count(b.*)::double precision/tmp7.count AS "p_>50k",
			1-count(b.*)::double precision/tmp7.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp7.count * log(count(b.*)::double precision/tmp7.count) + ((tmp7.count-count(b.*)::double precision)/tmp7.count * log((tmp7.count - count(b.*))::double precision/tmp7.count)) ) AS "h_conditional",
			tmp7.p*-(count(b.*)::double precision/tmp7.count * log(count(b.*)::double precision/tmp7.count) + ((tmp7.count-count(b.*)::double precision)/tmp7.count * log((tmp7.count - count(b.*))::double precision/tmp7.count)) ) AS "p_h_conditional"
		FROM
			tmp7,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=60 AND b."hours-per-week"<70
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp7."range", tmp7.count, tmp7.p,tmp7.numrec, tmp7."p_log_p"
	), tmp8 AS (
		SELECT
			'70-80'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=70 AND "hours-per-week"<80) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "70-80" AS (
		SELECT
			tmp8.*,
			count(b.*)::double precision/tmp8.count AS "p_>50k",
			1-count(b.*)::double precision/tmp8.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp8.count * log(count(b.*)::double precision/tmp8.count) + ((tmp8.count-count(b.*)::double precision)/tmp8.count * log((tmp8.count - count(b.*))::double precision/tmp8.count)) ) AS "h_conditional",
			tmp8.p*-(count(b.*)::double precision/tmp8.count * log(count(b.*)::double precision/tmp8.count) + ((tmp8.count-count(b.*)::double precision)/tmp8.count * log((tmp8.count - count(b.*))::double precision/tmp8.count)) ) AS "p_h_conditional"
		FROM
			tmp8,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=70 AND b."hours-per-week"<80
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp8."range", tmp8.count, tmp8.p,tmp8.numrec, tmp8."p_log_p"
	), tmp9 AS (
		SELECT
			'80+'::varchar(16) AS range,
			a.count AS "count",
			b.numrec,a.count::double precision/b.numrec AS p,
			CASE WHEN a.count=0 THEN 1E-10 ELSE a.count::double precision/b.numrec * log(a.count::double precision/b.numrec) END AS p_log_p
		FROM
			(SELECT COUNT(*) AS count FROM adults WHERE "hours-per-week">=80) as a,
			(SELECT COUNT(*) AS numrec FROM adults) AS b
	), "80+" AS (
		SELECT
			tmp9.*,
			count(b.*)::double precision/tmp9.count AS "p_>50k",
			1-count(b.*)::double precision/tmp9.count AS "p_<=50k",
			-(count(b.*)::double precision/tmp9.count * log(count(b.*)::double precision/tmp9.count) + ((tmp9.count-count(b.*)::double precision)/tmp9.count * log((tmp9.count - count(b.*))::double precision/tmp9.count)) ) AS "h_conditional",
			tmp9.p*-(count(b.*)::double precision/tmp9.count * log(count(b.*)::double precision/tmp9.count) + ((tmp9.count-count(b.*)::double precision)/tmp9.count * log((tmp9.count - count(b.*))::double precision/tmp9.count)) ) AS "p_h_conditional"
		FROM
			tmp9,
			(SELECT income,"hours-per-week" FROM adults) AS b
		WHERE
			b."hours-per-week">=80
		AND
			b.income LIKE '%>%'
		GROUP BY
			tmp9."range", tmp9.count, tmp9.p,tmp9.numrec, tmp9."p_log_p"
	)
	SELECT * FROM "0-10"
	UNION ALL
	SELECT * FROM "10-20"
	UNION ALL
	SELECT * FROM "20-30"
	UNION ALL
	SELECT * FROM "30-40"
	UNION ALL
	SELECT * FROM "40-50"
	UNION ALL
	SELECT * FROM "50-60"
	UNION ALL
	SELECT * FROM "60-70"
	UNION ALL
	SELECT * FROM "70-80"
	UNION ALL
	SELECT * FROM "80+"
);

--We could also do the other columns, but I don't really know what they are meaning
