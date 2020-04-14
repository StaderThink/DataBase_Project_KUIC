-- cargo

insert into cargo (nombre, pedidos, usuarios, logistica, clientes, solicitar)
values ('programador', true, true, true, true, true);

-- usuario

call crear_usuario(
	'andres camilo', 'celis pacheco', '1000383837', 'CC', '2019-09-22',
	'accelis73@misena.edu.co', 'accelis', 1, '3194028018', '2001-09-22'
);

-- TODO colocar sus datos

-- estado

call crear_estado('pendiente', 1, true);
call crear_estado('registrado', 2, true);
call crear_estado('empacado', 3, true);
call crear_estado('enviado', 4, false);
call crear_estado('en despacho', 5, false);
call crear_estado('entregado', 6, false);