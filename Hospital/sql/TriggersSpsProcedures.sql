 create trigger MayusCatEsp on cat_especialidad
 FOR INSERT
 AS
 BEGIN
	SET NOCOUNT ON;

	UPDATE cat_especialidad
		SET cat_especialidad.nEspecialidad = UPPER(cat_especialidad.nEspecialidad)
		FROM cat_especialidad INNER JOIN inserted ON cat_especialidad.idEspecialidad = inserted.idEspecialidad;
END;
Insert into cat_especialidad values('Nefrología')
SELECT * FROM cat_especialidad
DELETE from cat_especialidad where idEspecialidad=8
--------------------------------------------------------------------------------------------------------------------
create trigger MayusCatUsr on cat_usuarios
 FOR INSERT
 AS
 BEGIN
	SET NOCOUNT ON;

	UPDATE cat_usuarios
		SET cat_usuarios.nombre = UPPER(cat_usuarios.nombre)
		FROM cat_usuarios INNER JOIN inserted ON cat_usuarios.tusuario = inserted.tusuario;
END;

INsert into cat_usuarios values('recepcionista');
UPDATE cat_usuarios SET tusuario=1 where nombre = 'DOCTOR'
SELECT * FROM cat_usuarios;
---------------------------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------------------------------
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
SELECT * FROM Doctor
EXEC INSDoctor 'omar@gmail.com', 'Fernando','Ceja','Martinez',  '123456789', 'FMHV314704WTATOXA9', '5591449814','1995-08-18', 'MASCULINO', 2, '1111111111', 4, 2, '4PED1'
-----------------------------------------------------------------------------------------------------------------------------------
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
Select * from Paciente
EXEC INSConsultorio '10NF1', '11:00:00', '23:00:00', 3,3 
-----------------------------------------------------------------------------------------------------------------------------------
create Procedure regProcedimientos(
	@idCita int,
	@idProcedimiento int
)AS
BEGIN
	INSERT INTO cita_proced VALUES(@idCita, @idProcedimiento);
END;
EXEC regProcedimientos 3, 5 
select * from cita_proced
-----------------------------------------------------------------------------------------------------------------------------------
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
Select * from Cita
EXEC regCitas '10982112573', '2023-06-21 18:00:00', 'CARDIOLOGÍA'
------------------------------------------------------------------------------------------------------------------------------------
create Procedure Consulta
	@idCita int,
	@diagnostico varchar(500),
	@tratamiento varchar(200),
	@medicamento varchar(50)
AS
BEGIN
	declare @nss varchar(11)
	declare @cedula varchar(10)
	declare @comprobar varchar(500) 
	
	Select @comprobar=diagnostico, @nss=nss, @cedula=cedula FROM Cita WHERE idCita = @idCita; 
	print(@comprobar)
	if(@comprobar IS NULL)
	 begin
		insert into Receta (idCita, tratamiento, medicamento)VALUES(@idCita,@tratamiento, @medicamento);
		UPDATE Cita	SET diagnostico = @diagnostico WHERE idCita = @idCita;
		INSERT Into historialClinico VALUES(@idCita, @nss,@cedula);
		insert into cita_proced VALUES(@idCita, 1);
	 end;
	else
		insert into Receta (idCita, tratamiento, medicamento)VALUES(@idCita,@tratamiento, @medicamento);
END;
select * FROM Receta
Select * from historialClinico
EXEC Consulta @idCita=3,
				@diagnostico = 'Paciente Revisado con una posible arritmia cardiaca',
				@tratamiento = 'Tomar el medicamento por 8 dias, 1 tableta cada 12 horas',
				@medicamento = 'ASPIRINA'
-----------------------------------------------------------------------------------------------------------------------------------

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
------------------------------------------------------------------------------------------------------------------------------------
create function totalConsulta (@idCita int)
returns FLOAT
as
begin
	declare @totalreceta MONEY
	declare @totalproced MONEY
	declare @total MONEY

	select @totalreceta = SUM(f.precio) from Farmacia f INNER JOIN Receta r ON r.medicamento = f.medicamento
	where r.idCita = @idCita;

	select @totalproced=SUM(cp.costo) FROM cat_procedimientos cp INNER JOIN cita_proced cip ON cp.idProcedimiento=cip.idProcedimiento
	WHERE cip.idCita=@idCita;

	
	return @totalreceta + @totalproced
end

select dbo.totalConsulta(3) as TotalConsulta
-------------------------------------------------------------------------------------------------------------------------------------