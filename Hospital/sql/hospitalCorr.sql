 create database HospitalDBST;
 use HospitalDBST;

 Select * from Paciente;
 create table cat_usuarios(
	tusuario int IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(30)
 );
 insert into cat_usuarios values('RECEPCIONISTA')
 create table Usuario(
	correo varchar(75) PRIMARY KEY,
	contrasenia varchar(16),
	curp varchar(18) UNIQUE,
	nombre varchar(50),
	apaterno varchar(50),
	apmaterno varchar(50),
	telefono varchar (10),
	sexo varchar(15),
	fecha_nac date,
	tusuario int,
	FOREIGN KEY(tusuario) REFERENCES cat_usuarios(tusuario)
 );

 create table Paciente(
	nss varchar(11) PRIMARY KEY,
	peso float,
	altura float,
	correo varchar(75),
	FOREIGN KEY (correo) REFERENCES Usuario(correo)
 );
 Select * from Usuario
 create table cat_especialidad(
	idEspecialidad int IDENTITY(1,1) PRIMARY KEY,
	nEspecialidad varchar(40)
 );
 select * from cat_horarios;
 create table cat_horarios(
	idHorario int IDENTITY(1,1) PRIMARY KEY,
	horainicio time,
	horafin time
 );
 iNSERT INTO cat_horarios values('12:00:00', '18:30:00');
 create table Consultorio(
	idConsultorio varchar(5) PRIMARY KEY,
	horaapertura time,
	horacierre time,
	edificio int,
	piso int
 );
 create table Doctor(
	cedula varchar(10) PRIMARY KEY,
	correo varchar(75),
	idEspecialidad int,
	idHorario int,
	idConsultorio varchar(5),
	FOREIGN KEY (idEspecialidad) REFERENCES cat_especialidad(idEspecialidad),
	FOREIGN KEY (idHorario) REFERENCES cat_horarios(idHorario),
	FOREIGN KEY (idConsultorio) REFERENCES Consultorio(idConsultorio)
 );
 Select * from Consultorio;
 create table Cita(
	idCita int IDENTITY(1,1) PRIMARY KEY,
	fechaCita DATETIME,
	diagnostico varchar(500),
	pagoTotal FLOAT,
	idReceta int,
	nss varchar(11),
	cedula varchar(10),
	idConsultorio varchar(5),
	FOREIGN KEY (idReceta) REFERENCES Receta(idReceta),
	FOREIGN KEY (nss) REFERENCES Paciente(nss),
	FOREIGN KEY (cedula) REFERENCES Doctor(cedula),
	FOREIGN KEY (idConsultorio) REFERENCES Consultorio(idConsultorio)
 );

 select * from Usuario

 Select CONCAT(u.nombre,' ', u.apaterno,' ', u.apmaterno) AS Paciente, CONVERT(CHAR(10), c.fechaCita,108) as Hora, c.nss, 
                    (Select CONCAT(u.nombre,' ', u.apaterno,' ', u.apmaterno) FROM Doctor d, Usuario u WHERE d.correo=u.correo AND d.cedula='1023456789') as Doctor,
                    c.idConsultorio as Consultorio, ce.nEspecialidad From Cita c, Usuario u, Paciente p, Doctor d, cat_especialidad ce
                    WHERE c.nss=p.nss AND p.correo= u.correo AND d.cedula=c.cedula AND c.cedula='1023456789' AND d.idEspecialidad=ce.idEspecialidad AND DAY(c.fechaCita)= DAY(GETDATE())

 Select DISTINCT c.cedula from Cita c, Doctor d where c.cedula = d.cedula and DAY(c.fechaCita) = DAY(GETDATE())
 SELECT * FROM Cita
 SELECT CONCAT(u.nombre,' ',u.apaterno,' ',u.apmaterno) as Nombre, c.idCita, c.nss, c.idConsultorio,CONVERT(CHAR(10), c.fechaCita,108) as Hora 
 FROM Paciente p, Cita c, Usuario u WHERE p.correo=u.correo AND c.nss=p.nss AND c.cedula='1023456789'
 Select * from  Doctor
	Insert into Doctor VALUES('1203456789', 'bheaney4@china.com.cn', 2, 1, '1GP38')
 Insert into Cita (fechaCita, nss, cedula, idConsultorio) values(GETDATE(),'27150138520', '1023456789', '1GP38' );
 Select CONCAT(u.nombre,' ', u.apaterno,' ', u.apmaterno) AS Paciente, CONVERT(CHAR(10), c.fechaCita,108) as Hora, c.nss, 
 (Select CONCAT(u.nombre,' ', u.apaterno,' ', u.apmaterno) FROM Doctor d, Usuario u WHERE d.correo=u.correo AND d.cedula='1203456789') as Doctor,
 c.idConsultorio as Consultorio, ce.nEspecialidad From Cita c, Usuario u, Paciente p, Doctor d, cat_especialidad ce
 WHERE c.nss=p.nss AND p.correo= u.correo AND d.cedula=c.cedula AND c.cedula='1203456789' AND d.idEspecialidad=ce.idEspecialidad
	

 create table Receta(
	idReceta int IDENTITY(1,1) PRIMARY KEY,
	tratamiento varchar(200),
	medicamento varchar(50),
	FOREIGN KEY (medicamento) REFERENCES Farmacia(medicamento)
 );

 create table Farmacia(
	medicamento varchar(50) PRIMARY KEY,
	fabricante varchar(50),
	nomcompuesto varchar(50),
	concentracion int,
	presentacion varchar(50),
	precio FLOAT
 );
 Select * from Farmacia;
 Insert into Farmacia values('CIPROFLOXACINO', 'AMSA LABORATORIOS', 'CIPROFLOXACINO', 500, 'TABLETAS', 80.00);
 create table cita_proced(
	idCita int,
	idProcedimiento int,
	FOREIGN KEY (idCita) REFERENCES Cita(idCita),
	FOREIGN KEY (idProcedimiento) REFERENCES cat_procedimientos(idProcedimiento),
	PRIMARY KEY(idCita, idProcedimiento)
 );

 create table cat_procedimientos(
	idProcedimiento int IDENTITY(1,1) PRIMARY KEY,
	nomprocedimiento varchar(100),
	costo FLOAT
 );
 select * from cat_procedimientos;
 Insert into cat_procedimientos values('ANÁLISIS DE ORINA', 150.89);

 create table historialClinico(
	idCita int,
	nss varchar(11),
	cedula varchar(10),
	idReceta int,
	FOREIGN KEY (idCita) REFERENCES Cita(idCita),
	FOREIGN KEY (nss) REFERENCES Paciente(nss),
	FOREIGN KEY (cedula) REFERENCES Doctor(cedula),
	FOREIGN KEY (idReceta) REFERENCES Receta(idReceta),
	PRIMARY KEY (idCita, nss, cedula, idReceta)
 );

 create table Recepcionista(
	correo varchar(75),
	numEmpleado varchar(10) PRIMARY KEY,
	FOREIGN KEY (correo) REFERENCES Usuario(correo)
 );

 create trigger MayusCatEsp on cat_especialidad
 FOR INSERT
 AS
 BEGIN
	SET NOCOUNT ON;

	UPDATE cat_especialidad
		SET cat_especialidad.nEspecialidad = UPPER(cat_especialidad.nEspecialidad)
		FROM cat_especialidad INNER JOIN inserted ON cat_especialidad.idEspecialidad = inserted.idEspecialidad;
END;
Insert into cat_especialidad values('Urología')
create trigger MayusCatUsr on cat_usuarios
 FOR INSERT
 AS
 BEGIN
	SET NOCOUNT ON;

	UPDATE cat_usuarios
		SET cat_usuarios.nombre = UPPER(cat_usuarios.nombre)
		FROM cat_usuarios INNER JOIN inserted ON cat_usuarios.tusuario = inserted.tusuario;
END;

INsert into cat_usuarios values('Paciente');
SELECT * FROM cat_usuarios;

CREATE PROCEDURE INSPaciente(
	@correo varchar(75),
	@nombre varchar(50),
	@appaterno varchar(50),
	@apmaterno varchar(50),
	@contrasenia varchar(16),
	@curp varchar(18),
	@tel varchar(10),
	@fecha_nac DATE,
	@sexo varchar(15),
	@tpusr int,
	@nss varchar(11),
	@peso FLOAT,
	@altura FLOAT
)
AS
BEGIN
	INSERT INTO Usuario VALUES(@correo, @contrasenia, @curp, @nombre, @appaterno, @apmaterno, @tel,@sexo,@fecha_nac,@tpusr);
	INSERT INTO Paciente VALUES(@nss, @peso,@altura,@correo);
END;

EXEC INSPaciente'gaspinall0@i2i.jp', 'Germain','Semark','Aspinall',  'S3JXM4x1', 'SMHV314704WTATOXA9', '5291449814','1970-02-25', 'MASCULINO', 1, '12134567893', 85.4, 1.75

CREATE PROCEDURE INSDoctor(
	@correo varchar(75),
	@nombre varchar(50),
	@appaterno varchar(50),
	@apmaterno varchar(50),
	@contrasenia varchar(16),
	@curp varchar(18),
	@tel varchar(10),
	@fecha_nac DATE,
	@sexo varchar(15),
	@tpusr int,
	@cedula varchar(10),
	@idEspecialidad int,
	@idHorario int,
	@idConsultorio varchar(5)
)
AS
BEGIN
	INSERT INTO Usuario VALUES(@correo, @contrasenia, @curp, @nombre, @appaterno, @apmaterno, @tel,@sexo,@fecha_nac,@tpusr);
	INSERT INTO Doctor VALUES(@cedula, @correo,@idEspecialidad,@idHorario, @idConsultorio);
END;

Select * from Doctor
CREATE PROCEDURE INSConsultorio(
	@idConsultorio varchar(5),
	@horaapertura TIME,
	@horacierre TIME,
	@edificio int,
	@piso int
)
AS
BEGIN
	INSERT INTO Consultorio VALUES(@idConsultorio, @horaapertura, @horacierre, @edificio, @piso);
END;
EXEC INSConsultorio '1GIN3', '07:00:00', '20:00:00', 1, 1
Select *FROM cat_

create function sacarEdad (@correo varchar(75))
returns int
as
begin
	declare @edad int

	select @edad = DATEDIFF(YEAR,u.fecha_nac,GETDATE()) from Usuario u
	where u.correo=@correo

	return @edad
end
select dbo.sacarEdad('rgrealish8@jimdo.com') as Edad

Select * from Paciente

create function totalReceta (@idReceta int)
returns FLOAT
as
begin
	declare @total FLOAT

	select @total = SUM(f.precio) from Farmacia f INNER JOIN Receta r ON r.medicamento = f.medicamento
	where r.idReceta = @idReceta

	return @total
end
select dbo.totalReceta(1) as Total
select dbo.sacarEdad('gaspinall0@i2i.jp') as Edad
Select * from Cita
CREATE PROCEDURE regCitas(
	@nss varchar(11),
	@fecha DATETIME,
	@especialidad varchar(40)
)
AS
BEGIN
	declare @cedula varchar(11)
	declare @idcons varchar(5)

	Select TOP 1 @cedula = d.cedula, @idcons=d.idConsultorio FROM Doctor d INNER JOIN cat_especialidad ce ON d.idEspecialidad = ce.idEspecialidad
		WHERE ce.nEspecialidad=@especialidad ORDER BY NEWID();
	
	Insert into Cita (fechaCita, nss, cedula, idConsultorio) VALUES(CONVERT(DATETIME,@fecha), @nss, @cedula,@idcons);
END;

Insert into Usuario values('bbettovilla@df.dc', 'abcd1234', 'BXBV010410MDFJRCA5','Brenda Ximena', 'Betto','Villa','1232546212', 'Masculino', '2001-04-10', 3);
 select * from Cita

 CREATE Procedure Consulta
	@idCita int,
	@diagnostico varchar(500),
	@tratamiento varchar(200),
	@medicamento varchar(50)
AS
BEGIN
	declare @idReceta int
	declare @nss varchar(11)
	declare @cedula varchar(10)

	insert into Receta VALUES(@tratamiento, @medicamento);
	
	 SELECT @idReceta=SCOPE_IDENTITY();
	 SELECT @nss=nss, @cedula=cedula FROM Cita WHERE idCita = @idCita;
	UPDATE Cita	
		SET diagnostico = @diagnostico,
		idReceta = @idReceta
	WHERE idCita = @idCita;

	INSERT Into historialClinico VALUES(@idCita, @nss,@cedula,@idReceta);
END;

EXEC Consulta @idCita=2,
				@diagnostico = 'Paciente Revisado con una posible arritmia cardiaca',
				@tratamiento = 'Tomar el medicamento por 15 dias, 1 tableta cada 8 horas',
				@medicamento = 'CIPROFLOXACINO'

Select dbo.sacarEdad('rgrealish8@jimdo.com')

UPDATE Cita SET fechaCita = '2023-06-16 13:30:00' where idCita=25
SELECT * FROM Usuario where nombre like 'Alan'
SELECT * FROM Usuario where correo like 'uriel%'
Select * from Cita
DELETE FROM Paciente where nss = '27150138520'
