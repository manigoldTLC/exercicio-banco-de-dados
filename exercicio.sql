-- criando tabelas e adicionando valores

create table cliente (
	id_cliente serial not null primary key,
	ds_cliente varchar(255) not null
);

insert into cliente (ds_cliente) values
	('Maria da Silva'),
	('João Pedro'),
	('Eduardo Pereira')
;

select * from cliente;

create table estoque (
	id_produto int,
	qt_produto int not null,
	
	foreign key (id_produto) references produto (id_produto)
);

insert into estoque (id_produto, qt_produto) values
	(1, 127),
	(2, 2),
	(3, 15),
	(4, 7),
	(5, 7)
;

select * from estoque;

create table produto (
	id_produto serial primary key,
	ds_produto varchar(255) not null,
	qt_minima_reposicao int not null
);

insert into produto (ds_produto, qt_minima_reposicao) values
	('Margarina', 50),
	('Tomate', 10),
	('Macarrão', 15),
	('Sabonete', 5),
	('Esponja', 3)
;

select * from produto;

create table compra_cliente (
	id_cliente int not null,
	id_produto int not null,
	qt_produto int not null,
	
	foreign key (id_cliente) references cliente (id_cliente),
	foreign key (id_produto) references produto (id_produto)
);

insert into compra_cliente (id_cliente, id_produto, qt_produto) values
	(1, 1, 5),
	(1, 3, 7),
	(1, 5, 2),
	(3, 1, 7),
	(3, 1, 2),
	(3, 4, 5),
	(3, 5, 9)
;

select * from compra_cliente;

-- query exercício 1

select produto.id_produto, produto.ds_produto as nome_produto, estoque.qt_produto as estoque_produto
from compra_cliente
join produto on produto.id_produto = compra_cliente.id_produto
join estoque on estoque.id_produto = compra_cliente.id_produto
group by 1, 3
having sum(compra_cliente.qt_produto) > estoque.qt_produto;

-- query exercício 2

select compra_cliente.id_cliente, ds_cliente, compra_cliente.id_produto, ds_produto
from compra_cliente, cliente c, produto d
where compra_cliente.id_cliente = c.id_cliente and compra_cliente.id_produto = d.id_produto;

-- query exercício 3

select id_produto, ds_produto
from produto p
where p.id_produto not in (select id_produto from compra_cliente);

-- query exercício 4

select *
from cliente c
where c.id_cliente not in (select id_cliente from compra_cliente);

-- query exercício 5

select produto.id_produto, produto.ds_produto, sum(qt_produto) as quantidade_produto
from compra_cliente
join produto on produto.id_produto = compra_cliente.id_produto
group by 1
order by sum(qt_produto)
desc;
