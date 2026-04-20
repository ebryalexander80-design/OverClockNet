
CREATE DATABASE SamilMorel_2025_0405;
GO

-- Seleccionar la base de datos
USE SamilMorel_2025_0405;


-- Crear el esquema con mi nombre
GO
CREATE SCHEMA samil;
GO

-- Crear tabla ciudades
CREATE TABLE samil.ciudades (
    codigo INT IDENTITY(1,1),
    nombre VARCHAR(100)       
);

-- Definir clave primaria en ciudades
ALTER TABLE samil.ciudades 
ALTER COLUMN codigo INT NOT NULL;

ALTER TABLE samil.ciudades 
ADD CONSTRAINT PK_ciudades PRIMARY KEY (codigo);

-- Crear tabla clientes
CREATE TABLE samil.clientes (
    codigo INT IDENTITY(1,1), 
    nombre VARCHAR(100),      
    domicilio VARCHAR(100),  
    codigociudad INT          
);

-- Definir clave primaria en clientes
ALTER TABLE samil.clientes 
ALTER COLUMN codigo INT NOT NULL;

ALTER TABLE samil.clientes 
ADD CONSTRAINT PK_clientes PRIMARY KEY (codigo);

-- Crear clave foránea para validar que la ciudad exista
ALTER TABLE samil.clientes
ADD CONSTRAINT FK_clientes_ciudades
FOREIGN KEY (codigociudad)
REFERENCES samil.ciudades(codigo);

-- Insertar registros en la tabla ciudades
INSERT INTO samil.ciudades (nombre) VALUES ('Cordoba');
INSERT INTO samil.ciudades (nombre) VALUES ('Cruz del Eje');
INSERT INTO samil.ciudades (nombre) VALUES ('Carlos Paz');
INSERT INTO samil.ciudades (nombre) VALUES ('La Falda');
INSERT INTO samil.ciudades (nombre) VALUES ('Villa Maria');

-- Insertar registros en la tabla clientes
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Lopez Marcos','Colon 111',1);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Lopez Hector','San Martin 222',1);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Perez Ana','San Martin 333',2);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Garcia Juan','Rivadavia 444',3);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Perez Luis','Sarmiento 555',3);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Gomez Ines','San Martin 666',4);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Torres Fabiola','Alem 777',5);
INSERT INTO samil.clientes (nombre, domicilio, codigociudad) VALUES ('Garcia Luis','Sucre 888',5);

-- Realizar un INNER JOIN para mostrar clientes con el nombre de su ciudad
SELECT 
    c.codigo,
    c.nombre,
    c.domicilio,
    ci.nombre AS ciudad
FROM samil.clientes c
INNER JOIN samil.ciudades ci
ON c.codigociudad = ci.codigo;

-- Crear una vista basada en el INNER JOIN anterior
CREATE VIEW samil.vista_clientes_ciudades AS
SELECT 
    c.codigo,
    c.nombre,
    c.domicilio,
    ci.nombre AS ciudad
FROM samil.clientes c
INNER JOIN samil.ciudades ci
ON c.codigociudad = ci.codigo;

-- Crear un procedimiento almacenado que elimine un cliente por nombre
CREATE PROCEDURE samil.eliminar_cliente
    @nombre VARCHAR(100)
AS
BEGIN
    DELETE FROM samil.clientes
    WHERE nombre = @nombre;
END;