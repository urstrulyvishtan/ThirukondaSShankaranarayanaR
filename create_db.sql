DROP DATABASE IF EXISTS oncampus;
CREATE DATABASE oncampus;

USE oncampus;

CREATE TABLE employmentseekers(
primary_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
nuid INT UNSIGNED AUTO_INCREMENT,
mobile_no VARCHAR(10) NOT NULL,
email_id VARCHAR(50) NOT NULL,
program VARCHAR(20) NOT NULL,
course VARCHAR(20) NOT NULL,
user_name VARCHAR(50) NOT NULL,
pwd VARCHAR(100) NOT NULL,
CONSTRAINT employmentseekers_pk PRIMARY KEY (nuid)
);


CREATE TABLE college(
college_name VARCHAR(70) NOT NULL,
college_id INT AUTO_INCREMENT,
location VARCHAR(50) NOT NULL,
contact_no VARCHAR(10) NOT NULL,
contact_mail VARCHAR(50) NOT NULL,
CONSTRAINT college_pk PRIMARY KEY (college_id)
);

CREATE TABLE employer(
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
employer_id INT AUTO_INCREMENT,
user_name VARCHAR(100) NOT NULL,
pwd VARCHAR(100) NOT NULL,
dept_id INT NOT NULL,
post VARCHAR(30) NOT NULL,
mail_id VARCHAR(50) NOT NULL,
college_id INT NOT NULL,
CONSTRAINT employer_pk PRIMARY KEY (employer_id,dept_id),
CONSTRAINT employer_fk FOREIGN KEY (college_id) REFERENCES college(college_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE job_posting(
job_id INT AUTO_INCREMENT,
job_name VARCHAR(20) NOT NULL,
job_desc VARCHAR(100) NOT NULL,
job_level INT NOT NULL,
job_level_desc VARCHAR(100) NOT NULL,
job_category enum("Undergraduate","Graduate") NOT NULL,
job_status enum('Open','Closed') NOT NULL,
location VARCHAR(10) NOT NULL,
skills VARCHAR(20) NOT NULL,
mode_of_work enum("Online","Offline") NOT NULL,
created_by INT NOT NULL,
salary INT NOT NULL,
contract_period INT NOT NULL,
working_hrs INT NOT NULL,
CONSTRAINT job_posting_pk PRIMARY KEY (job_id),
CONSTRAINT job_posting_fk1 FOREIGN KEY (created_by) REFERENCES employer(employer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE resumes(
job_id INT NOT NULL,
school VARCHAR(100) NOT NULL,
degree VARCHAR(100) NOT NULL,
gpa VARCHAR(100) NOT NULL,
company VARCHAR(100) NOT NULL,
role VARCHAR(100) NOT NULL,
months_of_exp INT NOT NULL,
role_description VARCHAR(1000),
project_title VARCHAR(100) NOT NULL,
project_description VARCHAR(1000),
resume_name VARCHAR(20),
nuid INT UNSIGNED NOT NULL,
CONSTRAINT resumes_pk PRIMARY KEY (resume_name),
CONSTRAINT resumes_jobID FOREIGN KEY (job_id) REFERENCES job_posting(job_id),
CONSTRAINT resumes_fk FOREIGN KEY (nuid) REFERENCES employmentseekers(nuid) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE application(
application_id INT AUTO_INCREMENT,
job_name VARCHAR(100) NOT NULL,
Job_description VARCHAR(100) NOT NULL,
nuid INT UNSIGNED NOT NULL,
job_applied_to INT NOT NULL,
CONSTRAINT application_pk PRIMARY KEY (application_id),
CONSTRAINT application_fk1 FOREIGN KEY (nuid) REFERENCES employmentseekers(nuid) ON UPDATE RESTRICT ON DELETE RESTRICT,
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

#login validation
DELIMITER $$
CREATE PROCEDURE validate_admin_login_credentials (
  IN p_username VARCHAR(255),
  IN p_password VARCHAR(255),
  OUT p_valid_login BOOLEAN
)
BEGIN
  DECLARE v_count INT DEFAULT 0;
  SELECT COUNT(*) INTO v_count FROM employer
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
  DELETE FROM application WHERE application_id = p_id;

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
    IN p_job_level_desc VARCHAR(100),
    IN p_job_category enum("Undergraduate","Graduate"),
    IN p_job_status enum("Open","Close"),
    IN p_location VARCHAR(10),
    IN p_skills VARCHAR(20),
    IN p_mode_of_work enum("Online","Offline"),
    IN p_created_by INT,
    IN p_salary INT,
    IN p_contract_period INT,
    IN p_working_hrs INT
)
BEGIN
	INSERT INTO job_posting (job_id,job_name,job_desc,job_level,job_level_desc,job_category,job_status,location,skills,mode_of_work,created_by,salary,contract_period,working_hrs)
	VALUES (p_job_id,p_job_name,p_job_desc,p_job_level,p_job_level_desc,p_job_category,p_job_status,p_location,p_skills,p_mode_of_work,p_created_by,p_salary,p_contract_period,p_working_hrs);
END $$
DELIMITER ;

## Create a procedure to update job_status value
DELIMITER $$
CREATE PROCEDURE update_job_status(
	IN job_id INT, 
    IN new_status VARCHAR(255)
)
BEGIN
	UPDATE job_posting 
    SET job_status = new_status
    where job_id = job_id;
END $$
DELIMITER ;

INSERT INTO college(college_name, college_id, location, contact_no, contact_mail)
VALUES ("Khoury College of Computer sciences",01,"Boston", "8573960001" ,"khoury@northeastern.edu"),
	   ("College of Engineering",02,"Boston", "8573960002" ,"coe@northeastern.edu"),
	   ("College of Sciences",03,"Boston", "8573960003" ,"cos@northeastern,edu");

INSERT INTO employer(first_name, last_name, employer_id, user_name, pwd, dept_id, post, mail_id, college_id)
VALUES ("John","Doe",1,"j_doe","123",21,"admin","john_doe@neu.com",01),
	   ("Bruce","Campell",34,"b_camp","456",24,"admin","brucie@neu.com",02),
       ("Tony","Wayne",999,"t_way","789",3,"admin","ynot@neu.com",03);
       
INSERT INTO employmentseekers(primary_name,last_name,nuid,mobile_no,email_id,program,course,user_name,pwd)
VALUES ("Jack","Eastwood",123456789,"9443455114","jackie@neu.edu","Masters","Computer Science","jackie","987"),
	   ("Presephone","Odin",987654321,"8072002116","podin@neu.edu","Bachelors","Bioengineering","presdin","5t6y"),
       ("Cassandra","Alex",456987213,"7465830275","cassie@neu.edu","Doctorate","Political Science","cassex","uio89");

