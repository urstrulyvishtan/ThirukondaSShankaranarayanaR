DROP DATABASE IF EXISTS oncampus;
CREATE DATABASE oncampus;

USE oncampus;

CREATE TABLE employmentseekers(
primary_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
nuid INT AUTO_INCREMENT,
mobile_no INT NOT NULL,
email_id VARCHAR(50) NOT NULL,
program VARCHAR(20) NOT NULL,
course VARCHAR(20) NOT NULL,
user_name VARCHAR(50) NOT NULL,
pwd VARCHAR(100) NOT NULL,
CONSTRAINT employmentseekers_pk PRIMARY KEY (nuid)
);

CREATE TABLE address(
house_no INT NOT NULL,
street_no INT NOT NULL,
city VARCHAR(20) NOT NULL,
state VARCHAR(20) NOT NULL,
coutnry VARCHAR(20) NOT NULL,
pin INT NOT NULL,
is_permanent BOOLEAN DEFAULT TRUE NOT NULL,
nuid INT NOT NULL,
CONSTRAINT address_fk FOREIGN KEY (nuid) REFERENCES employmentseekers(nuid) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE college(
college_name VARCHAR(70) NOT NULL,
college_id INT AUTO_INCREMENT,
location VARCHAR(50) NOT NULL,
contact_no INT(10) NOT NULL,
contact_mail VARCHAR(50) NOT NULL,
CONSTRAINT college_pk PRIMARY KEY (college_id)
);

CREATE TABLE resumes(
education VARCHAR(100) NOT NULL,
work_experience VARCHAR(1000) NOT NULL,
projects VARCHAR(1000) NOT NULL,
resume_name VARCHAR(20),
nuid INT NOT NULL,
CONSTRAINT resumes_pk PRIMARY KEY (resume_name),
CONSTRAINT resumes_fk FOREIGN KEY (nuid) REFERENCES employmentseekers(nuid) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE employer(
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
employer_id INT AUTO_INCREMENT,
dept_id INT NOT NULL,
post VARCHAR(30) NOT NULL,
mail_id VARCHAR(50) NOT NULL,
college_id INT NOT NULL,
CONSTRAINT employer_pk PRIMARY KEY (employer_id,dept_id),
CONSTRAINT employer_fk FOREIGN KEY (college_id) REFERENCES college(college_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE hiring_team(
hr_manager_id INT NOT NULL,
recruiter_id INT NOT NULL,
team_id INT AUTO_INCREMENT,
portal_admin_id INT NOT NULL,
CONSTRAINT hiring_team_pk PRIMARY KEY (team_id),
CONSTRAINT hiring_team_fk1 FOREIGN KEY (hr_manager_id) REFERENCES employer(employer_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT hiring_team_fk2 FOREIGN KEY (recruiter_id) REFERENCES employer(employer_id) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT hiring_team_fk3 FOREIGN KEY (portal_admin_id) REFERENCES employer(employer_id)
);

CREATE TABLE level_desc(
job_level INT AUTO_INCREMENT,
lvl_desc VARCHAR(100) NOT NULL,
CONSTRAINT level_desc_PK PRIMARY KEY(job_level)
);


CREATE TABLE job_posting(
job_id INT AUTO_INCREMENT,
job_name VARCHAR(20) NOT NULL,
job_desc VARCHAR(100) NOT NULL,
job_level INT NOT NULL,
job_category VARCHAR(10) NOT NULL,
location VARCHAR(10) NOT NULL,
skills VARCHAR(20) NOT NULL,
mode_of_work enum("Graduate","Undergraduate") NOT NULL,
created_by INT NOT NULL,
salary INT NOT NULL,
lvl_of_work VARCHAR(10) NOT NULL,
working_hrs INT NOT NULL,
CONSTRAINT job_posting_pk PRIMARY KEY (job_id,job_level),
CONSTRAINT job_posting_fk1 FOREIGN KEY (job_level) REFERENCES level_desc(job_level) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT job_posting_fk2 FOREIGN KEY (created_by) REFERENCES hiring_team(team_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE application(
application_id INT AUTO_INCREMENT,
sex VARCHAR(1) NOT NULL,
race VARCHAR(10) NOT NULL,
consent BOOLEAN DEFAULT TRUE NOT NULL,
work_study_eligible BOOLEAN DEFAULT FALSE NOT NULL,
submitted_date DATETIME NOT NULL,
application_status ENUM('APPLIED','REJECTED') NOT NULL,
nuid INT NOT NULL,
job_applied_to INT NOT NULL,
CONSTRAINT application_pk PRIMARY KEY (application_id),
CONSTRAINT application_fk1 FOREIGN KEY (nuid) REFERENCES employmentseekers(nuid) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT application_fk2 FOREIGN KEY (job_applied_to) REFERENCES job_posting(job_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

#login validation
DELIMITER $$
CREATE PROCEDURE validate_login_credentials (
  IN p_username VARCHAR(255),
  IN p_password VARCHAR(255),
  OUT p_valid_login BOOLEAN
)
BEGIN
  DECLARE v_count INT DEFAULT 0;
  SELECT COUNT(*) INTO v_count FROM employmentseekers
  WHERE user_name = p_username AND pwd = p_password;
  
  IF v_count > 0 THEN
    SET p_valid_login = TRUE;
  ELSE
    SET p_valid_login = FALSE;
  END IF;
END$$
DELIMITER ;

# withdrawing application
DELIMITER $$
CREATE PROCEDURE delete_application (
  IN p_id INT
)
BEGIN
  DELETE FROM applications WHERE application_id = p_id;

END$$
DELIMITER ;

# Viewing users applications
DELIMITER $$
CREATE PROCEDURE view_applications(
	IN nuid INT
    )
BEGIN
	SELECT * FROM application WHERE application.nuid = employementseekers.nuid ;
END $$
DELIMITER ;

# Creating job applications from hiring team side.
DELIMITER $$
CREATE PROCEDURE create_job(
	IN p_job_id INT,
    IN p_job_name VARCHAR(20),
    IN p_job_desc VARCHAR(100),
    IN p_job_level INT,
    IN p_job_category VARCHAR(10),
    IN p_location VARCHAR(10),
    IN p_skills VARCHAR(20),
    IN p_mode_of_work enum("Graduate","Undergraduate"),
    IN p_created_by INT,
    IN p_salary INT,
    IN p_lvl_of_work VARCHAR(10),
    IN p_working_hrs INT
)
BEGIN
	INSERT INTO job_posting (job_id,job_name,job_desc,job_level,job_category,location,skills,mode_of_work,created_by,salary,lvl_of_work,working_hrs)
	VALUES (p_job_id,p_job_name,p_job_desc,p_job_level,p_job_category,p_location,p_skills,p_mode_of_work,p_created_by,p_salary,p_lvl_of_work,p_working_hrs);
END $$
DELIMITER ;

