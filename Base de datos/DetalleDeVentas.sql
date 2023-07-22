use TiendaDeRopa

--crear tabla DetalleDeVentas
create table DetalleDeVentas(
	ID_DDV int identity (1,1),
	ventaId_DDV int NOT NULL,
	codigoProducto_DDV varchar(10) NOT NULL,
	precioUnitario_DDV money default 0,
	cantidad_DDV int default 0,
	total_DDV money default 0,
	estado_DDV bit default 1
	CONSTRAINT PK_DetalleDeVentas PRIMARY KEY(ID_DDV),
    CONSTRAINT FK_DetalleDeVentas_Ventas fOREIGN KEY(ventaId_DDV)
	REFERENCES Ventas(ID_vent),
	CONSTRAINT FK_DetalleDeVentas_Productos fOREIGN KEY(codigoProducto_DDV)
	REFERENCES Productos (codigo_Prod)
)

--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_DetalleDeVentas_Agregar
@ventaId_DDV int,
@codigoProducto_DDV varchar(10),
@precioUnitario_DDV money,
@cantidad_DDV inT,
@total_DDV money
as 
begin
insert into DetalleDeVentas (ventaId_DDV,codigoProducto_DDV,precioUnitario_DDV,cantidad_DDV,total_DDV)
select @ventaId_DDV,@codigoProducto_DDV,@precioUnitario_DDV,@cantidad_DDV,@total_DDV
end
go

Create Procedure SP_DetalleDeVentas_ModificarEstado
@ID_DDV int,
@estado_DDV bit
as 
begin
update DetalleDeVentas set estado_DDV=@estado_DDV where ID_DDV = @ID_DDV
end
go

Create Procedure SP_DetalleDeVentas_Actualizar
@ID_DDV int,
@ventaId_DDV int,
@codigoProducto_DDV varchar(10),
@precioUnitario_DDV money,
@cantidad_DDV inT,
@total_DDV money
as 
begin
update DetalleDeVentas 
set
ventaId_DDV=@ventaId_DDV,codigoProducto_DDV=@codigoProducto_DDV,
precioUnitario_DDV=@precioUnitario_DDV,cantidad_DDV=@cantidad_DDV,
total_DDV=@total_DDV
where ID_DDV = @ID_DDV
end
go
--agregar 10 registros : 
EXEC SP_DetalleDeVentas_Agregar 1, 'ACOD1', 50.00, 2, 100.00;
EXEC SP_DetalleDeVentas_Agregar 2, 'ACOD2', 60.00, 3, 180.00;
EXEC SP_DetalleDeVentas_Agregar 3, 'ACOD3', 70.00, 4, 280.00;
EXEC SP_DetalleDeVentas_Agregar 4, 'ACOD4', 55.00, 2, 110.00;
EXEC SP_DetalleDeVentas_Agregar 5, 'ACOD5', 65.00, 3, 195.00;
EXEC SP_DetalleDeVentas_Agregar 6, 'ACOD6', 40.00, 1, 40.00;
EXEC SP_DetalleDeVentas_Agregar 7, 'ACOD7', 75.00, 5, 375.00;
EXEC SP_DetalleDeVentas_Agregar 8, 'ACOD8', 58.00, 3, 174.00;
EXEC SP_DetalleDeVentas_Agregar 9, 'ACOD9', 80.00, 4, 320.00;
EXEC SP_DetalleDeVentas_Agregar 10, 'ACOD10', 70.00, 2, 140.00;

/*Trigger para evitar eliminar registros en la tabla DetalleDeVentas*/
Create Trigger TG_DetalleDeVentas_PrevenirEliminar
on DetalleDeVentas
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla DetalleDeVentas')
rollback
end
go
--delete from DetalleDeVentas where ID_DDV = 1