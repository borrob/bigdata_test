DROP VIEW IF EXISTS "entropy" CASCADE;
CREATE VIEW "entropy" AS (
	WITH entrop AS (
		SELECT
			'age'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_age"
		UNION ALL
		SELECT
			'workclass'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_workclass"
		UNION ALL
		SELECT
			'education'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_education"
		UNION ALL
		SELECT
			'education-num'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_education_num"
		UNION ALL
		SELECT
			'marital-status'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_marital_status"
		UNION ALL
		SELECT
			'occupation'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_occupation"
		UNION ALL
		SELECT
			'relationship'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_relationship"
		UNION ALL
		SELECT
			'race'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_race"
		UNION ALL
		SELECT
			'sex'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_sex"
		UNION ALL
		SELECT
			'hours-per-week'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_hours_per_week"
		UNION ALL
		SELECT
			'native-country'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_native-country"
		UNION ALL
		SELECT
			'income'::varchar(16) AS variable,
			-SUM("p_log_p") AS h
		FROM
			"overview_income"
	)
	SELECT
		*
	FROM
		entrop
	ORDER BY
		h ASC
);
