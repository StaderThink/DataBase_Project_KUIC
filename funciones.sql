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

-- evento de desactivación cliente

CREATE EVENT desactivar_cliente
    ON SCHEDULE EVERY 2 Hour DO
    UPDATE cliente SET
        cliente.activo = false
    WHERE NOT EXISTS(
        SELECT fecha FROM pedido
        WHERE 
            fecha >= CURRENT_TIMESTAMP - INTERVAL 3 MONTH AND
            pedido.cliente = cliente.id
        ORDER BY pedido.fecha
    );

-- notificar inactivación

create trigger notificar_desactivacion_cliente after update
on cliente
for each row
begin
    if new.activo = false then
        insert into notificacion(autor, fecha_inicio, fecha_fin, texto)
        values (null, curdate(), curdate() +  interval 2 day, concat('El cliente "', new.nombre, '" ha sido desactivado'));

        -- obtener el id de la notificacion

        select id into @notificacion from notificacion order by notificacion.id desc limit 0, 1;

        -- hacer un select para insertar los segmentos a los cargos

        insert into segmento(notificacion, cargo)
        select @notificacion as notificacion, cargo.id as cargo from cargo
        where cargo.clientes = true or cargo.solicitar = true;
    end if;
end//