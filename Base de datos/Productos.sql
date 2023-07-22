use TiendaDeRopa
--crear tabla Productos
create table Productos(
codigo_Prod varchar(10) NOT NULL,
nombre_Prod varchar(30) NOT NULL,
tipo_Prod varchar(5) NOT NULL,
color_Prod varchar(20) NOT NULL,
stock_Prod int default 0,
precio_Prod money default 0,
fechaDeRegistro_Prod date default getdate(),
talla_Prod varchar(20) NOT NULL,
cuitProveedor_Prod varchar(11) NOT NULL,
estado_Prod bit default 1,
CONSTRAINT PK_Productos PRIMARY KEY (codigo_Prod),
CONSTRAINT FK_Productos_TipoDeProductos FOREIGN KEY (tipo_Prod)
REFERENCES TipoDeProductos(codigo_TDP),
CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (cuitProveedor_Prod)
REFERENCES Proveedores(cuit_Prov),
)
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_Productos_Agregar
@codigo_Prod varchar(10),
@nombre_Prod varchar(30),
@tipo_Prod varchar(5),
@color_Prod varchar(20),
@stock_Prod int,
@precio_Prod money,
@talla_Prod varchar(20),
@cuitProveedor_Prod varchar(11)
as 
begin
insert into Productos (codigo_Prod,nombre_Prod,tipo_Prod,color_Prod,stock_Prod,precio_Prod,talla_Prod,cuitProveedor_Prod)
select @codigo_Prod,@nombre_Prod,@tipo_Prod,@color_Prod,@stock_Prod,@precio_Prod,@talla_Prod,@cuitProveedor_Prod
end
go

Create Procedure SP_Productos_ModificarEstado
@codigo_Prod varchar(10),
@estado_Prod bit
as 
begin
update Productos set estado_Prod=@estado_Prod where codigo_Prod = @codigo_Prod
end
go

Create Procedure SP_Productos_Actualizar
@codigo_Prod varchar(10),
@nombre_Prod varchar(30),
@tipo_Prod varchar(5),
@color_Prod varchar(20),
@stock_Prod int,
@precio_Prod money,
@talla_Prod varchar(20),
@cuitProveedor_Prod varchar(11)
as 
begin
update Productos set nombre_Prod=@nombre_Prod,tipo_Prod=@tipo_Prod,
color_Prod=@color_Prod,stock_Prod=@stock_Prod,precio_Prod=@precio_Prod,
talla_Prod=@talla_Prod,cuitProveedor_Prod=@cuitProveedor_Prod
where codigo_Prod = @codigo_Prod
end
go
--crear 10 registros
-- Llamar al procedimiento para insertar cada registro de forma individual
EXEC SP_Productos_Agregar 'ACOD1', 'Producto 1', 'COD1', 'Rojo', 100, 50.00, 'M', '11111111111';
EXEC SP_Productos_Agregar 'ACOD2', 'Producto 2', 'COD2', 'Azul', 150, 60.00, 'L', '22222222222';
EXEC SP_Productos_Agregar 'ACOD3', 'Producto 3', 'COD3', 'Verde', 200, 70.00, 'XL', '33333333333';
EXEC SP_Productos_Agregar 'ACOD4', 'Producto 4', 'COD4', 'Negro', 120, 55.00, 'S', '44444444444';
EXEC SP_Productos_Agregar 'ACOD5', 'Producto 5', 'COD5', 'Blanco', 180, 65.00, 'M', '55555555555';
EXEC SP_Productos_Agregar 'ACOD6', 'Producto 6', 'COD6', 'Gris', 90, 40.00, 'L', '66666666666';
EXEC SP_Productos_Agregar 'ACOD7', 'Producto 7', 'COD7', 'Amarillo', 220, 75.00, 'XL', '77777777777';
EXEC SP_Productos_Agregar 'ACOD8', 'Producto 8', 'COD8', 'Marrón', 140, 58.00, 'M', '88888888888';
EXEC SP_Productos_Agregar 'ACOD9', 'Producto 9', 'COD9', 'Rosa', 250, 80.00, 'S', '99999999999';
EXEC SP_Productos_Agregar 'ACOD10', 'Producto 10', 'COD10', 'Morado', 180, 70.00, 'XL', '10101010101';
GO
SELECT * FROM Productos;

/*Trigger para evitar eliminar registros en la tabla provincias*/
Create Trigger TG_Productos_PrevenirEliminar
on productos
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Productos')
rollback
end
go
--delete from Productos where codigo_Prod = 'A'

