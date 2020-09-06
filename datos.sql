use aurelia;

-- cargo

insert into cargo (nombre, pedidos, usuarios, logistica, clientes, solicitar)
values
    ('administrador', true, true, true, true, true),
    ('gerente', false, true, false, true, false),
    ('supervisor', true, false, false, true, false),
    ('coordinador logístico', false, false, true, false, false),
    ('asesor', false, false, false, false, true);

-- usuario

call crear_usuario('administrador', '', '0000000', 'CC', '2019-01-01', '2019-01-01', 'aureliaproyecto@gmail.com', 'JfMtst71', 1, '0000');
