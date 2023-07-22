use TiendaDeRopa
go
--crear table ImagenesDeProductos

create table ImagenesDeProductos(
ID_imgDP int identity(1,1),
codigoProducto_imgDP varchar(10) NOT NULL,
descripcion_imgDP varchar(50) NOT NULL,
url_imgDP varchar(500) NOT NULL,
estado_imgDP bit default 1 
CONSTRAINT PK_ImagenesDeProductos PRIMARY KEY (ID_imgDP),
CONSTRAINT FK_ImagenesDeProductos_Productos FOREIGN KEY (codigoProducto_imgDP)
REFERENCES Productos(codigo_Prod)
)
--crear procedimientos almacenados de agregar/habilitar-deshabilitar/actuazlizar
Create Procedure SP_ImagenesDeProductos_Agregar
@codigoProducto_imgDP varchar(10),
@descripcion_imgDP varchar(50),
@url_imgDP varchar(500)
as 
begin
insert into ImagenesDeProductos (codigoProducto_imgDP,descripcion_imgDP,url_imgDP)
select @codigoProducto_imgDP,@descripcion_imgDP,@url_imgDP
end
go

Create Procedure SP_ImagenesDeProductos_ModificarEstado
@ID_imgDP int,
@estado_imgDP bit
as 
begin
update ImagenesDeProductos set estado_imgDP=@estado_imgDP where ID_imgDP = @ID_imgDP
end
go

Create Procedure SP_ImagenesDeProductos_Actualizar
@ID_imgDP int,
@codigoProducto_imgDP varchar(10),
@descripcion_imgDP varchar(50),
@url_imgDP varchar(500)
as 
begin
update ImagenesDeProductos
set
codigoProducto_imgDP=@codigoProducto_imgDP,
descripcion_imgDP=@descripcion_imgDP,
url_imgDP=@url_imgDP
where ID_imgDP = @ID_imgDP
end
go
exec SP_ImagenesDeProductos_Agregar 'ACOD1','Es un pantalon verder','https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2022/03/28/16484663750450.jpg'
exec SP_ImagenesDeProductos_Agregar 'ACOD2','Es una gorra azul','https://ih1.redbubble.net/image.2645525805.5678/ssrco,baseball_cap,product,161D36:1628f0f39d,front,square,600x600-bg,f8f8f8.jpg'
exec SP_ImagenesDeProductos_Agregar 'ACOD3','Es un sueter negro','https://i.ebayimg.com/thumbs/images/g/24cAAOSw0z5hjWmK/s-l300.jpg'
exec SP_ImagenesDeProductos_Agregar 'ACOD4','Zapatillas blancas','https://d3ugyf2ht6aenh.cloudfront.net/stores/102/392/products/img_46871-47bf0531826f36fd8f16279035686737-640-0.webp'
exec SP_ImagenesDeProductos_Agregar 'ACOD5','Medias de Los simpson','https://tap-multimedia-1172.nyc3.digitaloceanspaces.com/productimage/42184/100000150158.jpg'
exec SP_ImagenesDeProductos_Agregar 'ACOD6','Bufanda celeste','https://d2r9epyceweg5n.cloudfront.net/stores/001/973/184/products/tempimage8nhyyp1-c167f3707b40918e2b16812474496865-1024-1024.webp'
exec SP_ImagenesDeProductos_Agregar 'ACOD7','short de baño rojo ','https://d3ugyf2ht6aenh.cloudfront.net/stores/118/810/products/picsart_21-12-30_11-10-51-604-d41fe07675bc91742e16408735150440-640-0.webp'
exec SP_ImagenesDeProductos_Agregar 'ACOD8','Campera de river','https://rossettiar.vtexassets.com/arquivos/ids/485540-800-auto?v=638210091293930000&width=800&height=auto&aspect=true'
exec SP_ImagenesDeProductos_Agregar 'ACOD9','Camiseta del real madrid','https://newsport.vtexassets.com/arquivos/ids/16186331/HF0291-A.jpg?v=638216609495230000'
exec SP_ImagenesDeProductos_Agregar 'ACOD10','Boxer blanco','https://andezoficial.com.ar/wp-content/uploads/2023/07/2-900x1133.png'

--select * from ImagenesDeProductos

/*Trigger para evitar eliminar registros en la tabla provincias*/
Create Trigger TG_ImagenesDeProductos_PrevenirEliminar
on ImagenesDeProductos
instead of Delete
as begin
Print('No esta permitido eliminar en la tabla ImagenesDeProductos')
rollback
end
go
--delete from ImagenesDeProductos where ID_imgDP = 102