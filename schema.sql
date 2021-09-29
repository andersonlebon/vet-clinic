 
/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    species VARCHAR(50),
    PRIMARY KEY(ID)
);
