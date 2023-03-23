-- Show unique birth years from patients and order them by ascending.

select distinct(year(birth_date)) from patients order by birth_date asc


-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then dont 
-- include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

select first_name from patients group by first_name 
having count(first_name) = 1


-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

select patient_id, first_name from patients where first_name like "s%s" and len(first_name) >=6


-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.

Select patients.patient_id, first_name, last_name from patients join admissions 
on patients.patient_id = admissions.patient_id where admissions.diagnosis = "Dementia"


-- Display every patients first_name.
-- Order the list by the length of each name and then by alphbetically

select first_name from patients order by len(first_name), first_name


-- Show first and last name, allergies from patients which have allergies to either
-- 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

select first_name, last_name, allergies from patients 
where allergies = "Penicillin" or allergies = "Morphine" 
order by allergies, first_name, last_name


-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

select city, count(patient_id) as total_patient from patients group by city 
order by total_patient desc, city asc


-- Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' as role FROM patients
    union all
select first_name, last_name, 'Doctor' from doctors;



-- Show all allergies ordered by popularity. Remove NULL values from query.

select allergies, count(allergies) as total_diagnosis from patients group by allergies having 
allergies not null
order by total_diagnosis desc


--  Display patient's full name,
--  height in the units feet rounded to 1 decimal,
--  weight in the unit pounds rounded to 0 decimals,
--  birth_date,
--  gender non abbreviated.

--  Convert CM to feet by dividing by 30.48.
--  Convert KG to pounds by multiplying by 2.205.

select
    concat(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) as 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  ELSE 'FEMALE' 
END AS 'gender_type'      -- putting the END is must
from patients


-- Show patient_id, weight, height, isObese from the patients table.

-- Display isObese as a boolean 0 or 1.

-- Obese is defined as weight(kg)/(height(m)2) >= 30.

-- weight is in units kg.

-- height is in units cm.

SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;


-- Show patient_id, first_name, last_name, and attending doctor's specialty.
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

-- Check patients, admissions, and doctors tables for required information.

select patients.patient_id, patients.first_name, patients.last_name, doctors.specialty
from patients
join
	admissions on patients.patient_id = admissions.patient_id
join
	doctors on admissions.attending_doctor_id = doctors.doctor_id
where
	admissions.diagnosis = 'Epilepsy' and doctors.first_name = 'Lisa'
  
  
 





















