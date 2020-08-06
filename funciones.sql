-- para usar en phpmyadmin, colocar el delimitador en //
-- para usar en mysqlshell, colocar el comando: delimiter // y al finalizar, colocal el comando: delimiter ;

use aurelia//

-- crear usuario

create procedure crear_usuario (
    nombre text, apellido text, documento varchar(10), tipo_documento text,
    nacimiento date, expedicion date, correo text, clave text, cargo int, telefono varchar(10)
)
begin
    insert into usuario(
        nombre, apellido, documento, tipo_documento, expedicion,
        correo, clave, cargo, telefono, nacimiento, activo
    )
    values (
        lower(nombre), lower(apellido), documento, tipo_documento, expedicion,
        lower(correo), clave, cargo, telefono, nacimiento, true
    );
end//

-- desactivar notificaciones

create event desactivar_notificacion
on schedule
	every 1 second
do
	delete from notificacion where fecha_fin <= now();
