/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%pus';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered=true AND escape_attempts<2;

SELECT date_of_birth FROM animals WHERE name='Saggapus' OR name='rex';

SELECT name, escape_attempts FROM animals WHERE weight_kg>8;

SELECT * FROM animals WHERE neutered=true;

SELECT * FROM animals WHERE NOT name='Milu';

SELECT * FROM animals WHERE weight_kg BETWEEN 10 AND 20;
