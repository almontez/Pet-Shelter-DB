-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the Pet Shelter database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- -----------------------------------------------------
-- PetStatuses
-- -----------------------------------------------------
-- get all pet_status_id's and statuses to populate the adoption_status dropdown for the:
--  List PetStatuses page
SELECT ps.pet_status_id, ps.code, ps.status FROM PetStatuses as ps;

-- Add a new pet status
INSERT INTO PetStatuses (code, status) VALUES (:code_input, :status_input)

-- -----------------------------------------------------
-- AdoptionFeeCodes
-- -----------------------------------------------------
-- Get all adoption_fee_id's, codes, and fees to populate the adoption_fee dropdown for the:
--  Pets Add and Edit pages
--  List AdoptionFeeCodes page
SELECT afc.adoption_fee_id, afc.code, afc.fee FROM AdoptionFeeCodes as afc;

-- Add a new adoption fee code
INSERT INTO AdoptionFeeCodes (code, fee) VALUES (:code_input, :fee_input)

-- -----------------------------------------------------
-- Pets
-- -----------------------------------------------------
-- Get all pet staus IDs and status names to populate the adoption_status dropdown for the
--  Add Pet page and Edit Pet page
SELECT ps.pet_status_id, ps.status FROM PetStatuses as ps;

-- Get all pets, their adoption status, and  their adoption fee for the List Pets page
SELECT pet_id, species, name, breed, age, gender, weight, coat_color, ps.status as adoption_status, afc.fee as adoption_fee
FROM Pets as pets
INNER JOIN PetStatuses as ps on pets.adoption_status = ps.pet_status_id
INNER JOIN AdoptionFeeCodes as afc on pets.adoption_fee_type = afc.adoption_fee_id;
-- For Searching/filtering for a pet, we add a WHERE clause:
WHERE breed = :breed_from_text_input

-- Add a new pet
INSERT INTO Pets (species, name, breed, age, gender, weight, coat_color, adoption_status, adoption_fee_type)
VALUES (:species_from_dropdown_input, :name_input, :breed_input, :age_input, :gender_from_dropdown_input, :weight_input, :coat_color_input, :adoption_status_from_dropdown_input, :adoption_fee_type_from_dropdown_input)

-- Update a pet's data based on submission of the Update Pet form 
UPDATE Pets
SET species = :species_from_dropdown_input, name = :name_input, breed = :breed_input, age = :age_input, gender = :gender_from_dropdown_input, weight = :weight_input, coat_color = :coat_color_input, adoption_status = :pet_status_id_from_dropdown_input, adoption_fee_type = :adoption_fee_id_from_dropdown_input
WHERE id= :pet_ID_from_the_update_form

-- Delete a Pet
DELETE FROM Pets WHERE pet_id = :pet_id_selected_from_browse_pets_page

-- -----------------------------------------------------
-- PersonnelTypeCodes
-- -----------------------------------------------------
-- Get all personnel type codes for the: 
--  List PersonnelTypeCodes
--  and populate the perstonnel_type_codes dropdown for the Add Personnel page
SELECT pts.personnel_type_id, pts.code, pts.personnel_type FROM PersonnelTypeCodes as pts;

-- -----------------------------------------------------
-- Personnel
-- -----------------------------------------------------
-- Get all personnel and their personnel type for the List Personnel page
SELECT p.personnel_id, p.first_name, p.last_name, p.job_title, pts.personnel_type, p.address, p.phone_number, p.email, p.birth_date 
FROM Personnel as p
INNER JOIN PersonnelTypeCodes as pts ON p.personnel_type = pts.personnel_type_id;

-- Add a new personnel
INSERT INTO Personnel (personnel_type, job_title, first_name, last_name, address, phone_number, email, birth_date)
VALUES (:personnel_type_input_from_dropdown_input, :job_title_input, :first_name_input, :last_name_input, :address_input, :phone_number_input, :email_input, :birth_date_input)

-- -----------------------------------------------------
-- Intakes
-- -----------------------------------------------------
-- Get all intakes, its pet name, and its processor name
SELECT i.intake_id, pets.name as pet_name, CONCAT(p.first_name, ' ', p.last_name) as processor, i.intake_date, i.drop_off_type, i.intake_details
FROM Intakes as i
join Pets as pets on i.pet_id=pets.pet_id
join Personnel as p on i.processor=p.personnel_id;

-- Add a new intake
INSERT INTO Intakes (pet_id, intake_date, processor, drop_off_type, intake_details)
VALUES (:pet_id_from_dropdown_input, :intake_date_input, :personnel_id_from_dropdown_input, drop_off_type_input, intake_details_input)

-- -----------------------------------------------------
-- Adopters
-- -----------------------------------------------------
-- Get all adopters
SELECT a.adopter_id, a.first_name, a.last_name, a.address, a.phone_number, a.email, a.birth_date
FROM Adopters as a;

-- Add a new adopter
INSERT INTO Adopters (first_name, last_name, address, phone_number, email, birth_date)
VALUES (:first_name_input, :last_name_input, :address_input, :phone_number_input, :email_input, :birth_date_input)

-- Delete an Adopter
DELETE FROM Adopters WHERE adopter_id = :adopter_id_selected_from_browse_adopters_page

-- -----------------------------------------------------
-- AdoptionRequestStatusCodes
-- -----------------------------------------------------
-- Get all AdoptionRequestStatusCodes
SELECT ap.adopter_pet_id, ar.adoption_request_id, CONCAT(a.first_name, ' ',  a.last_name) as adopter_name, pets.name as pet_name, CONCAT(p.first_name, ' ', p.last_name) as processor, ar.request_date, ar.amount_paid, arsc.status as request_status
FROM AdoptionRequests as ar
INNER JOIN AdoptionRequestStatusCodes as arsc on ar.application_status = arsc.adoption_request_status_id
INNER JOIN Adopters_Pets as ap on ar.adopter_pet_id = ap.adopter_pet_id
INNER JOIN Adopters as a on ap.adopter_id = a.adopter_id
INNER JOIN Pets as pets on ap.pet_id = pets.pet_id
INNER JOIN Personnel as p on ar.processor = p.personnel_id;

-- Probably won't need this anymore since we are combine the display of Adopters_Pets with AdoptionRequests
-- SELECT arpc.adoption_request_status_id, arpc.code, arpc.status
-- FROM AdoptionRequestStatusCodes as arpc;

-- Add a new adoption request status code
INSERT INTO AdoptionRequestStatusCodes (code, status)
VALUES (:code_input, :status_input)

-- Delete an AdoptionRequestStatusCode
DELETE FROM AdoptionRequestStatusCodes WHERE adoption_request_status_id = :adoption_request_status_id_selected_from_browse_adopters_page

-- -----------------------------------------------------
-- Adopters_Pets and AdoptionRequests
-- -----------------------------------------------------
-- Get all Adopters_Pets and AdoptionRequests
SELECT ap.adopter_pet_id, ar.adoption_request_id, ap.adopter_id, CONCAT(a.first_name, ' ', a.last_name) as adopter_name, ap.pet_id, pets.name as pet_name, CONCAT(p.first_name, ' ', p.last_name) as processor, ar.request_date, ar.amount_paid, arsc.status as application_status
FROM AdoptionRequests as ar
INNER JOIN AdoptionRequestStatusCodes as arsc on ar.application_status = arsc.adoption_request_status_id
INNER JOIN Adopters_Pets as ap on ar.adopter_pet_id = ap.adopter_pet_id
INNER JOIN Adopters as a on ap.adopter_id = a.adopter_id
INNER JOIN Pets as pets on ap.pet_id = pets.pet_id
INNER JOIN Personnel as p on ar.processor = p.personnel_id;

-- Add an Adopters_Pets relationship...
-- 	Associates an adopter with a pet (M-to-M relationship addition)
INSERT INTO Adopters_Pets (adopter_id, pet_id)
VALUES (:adopter_id_from_dropdown_input, :pet_id_from_dropdown_input);
-- ...and its associated AdoptionRequests data
INSERT INTO AdoptionRequests (adopter_pet_id, processor, request_date, application_status, amount_paid)
VALUES (:adopter_pet_id_from_dropdown_input, :personnel_id_from_dropdown_input, :request_date_input, :application_status_from_dropdown_input, :amount_paid_input)

-- Update an Adopters_Pets relationship based on the submission on the Edit AdoptionRequest page...
UPDATE Adopters_Pets
SET adopter_id = :adopter_id_from_dropdown_input, pet_id = :pet_id_from_dropdown_input
WHERE adopter_pet_id= :adopter_pet_id_from_the_update_form
-- ...and Update an AdoptionRequest based on the submission on the Edit AdoptionRequest page
UPDATE AdoptionRequests
SET processor = :personnel_id_from_dropdown_input, request_date= :request_date_input, application_status = :adoption_request_status_id_from_dropdown_input, amount_paid= :amount_paid_input
WHERE adoption_request_id= :adoption_request_id_from_the_update_form

-- Dis-associate an adopter from a pet (M-to-M relationship deletion)
DELETE FROM Adopters_Pets WHERE adopter_pet_id = :adopter_pet_id_selected_from_AdoptionRequests_list
-- Probably won't need this delete query since deleting adopter_pet_id in Adopter_Pets should automatically delete the associated adoption_request_id in AdoptionRequests because of ON CASCADE DELETE
-- DELETE FROM AdoptersRequests WHERE adopter_request_id = :adoption_request_id_selected_from_AdoptionRequests_list
