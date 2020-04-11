delimiter $$ -- NO TOCAR, dejar al principio

-- crear usuario

create or replace procedure crear_usuario
(
	$nombre text, $apellido text, $documento varchar(10), $tipo_documento enum('CC', 'NIT'),
	$expedicion date, $correo text, $clave text, $cargo int, $telefono varchar(10), $nacimiento date
)
begin
	insert into usuario(
		nombre, apellido, documento, tipo_documento, expedicion,
		correo, clave, cargo, telefono, nacimiento, activo
	)
	values (
			lower($nombre), lower($apellido), $documento, $tipo_documento, $expedicion,
			lower($correo), md5($clave), $cargo, $telefono, $nacimiento, false
		);
end$$

-- crear estado

create or replace procedure crear_estado
(
	$nombre text, $orden tinyint, $cancelable boolean
)
begin
	declare $ultimo tinyint default 0;
	declare $id int;

	select orden into $ultimo from estado
	order by orden desc limit 0, 1;

	insert into estado(nombre, orden, cancelable)
	values ($nombre, $ultimo + 1, $cancelable);

	select id into $id from estado
	order by id desc limit 0, 1;

	call ordenar_estado($id, $orden);
end$$

-- ordenar estado

create or replace procedure ordenar_estado($id int, $orden tinyint)
begin
	declare $restantes int default 0;
	declare $contador int default 1;

	select count(*) into $restantes
	from estado where orden >= $orden;

	if $restantes > 0 then
		while $contador <= $restantes do
			declare $orden_actual tinyint;
			declare $id int;

			set $orden_actual = $contador + $restantes;

			select id into $id from estado
			where orden = $orden_actual;

			update estado set
				orden = $orden_actual + 1
			where id = $id;

			set $contador = $contador + 1;
		end while;
	end if;

	update estado set orden = $orden where id = $id;
end$$

delimiter ; -- NO TOCAR, dejar al final