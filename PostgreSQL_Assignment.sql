-- create database
CREATE DATABASE conservation_db;

-- create tables
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region TEXT
);

CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id),
    species_id INTEGER REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location TEXT,
    notes TEXT
);

-- data insertion into tables
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        1,
        'Alice Green',
        'Northern Hills'
    ),
    (2, 'Bob White', 'River Delta'),
    (
        3,
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        species_id,
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        1,
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        2,
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        3,
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        4,
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        sighting_id,
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        4,
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- Problem 1
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        4,
        'Derek Fox',
        'Coastal Plains'
    );

-- Problem 2
SELECT * FROM species;
-- I'm confuse about this question. Join support session and clear confusion. but before join suport session, review the assignment video.

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass';

-- Problem 4
SELECT name, count(species_id) as total_sightings
FROM rangers
    JOIN sightings USING (ranger_id)
GROUP BY
    name;

-- Problem 5
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- Problem 6
SELECT common_name, sighting_time, name
FROM sightings
    JOIN species USING (species_id)
    JOIN rangers USING (ranger_id)
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        year
        from discovery_date
    ) < 1800;

-- Problem 8
-- SELECT sighting_id, extract(
--         hour
--         FROM sighting_time
--     ) as time_of_day
-- FROM sightings WHERE time_of_day

-- Problem 9
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT ranger_id
        FROM sightings
    );