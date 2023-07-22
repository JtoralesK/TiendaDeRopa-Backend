use TiendaDeRopa

--crear tabla Ventas

create table Ventas(
	ID_Vent int identity(1,1),
	cuitEmpleado_Vent varchar(11) NOT NULL,
	dniCliente_Vent varchar(8) NOT NULL,
	tipoDePago_Vent varchar(1) NOT NULL,
	fechaDeVenta_Vent date default getdate(),
	impuestos_Vent money default 0,
	descuento_Vent money default 0,
	total_Vent money default 0,
	estado_Vent bit default 1
	CONSTRAINT PK_Ventas PRIMARY KEY (ID_Vent),
	CONSTRAINT FK_Ventas_Empleados FOREIGN KEY (cuitEmpleado_Vent)
	REFERENCES EMPLEADOS (cuit_Emp),
	CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (dniCliente_Vent)
	REFERENCES Clientes (dni_Cli),
	CONSTRAINT FK_Ventas_TipoDePago FOREIGN KEY (tipoDePago_Vent)
	REFERENCES TipoDePago (codigo_TPD)
)
go
--crear procedimientos almacenados para agregar/habilitar-deshabilitar/ actualizar
Create Procedure SP_Ventas_Agregar
@cuitEmpleado_Vent varchar(11),
@dniCliente_Vent varchar(8),
@tipoDePago_Vent varchar(1),
@impuestos_Vent money,
@descuento_Vent money,
@total_Vent money
as 
begin
insert into Ventas (cuitEmpleado_Vent,dniCliente_Vent,tipoDePago_Vent,impuestos_Vent,descuento_Vent,total_Vent)
select @cuitEmpleado_Vent,@dniCliente_Vent,@tipoDePago_Vent,@impuestos_Vent,@descuento_Vent,@total_Vent
end
go

Create Procedure SP_Ventas_ModificarEstado
@ID_Vent int,
@estado_Vent bit
as 
begin
update Ventas set estado_Vent=@estado_Vent where ID_Vent = @ID_Vent
end
go

Create Procedure SP_Ventas_Actualizar
@ID_Vent int,
@cuitEmpleado_Vent varchar(11),
@dniCliente_Vent varchar(8),
@tipoDePago_Vent varchar(1),
@impuestos_Vent money,
@descuento_Vent money,
@total_Vent money
as 
begin
update Ventas set 
cuitEmpleado_Vent=@cuitEmpleado_Vent,dniCliente_Vent=@dniCliente_Vent,
tipoDePago_Vent=@tipoDePago_Vent,impuestos_Vent=@impuestos_Vent,
descuento_Vent=@descuento_Vent,total_Vent=@total_Vent
where ID_Vent = @ID_Vent
end
go

--agregar 10 registros

-- Agregar 10 ventas con los valores correctos para las claves externas
EXEC SP_Ventas_Agregar '11111111111', '11111111', '1', 100.00, 10.00, 90.00;
EXEC SP_Ventas_Agregar '22222222222', '22222222', '2', 200.00, 20.00, 180.00;
EXEC SP_Ventas_Agregar '33333333333', '33333333', '1', 300.00, 30.00, 270.00;
EXEC SP_Ventas_Agregar '44444444444', '44444444', '2', 400.00, 40.00, 360.00;
EXEC SP_Ventas_Agregar '55555555555', '55555555', '1', 500.00, 50.00, 450.00;
EXEC SP_Ventas_Agregar '66666666666', '66666666', '2', 600.00, 60.00, 540.00;
EXEC SP_Ventas_Agregar '77777777777', '77777777', '1', 700.00, 70.00, 630.00;
EXEC SP_Ventas_Agregar '88888888888', '88888888', '2', 800.00, 80.00, 720.00;
EXEC SP_Ventas_Agregar '99999999999', '99999999', '1', 900.00, 90.00, 810.00;
EXEC SP_Ventas_Agregar '12345678901', '12345678', '2', 1000.00, 100.00, 900.00;

/*Trigger para evitar eliminar registros en la tabla Ventas*/
Create Trigger TG_Ventas_PrevenirEliminar
on Ventas
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Ventas')
rollback
end
go
--delete from Ventas where ID_Vent = 1
