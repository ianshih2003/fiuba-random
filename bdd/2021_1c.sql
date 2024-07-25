-- Mostrar para cada Departamento su temperatura media, en el invierno del anio 2020

-- Create the 'estaciones' table
CREATE TABLE estaciones (
    cod_estacion INT PRIMARY KEY,
    latitud DECIMAL(9, 6),
    longitud DECIMAL(9, 6),
    nombre_dpto VARCHAR(255)
);

-- Insert data into the 'estaciones' table
INSERT INTO estaciones (cod_estacion, latitud, longitud, nombre_dpto)
VALUES (794, -32.318, -64.129, 'RIO CUARTO');

-- Create the 'equipamientos' table
CREATE TABLE equipamientos (
    cod_estacion INT,
    variable VARCHAR(255),
    nombre_equipo VARCHAR(255),
    nro_serie_equipo VARCHAR(255),
    PRIMARY KEY (cod_estacion, variable)
);

-- Insert data into the 'equipamientos' table
INSERT INTO equipamientos (cod_estacion, variable, nombre_equipo, nro_serie_equipo)
VALUES (794, 'PRESION ATMOSFERICA', 'ESTACION DAZA DZ-WH2900', 'CN2832XAJM');

-- Create the 'mediciones' table
CREATE TABLE mediciones (
    uuid UUID PRIMARY KEY,
    cod_estacion INT,
    variable VARCHAR(255),
    fecha DATE,
    hora TIME,
    valor DECIMAL(5, 1)
);

-- Insert data into the 'mediciones' table
INSERT INTO mediciones (uuid, cod_estacion, variable, fecha, hora, valor)
VALUES ('ab035598-e31c-a00d-0158-a0bd75951000', 794, 'TEMPERATURA', '2021-01-15', '13:00:00', 37.1);

-- Create the 'departamentos' table
CREATE TABLE departamentos (
    nombre_dpto VARCHAR(255) PRIMARY KEY,
    poblacion INT,
    superficie INT
);

-- Insert data into the 'departamentos' table
INSERT INTO departamentos (nombre_dpto, poblacion, superficie)
VALUES ('RIO CUARTO', 246393, 18394);

INSERT INTO estaciones (cod_estacion, latitud, longitud, nombre_dpto)
VALUES
    (795, -32.500, -64.200, 'CORDOBA'),
    (796, -32.600, -64.300, 'SAN FRANCISCO');
   
   INSERT INTO departamentos (nombre_dpto, poblacion, superficie)
VALUES 
		('CORDOBA', 246393, 18394),
		('SAN FRANCISCO', 246393, 18394);

INSERT INTO mediciones (uuid, cod_estacion, variable, fecha, hora, valor)
VALUES
--    ('ab035598-e31c-a00d-0158-a0bd75951001', 794, 'TEMPERATURA', '2020-06-16', '14:00:00', 35.5),
--    ('ab035598-e31c-a00d-0158-a0bd75951002', 794, 'TEMPERATURA', '2020-06-16', '14:00:00', 60.2),
    ('ab035598-e31c-a00d-0158-a0bd75951003', 795, 'TEMPERATURA', '2020-06-16', '14:00:00', 60.2),
    ('ab035598-e31c-a00d-0158-a0bd75951004', 795, 'TEMPERATURA', '2020-06-16', '14:00:00', 60.2),
    ('ab035598-e31c-a00d-0158-a0bd75951005', 796, 'TEMPERATURA', '2021-06-16', '14:00:00', 60.2);


SELECT nombre_dpto, AVG(valor) FROM departamentos 
JOIN estaciones USING(nombre_dpto) 
JOIN mediciones USING (cod_estacion) 
where mediciones.fecha <= '2020-09-21' and mediciones.fecha >= '2020-06-01' GROUP BY nombre_dpto;


-- 

select split_part(nietos.nombre_apellido, ' ', 1) as nombre, split_part(nietos.nombre_apellido, ' ', 2) as apellido, nietos.f_nac fecha_nacimiento from personas nietos 
inner join progenitores padres on padres.td_hijo = nietos.td and padres.nd_hijo = nietos.nd 
inner join progenitores abuelos on abuelos.td_hijo = padres.td and abuelos.nd_hijo = padres.nd 
join personas p on abuelos.td = p.td and abuelos.nd = p.nd
where p.nombre_apellido = 'Juan Pérez';