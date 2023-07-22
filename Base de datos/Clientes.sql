use TiendaDeRopa
--crear tabla clientes
create table Clientes(
dni_Cli varchar(8) NOT NULL,
nombre_Cli varchar(50) NOT NULL,
email_Cli varchar(75) NOT NULL,
telefono_Cli varchar(20) NOT NULL,
estado_Cli bit default 1,
CONSTRAINT PK_Clientes PRIMARY KEY (dni_Cli)
)	
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_Clientes_Agregar
@dni_Cli varchar(8),
@nombre_Cli varchar(50),
@email_Cli varchar(75),
@telefono_Cli varchar(20)
as 
begin
insert into Clientes (dni_Cli,nombre_Cli,email_Cli,telefono_Cli)
select @dni_Cli,@nombre_Cli,@email_Cli,@telefono_Cli
end
go

Create Procedure SP_Clientes_ModificarEstado
@dni_Cli varchar(8),
@estado_Cli bit
as 
begin
update Clientes set estado_Cli=@estado_Cli where dni_Cli = @dni_Cli
end
go

Create Procedure SP_Clientes_Actualizar
@dni_Cli varchar(8),
@nombre_Cli varchar(50),
@email_Cli varchar(75),
@telefono_Cli varchar(20)
as 
begin
update Clientes set nombre_Cli=@nombre_Cli,
email_Cli=@email_Cli,telefono_Cli=@telefono_Cli
where dni_Cli = @dni_Cli
end
go
--agregar 10 registros
-- Execute the stored procedure 10 times with different parameters
EXEC SP_Clientes_Agregar '11111111', 'John Doe', 'john.doe@example.com', '123456789';
EXEC SP_Clientes_Agregar '22222222', 'Jane Smith', 'jane.smith@example.com', '987654321';
EXEC SP_Clientes_Agregar '33333333', 'Michael Johnson', 'michael.johnson@example.com', '567890123';
EXEC SP_Clientes_Agregar '44444444', 'Emily Brown', 'emily.brown@example.com', '789012345';
EXEC SP_Clientes_Agregar '55555555', 'Robert Lee', 'robert.lee@example.com', '456789012';
EXEC SP_Clientes_Agregar '66666666', 'Amanda Davis', 'amanda.davis@example.com', '901234567';
EXEC SP_Clientes_Agregar '77777777', 'Daniel Wilson', 'daniel.wilson@example.com', '234567890';
EXEC SP_Clientes_Agregar '88888888', 'Olivia Garcia', 'olivia.garcia@example.com', '890123456';
EXEC SP_Clientes_Agregar '99999999', 'James Martinez', 'james.martinez@example.com', '345678901';
EXEC SP_Clientes_Agregar '12345678', 'Sophia Hernandez', 'sophia.hernandez@example.com', '678901234';

select * from Clientes

/*Trigger para evitar eliminar registros en la tabla Roles*/
Create Trigger TG_Clientes_PrevenirEliminar
on Clientes
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Clientes')
rollback
end
go
--delete from Clientes where dni_Cli = 'A'