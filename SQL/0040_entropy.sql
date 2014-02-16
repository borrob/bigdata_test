DROP VIEW IF EXISTS "entropy-and-informationgain" CASCADE;
CREATE VIEW "entropy-and-informationgain" AS (
	--show the entropy and information gain per column
	WITH entrop AS (
		--in a subselect so we can do the ordering later
		SELECT
			'age'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_age"
		UNION ALL
		SELECT
			'workclass'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_workclass"
		UNION ALL
		SELECT
			'education'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_education"
		UNION ALL
		SELECT
			'education-num'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_education-num"
		UNION ALL
		SELECT
			'marital-status'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_marital-status"
		UNION ALL
		SELECT
			'occupation'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_occupation"
		UNION ALL
		SELECT
			'relationship'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_relationship"
		UNION ALL
		SELECT
			'race'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_race"
		UNION ALL
		SELECT
			'sex'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_sex"
		UNION ALL
		SELECT
			'hours-per-week'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_hours-per-week"
		UNION ALL
		SELECT
			'native-country'::varchar(16) AS variable,
			-SUM("p_log_p") AS h,
			0.239735458581386 - SUM ("p_h_conditional") AS "information_gain"
		FROM
			"overview_native-country"
	)
	SELECT
		*
	FROM
		entrop
	ORDER BY
		"information_gain" DESC
);
