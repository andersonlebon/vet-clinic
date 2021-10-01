/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;

SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

SELECT * FROM animals WHERE neutered=true;

SELECT * FROM animals WHERE NOT name='Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Begin a transaction to update the spacies column

 BEGIN TRANSACTION;
 UPDATE animals SET species = 'unspecified';

-- Rollback the transaction
 ROLLBACK TRANSACTION;


-- Begin another transaction

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Commit the transaction
COMMIT TRANSACTION;

-- Delete all recordes in the animals table and rollback the transaction
BEGIN TRANSACTION;
DELETE FROM animals;
-- Rollback the transaction
ROLLBACK TRANSACTION

-- Delete some recordes in the animals table and commit the transaction
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
-- Create a savepioint for the transaction
SAVEPOINT DELETE_DATE; 

UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO DELETE_DATE;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
-- Commit the transaction
COMMIT TRANSACTION;

-- Quering some data

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT neutered, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY neutered;
SELECT neutered, AVG(escape_attempts) FROM animals  date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY neutered;

-- Query multiple tables 

--  What animals belong to Melody Pond
SELECT animals.name, owners.full_name FROM animalsINNER JOIN owners ON owners.id = animals.owner_id
 AND owners.full_name = 'Melody Pond';

--  List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals INNER JOIN species ON species.id = animals.species_id
  AND species.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

--  How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals FULL OUTER JOIN species ON species.id = animals.species_id
  GROUP BY species.id;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name FROM animals INNER JOIN owners ON owners.id = animals.owner_id
  INNER JOIN species ON species.id = animals.species_id
  WHERE owners.full_name = 'Jennifer Orwell'
  AND species.name = 'Digimon';

--  List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON owners.id = animals.owner_id
  WHERE owners.full_name = 'Dean Winchester'
  AND animals.escape_attempts = 0;

--  Who owns the most animals?
SELECT owners.full_name, COUNT(animals.owner_id) FROM animals FULL OUTER JOIN owners ON animals.owner_id = owners.id
  GROUP BY owners.id; 

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit AS last_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'William Tatcher'
    GROUP BY animals.name, visits.date_of_visit
    ORDER BY last_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT visits.animals_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    WHERE vets.name = 'Stephanie Mendez';

--  List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets 
    LEFT JOIN specialization ON specialization.vets_id = vets.id
    LEFT JOIN species ON species.id = specialization.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'Stephanie Mendez'
    AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-04-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animals_id) AS visit_count FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    GROUP BY animals.name, visits.animals_id
    ORDER BY visit_count DESC LIMIT 1;

--  Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit AS first_visit FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY animals.name, visits.date_of_visit
    ORDER BY first_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit. 
SELECT * FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    ORDER BY visits.date_of_visit DESC LIMIT 1;

--  How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animals_id) FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    INNER JOIN specialization ON specialization.vets_id = vets.id
    WHERE specialization.species_id <> animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most 
SELECT species.name, COUNT(visits.animals_id) AS species_count FROM visits
    INNER JOIN vets ON vets.id = visits.vets_id
    INNER JOIN animals ON animals.id = visits.animals_id
    INNER JOIN species ON species.id = animals.species_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name
    ORDER BY species_count DESC LIMIT 1;