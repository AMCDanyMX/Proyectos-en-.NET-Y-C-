

USE bd_servicio_social;

-- -----------------------------------------------------
-- Table dbo.tipo_usuario
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.tipo_usuario ;

CREATE TABLE  dbo.tipo_usuario (
  Id INT NOT NULL,
  Name NVARCHAR(255) NULL DEFAULT NULL,
  Status INT NULL DEFAULT NULL,
  PRIMARY KEY (Id))
;


-- -----------------------------------------------------
-- Table dbo.usuarios
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.usuarios ;

CREATE TABLE  dbo.usuarios (
  Id NVARCHAR(80) NOT NULL,
  UserName NVARCHAR(13) NOT NULL,
  PasswordHash NVARCHAR(45) NOT NULL,
  Email NVARCHAR(80) NULL DEFAULT NULL,
  Status INT NULL DEFAULT NULL,
  tipo_usuario_id INT NOT NULL,
  PRIMARY KEY (UserName, tipo_usuario_id),
  CONSTRAINT fk_usuarios_tipo_usuario1
    FOREIGN KEY (tipo_usuario_id)
    REFERENCES dbo.tipo_usuario (Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_usuarios_tipo_usuario1_idx ON dbo.usuarios (tipo_usuario_id ASC);

-- -----------------------------------------------------
-- Table dbo.alumno
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.alumno ;

CREATE TABLE dbo.alumno (
  Matricula INT NOT NULL,
  Nombre NVARCHAR(55) NULL DEFAULT NULL,
  ApPaterno NVARCHAR(55) NULL DEFAULT NULL,
  ApMaterno NVARCHAR(55) NULL DEFAULT NULL,
  RFC NVARCHAR(10) NULL DEFAULT NULL,
  Carrera NVARCHAR(55) NULL DEFAULT NULL,
  Semestre INT NULL DEFAULT NULL,
  Grupo NVARCHAR(2) NULL DEFAULT NULL,
  Telefono INT NULL DEFAULT NULL,
  Telefono_fijo INT NULL DEFAULT NULL,
  Calle NVARCHAR(55) NULL DEFAULT NULL,
  Numero INT NULL DEFAULT NULL,
  Colonia NVARCHAR(55) NULL DEFAULT NULL,
  Localidad NVARCHAR(55) NULL DEFAULT NULL,
  CodigoPostal INT NULL DEFAULT NULL,
  Email NVARCHAR(55) NULL DEFAULT NULL,
  Ciudad_origen NVARCHAR(50) NULL DEFAULT NULL,
  Foto NVARCHAR(55) NULL DEFAULT NULL,
  usuarios_username NVARCHAR(13) NOT NULL,
  usuarios_tipo_usuario_id INT NOT NULL,

  PRIMARY KEY (Matricula),
  CONSTRAINT fk_alumno_usuarios1
    FOREIGN KEY (usuarios_username , usuarios_tipo_usuario_id)
    REFERENCES dbo.usuarios (UserName , tipo_usuario_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_alumno_usuarios1_idx ON dbo.alumno (usuarios_username ASC, usuarios_tipo_usuario_id ASC);


-- -----------------------------------------------------
-- Table dbo.asesorexterno
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.asesorexterno ;

CREATE TABLE  dbo.asesorexterno (
  Nombre NVARCHAR(55) NULL DEFAULT NULL,
  ApPaterno NVARCHAR(55) NULL DEFAULT NULL,
  ApMaterno NVARCHAR(55) NULL DEFAULT NULL,
  RFC NVARCHAR(10) NOT NULL,
  Institucion NVARCHAR(55) NULL DEFAULT NULL,
  Cargo NVARCHAR(55) NULL DEFAULT NULL,
  Programa_Estudio NVARCHAR(55) NULL DEFAULT NULL,
  Telefono INT NULL DEFAULT NULL,
  Email NVARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (RFC))
;


-- -----------------------------------------------------
-- Table dbo.asesorinterno
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.asesorinterno ;

CREATE TABLE  dbo.asesorinterno (
  Nombre NVARCHAR(55) NULL DEFAULT NULL,
  ApPaterno NVARCHAR(55) NULL DEFAULT NULL,
  ApMaterno NVARCHAR(55) NULL DEFAULT NULL,
  RFC NVARCHAR(10) NOT NULL,
  Institucion NVARCHAR(55) NULL DEFAULT NULL,
  Cargo NVARCHAR(55) NULL DEFAULT NULL,
  Programa_Estudio NVARCHAR(55) NULL DEFAULT NULL,
  Telefono INT NULL DEFAULT NULL,
  Email NVARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (RFC))
;


-- -----------------------------------------------------
-- Table dbo.generales
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.generales ;

CREATE TABLE  dbo.generales (
  id_general INT NOT NULL,
  nombre_universidad NVARCHAR(70) NULL DEFAULT NULL,
  area NVARCHAR(50) NULL DEFAULT NULL,
  unidad NVARCHAR(70) NULL DEFAULT NULL,
  departamento NVARCHAR(70) NULL DEFAULT NULL,
  RFC_coordinador NVARCHAR(70) NULL DEFAULT NULL,
  descripcion_cargo NVARCHAR(70) NULL DEFAULT NULL,
  PRIMARY KEY (id_general))
;


-- -----------------------------------------------------
-- Table dbo.institucion_receptora
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.institucion_receptora ;

CREATE TABLE  dbo.institucion_receptora (
  id_instituto INT NOT NULL,
  Nombre NVARCHAR(55) NULL DEFAULT NULL,
  RFC NVARCHAR(10) NULL DEFAULT NULL,
  Telefono INT NULL DEFAULT NULL,
  Calle NVARCHAR(55) NULL DEFAULT NULL,
  Numero INT NULL DEFAULT NULL,
  Colonia NVARCHAR(55) NULL DEFAULT NULL,
  Localidad NVARCHAR(55) NULL DEFAULT NULL,
  CodigoPosta INT NULL DEFAULT NULL,
  Email NVARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (id_instituto))
;
-- -----------------------------------------------------
-- Table dbo.responsableprograma
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.responsableprograma ;

CREATE TABLE  dbo.responsableprograma (
  Nombre NVARCHAR(55) NULL DEFAULT NULL,
  ApPaterno NVARCHAR(55) NULL DEFAULT NULL,
  ApMaterno NVARCHAR(55) NULL DEFAULT NULL,
  RFC NVARCHAR(10) NOT NULL,
  Institucion NVARCHAR(55) NULL DEFAULT NULL,
  Cargo NVARCHAR(55) NULL DEFAULT NULL,
  Programa_Estudio NVARCHAR(55) NULL DEFAULT NULL,
  Telefono INT NULL DEFAULT NULL,
  Email NVARCHAR(55) NULL DEFAULT NULL,
  PRIMARY KEY (RFC))
;

-- -----------------------------------------------------
-- Table dbo.solicitud
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.solicitud ;

CREATE TABLE  dbo.solicitud (
  id_solicitud INT NOT NULL,
  fecha_solicitud DATE NULL DEFAULT NULL,
  estatus NVARCHAR(20) NULL DEFAULT NULL,
  alumno_Matricula INT NOT NULL,
  institucion_receptora_id_instituto INT NOT NULL,
  PRIMARY KEY (id_solicitud, alumno_Matricula),
  CONSTRAINT fk_solicitud_alumno1
    FOREIGN KEY (alumno_Matricula)
    REFERENCES dbo.alumno (Matricula)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_solicitud_institucion_receptora1
    FOREIGN KEY (institucion_receptora_id_instituto)
    REFERENCES dbo.institucion_receptora (id_instituto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_solicitud_alumno1_idx ON dbo.solicitud (alumno_Matricula ASC);

CREATE INDEX fk_solicitud_institucion_receptora1_idx ON dbo.solicitud (institucion_receptora_id_instituto ASC);


-- -----------------------------------------------------
-- Table dbo.servicio_social
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.servicio_social ;

CREATE TABLE  dbo.servicio_social (
  id_servicio_social INT NOT NULL,
  fecha_inicio_servicio DATE NULL DEFAULT NULL,
  creditos INT NULL DEFAULT NULL,
  estatus NVARCHAR(20) NULL DEFAULT NULL,
  solicitud_id_solicitud INT NOT NULL,
  solicitud_alumno_Matricula INT NOT NULL,
  asesor_RFC NVARCHAR(10) NOT NULL,
  asesorexterno_RFC NVARCHAR(10) NOT NULL,
  responsableprograma_RFC NVARCHAR(10) NOT NULL,
  generales_id_general INT NOT NULL,
  PRIMARY KEY (id_servicio_social, solicitud_id_solicitud, solicitud_alumno_Matricula),
  CONSTRAINT fk_servicio_social_solicitud1
    FOREIGN KEY (solicitud_id_solicitud , solicitud_alumno_Matricula)
    REFERENCES dbo.solicitud (id_solicitud , alumno_Matricula)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servicio_social_asesor1
    FOREIGN KEY (asesor_RFC)
    REFERENCES dbo.asesorinterno (RFC)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servicio_social_asesorexterno1
    FOREIGN KEY (asesorexterno_RFC)
    REFERENCES dbo.asesorexterno (RFC)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servicio_social_responsableprograma1
    FOREIGN KEY (responsableprograma_RFC)
    REFERENCES dbo.responsableprograma (RFC)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_servicio_social_generales1
    FOREIGN KEY (generales_id_general)
    REFERENCES dbo.generales (id_general)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_servicio_social_solicitud1_idx ON dbo.servicio_social (solicitud_id_solicitud ASC, solicitud_alumno_Matricula ASC);

CREATE INDEX fk_servicio_social_asesor1_idx ON dbo.servicio_social (asesor_RFC ASC);

CREATE INDEX fk_servicio_social_asesorexterno1_idx ON dbo.servicio_social (asesorexterno_RFC ASC);

CREATE INDEX fk_servicio_social_responsableprograma1_idx ON dbo.servicio_social (responsableprograma_RFC ASC);

CREATE INDEX fk_servicio_social_generales1_idx ON dbo.servicio_social (generales_id_general ASC);


-- -----------------------------------------------------
-- Table dbo.reporte_inicial
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.reporte_inicial ;

CREATE TABLE  dbo.reporte_inicial (
  id_reporte INT NOT NULL,
  fecha_reporte DATE NULL DEFAULT NULL,
  asunto NVARCHAR(30) NULL DEFAULT NULL,
  nombre_proyecto NVARCHAR(50) NULL DEFAULT NULL,
  planeacion_mes_1 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_2 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_3 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_4 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_5 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_6 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_7 NVARCHAR(60) NULL DEFAULT NULL,
  planeacion_mes_8 NVARCHAR(60) NULL DEFAULT NULL,
  descripcion_horario NVARCHAR(60) NULL DEFAULT NULL,
  servicio_social_id_servicio_social INT NOT NULL,
  servicio_social_solicitud_id_solicitud INT NOT NULL,
  servicio_social_solicitud_alumno_Matricula INT NOT NULL,
  PRIMARY KEY (id_reporte, servicio_social_id_servicio_social, servicio_social_solicitud_id_solicitud, servicio_social_solicitud_alumno_Matricula),
  CONSTRAINT fk_reporte_inicial_servicio_social1
    FOREIGN KEY (servicio_social_id_servicio_social , servicio_social_solicitud_id_solicitud , servicio_social_solicitud_alumno_Matricula)
    REFERENCES dbo.servicio_social (id_servicio_social , solicitud_id_solicitud , solicitud_alumno_Matricula)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_reporte_inicial_servicio_social1_idx ON dbo.reporte_inicial (servicio_social_id_servicio_social ASC, servicio_social_solicitud_id_solicitud ASC, servicio_social_solicitud_alumno_Matricula ASC);


-- -----------------------------------------------------
-- Table dbo.reporte_mensual
-- -----------------------------------------------------
DROP TABLE IF EXISTS dbo.reporte_mensual ;

CREATE TABLE  dbo.reporte_mensual (
  id_reporte INT NOT NULL,
  fecha_reporte DATE NULL DEFAULT NULL,
  asunto NVARCHAR(30) NULL DEFAULT NULL,
  periodo_reportado NVARCHAR(30) NULL DEFAULT NULL,
  horas_reportadas INT NULL DEFAULT NULL,
  nombre_proyecto NVARCHAR(50) NULL DEFAULT NULL,
  descripcion NVARCHAR(500) NULL DEFAULT NULL,
  servicio_social_id_servicio_social INT NOT NULL,
  servicio_social_solicitud_id_solicitud INT NOT NULL,
  servicio_social_solicitud_alumno_Matricula INT NOT NULL,
  PRIMARY KEY (id_reporte, servicio_social_id_servicio_social, servicio_social_solicitud_id_solicitud, servicio_social_solicitud_alumno_Matricula),
  CONSTRAINT fk_reporte_mensual_servicio_social1
    FOREIGN KEY (servicio_social_id_servicio_social , servicio_social_solicitud_id_solicitud , servicio_social_solicitud_alumno_Matricula)
    REFERENCES dbo.servicio_social (id_servicio_social , solicitud_id_solicitud , solicitud_alumno_Matricula)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_reporte_mensual_servicio_social1_idx ON dbo.reporte_mensual (servicio_social_id_servicio_social ASC, servicio_social_solicitud_id_solicitud ASC, servicio_social_solicitud_alumno_Matricula ASC);








