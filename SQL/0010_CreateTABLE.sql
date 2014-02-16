DROP TABLE IF EXISTS adults CASCADE;
DROP SEQUENCE IF EXISTS adults_id_seq CASCADE;

CREATE SEQUENCE adults_id_seq;
CREATE TABLE adults (
	"id"               integer PRIMARY KEY DEFAULT nextval('adults_id_seq'),
	"age"              integer,
	"workclass"        varchar(25),
	"fnlwgt"           integer,
	"education"        varchar(25),
	"education-num"    integer,
	"marital-status"   varchar(25),
	"occupation"       varchar(25),
	"relationship"     varchar(25),
	"race"             varchar(25),
	"sex"              varchar(25),
	"capital-gain"     integer,
	"capital-loss"     integer,
	"hours-per-week"   integer,
	"native-country"   varchar(64),
	"income"           varchar(6)
);

COMMENT ON TABLE adults IS 'data from UCI machine learning repository';

CREATE INDEX adults_age_idx ON adults("age");
CREATE INDEX adults_workclass_idx ON adults("workclass");
CREATE INDEX adults_fnlwgt_idx ON adults("fnlwgt");
CREATE INDEX adults_education_idx ON adults("education");
CREATE INDEX adults_education_num_idx ON adults("education-num");
CREATE INDEX adults_marital_status_idx ON adults("marital-status");
CREATE INDEX adults_occupation_idx ON adults("occupation");
CREATE INDEX adults_relationship_idx ON adults("relationship");
CREATE INDEX adults_race_idx ON adults("race");
CREATE INDEX adults_sex_idx ON adults("sex");
CREATE INDEX adults_capital_gain_idx ON adults("capital-gain");
CREATE INDEX adults_capital_loss_idx ON adults("capital-loss");
CREATE INDEX adults_hours_per_week_idx ON adults("hours-per-week");
CREATE INDEX adults_native_country_idx ON adults("native-country");
CREATE INDEX adults_income_idx ON adults("income");
