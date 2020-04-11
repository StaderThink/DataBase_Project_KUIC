create database aurelia;

-- tablas

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
	categoria int not null-- fk
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
	cargo int , -- fk
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
	usuarios boolean not null default(false),
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

create table entrada(
	id int primary key auto_increment not null,
	fecha datetime not null,
	observacion text,
);

create table detalle_entrada(
	id int primary key auto_increment not null,
	cantidad int not null,
	entrada int not null, -- fk
	producto int not null, -- fk
);

create table salida(
	id int primary key auto_increment not null,
	fecha datetime not null,
	observacion text,
	pedido int not null, -- fk 
);

create table detalle_salida(
	id int primary key auto_increment not null,
	cantidad int not null,
	salida int not null, -- fk
	producto int not null, -- fk
);

create table pedido(
	id int primary key auto_increment not null,
	fecha datetime not null,
	cancelado bit, 
	descuento double not null,
	observacion text,
	cliente int not null, -- fk
	asesor int not null, -- fk
	estado int not null, -- fk 
);

create table detalle_pedido(
	id int primary key auto_increment not null,
	cantidad int not null, 
	pedido int not null, -- fk
	producto int not null, -- fk
);

create table estado(
	id int primary key auto_increment not null,
	nombre text not null,
	orden tinyint not null,
	cancelable bit not null
);

create table notificacion(
	id int primary key auto_increment not null,
	texto text not null,
	fecha_inicio datetime not null,
	fecha_fin datetime,
	autor int , -- fk
);

create table segmento(
	id int primary key auto_increment not null,
	notificacion int not null, -- fk
	cargo int not null, -- fk 
);

-- restricciones

-- TODO