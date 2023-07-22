use TiendaDeRopa
--crear tabla 
CREATE TABLE Proveedores(
cuit_Prov varchar(11) NOT NULL,
razonSocial_Prov varchar(30) NOT NULL,
email_Prov varchar(75) NOT NULL,
localidad_Prov varchar(50) NOT NULL,
Provincia_Prov varchar(2) NOT NULL,
telefono_Prov varchar(20) NOT NULL,
fechaDeRegistro_Prov date default getdate(),
codigoPostal_Prov varchar(5) NOT NULL,
estado_Prov bit default 1,
CONSTRAINT PK_Proveedores PRIMARY KEY (cuit_Prov),
CONSTRAINT FK_Proveedores_Provincias FOREIGN KEY (Provincia_Prov) references Provincias (codigo_Provin)
)
go

--crear procedimientos almacenados agregar/deshabilitar-habilidar/actualizar
Create Procedure SP_Proveedores_Agregar
@cuit_Prov varchar(11),
@razonSocial_Prov varchar(30),
@email_Prov varchar(75),
@localidad_Prov varchar(50),
@Provincia_Prov varchar(2),
@telefono_Prov varchar(20),
@codigoPostal_Prov varchar(5)
as 
begin
insert into Proveedores(cuit_Prov,razonSocial_Prov,email_Prov,localidad_Prov,Provincia_Prov,telefono_Prov,codigoPostal_Prov)
select @cuit_Prov,@razonSocial_Prov,@email_Prov,@localidad_Prov,@Provincia_Prov,@telefono_Prov,@codigoPostal_Prov
end
go

Create Procedure SP_Proveedores_ModificarEstado
@cuit_Prov varchar(11),
@estado_Prov bit
as 
begin
update Proveedores set estado_Prov=@estado_Prov where cuit_Prov=@cuit_Prov
end
go

Create Procedure SP_Proveedores_Actualizar
@cuit_Prov varchar(11),
@razonSocial_Prov varchar(30),
@email_Prov varchar(75),
@localidad_Prov varchar(50),
@Provincia_Prov varchar(2),
@telefono_Prov varchar(20),
@codigoPostal_Prov varchar(5)
as 
begin
update proveedores set razonSocial_Prov=@razonSocial_Prov,email_Prov=@email_Prov,
localidad_Prov=@localidad_Prov,Provincia_Prov=@Provincia_Prov,telefono_Prov=@telefono_Prov,codigoPostal_Prov=@codigoPostal_Prov
where cuit_Prov=@cuit_Prov
end
go
--insertar 10 registros
EXEC SP_Proveedores_Agregar '11111111111', 'Proveedor 1', 'proveedor1@example.com', 'Localidad 1', 'A', '1111111111', '11111';
EXEC SP_Proveedores_Agregar '22222222222', 'Proveedor 2', 'proveedor2@example.com', 'Localidad 2', 'B', '2222222222', '22222';
EXEC SP_Proveedores_Agregar '33333333333', 'Proveedor 3', 'proveedor3@example.com', 'Localidad 3', 'C', '3333333333', '33333';
EXEC SP_Proveedores_Agregar '44444444444', 'Proveedor 4', 'proveedor4@example.com', 'Localidad 4', 'U', '4444444444', '44444';
EXEC SP_Proveedores_Agregar '55555555555', 'Proveedor 5', 'proveedor5@example.com', 'Localidad 5', 'X2', '5555555555', '55555';
EXEC SP_Proveedores_Agregar '66666666666', 'Proveedor 6', 'proveedor6@example.com', 'Localidad 6', 'W', '6666666666', '66666';
EXEC SP_Proveedores_Agregar '77777777777', 'Proveedor 7', 'proveedor7@example.com', 'Localidad 7', 'E', '7777777777', '77777';
EXEC SP_Proveedores_Agregar '88888888888', 'Proveedor 8', 'proveedor8@example.com', 'Localidad 8', 'P', '8888888888', '88888';
EXEC SP_Proveedores_Agregar '99999999999', 'Proveedor 9', 'proveedor9@example.com', 'Localidad 9', 'Y', '9999999999', '99999';
EXEC SP_Proveedores_Agregar '10101010101', 'Proveedor 10', 'proveedor10@example.com', 'Localidad 10', 'L', '1010101010', '10101';

--crear trigger para evitar delete
Create Trigger TG_Proveedores_PrevenirEliminar
on Proveedores
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla Proveedores')
rollback
end
go
delete from Proveedores where cuit_Prov=''