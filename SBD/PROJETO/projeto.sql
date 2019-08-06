create SCHEMA projeto;
SET search_path to projeto;
SET datestyle to DMY;


create TABLE usuario(
	CPF varchar(50) not null,
	nome varchar(50) ,
	endereco varchar(50),
	data_nasc date,
	constraint usuariopk PRIMARY KEY (CPF)
);

create TABLE ENTREGADOR(
	placa varchar(50),
	capacidade smallint, 
	salario_hora money,
	CNH varchar(5),
	Veiculo varchar(50),
	CPF varchar(50) not null,
	
	constraint entregadorfpk PRIMARY KEY(CPF),
	constraint entregadorfk FOREIGN KEY(CPF)
			references usuario(CPF)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

create TABLE ANIMADOR(
	preco_30min money,
	nomeartistisco varchar(50),
	biografia varchar(500),
	CPF varchar(50) not null,
	
	constraint animadorfpk PRIMARY KEY(CPF),
	constraint animadorfk FOREIGN KEY(CPF)
			references usuario(CPF)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

create TABLE dono(
	linkedin varchar(50),
	CPF varchar(50) not null,
	constraint donofpk PRIMARY KEY(CPF),
	constraint donofk FOREIGN KEY(CPF)
			references usuario(CPF)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

create TABLE consumidor_faminto(
	end_entrega varchar(50),
	CPF varchar(50) not null,
	constraint consumidorfpk PRIMARY KEY(CPF),
	constraint consumidorfk FOREIGN KEY(CPF)
			references usuario(CPF)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

create table pizzaria(
	nome varchar(50),
	id_dn varchar(50),
	cep varchar(50),
	abertura time,
	fechamento time,
	telefone varchar(50),
	site varchar(50),
	constraint pizzariafk FOREIGN KEY(id_dn)
		references dono(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	constraint pizzariapk PRIMARY KEY(nome)
);

create table categoria(
    cod smallint,
    nome varchar(50),
    cod_h smallint,

    CONSTRAINT categoriapk PRIMARY KEY(cod),
    CONSTRAINT categoriafk FOREIGN KEY(cod_h)
        REFERENCES categoria(cod)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE pizza(
    nome varchar(50),
    nome_p varchar(50),
    cat smallint,
    preco money,

    CONSTRAINT pizzafk FOREIGN KEY(cat)
        REFERENCES categoria(cod)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
    CONSTRAINT pizzapfk FOREIGN key(nome_p)
        REFERENCES pizzaria(nome)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
    CONSTRAINT pizzapk PRIMARY KEY(nome, nome_p)
);

CREATE TABLE pedido(
    id_p smallint,
    data date,
    horario time,
    h_entrega time,
    qtde SMALLINT,
    custo_total money,
    tipo varchar(50),
    cliente varchar(50),
 CONSTRAINT pedidopk PRIMARY KEY(id_p),
    CONSTRAINT pedidofk FOREIGN KEY(cliente)
        REFERENCES consumidor_faminto(CPF)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE pedido_entretenimento(
    id_p SMALLINT,
    tipo_e varchar(50),
    duracao time,
    animador varchar(50),

    constraint pedido_ePK PRIMARY KEY(id_p),
    CONSTRAINT pedido_efk FOREIGN KEY(animador)
        REFERENCES animador(CPF)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
    CONSTRAINT pedido_ePFK FOREIGN KEY(id_p)
        REFERENCES pedido(id_p)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE ingrediente(
    cod SMALLINT,
    nome varchar(50),
    preco money,
    CONSTRAINT ingredientePK PRIMARY KEY(cod)
);

CREATE TABLE acompanhamento(
    cod SMALLINT,
    nome_p VARCHAR(50),
    nome VARCHAR(50),
    descricao VARCHAR(50),
    tipo varchar(50),
    preco money,
    CONSTRAINT acompPK PRIMARY KEY(cod, nome_p),
    CONSTRAINT acompPFK FOREIGN KEY(nome_p)
        REFERENCES pizzaria(nome)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Trabalha(
	Animador varchar (50),
	Pizzaria varchar (50),
	Disponibilidade varchar(50),
	
	Constraint trabFK FOREIGN KEY (Animador)
		REFERENCES Animador(CPF)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT trabPFK FOREIGN KEY (Pizzaria)
		REFERENCES Pizzaria(nome)
		ON UPDATE CASCADE
  		ON DELETE CASCADE,
	CONSTRAINT trabPK PRIMARY KEY (Animador, Pizzaria) );

CREATE TABLE contem(
    pedido SMALLINT,
    nome VARCHAR(50),
    pizzaria varchar(50),
    massa VARCHAR(50),
    borda VARCHAR(50),
    molho VARCHAR(50),
    CONSTRAINT contemFK FOREIGN KEY(nome, pizzaria)
        REFERENCES pizza(nome, nome_p),
    CONSTRAINT contemPFK FOREIGN KEY(pedido)
        REFERENCES pedido(id_p),
    CONSTRAINT contemPK PRIMARY KEY(pedido,nome,pizzaria)
);

CREATE TABLE tem(
	Ingrediente SMALLINT,
	Pedido SMALLINT,
	Nome varchar(50),
	Pizzaria varchar(50),

	CONSTRAINT temPFK FOREIGN KEY(ingrediente)
		References Ingrediente(Cod)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT temPFK1 FOREIGN KEY(Pedido, Nome, Pizzaria)
		REFERENCES Contem(pedido, nome, pizzaria)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT temPK PRIMARY KEY(Ingrediente, Pedido, Nome, Pizzaria)
);

create table tem_acomp(
id_p smallint,
cod_acomp smallint,
pizzaria varchar(50),
qtd smallint,

constraint fk_tem_acomp foreign key (cod_acomp, pizzaria) references acompanhamento(cod, nome_p)
   	 ON UPDATE CASCADE
   	 ON DELETE CASCADE,
   	 FOREIGN KEY (id_p) REFERENCES PEDIDO(id_p)
   	 ON UPDATE CASCADE
   	 ON DELETE CASCADE
);

-- Todos gatilhos e procedimentos abaixo s�o usados para calcular o pre�o total do pedido, somando o valor das pizzas pedidas, dos acompanhamentos e dos ingredientes extras

create or replace function calcula_pizza()
returns trigger as $$
begin
update pedido
set custo_total = custo_total + (
    select  p.preco
    from pizza p, contem c
    where p.nome = c.nome and p.nome_p = c.pizzaria
    and c.nome = new.nome and c.pizzaria = new.pizzaria
    and c.pedido = new.pedido

) where id_p = new.pedido;


    return NULL;
end $$ language 'plpgsql';


create trigger calcula_pizza_trigger
after insert on contem
for each row
execute procedure calcula_pizza();



create or replace function calcula_acomp()
returns trigger as $$
begin
update pedido
set custo_total = custo_total + (
    select  a.preco
    from acompanhamento a, tem_acomp c
    where a.nome_p = c.pizzaria and a.cod = c.cod_acomp
    and c.cod_acomp = new.cod_acomp and c.pizzaria = new.pizzaria
    and c.id_p = new.id_p
)*qtd
where id_p = new.id_p;


    return NULL;
end $$ language 'plpgsql';


create trigger calcula_acomp_trigger
after insert on tem_acomp
for each row
execute procedure calcula_acomp();



create or replace function calcula_ing()
returns trigger as $$
declare aux real;
begin
 select ing.preco
 into aux
 from tem t,ingrediente ing, contem c
 where t.ingrediente = ing.cod and t.ingrediente = new.ingrediente and
    c.pedido = t.pedido and c.pedido = new.pedido;
    
    update pedido
    set custo_total = custo_total + aux
    where id_p = new.pedido;

return NULL;
end $$ language 'plpgsql';


create trigger calcula_ing_trigger
after insert on tem
for each row
execute procedure calcula_ing();


create or replace function calcula_anim()
returns trigger as $$
declare aux varchar(50);
begin

    select nomeartistisco
    into aux
    from animador an, pedido_entretenimento p_e, pedido p
    where p_e.id_p = p.id_p and p_e.animador = an.CPF and p_e.animador = new.animador
    and p_e.id_p = new.id_p;
    
    update pedido
    set custo_total = (custo_total)::numeric + (calcula_din_hr(aux))::numeric
    where id_p = new.id_p;

    return NULL;
end $$ language 'plpgsql';


create or replace function calcula_din_hr(IN nome animador.nomeartistisco%TYPE, out valor real)
as $$
declare tempo time;
begin
   			 select sum(p_e.duracao)
   		   	 into tempo
   		   	 from animador a, pedido_entretenimento p_e
   			 where nome = nomeartistisco and a.cpf = p_e.animador
   			 group by p_e.animador;
   			 
   			 select preco_30min::numeric
   			 into valor
   			 from animador
   			 where nome = nomeartistisco;
   			 
   			 valor := ((to_seconds(tempo) * valor) / to_seconds('00:30:00'));

end $$ language 'plpgsql';

CREATE TRIGGER calcula_anim_trigger
AFTER INSERT ON PEDIDO_ENTRETENIMENTO
FOR EACH ROW
EXECUTE PROCEDURE calcula_anim();

CREATE OR REPLACE FUNCTION to_seconds(tempo TIME)
  RETURNS REAL AS $$
DECLARE
	hs INTEGER;
	ms INTEGER;
	s INTEGER;
    resultado REAL;
BEGIN
	SELECT (EXTRACT (HOUR FROM tempo) * 60*60) INTO hs;
	SELECT (EXTRACT (MINUTES FROM tempo) * 60) INTO ms;
	SELECT (EXTRACT (SECONDS FROM tempo)) INTO s;
	SELECT (hs + ms + s)::real INTO resultado;
	RETURN resultado;
END $$ LANGUAGE 'plpgsql';

-- Exemplo de ativa��o de Gatilho:
--insert into pedido values (28, '01/01/2019', '20:00', '20:30', 1, null, 'Com entretenimento', '11721040');
--insert into contem values (28, 'Calabresa', 'Buxim xei', 'fina','normal','Apimentado');
--select p.custo_total
--from pedido p
--where p.id_p = 28

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Procedure escolhido pelo grupo
CREATE FUNCTION Entregador()
RETURNS trigger AS $$ BEGIN
IF ( (new.CNH = 'B' and new.veiculo = 'moto') or (new.CNH = 'A' and new.veiculo = 'carro')  
or (new.CNH = 'C' and new.veiculo = 'van') ) then IF (LENGTH(new.placa) = 7) then return new;
ELSE RAISE notice 'Placa de Ve�culo Inv�lida';
END IF;
ELSE Raise notice 'Categoria de Habilita��o %, n�o � permitida por lei para dirigir %', new.CNH, new.veiculo; 
END IF;
END $$ language plpgsql; 

-- Trigger escolhido pelo grupo
CREATE TRIGGER Entregador
BEFORE insert or update of CNH, veiculo, placa on ENTREGADOR for each row 
EXECUTE PROCEDURE entregador();

-- Ativando os Gatilhos:
--Insert into entregador values ('ACB011o20', 50, 20.25, 'C', 'van','11721001');
--Insert into entregador values ('ACB01120', 50, 20.25, 'C', 'carro','11721001');
--Insert into entregador values ('ACB011o20', 50, 20.25, 'C', 'moto','11721001');

insert into usuario values ('11721027', 'Luis Gabriel Maximo', 'rua 7 casa 8', '23/07/1997');
insert into usuario values ('11721032', 'Eliabe Vinicius Costa Silva', 'rua 1 casa 8', '21/08/2000');
insert into usuario values ('11721018', 'Gabriel Jose Bueno Otsuka', 'rua 1 casa 7', '03/11/2000');
insert into usuario values ('11721012', 'Fulano', 'rua 1 casa 6', '18/06/1996');
insert into usuario values ('11721013', 'Ciclano', 'rua 1 casa 5', '04/08/1998');
insert into usuario values ('11721014', 'Marcos', 'rua 2 casa 1', '08/08/1990');
insert into usuario values ('11721015', 'Vinicius', 'rua 3 casa 2', '05/10/1975');
insert into usuario values ('11721016', 'Eduardo', 'rua 4 casa 3', '07/11/1985');
insert into usuario values ('11721017', 'Joao', 'rua 3 casa 4', '25/12/1995');
insert into usuario values ('11721002', 'Marcelo', 'rua 5 casa 9', '30/07/1987');

insert into usuario values ('11721019', 'Felipe', 'rua 1 casa 10', '08/12/1982');
insert into usuario values ('11721020', 'Breno', 'rua 2 casa 1', '10/10/1969');
insert into usuario values ('11721021', 'Yago', 'rua 2 casa 2', '05/01/1980');
insert into usuario values ('11721022', 'Lorena', 'rua 2 casa 3', '02/02/1981');
insert into usuario values ('11721023', 'Victor', 'rua 2 casa 4', '11/03/1987');
insert into usuario values ('11721024', 'Vitor', 'rua 2 casa 5', '12/04/1990');
insert into usuario values ('11721025', 'Lucas', 'rua 2 casa 6', '10/05/1970');
insert into usuario values ('11721026', 'Adiel', 'rua 2 casa 7', '12/06/1980');
insert into usuario values ('11721028', 'Rodrigo', 'rua 2 casa 8', '05/08/2000');
insert into usuario values ('11721029', 'Ricardo', 'rua 2 casa 9', '05/08/2000');

insert into usuario values ('11721030', 'Roberto', 'rua 3 casa 1', '01/07/2001');
insert into usuario values ('11721031', 'Bufulin', 'rua 3 casa 2', '05/08/1963');
insert into usuario values ('11721001', 'Roberto', 'rua 3 casa 3', '12/01/1999');
insert into usuario values ('11721033', 'Ricardo', 'rua 3 casa 4', '11/02/1998');
insert into usuario values ('11721034', 'Nicolas', 'rua 3 casa 5', '01/03/1997');
insert into usuario values ('11721035', 'Rafael', 'rua 3 casa 6', '11/04/1996');
insert into usuario values ('11721036', 'Heitor', 'rua 3 casa 7', '12/05/1995');
insert into usuario values ('11721037', 'Erick', 'rua 3 casa 8', '04/06/1994');
insert into usuario values ('11721038', 'Plinio', 'rua 3 casa 9', '08/07/1993');
insert into usuario values ('11721039', 'Gabriella', 'rua 3 casa 10', '09/09/1992');

insert into usuario values ('11721040', 'Gabriela', 'rua 4 casa 1', '09/01/1992');
insert into usuario values ('11721041', 'Ana', 'rua 4 casa 2', '12/02/1982');
insert into usuario values ('11721042', 'Giovanna', 'rua 4 casa 3', '11/03/1972');
insert into usuario values ('11721043', 'Julia', 'rua 4 casa 9', '05/04/1962');
insert into usuario values ('11721044', 'Maria', 'rua 4 casa 8', '05/06/1952');
insert into usuario values ('11721045', 'Eduarda', 'rua 4 casa 7', '10/07/1983');
insert into usuario values ('11721046', 'Juliana', 'rua 4 casa 6', '06/09/1984');
insert into usuario values ('11721047', 'Isabela', 'rua 4 casa 5', '09/09/1981');
insert into usuario values ('11721048', 'Isabella', 'rua 4 casa 10', '02/10/1985');
insert into usuario values ('11721049', 'Sophia', 'rua 4 casa 4', '03/11/1979');

insert into entregador values ('ACB0101', 25, 20.25, 'A', 'carro','11721027');
insert into entregador values ('ACB0102', 10, 20.25, 'B', 'moto','11721032');
insert into entregador values ('ACB0103', 10, 30.25, 'B', 'moto','11721018');
insert into entregador values ('ACB0104', 10, 20.25, 'B', 'moto','11721012');
insert into entregador values ('ACB0105', 25, 30.25, 'A', 'carro','11721013');
insert into entregador values ('ACB0106', 10, 20.25, 'B', 'moto','11721014');
insert into entregador values ('ACB0107', 25, 30.25, 'A', 'carro','11721015');
insert into entregador values ('ACB0108', 10, 20.25, 'B', 'moto','11721016');
insert into entregador values ('ACB0109', 50, 30.25, 'C', 'van','11721017');
insert into entregador values ('ACB0110', 50, 20.25, 'C', 'van','11721002');

insert into animador values (10.15, 'Maluco', 'Um rapaz bem maluco e divertido que faz de tudo para alegrar o seu pedido :)', '11721019');
insert into animador values (10.15, 'Louco', 'Um rapaz bem louco e divertido que faz de tudo para alegrar o seu pedido :)', '11721020');
insert into animador values (10.15, 'Animado', 'Um rapaz bem animado e divertido que faz de tudo para alegrar o seu pedido :)', '11721021');
insert into animador values (10.15, 'Patati', 'Um palhaco alegre e engracado :)', '11721022');
insert into animador values (10.15, 'Patata', 'Um palhaco alegre e engracado :)', '11721023');
insert into animador values (10.15, 'Marcelin', 'Um rapaz bem pequeno, divertido e engracado que faz de tudo para alegrar o seu pedido :)', '11721024');
insert into animador values (10.15, 'Gil Maluco', 'Um rapaz bem maluco e engracado :)', '11721025');
insert into animador values (10.15, 'Peralta', 'Um rapaz super animado que faz de tudo pelo seu pedido :)', '11721026');
insert into animador values (10.15, 'Miranha', 'O proprio homem aranha da carreta furacao :)', '11721029');
insert into animador values (10.15, 'Fofao', 'O proprio fofao da carreta furacao :)', '11721028');

insert into dono values ('linkedin.com/perfil/roberto', '11721030');
insert into dono values ('linkedin.com/perfil/Bufulin', '11721031');
insert into dono values ('linkedin.com/perfil/robertoa', '11721001');
insert into dono values ('linkedin.com/perfil/ricarrdo', '11721033');
insert into dono values ('linkedin.com/perfil/nicolau', '11721034');
insert into dono values ('linkedin.com/perfil/rafael', '11721035');
insert into dono values ('linkedin.com/perfil/heito', '11721036');
insert into dono values ('linkedin.com/perfil/eric', '11721037');
insert into dono values ('linkedin.com/perfil/plinin', '11721038');
insert into dono values ('linkedin.com/perfil/gabs', '11721039');

insert into consumidor_faminto values ('rua 4 casa 1', '11721040');
insert into consumidor_faminto values ('rua 40 casa 10', '11721041');
insert into consumidor_faminto values ('rua 4 casa 3 ', '11721042');
insert into consumidor_faminto values ('rua 4 casa 4', '11721043');
insert into consumidor_faminto values ('rua 4 casa 5', '11721044');
insert into consumidor_faminto values ('rua 4 casa 6', '11721045');
insert into consumidor_faminto values ('rua 15 casa 17', '11721046');
insert into consumidor_faminto values ('rua 4 casa 8', '11721047');
insert into consumidor_faminto values ('rua 4 casa 9', '11721048');
insert into consumidor_faminto values ('rua 1 casa 23', '11721049');

insert into pizzaria values ('Dominus', '11721030', '14820-000', '09:00', '23:00', '3392-1222', 'www.dominus.com.br');
insert into pizzaria values ('Crunch', '11721031', '38408-138', '09:00', '23:00', '3392-3848', 'www.crunch.com.br');
insert into pizzaria values ('Habbibs', '11721001', '38408-188', '09:00', '23:00', '3392-4649', 'www.habbibs.com.br');
insert into pizzaria values ('Ramos', '11721033', '38408-109', '12:00', '20:00', '3391-7584', 'www.ramospizza.com.br');
insert into pizzaria values ('Fratelli', '11721034', '38408-850', '18:00', '23:00', '9532-8549', 'www.fratelli.com.br');
insert into pizzaria values ('Casa das massas', '11721035', '38520-188', '11:00', '18:00', '7451-8468', 'www.casadasmassas.com.br');
insert into pizzaria values ('Buxim xei', '11721036', '27408-188', '20:00', '03:00', '8426-8451', 'www.mucei.com.br');
insert into pizzaria values ('Pizzatop', '11721037', '38951-188', '17:00', '02:00', '3562-2856', 'www.pizzatop.com.br');
insert into pizzaria values ('PizzaYOLO', '11721038', '39453-788', '15:00', '22:00', '8452-8564', 'www.yolopizza.com.br');
insert into pizzaria values ('Pizza barata', '11721039', '12345-188', '19:00', '04:00', '9756-8465', 'www.baratinha.com.br');

insert into categoria values (40, 'Pizza Salgada -> TRADICIONAL', 40);
insert into categoria values (41, 'Pizza Salgada -> ESPECIAL', 40);
insert into categoria values (50, 'Pizza Doce -> TRADICIONAL', 50);
insert into categoria values (51, 'Pizza Doce -> ESPECIAL', 50);
insert into categoria values (52, 'Pizza Salgada -> GOURMET', 41);
insert into categoria values (53, 'Pizza Doce -> GOURMET', 51);
insert into categoria values (10, 'Pizza Salgada -> RUSTICA', 41);
insert into categoria values (20, 'Pizza Doce -> RUSTICA', 51);
insert into categoria values (30, 'Pizza Salgada -> DOIS SABORES', 41);
insert into categoria values (60, 'Pizza Doce -> DOIS SABORES', 51);

insert into pizza values ('Calabresa', 'Dominus', 40, 30.00);
insert into pizza values ('Calabresa', 'Ramos', 40, 23.00);
insert into pizza values ('Calabresa', 'Crunch', 40, 38.00);
insert into pizza values ('Calabresa', 'Habbibs', 40, 25.00);
insert into pizza values ('Calabresa', 'Fratelli', 40, 35.90);
insert into pizza values ('Calabresa', 'Casa das massas', 40, 32.20);
insert into pizza values ('Calabresa', 'Buxim xei', 40, 31.50);
insert into pizza values ('Calabresa', 'Pizzatop', 40, 40.25);
insert into pizza values ('Calabresa', 'PizzaYOLO', 40, 30.50);
insert into pizza values ('Frango', 'Dominus', 40, 30.00);
insert into pizza values ('Estrogonof', 'Dominus', 41, 39.90);
insert into pizza values ('Bacon', 'Dominus', 41, 39.90);
insert into pizza values ('Presunto', 'Crunch', 10, 23.90);
insert into pizza values ('Portuguesa', 'Crunch', 40, 23.90);
insert into pizza values ('Peperoni', 'Crunch', 52, 29.90);
insert into pizza values ('A Moda', 'Crunch', 41, 29.90);
insert into pizza values ('Cheddar', 'Habbibs', 40, 28.90);
insert into pizza values ('Espanhola', 'Crunch', 40, 28.90);
insert into pizza values ('4 queijos', 'Crunch', 41, 32.90);
insert into pizza values ('Brocolis', 'Crunch', 41, 32.90);
insert into pizza values ('Frango', 'Pizza barata', 40, 20.50);
insert into pizza values ('Frango', 'Fratelli', 40, 30.00);
insert into pizza values ('Estrogonof', 'Casa das massas', 41, 39.90);
insert into pizza values ('Bacon', 'Buxim xei', 41, 35.90);
insert into pizza values ('Presunto', 'Pizzatop', 10, 25.90);
insert into pizza values ('Portuguesa', 'PizzaYOLO', 40, 23.50);
insert into pizza values ('Peperoni', 'Pizza barata', 52, 39.90);
insert into pizza values ('A Moda', 'PizzaYOLO', 41, 49.90);
insert into pizza values ('Cheddar', 'Pizzatop', 40, 38.50);
insert into pizza values ('Espanhola', 'Buxim xei', 40, 28.40);
insert into pizza values ('4 queijos', 'Pizza barata', 41, 33.90);
insert into pizza values ('Brocolis', 'Fratelli', 41, 32.50);
insert into pizza values ('banana e chocolate', 'PizzaYOLO', 60, 40.90);
insert into pizza values ('frango e calabresa', 'Pizza barata', 30, 45.90);
insert into pizza values ('banana', 'Habbibs', 50, 32.40);
insert into pizza values ('banana', 'Crunch', 50, 35.55);
insert into pizza values ('banana', 'Pizza barata', 50, 42.80);
insert into pizza values ('banana', 'Buxim xei', 50, 52.40);
insert into pizza values ('banana', 'Pizzatop', 50, 32.10);
insert into pizza values ('banana', 'Casa das massas', 50, 22.30);
insert into pizza values ('banana', 'PizzaYOLO', 50, 36.10);
insert into pizza values ('banana', 'Fratelli', 50, 37.20);
insert into pizza values ('banana', 'Dominus', 50, 29.40);
insert into pizza values ('banana', 'Ramos', 50, 34.50);
insert into pizza values ('chocolate', 'Buxim xei', 51, 33.20);
insert into pizza values ('banana com canela', 'Habbibs', 53, 42.50);
insert into pizza values ('brigadeiro', 'Buxim xei', 20, 52.90);
insert into pizza values ('chocolate gourmet', 'Buxim xei', 51, 44.50);

insert into pedido values (1, '01/01/2019', '20:00', '20:30', 1, null, 'Com entretenimento', '11721040');
insert into pedido values (2, '02/01/2019', '21:00', '21:45', 2, null, 'Com entretenimento', '11721041');
insert into pedido values (3, '03/01/2019', '20:00', '20:30', 1, null, 'Com entretenimento', '11721042');
insert into pedido values (4, '04/01/2019', '22:00', '22:55', 2, null, 'Com entretenimento', '11721043');
insert into pedido values (5, '02/01/2019', '21:00', '22:10', 1, null, 'Com entretenimento', '11721044');
insert into pedido values (6, '04/01/2019', '22:00', '23:30', 3, null, 'Com entretenimento', '11721045');
insert into pedido values (7, '01/01/2019', '20:00', '21:40', 1, null, 'Com entretenimento', '11721046');
insert into pedido values (8, '01/01/2019', '20:00', '22:05', 4, null, 'Com entretenimento', '11721047');
insert into pedido values (9, '02/01/2019', '21:00', '23:01', 1, null, 'Com entretenimento', '11721048');
insert into pedido values (10,'03/01/2019', '22:00', '22:20', 6, null, 'Com entretenimento', '11721049');

insert into pedido values (11, '02/01/2019', '13:44', '15:30', 1, null, 'Normal', '11721040');
insert into pedido values (12, '04/01/2019', '15:33', '16:30', 2, null, 'Normal', '11721041');
insert into pedido values (13, '01/01/2019', '17:05', '19:09', 1, null, 'Normal', '11721042');
insert into pedido values (14, '03/01/2019', '15:20', '17:10', 2, null, 'Normal', '11721043');
insert into pedido values (15, '04/01/2019', '12:10', '14:03', 5, null, 'Normal', '11721049');
insert into pedido values (16, '02/01/2019', '17:22', '18:00', 1, null, 'Normal', '11721043');
insert into pedido values (17, '02/01/2019', '17:22', '18:00', 1, null, 'Normal', '11721042');
insert into pedido values (18, '02/01/2019', '17:22', '18:00', 1, null, 'Normal', '11721040');
insert into pedido values (19, '02/01/2019', '17:22', '18:00', 1, null, 'Normal', '11721047');
insert into pedido values (20, '02/01/2019', '17:22', '18:00', 1, null, 'Normal', '11721044');

insert into ingrediente values (90, '+ Cheddar', '2.00');
insert into ingrediente values (91, '+ Catupiry', '2.00');
insert into ingrediente values (92, '+ Bacon', '2.00');
insert into ingrediente values (93, '+ Ketchup', '1.00');
insert into ingrediente values (94, '+ Maionese', '1.00');
insert into ingrediente values (95, '+ Mostarda', '1.00');
insert into ingrediente values (96, '+ champignon', '5.00');
insert into ingrediente values (97, '+ Calabresa', '5.00');
insert into ingrediente values (98, '+ Banana', '3.00');
insert into ingrediente values (99, '+ Milho', '5.00');

insert into pedido_entretenimento values (1, 'palhaco', '00:30', '11721022');
insert into pedido_entretenimento values (2, 'palhaco', '00:30', '11721023');
insert into pedido_entretenimento values (3, 'Stand up', '00:30', '11721019');
insert into pedido_entretenimento values (4, 'Stand up', '00:30', '11721020');
insert into pedido_entretenimento values (5, 'Stand up', '00:30', '11721021');
insert into pedido_entretenimento values (6, 'Stand up', '00:30', '11721024');
insert into pedido_entretenimento values (7, 'Stand up', '00:30', '11721025');
insert into pedido_entretenimento values (8, 'Stand up', '00:30', '11721026');
insert into pedido_entretenimento values (9, 'Personagem', '00:30', '11721028');
insert into pedido_entretenimento values (10, 'Personagem', '00:30', '11721029');

insert into acompanhamento values (70, 'Dominus', 'Suco de Laranja', 'suco de laranja natural', 'bebida', 6.00);
insert into acompanhamento values (71, 'Crunch', 'Salada de Pepino', 'Salada com muito pepino NOSSA ESPECIALIDADE', 'Salada', 10.00);
insert into acompanhamento values (72, 'Habbibs', 'Brigadeiro', 'Brigadeiro comum', 'Sobremesa', 2.00);
insert into acompanhamento values (73, 'Dominus', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 4.00);
insert into acompanhamento values (74, 'Crunch', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 5.00);
insert into acompanhamento values (75, 'Habbibs', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 4.50);
insert into acompanhamento values (76, 'Ramos', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 5.50);
insert into acompanhamento values (77, 'Fratelli', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 6.30);
insert into acompanhamento values (78, 'Casa das massas', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 4.00);
insert into acompanhamento values (79, 'Buxim xei', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 5.00);
insert into acompanhamento values (80, 'Pizzatop', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 7.00);
insert into acompanhamento values (81, 'PizzaYOLO', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 4.90);
insert into acompanhamento values (82, 'Pizza barata', 'Refrigerante', 'diversos refrigerantes 600ml', 'bebida', 5.50);

insert into trabalha values ('11721019', 'Dominus', 'segunda a sexta');
insert into trabalha values ('11721020', 'Crunch', 'segunda a quarta');
insert into trabalha values ('11721021', 'Habbibs', 'somente aos sabados');
insert into trabalha values ('11721022', 'Ramos', 'somente aos domingos');
insert into trabalha values ('11721023', 'Fratelli', 'sabados, domingos e feriados');
insert into trabalha values ('11721024', 'Casa das massas', 'quinta e sexta');
insert into trabalha values ('11721025', 'Buxim xei', 'segunda a sexta');
insert into trabalha values ('11721026', 'Pizzatop', 'segunda a sabado');
insert into trabalha values ('11721028', 'Pizza barata', 'ter�a e quinta');
insert into trabalha values ('11721029', 'PizzaYOLO', 'quarta, quinta e sexta');

insert into contem values (1, 'Calabresa', 'Buxim xei', 'fina','normal','Apimentado');
insert into contem values (2, 'Calabresa', 'Dominus', 'grossa','Cheddar','normal');
insert into contem values (3, 'Calabresa', 'Crunch', 'fina','normal','normal');
insert into contem values (4, 'Calabresa', 'Habbibs', 'grossa','Requeijao','Apimentado');
insert into contem values (5, 'Calabresa', 'Fratelli', 'grossa','Cheddar','normal');
insert into contem values (6, 'Calabresa', 'Casa das massas', 'fina','normal','normal');
insert into contem values (7, 'Calabresa', 'Pizzatop', 'grossa','Cheddar','normal');
insert into contem values (8, 'Calabresa', 'PizzaYOLO', 'fina','normal','normal');
insert into contem values (9, 'Estrogonof', 'Dominus', 'grossa','Cheddar','normal');
insert into contem values (10, 'Espanhola', 'Crunch', 'fina','Requeijao','normal');
insert into contem values (11, '4 queijos', 'Pizza barata', 'fina','normal','Apimentado');
insert into contem values (12, 'banana', 'Ramos', 'fina','normal','Apimentado');
insert into contem values (13, 'Bacon', 'Buxim xei', 'grossa','Cheddar','normal');
insert into contem values (14, 'A Moda', 'PizzaYOLO', 'fina','Requeijao','normal');
insert into contem values (15, 'Cheddar', 'Pizzatop', 'grossa','Cheddar','normal');
insert into contem values (16, 'Brocolis', 'Crunch', 'fina','Requeijao','normal');
insert into contem values (17, 'Portuguesa', 'PizzaYOLO', 'fina','normal','normal');
insert into contem values (18, 'Espanhola', 'Buxim xei', 'grossa','Cheddar','normal');
insert into contem values (19, 'banana com canela','Habbibs','fina','normal','normal');
insert into contem values (20,  'Frango', 'Pizza barata','fina','Cheddar','normal');

insert into tem values(90, 11,'4 queijos','Pizza barata');
insert into tem values(91, 2,'Calabresa','Dominus');
insert into tem values(92, 1,'Calabresa','Buxim xei');
insert into tem values(93, 5,'Calabresa','Fratelli');
insert into tem values(94, 15,'Cheddar','Pizzatop');
insert into tem values(95, 9,'Estrogonof','Dominus');
insert into tem values(96, 7,'Calabresa','Pizzatop');
insert into tem values(96, 3,'Calabresa','Crunch');
insert into tem values(96, 4,'Calabresa','Habbibs');
insert into tem values(96, 6,'Calabresa','Casa das massas');

insert into tem_acomp values (1, 70, 'Dominus', 1);
insert into tem_acomp values (2, 71, 'Crunch', 2);
insert into tem_acomp values (11, 72, 'Habbibs', 1);
insert into tem_acomp values (12, 73, 'Dominus', 2);
insert into tem_acomp values (3, 74, 'Crunch', 1);
insert into tem_acomp values (4, 75, 'Habbibs', 2);
insert into tem_acomp values (13, 76, 'Ramos', 1);
insert into tem_acomp values (14, 77, 'Fratelli', 2);
insert into tem_acomp values (5, 78, 'Casa das massas', 1);
insert into tem_acomp values (6, 79, 'Buxim xei', 3);
insert into tem_acomp values (15, 80, 'Pizzatop', 5);
insert into tem_acomp values (16, 81, 'PizzaYOLO', 1);

-- Consulta 1) Qual o nome e quantidade de pedidos da Pizzaria com o maior numero de pedidos
SELECT p.nome, count(c.pedido)
FROM Contem c, Pizzaria p
Where c.pizzaria = p.nome
Group By p.nome
having count(c.pedido) >= ALL(SELECT count(c.pedido)
   							 FROM Contem c, Pizzaria p
   							 Where c.pizzaria = p.nome
   							 Group By p.nome);

-- Consulta 2) Quais s�o os 3 Clientes que mais gastaram com pedidos de entretenimento? (Desc)
SELECT u.nome, p.custo_total
FROM Consumidor_Faminto cl, pedido_entretenimento pe, pedido p, usuario u
WHERE cl.CPF = p.Cliente and p.id_p = pe.id_p and u.CPF = cl.CPF
Order By p.custo_total Desc
Limit 3;

-- Consulta 3) Qual a M�dia dos pre�os das Pizzas de cada Pizzaria em ordem crescente?
select piz.nome, avg(pizza.preco::numeric)::money
from pizzaria piz, pizza
where piz.nome = pizza.nome_p
group by piz.nome
order by avg(pizza.preco::numeric)::money asc;

-- Consulta 4) Quais � a pizzaria com a pizza Doce Especial mais cara? 
SELECT piz.nome
FROM Pizza p, Categoria c, pizzaria piz
WHERE p.cat = c.cod and c.nome = 'Pizza Doce -> ESPECIAL' and piz.nome = p.nome_p
Group By piz.nome, p.preco
Having p.preco >= ALL            	( SELECT pi.preco
            	FROM Pizza pi, Categoria categ, pizzaria piza
            	WHERE pi.cat = categ.cod and categ.nome = 'Pizza Doce -> ESPECIAL' and
piza.nome = 'Buxim xei'
Group By pi.preco );

-- Consulta 5) Qual � a pizza mais vendida entre as pizzarias ?
select c.nome, count(c.nome)
from contem c
group by c.nome
having count(c.nome) >= ALL(
   				select count(c.nome)
   				from contem c
   				group by c.nome );

-- Consulta 6) Qual dia houve mais pedidos de entretenimento?
select p.data, count(p.data)
from pedido_entretenimento pe, pedido p
where pe.id_p = p.id_p
group by p.data
having count(p.data) >= ALL(
   							 select count(p.data)
   							 from pedido_entretenimento pe, pedido p
   							 where pe.id_p = p.id_p
   							 group by p.data);

-- Consulta 7) Qual Pizzaria mais arrecadou na datas x/y/z entre as i horas e j horas
	SELECT pz.nome_p, sum(pz.preco::numeric)::money
	FROM contem c, pizza pz, pedido p
	WHERE  c.pedido = p.id_p and c.pizzaria = pz.nome_p and p.data = '02/01/2019' and p.horario BETWEEN '15:30' and '20:00'
	GROUP BY pz.nome_p
	HAVING sum(pz.preco::numeric) >= ALL ( SELECT sum(pz.preco::numeric)
                    	FROM contem c, pizza pz, pedido p
                    	WHERE c.pedido = p.id_p and c.pizzaria = pz.nome_p and p.data = '02/01/2019' and p.horario BETWEEN '15:30' and '20:00'
                    	GROUP BY  pz.nome_p);

-- Consulta 8) Qual Acompanhamento � o mais pedido?
select acompanhamento.nome
from pedido,contem,acompanhamento
where pedido.id_p = contem.pedido and contem.pizzaria = acompanhamento.nome_p
group by acompanhamento.nome
having count(acompanhamento.nome) >= ALL (
         select count(acompanhamento.nome)
        from pedido,contem,acompanhamento
        where pedido.id_p = contem.pedido and contem.pizzaria = acompanhamento.nome_p
        group by acompanhamento.nome );
 
-- Consulta 9) Quais os ingredientes extras pedidos por todos os clientes na data x/y/z
select ing.nome
from tem t ,pedido p ,ingrediente ing
where t.Pedido = p.id_p and ing.Cod = t.Ingrediente and p.data = '04/01/2019';

-- Consulta 10) Qual das categorias possui o maior n�mero de Pizzas cadastradas?
	SELECT c.nome, count(p.nome)
	FROM categoria c, pizza p
	WHERE p.cat = c.cod
	GROUP BY c.nome
	HAVING count(p.nome) >= ALL ( SELECT count(pi.nome)
					 FROM	categoria ca, pizza pi
					 WHERE pi.cat = ca.cod
					 GROUP BY ca.nome );



