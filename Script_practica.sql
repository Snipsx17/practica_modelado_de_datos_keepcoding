-- SCRIPT PARA LA CREACION DE LA BASE DE DATOS DE LA FLOTA DE VEHICULOS DE KEEPCODING
create schema if not exists keepcoding;

-- CREAMOS LAS TABLAS
drop table if exists keepcoding.coches;
create table keepcoding.coches(
	matricula varchar(7) primary key,
	modelo varchar(15) not null,
	"year" integer not null,
	color integer not null,
	kilometros integer not null,
	numero_poliza varchar(10) not null unique,
	fecha_compra date not null
);

drop table if exists keepcoding.coche_revision;
create table keepcoding.coche_revision(
	id_revision_coche Serial primary key,
	matricula varchar(7) not null,
	id_revision integer not null
);

drop table if exists keepcoding.revision;
create table keepcoding.revision(
	id Serial primary key,
	fecha_revision date not null,
	importe numeric not null,
	moneda integer not null,
	kilometros integer not null,
	apto bool not null
);

drop table if exists keepcoding.moneda;
create table keepcoding.moneda(
	id Serial primary key,
	moneda varchar(10) not null unique,
	simbolo varchar(1) not null unique
);

drop table if exists keepcoding.modelos_coches;
create table keepcoding.modelos_coches(
	id_modelo Serial primary key,
	modelo varchar(15) not null unique,
	marca varchar(15) not null
	
);

drop table if exists keepcoding.marcas;
create table keepcoding.marcas(
	marca varchar(15) primary key,
	grupo_empresarial integer not null
);

drop table if exists keepcoding.grupo_empresarial;
create table keepcoding.grupo_empresarial(
	id Serial primary key,
	nombre varchar(15) not null unique
);

drop table if exists keepcoding.colores_coches;
create table keepcoding.colores_coches(
	id_color Serial primary key,
	color varchar(10) not null
);

drop table if exists keepcoding.polizas;
create table keepcoding.polizas(
	numero_poliza varchar(10) primary key,
	aseguradora integer not null,
	fecha_inicio date not null
);

drop table if exists keepcoding.aseguradoras;
create table keepcoding.aseguradoras(
	id_aseguradora Serial primary key,
	nombre_aseguradora varchar(25) not null unique
);

-- RELACIONES
alter table keepcoding.coche_revision add constraint matricula_revision_fk foreign key (matricula) references keepcoding.coches(matricula);
alter table keepcoding.coche_revision add constraint id_revision_fk foreign key (id_revision) references keepcoding.revision(id);
alter table keepcoding.revision add constraint id_moneda_fk foreign key (moneda) references keepcoding.moneda(id);
alter table keepcoding.coches add constraint modelo_fk foreign key (modelo) references keepcoding.modelos_coches(modelo);
alter table keepcoding.coches add constraint color_fk foreign key (color) references keepcoding.colores_coches(id_color);
alter table keepcoding.coches add constraint num_poliza_fk foreign key (numero_poliza) references keepcoding.polizas(numero_poliza);
alter table keepcoding.modelos_coches add constraint marca_fk foreign key (marca) references keepcoding.marcas(marca);
alter table keepcoding.marcas add constraint grupo_empresarial_fk foreign key (grupo_empresarial) references keepcoding.grupo_empresarial(id);
alter table keepcoding.polizas add constraint aseguradora_fk foreign key (aseguradora) references keepcoding.aseguradoras(id_aseguradora);

-- AGREGAMOS DATOS
insert into keepcoding.colores_coches( color ) values ('rojo'), ('azul'), ('verde'), ('blanco'),('negro'), ('plata');

insert into keepcoding.aseguradoras ( nombre_aseguradora ) values ('mapfre'), ('allianz'), ('mutua madrileña'),
('axa'), ('linea directa'), ('catalana occidente'), ('generali'), ('helvetica'), ('reale'), ('liberty'), ('zurich'),
('regal'), ('interauto');

insert into keepcoding.polizas( numero_poliza, aseguradora, fecha_inicio ) values ( '0385717401', 1, '2012-10-01' ), 
( '2934719483', 2, '2013-11-12' ), ( '1847294846', 3, '2014-12-15' ),( '2927461947', 5, '2016-02-13' ), 
( '8126374654', 6, '2017-08-08' ), ( '2836122398', 7, '2018-06-24' ), ( '8351746523', 8, '2019-04-16' ), 
( '9284528592', 9, '2020-11-17' ), ( '1324654234', 10, '2021-03-04' ),( '0234125345', 11, '2022-09-24' ), 
( '1823453563', 12, '2018-09-28' ), ( '1534556345', 13, '2014-12-01' ), ( '3245345654', 1, '2015-03-22' ), 
( '1763425464', 2, '2019-05-27' ), ( '2435765432', 3, '2019-02-15' ),( '3234165432', 5, '2021-04-17' ), 
( '3763549123', 6, '2015-04-07' ), ( '6348234612', 7, '2016-10-21' ), ( '4323416546', 8, '2012-07-29' ), 
( '0912564326', 9, '2021-04-12' ), ( '3216542345', 10, '2022-03-07' ),( '2323234512', 11, '2016-08-17' ), 
( '4352617283', 12, '2023-01-12' ), ( '1113245634', 13, '2013-07-07' ), ( '2342376895', 4, '2017-03-24' ), 
( '3224212345', 4, '2021-09-08' );

insert into keepcoding.grupo_empresarial( nombre ) values ('volkswagen'),('stellantis'),('honda'),('daimler'),
('ford'),('hyundai'),('toyota'),('tata'),('bmw group'),('nissan'), ('renault'), ('geely'),('gm');

insert into keepcoding.marcas( marca, grupo_empresarial ) values ('volkswagen', 1 ),('skoda',1 ),('seat', 1),
('porche', 1),('lamborghini',1 ),('bugatti', 1),('bentley', 1),('audi', 1),('fiat', 2),('chrysler', 2),
('opel',2 ),('vauxhall',2 ),('citroen',2 ),('ds',2 ),('peugeot',2 ),('honda', 3),('acura', 3),('mercedes benz', 4),
('smart', 4),('ford', 5),('lincon', 5),('kia', 6),('hyundai', 6),('genesis', 6),('toyota', 7),('lexus', 7),('daihatsu', 7),
('tata', 8),('land rover',8 ),('jaguar', 8),('rolss royce', 9),('mini', 9),('bmw', 9),('infiniti', 10),('nissan', 10),
('datsu', 10),('mitsubishi', 10),('venuncia', 11),('alpine', 11),('lada', 11),('dacia', 11),('renault', 11),('samsung', 11),
('geely', 12),('london taxi', 12),('volvo', 12),('proton', 12),('lotus', 12),('lynk&co', 12),('baojuin', 13),('buick', 13),
('cadilac', 13),('chevrolet', 13),('gmg', 13),('holden', 13),('wiling motors', 13);

insert into keepcoding.modelos_coches( marca, modelo ) values ('volkswagen', 'Golf'), ('volkswagen', 'Polo'), ('volkswagen', 'Passat'),
('volkswagen', 'Tiguan'), ('bmw', '3 Series'), ('bmw', '5 Series'), ('bmw', 'X5'), ('mercedes benz', 'C-Class'),
('mercedes benz', 'E-Class'),('mercedes benz', 'GLC'),('mercedes benz', 'A-Class'),('audi', 'A4'),('audi', 'Q5'),('audi', 'A6'),
('renault', 'Clio'), ('renault', 'Megane'), ('renault', 'Captur'),('peugeot', '208'), ('peugeot', '308'),('peugeot', '3008'),
('ford', 'Focus'), ('ford', 'Fiesta'),('ford', 'Escape'), ('fiat', '500'),('fiat', 'Panda'),('fiat', 'Tipo'),('volvo', 'XC60'),
('volvo', 'V40'),('volvo', 'S60'),('seat', 'Leon'),('seat', 'Ibiza');

INSERT INTO keepcoding.coches (matricula, modelo, "year", color, kilometros, numero_poliza, fecha_compra)
VALUES
  ('AB123CD', 'Golf', 2020, 1, 15000, '0385717401', '2020-01-15'),
  ('XY456YZ', 'Polo', 2019, 2, 18000, '2934719483', '2019-02-20'),
  ('GH789IJ', 'Passat', 2021, 3, 10000, '1847294846', '2021-03-25'),
  ('LM101NO', 'Tiguan', 2022, 4, 8000, '2342376895', '2022-04-10'),
  ('QR202ST', '3 Series', 2020, 1, 12000, '2927461947', '2020-05-05'),
  ('UV303WX', '5 Series', 2019, 2, 16000, '8126374654', '2019-06-10'),
  ('YZ404AB', 'X5', 2021, 3, 9000, '2836122398', '2021-07-15'),
  ('CD505EF', 'C-Class', 2022, 4, 7000, '8351746523', '2022-08-20'),
  ('GH606IJ', 'E-Class', 2020, 1, 11000, '9284528592', '2020-09-25'),
  ('KL707MN', 'GLC', 2019, 2, 13000, '1324654234', '2019-10-30'),
  ('OP808QR', 'A4', 2021, 3, 9500, '0234125345', '2021-11-05'),
  ('ST909UV', 'Q5', 2022, 4, 8500, '1823453563', '2022-12-10'),
  ('WX010YZ', 'A6', 2020, 1, 10500, '1534556345', '2020-01-15'),
  ('AB111CD', 'Clio', 2019, 2, 14000, '3245345654', '2019-02-20'),
  ('XY212YZ', 'Megane', 2021, 3, 9500, '1763425464', '2021-03-25'),
  ('GH313IJ', 'Captur', 2022, 4, 8000, '2435765432', '2022-04-10'),
  ('LM414NO', '208', 2020, 1, 12000, '3224212345', '2020-05-05'),
  ('QR515ST', '308', 2019, 2, 16000, '3234165432', '2019-06-10'),
  ('UV616WX', '3008', 2021, 3, 9000, '3763549123', '2021-07-15'),
  ('YZ717AB', 'Focus', 2022, 4, 7000, '6348234612', '2022-08-20'),
  ('CD818EF', 'Fiesta', 2020, 1, 11000, '4323416546', '2020-09-25'),
  ('GH919IJ', 'Escape', 2019, 2, 13000, '0912564326', '2019-10-30'),
  ('KL020MN', '500', 2021, 3, 9500, '3216542345', '2021-11-05'),
  ('OP121QR', 'Panda', 2022, 4, 8500, '2323234512', '2022-12-10'),
  ('ST222UV', 'Tipo', 2020, 1, 10500, '4352617283', '2020-01-15');
 
 insert into keepcoding.moneda( moneda, simbolo ) values ('EU', '€'), ('USD', '$');
 
 insert into keepcoding.revision(fecha_revision, importe, moneda, kilometros, apto ) values 
 	('2023-01-15', 154.60, 1, 7500, true), ('2023-06-15', 154.60, 1, 15000, true),
 	('2022-12-10', 146.90, 1, 1287, true), ('2023-05-20', 146.90, 1, 18000, true),
 	('2023-02-07', 96.10, 1, 7450, false), ('2023-07-30', 98.30, 1, 10000, true),
 	('2023-03-05', 265.37, 1, 3598, true), ('2023-08-10', 264.56, 1, 8000, true),
 	('2022-09-14', 245.80, 1, 6395, true), ('2023-09-01', 254.80, 1, 12000, true),
 	('2022-07-08', 254.60, 1, 7534, true), ('2023-07-10', 254.60, 1, 16000, false),
 	('2021-06-29', 235.56, 1, 5487, true), ('2022-09-03', 235.56, 1, 9000, true),
 	('2022-12-28', 197.34, 1, 3460, true), ('2023-06-28', 197.60, 1, 7000, true),
 	('2022-07-23', 168.23, 1, 9834, true), ('2023-07-01', 168.23, 1, 11000, false),
 	('2020-11-17', 234.54, 1, 8365, false), ('2023-01-16', 245.87, 1, 13000, true),
 	('2021-10-14', 152.54, 1, 6500, false), ('2022-12-11', 153.66, 1, 95000, true),
 	('2022-02-23', 187.34, 1, 6540, true), ('2023-02-20', 187.98, 1, 8500, true),
 	('2021-07-18', 174.87, 1, 6987, true), ('2022-10-29', 184.90, 1, 10500, true),
 	('2021-03-13', 55.98, 1, 10400, true), ('2022-06-15', 5.98, 1, 14000, true),
 	('2022-04-27', 54.10, 1, 7545, true), ('2023-04-04', 54.20, 1, 9500, true),
 	('2022-05-12', 97.00, 1, 5360, true), ('2023-06-03', 97.00, 1, 8000, true),
 	('2021-08-15', 34.70, 1, 8900, true), ('2022-12-12', 34.70, 1, 12000, true),
 	('2020-08-19', 37.60, 1, 12756, true), ('2022-07-19', 42.50, 1, 16000, true),
 	('2022-07-15', 64.00, 1, 7600, true), ('2023-06-15', 64.00, 1, 9000, true),
 	('2022-08-25', 53.60, 1, 5500, true), ('2023-07-30', 54.60, 1, 7000, true),
 	('2021-09-20', 42.00, 1, 9450, true), ('2023-01-19', 42.60, 1, 11000, true),
 	('2019-10-30', 33.70, 1, 10040, true), ('2022-11-17', 33.70, 1, 13000, true),
 	('2022-01-09', 61.00, 1, 4770, true), ('2023-02-25', 61.00, 1, 9500, true),
 	('2022-12-15', 34.60, 1, 5500, true), ('2023-06-28', 34.60, 1, 8500, true),
 	('2021-11-19', 36.90, 1, 9500, true), ('2023-01-20', 36.90, 1, 10500, true);
 	
insert into keepcoding.coche_revision(matricula, id_revision) values 
	( 'AB123CD', 1 ), ( 'AB123CD', 2 ), ( 'XY456YZ', 3 ), ( 'XY456YZ', 4 ), 
	( 'GH789IJ', 5 ), ( 'GH789IJ', 6 ), ( 'LM101NO', 7 ), ( 'LM101NO', 8 ),
	( 'QR202ST', 9 ), ( 'QR202ST', 10 ), ( 'UV303WX', 11 ), ( 'UV303WX', 12 ),
	( 'YZ404AB', 13 ), ( 'YZ404AB', 14 ), ( 'CD505EF', 15 ), ( 'CD505EF', 16 ),
	( 'GH606IJ', 17 ), ( 'GH606IJ', 18 ), ( 'KL707MN', 19 ), ( 'KL707MN', 20 ),
	( 'OP808QR', 21 ), ( 'OP808QR', 22 ), ( 'ST909UV', 23 ), ( 'ST909UV', 24 ),
	( 'WX010YZ', 25 ), ( 'WX010YZ', 26 ), ( 'AB111CD', 27 ), ( 'AB111CD', 28 ),
	( 'XY212YZ', 29 ), ( 'XY212YZ', 30 ), ( 'GH313IJ', 31 ), ( 'GH313IJ', 32 ),
	( 'LM414NO', 33 ), ( 'GH313IJ', 34 ), ( 'QR515ST', 35 ), ( 'QR515ST', 36 ),
	( 'UV616WX', 37 ), ( 'UV616WX', 38 ), ( 'YZ717AB', 39 ), ( 'YZ717AB', 40 ),
	( 'CD818EF', 41 ), ( 'CD818EF', 42 ), ( 'GH919IJ', 43 ), ( 'GH919IJ', 44 ),
	( 'KL020MN', 45 ), ( 'KL020MN', 46 ), ( 'OP121QR', 47 ), ( 'OP121QR', 48 ),
	( 'ST222UV', 49 ), ( 'ST222UV', 50 );
	
-- LISTADO 
select mc.modelo, mc.marca, ge.nombre as "grupo empresarial", c.fecha_compra
as "fecha de compra", c.matricula, cc.color, c.kilometros, c.numero_poliza as "poliza numero", a.nombre_aseguradora as "empresa aseguradora"
from keepcoding.modelos_coches mc join keepcoding.coches c on mc.modelo = c.modelo
join keepcoding.marcas m on m.marca = mc.marca
join keepcoding.grupo_empresarial ge on m.grupo_empresarial = ge.id
join keepcoding.colores_coches cc on c.color = cc.id_color
join keepcoding.polizas p on c.numero_poliza = p.numero_poliza
join keepcoding.aseguradoras a on p.aseguradora = a.id_aseguradora
order by mc.modelo ASC;
