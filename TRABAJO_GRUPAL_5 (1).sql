-- ----------------------------------------------------------------------------------------------------------

-- Parte 1: Crear entorno de trabajo

-- Crear una base de datos
CREATE DATABASE TLVusuarios;
-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'tlv_usuarios'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON TLVusuarios.* TO 'tlv_usuarios'@'localhost';
FLUSH PRIVILEGES;

-- ----------------------------------------------------------------------------------------------------------

-- Parte 2: Crear dos tablas.

-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, 
-- zona horaria (por defecto UTC-3), género y teléfono de contacto).
CREATE TABLE TLVusuarios.usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  contrasena VARCHAR(30),
  zona_horaria VARCHAR(20) DEFAULT 'UTC-3',
  genero VARCHAR(12),
  telefono_contacto INT
);

-- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la plataforma 
-- (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).
CREATE TABLE TLVusuarios.ingresos (
  id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  fecha_hora_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ----------------------------------------------------------------------------------------------------------

-- Parte 3: Modificación de la tabla

-- Modifique el UTC por defecto. Desde UTC-3 a UTC-2.
ALTER TABLE TLVusuarios.usuarios
MODIFY COLUMN zona_horaria VARCHAR(20)
DEFAULT 'UTC-2';

-- ----------------------------------------------------------------------------------------------------------

-- Parte 4: Creación de registros.

-- Para cada tabla crea 8 registros.
-- Tabla usuarios
INSERT INTO TLVusuarios.usuarios (nombre, apellido, contrasena, genero, telefono_contacto)
VALUES
  ('Juan', 'Perez', 'Contraseña1', 'Masculino', 911111111),
  ('Maria', 'Tolosa', 'Contraseña2', 'Femenino', 922222222),
  ('Patricio', 'Barahona', 'Contraseña3', 'Masculino', 933333333),
  ('Elisa', 'Torres', 'Contraseña4', 'Femenino', 944444444),
  ('Luis', 'Gonzalez', 'Contraseña5', 'Masculino', 955555555),
  ('Daniela', 'Garrido', 'Contraseña6', 'Femenino', 966666666),
  ('Andres', 'Soto', 'Contraseña7', 'Masculino', 977777777),
  ('Fernanda', 'Caceres', 'Contraseña8', 'Femenino', 988888888);
-- Tabla ingresos
INSERT INTO TLVusuarios.ingresos (id_usuario, fecha_hora_ingreso)
VALUES
(5, '2023-05-01 10:30:00'),
(1, '2023-04-15 18:45:00'),
(8, '2023-05-07 09:15:00'),
(3, '2023-04-22 14:00:00'),
(6, '2023-05-03 16:20:00'),
(4, '2023-04-28 12:10:00'),
(7, '2023-05-05 11:00:00'),
(2, '2023-04-17 19:30:00');

-- ----------------------------------------------------------------------------------------------------------

-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
- id_usuario y id_ingreso: Se utiliza INT con AUTO_INCREMENT para generar un identificador único para cada usuario.
- nombre y apellido: Se utiliza VARCHAR(50) para almacenar los nombres y apellidos de longitud variable.
- contrasena: Se utiliza VARCHAR(30) para almacenar las contraseñas, permitiendo una longitud de hasta 30 caracteres.
- zona_horaria: Se utiliza VARCHAR(50) para almacenar la zona horaria de los usuarios.
- genero: Se utiliza VARCHAR(12) para almacenar el género de los usuarios, asumiendo valores como "Masculino" o "Femenino".
- telefono_contacto: Se utiliza INT para almacenar los números de teléfono de contacto de los usuarios, permitiendo que se almacenen los 9 digitos que siguen.
- fecha_hora_ingreso: Se utiliza DATETIME para almacenar la fecha y hora, y se agrega DEFAULT CURRENT_TIMESTAMP para obtener la fecha y hora actual.

-- ----------------------------------------------------------------------------------------------------------

-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono,
-- correo electronico).
CREATE TABLE TLVusuarios.contactos (
  id_contacto INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  numero_telefono INT,
  correo_electronico VARCHAR(100),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ----------------------------------------------------------------------------------------------------------

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
-- tabla Contactos.
ALTER TABLE tlvusuarios.usuarios DROP COLUMN telefono_contacto;

ALTER TABLE tlvusuarios.usuarios ADD COLUMN telefono_contacto INT;

ALTER TABLE tlvusuarios.usuarios ADD FOREIGN KEY (telefono_contacto)
REFERENCES tlvusuarios.contactos(id_contacto)

-- -----------------------------------------------------------------------------------------------------------
REPO GITHUB: https://github.com/danydaniela21/grupal5.git