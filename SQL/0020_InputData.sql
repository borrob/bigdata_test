-- change the data location
COPY adults(age,workclass,fnlwgt,education,"education-num","marital-status",occupation, relationship, race, sex, "capital-gain", "capital-loss","hours-per-week","native-country",income) FROM '/home/rob/dev/bigdata/adults/data/adult.data' DELIMITER ',' CSV;
