create database aurelia;

create table producto(
	id int primary key auto_increment not null,
	nombre text not null,
	descripcion text,
	codigo varchar(5), -- uq
	precio double not null,
	min_cantidad int not null,
	min_peso double not null,
	max_peso double not null,
	magnitud enum('kg', 'gr', 'lb') not null,
	presentacion enum('') not null, -- TODO
	categoria int -- fk
);

create table categoria(
	id int primary key auto_increment not null,
	nombre text not null,
	descripcion text
);

create table existencia(
	id int primary key auto_increment not null,
	producto int not null, -- fk
	cantidad int not null
);

create table usuario(
	id int primary key auto_increment not null,
	nombre text not null,
	apellido text not null,
	documento varchar(10), -- uq
	tipo_documento enum('CC', 'NIT') not null,
	expedicion date not null,
	correo text not null,
	clave text not null,
	cargo int, -- fk
	telefono varchar(10) not null,
	nacimiento date not null,
	creado date not null default(curdate()),
	actualizado date not null default(curdate()),
	activo boolean not null default(false)
);

create table cargo(
	id int primary key auto_increment not null,
	nombre text not null,
	pedidos boolean not null default(false),
	usuario boolean not null default(false),
	logistica boolean not null default(false),
	clientes boolean not null default(false),
	solicitar boolean not null default(false)
);

create table cliente(
	id int primary key auto_increment not null,
	nombre text not null,
	encargado text not null,
	rut varchar(11), -- uq
	correo text not null,
	direccion text not null,
	telefono varchar(10) not null,
	creado date not null,
	actualizado date not null,
	activo boolean not null default(false)
);

-- TODO: cliente, entrada, detalle_entrada, salida, detalle_salida, pedido, detalle_pedido, estado, notificacion y segmento

-- TODO: restricciones