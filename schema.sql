 
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

ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Remove the spacies column in the animals table
ALTER TABLE animals DROP species;

ALTER TABLE animals ADD owner_id INT; 
ALTER TABLE animals ADD species_id INT;


-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id); 

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);



