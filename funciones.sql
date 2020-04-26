delimiter $$ -- NO TOCAR, dejar al principio

-- crear usuario

create procedure crear_usuario (
	$nombre text, $apellido text, $documento varchar(10), $tipo_documento text,
	$expedicion date, $correo text, $clave text, $cargo int, $telefono varchar(10), $nacimiento date
)
begin
	insert into usuario(
		nombre, apellido, documento, tipo_documento, expedicion,
		correo, clave, cargo, telefono, nacimiento, activo
	)
	values (
		lower($nombre), lower($apellido), $documento, $tipo_documento, $expedicion,
		lower($correo), $clave, $cargo, $telefono, $nacimiento, false
	);
end$$

-- ordenar estado

create procedure ordenar_estado($id int, $orden tinyint)
begin
	select orden into @actual from estado where id = $id;

	set sql_safe_updates = false; -- seguridad de sql

	if @actual = 0 then
		update estado set orden = orden + 1 where orden >= $orden;
	else
		update estado set orden = 0 where id = $id;

		-- actualizar el bloque

		update estado set orden = orden + 1
		where orden between least(@actual, $orden) and greatest(@actual, $orden);
	end if;
	
	set sql_safe_updates = true;

	update estado set orden = $orden where id = $id;
end$$

-- crear estado

create procedure crear_estado (
	$nombre text, $orden tinyint, $cancelable boolean
)
begin
	insert into estado(nombre, orden, cancelable)
	values ($nombre, 0, $cancelable);

	select id into @id from estado
	order by id desc limit 0, 1;

	call ordenar_estado(@id, $orden);
end$$

delimiter ; -- NO TOCAR, dejar al final