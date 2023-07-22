use TiendaDeRopa
--crear tabla TipoDeProductos
Create Table TipoDeProductos(
codigo_TDP varchar(5) not null,
nombre_TDP varchar(20) not null,
descripcion_TDP varchar(50) not null,
estado_TDP bit default 1
CONSTRAINT PK_TipoDeProductos PRIMARY KEY (codigo_TDP)
)
--crear procedimientos almacenados de Agregar/ habilitar-deshabilitar/ actualizar 
go

--crear procedimientos almacenados agregar/deshabilitar-habilidar/actualizar
Create Procedure SP_TipoDeProductos_Agregar
@codigo_TDP varchar(5),
@nombre_TDP varchar(20),
@descripcion_TDP varchar(50)
as 
begin
insert into TipoDeProductos(codigo_TDP,nombre_TDP,descripcion_TDP)
select @codigo_TDP,@nombre_TDP,@descripcion_TDP
end
go

Create Procedure SP_TipoDeProductos_ModificarEstado
@codigo_TDP varchar(5),
@estado_TDP bit
as 
begin
update TipoDeProductos set estado_TDP=@estado_TDP where codigo_TDP=@codigo_TDP
end
go

Create Procedure SP_TipoDeProductos_Actualizar
@codigo_TDP varchar(5),
@nombre_TDP varchar(20) ,
@descripcion_TDP varchar(50) 
as 
begin
update TipoDeProductos set nombre_TDP=@nombre_TDP,descripcion_TDP=@descripcion_TDP where codigo_TDP=@codigo_TDP
end
go
--ingresar 10 registros de prueba
EXEC SP_TipoDeProductos_Agregar 'COD1', 'Producto 1', 'Descripción del producto 1';
EXEC SP_TipoDeProductos_Agregar 'COD2', 'Producto 2', 'Descripción del producto 2';
EXEC SP_TipoDeProductos_Agregar 'COD3', 'Producto 3', 'Descripción del producto 3';
EXEC SP_TipoDeProductos_Agregar 'COD4', 'Producto 4', 'Descripción del producto 4';
EXEC SP_TipoDeProductos_Agregar 'COD5', 'Producto 5', 'Descripción del producto 5';
EXEC SP_TipoDeProductos_Agregar 'COD6', 'Producto 6', 'Descripción del producto 6';
EXEC SP_TipoDeProductos_Agregar 'COD7', 'Producto 7', 'Descripción del producto 7';
EXEC SP_TipoDeProductos_Agregar 'COD8', 'Producto 8', 'Descripción del producto 8';
EXEC SP_TipoDeProductos_Agregar 'COD9', 'Producto 9', 'Descripción del producto 9';
EXEC SP_TipoDeProductos_Agregar 'COD10', 'Producto 10', 'Descripción del producto 10';


/*Trigger para evitar eliminar registros en la tabla TipoDeProductos*/
Create Trigger TG_TipoDeProductos_PrevenirEliminar
on TipoDeProductos
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Tipo de productos')
rollback
end
go

delete from TipoDeProductos where codigo_TDP = 'A'

select * from TipoDeProductos