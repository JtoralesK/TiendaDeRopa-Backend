use TiendaDeRopa
--crear table TipoDePago
Create table TipoDePago(
codigo_TPD varchar(1) NOT NULL,
nombre_TPD varchar(30) NOT NULL,
estado_TDP bit default 1
CONSTRAINT PK_TipoDePago PRIMARY KEY (codigo_TPD)
)
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_TipoDePago_Agregar
@codigo_TPD varchar(1),
@nombre_TPD varchar(30)
as 
begin
insert into TipoDePago (codigo_TPD,nombre_TPD)
select @codigo_TPD,@nombre_TPD
end
go

Create Procedure SP_TipoDePago_ModificarEstado
@codigo_TDP varchar(1),
@estado_TDP bit
as 
begin
update TipoDePago set estado_TDP=@estado_TDP where codigo_TPD = @codigo_TDP
end
go

Create Procedure SP_TipoDePago_Actualizar
@codigo_TDP varchar(1),
@nombre_TPD varchar(30)
as 
begin
update TipoDePago set nombre_TPD=@nombre_TPD
where codigo_TPD = @codigo_TDP
end
go
exec SP_TipoDePago_Agregar '1','Tarjeta de credito'
exec SP_TipoDePago_Agregar '2','Efectivo'

--exec SP_Roles_Actualizar 'B','empleado','se encarga de manejar las ventas'

/*Trigger para evitar eliminar registros en la tabla Roles*/
Create Trigger TG_TipoDePago_PrevenirEliminar
on TipoDePago
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla TipoDePago')
rollback
end
go
--delete from TipoDePago where codigo_TPD = 'A'
select * from TipoDePago