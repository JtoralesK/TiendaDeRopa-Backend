use TiendaDeRopa
--crear tabla Empleados
create table Empleados(
cuit_Emp varchar(11) NOT NULL,
codRol_Emp varchar(1) NOT NULL,
nombre_Emp varchar(40) NOT NULL,
password_Emp varchar(20) NOT NULL,
email_Emp varchar(75) NOT NULL,
telefono_Emp varchar(20) NOT NULL,
genero_Emp varchar(10) NOT NULL,
direccion_Emp varchar(50) NOT NULL,
imgPerfil_Emp varchar(500) NOT NULL,
fechaDeRegistro_Emp date default getdate(),
ultimaConexion_Emp date default getDate(),
estado_Emp bit default 1,
CONSTRAINT PK_Empleados PRIMARY KEY (cuit_Emp),
CONSTRAINT FK_Empleados_Roles FOREIGN KEY (codRol_Emp)
REFERENCES Roles(codigo_Rol)
)
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_Empleados_Agregar
@cuit_Emp varchar(11),
@codRol_Emp varchar(1),
@nombre_Emp varchar(40),
@password_Emp varchar(20),
@email_Emp varchar(75),
@telefono_Emp varchar(20),
@genero_Emp varchar(10),
@direccion_Emp varchar(50),
@imgPerfil_Emp varchar(500)
as 
begin
insert Empleados (cuit_Emp,codRol_Emp,nombre_Emp,password_Emp,email_Emp,telefono_Emp,genero_Emp,direccion_Emp,imgPerfil_Emp)
select @cuit_Emp,@codRol_Emp,@nombre_Emp,@password_Emp,@email_Emp,@telefono_Emp,@genero_Emp,@direccion_Emp,@imgPerfil_Emp
end
go

Create Procedure SP_Empleados_ModificarEstado
@cuit_Emp varchar(11),
@estado_Emp bit
as 
begin
update Empleados set estado_Emp=@estado_Emp where cuit_Emp = @cuit_Emp
end
go

Create Procedure SP_Empleados_Actualizar
@cuit_Emp varchar(11),
@codRol_Emp varchar(1),
@nombre_Emp varchar(40),
@password_Emp varchar(20),
@email_Emp varchar(75),
@telefono_Emp varchar(20),
@genero_Emp varchar(10),
@direccion_Emp varchar(50),
@imgPerfil_Emp varchar(500),
@ultimaConexion_Emp date
as 
begin
update Empleados set codRol_Emp=@codRol_Emp,
nombre_Emp=@nombre_Emp,password_Emp=@password_Emp,
email_Emp=@email_Emp,telefono_Emp=@telefono_Emp,
genero_Emp=@genero_Emp,direccion_Emp=@direccion_Emp,
imgPerfil_Emp=@imgPerfil_Emp,ultimaConexion_Emp=@ultimaConexion_Emp
where cuit_Emp = @cuit_Emp
end
go

--ingresar 10 registros
-- Execute the stored procedure 10 times with different parameters to add 10 employees
EXEC SP_Empleados_Agregar '11111111111', 'A', 'John Doe', 'password1', 'john.doe@example.com', '123456789', 'Male', '123 Main St', 'profile1.jpg';
EXEC SP_Empleados_Agregar '22222222222', 'A', 'Jane Smith', 'password2', 'jane.smith@example.com', '987654321', 'Female', '456 Elm St', 'profile2.jpg';
EXEC SP_Empleados_Agregar '33333333333', 'B', 'Michael Johnson', 'password3', 'michael.johnson@example.com', '567890123', 'Male', '789 Oak Ave', 'profile3.jpg';
EXEC SP_Empleados_Agregar '44444444444', 'B', 'Emily Brown', 'password4', 'emily.brown@example.com', '789012345', 'Female', '101 Pine Rd', 'profile4.jpg';
EXEC SP_Empleados_Agregar '55555555555', 'B', 'Robert Lee', 'password5', 'robert.lee@example.com', '456789012', 'Male', '222 Maple Blvd', 'profile5.jpg';
EXEC SP_Empleados_Agregar '66666666666', 'B', 'Amanda Davis', 'password6', 'amanda.davis@example.com', '901234567', 'Female', '333 Cedar Ln', 'profile6.jpg';
EXEC SP_Empleados_Agregar '77777777777', 'B', 'Daniel Wilson', 'password7', 'daniel.wilson@example.com', '234567890', 'Male', '444 Oak St', 'profile7.jpg';
EXEC SP_Empleados_Agregar '88888888888', 'B', 'Olivia Garcia', 'password8', 'olivia.garcia@example.com', '890123456', 'Female', '555 Pine St', 'profile8.jpg';
EXEC SP_Empleados_Agregar '99999999999', 'B', 'James Martinez', 'password9', 'james.martinez@example.com', '345678901', 'Male', '666 Elm Ave', 'profile9.jpg';
EXEC SP_Empleados_Agregar '12345678901', 'B', 'Sophia Hernandez', 'password10', 'sophia.hernandez@example.com', '678901234', 'Female', '777 Maple Rd', 'profile10.jpg';

SELECT * FROM Empleados
/*Trigger para evitar eliminar registros en la tabla Roles*/
Create Trigger TG_Empleados_PrevenirEliminar
on Empleados
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Empleados')
rollback
end
go
--delete from Empleados where cuit_Emp = 'A'