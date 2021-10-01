 
/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(ID)
);

ALTER TABLE animals ADD species VARCHAR(100);   

-- Create the owner's table

CREATE TABLE owners (
  id         INT GENERATED ALWAYS AS IDENTITY,
  full_name  VARCHAR(100),
  age        INT,
  PRIMARY KEY(id)
);

-- Create the spacies table 

CREATE TABLE species (
  id       INT GENERATED ALWAYS AS IDENTITY,
  name     VARCHAR(100),
  PRIMARY KEY(id)
);

-- Remove the spacies column in the animals table
ALTER TABLE animals DROP species;



-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id); 

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT; 
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

--  Create the vets table

CREATE TABLE vets (
  id                 INT GENERATED ALWAYS AS IDENTITY,
  name               VARCHAR(60),
  age                INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

-- Create the specialization table

CREATE TABLE specialization (
    species_id  INT,
    vet_id     INT,
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vets_id) REFERENCES vets (id),
    PRIMARY KEY (species_id, vets_id)
);

-- Create the visits table

CREATE TABLE visits (
    vet_id     INT,
    animal_id  INT,
    date_of_visit    DATE,
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    FOREIGN KEY(animal_id) REFERENCES animals(id)
);