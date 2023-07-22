use TiendaDeRopa

--crear table roles
Create table Roles(
codigo_Rol varchar(1) NOT NULL,
nombre_Rol varchar(20) NOT NULL,
descripcion_Rol varchar(50) NOT NULL,
estado_Rol bit default 1,
CONSTRAINT PK_Roles PRIMARY KEY (codigo_Rol)
)
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_Roles_Agregar
@codigo_Rol varchar(1),
@nombre_Rol varchar(20),
@descripcion_Rol varchar(50)
as 
begin
insert into Roles (codigo_Rol,nombre_Rol,descripcion_Rol)
select @codigo_Rol,@nombre_Rol,@descripcion_Rol
end
go

Create Procedure SP_Roles_ModificarEstado
@codigo_Rol varchar(1),
@estado_Rol bit
as 
begin
update Roles set estado_Rol=@estado_Rol where codigo_Rol = @codigo_Rol
end
go

Create Procedure SP_Roles_Actualizar
@codigo_Rol varchar(1),
@nombre_Rol varchar(20),
@descripcion_Rol varchar(50)
as 
begin
update Roles set nombre_Rol=@nombre_Rol,descripcion_Rol=@descripcion_Rol
where codigo_Rol = @codigo_Rol
end
go
exec SP_Roles_Agregar 'A','administrador','se encarga de manejar todas las actividades'
--exec SP_Roles_Actualizar 'B','empleado','se encarga de manejar las ventas'

/*Trigger para evitar eliminar registros en la tabla Roles*/
Create Trigger TG_Roles_PrevenirEliminar
on roles
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Roles')
rollback
end
go
--delete from Roles where codigo_rol = 'A'
select * from roles