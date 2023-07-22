create database TiendaDeRopa
go
use TiendaDeRopa
-- Crear Tabla Provincias

create table Provincias(
codigo_Provin varchar(2) NOT NULL,
nombre_Provin varchar(40) NOT NULL,
estado_Provin bit default 1,
CONSTRAINT PK_Provincias PRIMARY KEY (codigo_Provin)
)
go

/*insertar provincias*/
INSERT INTO Provincias (codigo_Provin, nombre_Provin)
SELECT 'A', 'Buenos Aires'
UNION
SELECT 'B', 'Catamarca'
UNION
SELECT 'C', 'Chaco'
UNION
SELECT 'U', 'Chubut'
UNION
SELECT 'X', 'Córdoba'
UNION
SELECT 'W', 'Corrientes'
UNION
SELECT 'E', 'Entre Ríos'
UNION
SELECT 'P', 'Formosa'
UNION
SELECT 'Y', 'Jujuy'
UNION
SELECT 'L', 'La Pampa'
UNION
SELECT 'F', 'La Rioja'
UNION
SELECT 'M', 'Mendoza'
UNION
SELECT 'N', 'Misiones'
UNION
SELECT 'Q', 'Neuquén'
UNION
SELECT 'R', 'Río Negro'
UNION
SELECT 'H', 'Salta'
UNION
SELECT 'J', 'San Juan'
UNION
SELECT 'D', 'San Luis'
UNION
SELECT 'Z', 'Santa Cruz'
UNION
SELECT 'S', 'Santa Fe'
UNION
SELECT 'G', 'Santiago del Estero'
UNION
SELECT 'V', 'Tierra del Fuego'
UNION
SELECT 'T', 'Tucumán';
go
SELECT * FROM Provincias
go
--crear procedimientos almacenados agregar/deshabilitar-habilidar/actualizar
Create Procedure SP_Provincias_Agregar
@codigo_Provin varchar(2),
@nombre_Provin varchar(40)
as 
begin
insert into Provincias (codigo_Provin,nombre_Provin)
select @codigo_Provin,@nombre_Provin
end
go

Create Procedure SP_Provincias_ModificarEstado
@codigo_Provin varchar(2),
@estado_Provin bit
as 
begin
update Provincias set estado_Provin=@estado_Provin where codigo_Provin = @codigo_Provin
end
go

Create Procedure SP_Provincias_Actualizar
@codigo_Provin varchar(2),
@nombre_Provin varchar(40)
as 
begin
update Provincias set nombre_Provin=@nombre_Provin where codigo_Provin = @codigo_Provin
end
go
--EXEC sp_rename 'SP_Provincia_Actualizar', 'SP_Provincias_Actualizar';

/*Trigger para evitar eliminar registros en la tabla provincias*/
Create Trigger TG_Provincias_PrevenirEliminar
on provincias
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Provincias')
rollback
end
go
--delete from Provincias where codigo_Provin = 'A'
