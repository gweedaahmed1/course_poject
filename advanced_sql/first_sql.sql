-- make a new table
-- CREATE TABLE job_applied(
--     job_id INT,
--     application_sent_data DATE,
--     custom_resume BOOLEAN,
--     resume_file_name VARCHAR(255),
--     cover_letter_sent BOOLEAN,
--     cover_letter_file_name VARCHAR(255),
--     status VARCHAR(255)
    
-- );

INSERT INTO job_applied
    (job_id,
     application_sent_data,
     custom_resume,
     resume_file_name,
     cover_letter_sent,
     cover_letter_file_name,
     status 
    );
VALUES (101, '2026-01-15', TRUE, 'Resume_SoftwareEng_FAANG.pdf', TRUE, 'CoverLetter_FAANG.pdf', 'Interviewing'),
    (102, '2026-01-18', FALSE, 'General_Tech_Resume_2026.pdf', FALSE, NULL, 'Applied'),
    (103, '2026-02-02', TRUE, 'DataAnalyst_Finance_CV.pdf', TRUE, 'CoverLetter_FinanceCorp.pdf', 'Rejected'),
    (104, '2026-02-10', FALSE, 'General_Tech_Resume_2026.pdf', TRUE, 'Generic_CoverLetter.pdf', 'Applied'),
    (105, '2026-02-14', TRUE, 'ProductManager_V2.pdf', TRUE, 'PM_Startup_CoverLetter.pdf', 'Offer Received'),
    (106, '2026-03-01', TRUE, 'Resume_SoftwareEng_FAANG.pdf', FALSE, NULL, 'Screening'),
    (107, '2026-03-05', FALSE, 'General_Tech_Resume_2026.pdf', FALSE, NULL, 'Rejected'),
    (108, '2026-03-12', TRUE, 'Cybersecurity_Specialist_CV.pdf', TRUE, 'CoverLetter_SecurityRole.pdf', 'Applied'),
    (109, '2026-03-19', TRUE, 'DataAnalyst_Finance_CV.pdf', FALSE, NULL, 'Interviewing'),
    (110, '2026-03-25', FALSE, 'General_Tech_Resume_2026.pdf', TRUE, 'Generic_CoverLetter.pdf', 'Applied');

ALTER TABLE job_applied
    ADD contact VARCHAR(50);

UPDATE job_applied
SET contact = 'Liam Henderson'
WHERE job_id = 101;

UPDATE job_applied
SET contact = 'Sofia Rodriguez'
WHERE job_id = 102;

UPDATE job_applied 
SET contact = 'Alexander Vance'
WHERE job_id = 103;

UPDATE job_applied 
SET contact = 'Amara Patel'
WHERE job_id = 104;

UPDATE job_applied 
SET contact = 'Mateo Silva'
WHERE job_id = 105;

UPDATE job_applied 
SET contact = 'Chloe Beaumont'
WHERE job_id = 106;

UPDATE job_applied 
SET contact = 'Omar Mansoor'
WHERE job_id = 107;

UPDATE job_applied 
SET contact = 'Elena Rostova'
WHERE job_id = 108;

UPDATE job_applied 
SET contact = 'Julian Sterling'
WHERE job_id = 109;

UPDATE job_applied 
SET contact = 'Maya Lin'
WHERE job_id = 110;

ALTER TABLE job_applied
RENAME COLUMN contact_ TO contact_name

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;

SELECT *

FROM job_applied