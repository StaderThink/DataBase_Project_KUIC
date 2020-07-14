create database aurelia;

use aurelia;

-- tablas

create table producto(
    id int primary key auto_increment not null,
    nombre text not null,
    descripcion text,
    codigo varchar(5) not null, -- uq
    precio double not null,
    min_cantidad int not null,
    min_peso double not null,
    max_peso double not null,
    magnitud enum('kg', 'gr', 'lb') not null,
    existencias int not null,
    presentacion enum('bandeja', 'granel', 'caja', 'bolsa', 'paquete') not null,
    categoria int not null -- fk
);

create table categoria(
    id int primary key auto_increment not null,
    nombre text not null,
    descripcion text
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
    cargo int not null, -- fk
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
    creado date not null default(curdate()),
    actualizado date not null default(curdate()),
    activo boolean not null default(false)
);

create table entrada(
    id int primary key auto_increment not null,
    fecha datetime not null default(curdate()),
    observacion text
);

create table detalle_entrada(
    id int primary key auto_increment not null,
    cantidad int not null,
    entrada int not null, -- fk
    producto int not null -- fk
);

create table salida(
    id int primary key auto_increment not null,
    fecha datetime not null default(curdate()),
    observacion text,
    pedido int -- fk 
);

create table detalle_salida(
    id int primary key auto_increment not null,
    cantidad int not null,
    salida int not null, -- fk
    producto int not null -- fk
);

create table pedido(
    id int primary key auto_increment not null,
    fecha datetime not null default(curdate()),
    activo bit, 
    descuento double not null,
    observacion text,
    estado enum('pendiente', 'autorizado', 'despachado', 'entregado') not null, 
    cliente int not null, -- fk
    asesor int not null -- fk
);

create table detalle_pedido(
    id int primary key auto_increment not null,
    cantidad int not null, 
    pedido int not null, -- fk
    producto int not null -- fk
);

create table notificacion(
    id int primary key auto_increment not null,
    texto text not null,
    fecha_inicio datetime not null default(curdate()),
    fecha_fin datetime,
    autor int not null -- fk
);

create table segmento(
    id int primary key auto_increment not null,
    notificacion int not null, -- fk
    cargo int not null -- fk
);

-- restricciones

alter table producto add constraint uq_codigo unique(codigo);
alter table producto add foreign key (categoria) references categoria(id);

alter table usuario add constraint uq_documento unique(documento);
alter table usuario add foreign key (cargo) references cargo(id);

alter table cliente add constraint uq_rut unique(rut);

alter table detalle_entrada add foreign key (entrada) references entrada(id);
alter table detalle_entrada add foreign key (producto) references producto(id);

alter table salida add foreign key (pedido) references pedido(id);

alter table detalle_salida add foreign key (salida) references salida(id);
alter table detalle_salida add foreign key (producto) references producto(id);

alter table pedido add foreign key (cliente) references cliente(id);
alter table pedido add foreign key (asesor) references usuario(id);

alter table detalle_pedido add foreign key (pedido) references pedido(id);
alter table detalle_pedido add foreign key (producto) references producto(id);

alter table notificacion add foreign key (autor) references usuario(id);

alter table segmento add foreign key (notificacion) references notificacion(id);
alter table segmento add foreign key (cargo) references cargo(id);
