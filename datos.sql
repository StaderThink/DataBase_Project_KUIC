-- cargo

insert into cargo (nombre, pedidos, usuarios, logistica, clientes, solicitar)
values ('programador', true, true, true, true, true);

-- usuario

call crear_usuario(
	'andres camilo', 'celis pacheco', '1000383837', 'CC', '22-09-2019',
	'accelis73@misena.edu.co', 'accelis', 1, '3194028018', '22-09-2001'
);

-- estado

call crear_estado('pendiente', 1, true);
call crear_estado('registrado', 2, true);
call crear_estado('empacado', 3, true);
call crear_estado('enviado', 4, false);
call crear_estado('en despacho', 5, false);
call crear_estado('entregado', 6, false);