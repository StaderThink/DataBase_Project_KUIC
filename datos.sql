insert into cargo (nombre, pedidos, usuarios, logistica, clientes, solicitar)
values ('programador', true, true, true, true, true);

insert into usuario(
	nombre, apellido, documento, tipo_documento, expedicion, correo, clave, cargo, telefono, nacimiento, activo
)
values
	('andres camilo', 'celis pacheco', '1000383837', 'CC', '22-09-2019', 'accelis73@misena.edu.co', md5('accelis'), 1, '3194028018', '22-09-2001', true);

insert into estado(nombre, orden, cancelable)
values
	('pendiente', 1, true),
	('registrado', 2, true),
	('empacado', 3, true),
	('enviado', 4, false),
	('en despacho', 5, false),
	('entregado', 6, false);