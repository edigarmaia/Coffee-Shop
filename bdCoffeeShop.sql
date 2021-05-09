create database coffeeShop;
use coffeeShop;

create table funcionario (
cod_func int primary key auto_increment,
nome_func varchar(50),
cpf_func varchar(11),
email_func varchar(50),
tel_func varchar (20),
endereco_func varchar(200),
usuario varchar(30),
senha varchar(20)
);

create table arquivoFuncionario (
cod_func int primary key auto_increment,
nome_func varchar(50),
cpf_func varchar(11),
email_func varchar(50),
tel_func varchar (20),
endereco_func varchar(200),
usuario varchar(30),
senha varchar(20)
);


create table login (
usuario varchar(30),
senha varchar(20)
);

create table produto(
cod_prod int primary key auto_increment,
nome_prod varchar(30),
descricao varchar(100),
quant_estoque int,
valor_unitario float
);

create table cliente (
cod_cli int primary key auto_increment,
nome_cli varchar(70),
email_cli varchar(50),
end_cli varchar(100),
cpf_cli varchar(11),
tel_cli varchar(30)
);
create table pagamento (
cod_pagto int primary key auto_increment,
desc_pagto varchar(30)
);


create table pedido(
cod_pedido int primary key auto_increment,
quant_pedido int,
valor_total float,
data_pedido datetime,
cod_pagto int,
cod_cli int,
cod_prod int,
status_ped varchar(20),
foreign key (cod_pagto) references pagamento(cod_pagto),
foreign key (cod_cli) references cliente(cod_cli),
foreign key (cod_prod) references produto(cod_prod)
);

drop table pedidoArquivados;
create table pedidoArquivados(
cod_pedido int,
quant_pedido int,
valor_total float,
data_pedido datetime,
cod_pagto int,
cod_cli int,
cod_prod int,
status_ped varchar(20),
foreign key (cod_pagto) references pagamento(cod_pagto),
foreign key (cod_cli) references cliente(cod_cli),
foreign key (cod_prod) references produto(cod_prod)
);

-- PROCEDURES FUNCIONARIO
-- Procedure para cadastrar funcionario e login
delimiter $$
create procedure inserirFuncLogin(
nome_func varchar(50),
cpf_func varchar(11),
email_func varchar(50),
tel_func varchar (20),
endereco_func varchar(200),
usuario varchar(30),
senha varchar(20)
) 
begin
insert into funcionario(nome_func, cpf_func, email_func, tel_func, endereco_func)
values (nome_func, cpf_func, email_func, tel_func, endereco_func);

insert into login(usuario, senha) values (usuario, senha);
end $$
delimiter ;

call inserirFuncLogin('Edigar Maia', '00022244478', 'edigarmaia@gmail.com', 3645-4578, 'Rua da Imaginação, 150', 'edigarmaia', 'edigarmaia');
call inserirFuncLogin('Wesley Amorim', '12345647881', 'wesley@gmail.com', 3645-7845, 'Serra do Mar, 145', 'wesley', 'wesley');

-- Consultando funcionarios
delimiter $$
create procedure consultaFuncionario()
begin
    select * from funcionario;
end $$
delimiter ;
call consultaFuncionario();

----------------------------------------------------------------
-- PROCEDURES PRODUTO
-- Procedure para cadastrar produtos
delimiter $$
create procedure inserirProduto( in Produto varchar(30), Descricao varchar(100), Estoque int, Valor_Unitario float) 
begin
insert into produto(nome_prod, descricao, quant_estoque, valor_unitario)
values (Produto, Descricao, Estoque, Valor_Unitario);
end $$
delimiter ;
call inserirProduto('café','café expresso','10','5.00');

-- Consulta produtos
delimiter $$
create procedure consultaProduto()
begin
    select * from produto;
end $$
delimiter ;
call consultaProduto();

-- Alterar produto
 delimiter $$
 create procedure alterarProduto (in codigo int, nome varchar(30), descricao varchar(100), estoque int, valor float)
 begin
	update produto
    set nome_prod = nome, descricao = descricao, quant_estoque = estoque, valor_unitario = valor
    where cod_prod = codigo; 
 end $$
 delimiter ;
 
call alterarProduto(1, 'Café com leite', 'Café com leite copo 200ml', '5', '7.50');

-- PROCEDURES CLIENTE

-- Procedure para cadastrar clientes
delimiter $$
create procedure inserirCliente( in Cliente varchar(70), Email varchar(50), Endereco varchar(100), CPF varchar(11), Telefone varchar(30)) 
begin
insert into cliente(nome_cli, email_cli, end_cli, cpf_cli, tel_cli)
values (Cliente, Email, Endereco, CPF, Telefone);
end $$
delimiter ;
call inserirCliente('Antonieta', 'toninha@globo.com', 'Rua Sabiá, 157', 11122233345, '3645-7889');
call inserirCliente('Manuela', 'manu@gmail.com', 'Rua Ouro Preto, 137', 00042135675, '3627-4572');

-- -- Consulta clientes
delimiter $$
create procedure consultaCliente()
begin
    select * from cliente;
end $$
delimiter ;
call consultaCliente();

-- Alterar Cliente
 delimiter $$
 create procedure alterarCliente (in Codigo int, Nome varchar(70), Email varchar(50), Endereco varchar(100), CPF varchar(11), Telefone varchar (30))
 begin
	update cliente 
    set nome_cli = Nome, email_cli = Email, end_cli = Endereco, cpf_cli = CPF , tel_cli = Telefone
    where cod_cli = Codigo; 
 end $$
 delimiter ;
call alterarCliente(1,'Marieta', 'toninha@globo.com', 'Rua Sabiá, 157', 11122233345, '3645-7889');

-- PROCEDURE CONDIÇÃO PAGAMENTO
-- cadastrar condição de pagamento
delimiter $$
create procedure cadCondPagamento(in desc_pagto varchar(30))
begin
	insert into pagamento(desc_pagto) 
    values(desc_pagto);
end $$
delimiter ;

call cadCondPagamento('VR');

-- seleciona condição de pagamento
delimiter $$
create procedure SelecionaCondPagamento()
begin
    select * from pagamento;
end $$
delimiter ;
call SelecionaCondPagamento();

-- PROCEDURES PEDIDO
-- cadastro de pedido
delimiter $$
create procedure cadastrarPedido(in quant_pedido int, valor_total float, data_pedido datetime, cod_pagto int, cod_cli int, cod_prod int, status_ped varchar(20))
begin
	insert into pedido (quant_pedido, valor_total, data_pedido, cod_pagto, cod_cli, cod_prod, status_ped) 
    values(quant_pedido, valor_total, data_pedido, cod_pagto, cod_cli, cod_prod, status_ped);
end $$
delimiter ;

call cadastrarPedido(3, 30, '2021-05-05', 1, 1, 1, 'fechado');

-- alterar pedido
delimiter $$
create procedure alterarPedido (in pedido int, quantidade_pedido int, valor_total float, data_pedido datetime, cod_pagto int, codigo_cliente int, codigo_produto int, status_pedido varchar(20))
 begin
	update pedido
    set quant_pedido =  quantidade_pedido, valor_total = valor_total, data_pedido = data_pedido, cod_pagto = cod_pagto , cod_cli = codigo_cliente, cod_prod = codigo_produto, status_ped = status_pedido
    where cod_pedido = pedido; 
 end $$
 delimiter ;
call alterarPedido(1, 10, 50, '2021-05-05', 4, 1, 1, 'fechado');

drop procedure alterarPedido;

-- TRIGGERS
-- trigger para arquivar os pedidos concluídos
delimiter $$
create trigger pedidosFinalizados
before delete on pedido for each row
begin
insert into pedidoArquivados(cod_pedido, quant_pedido, valor_total, data_pedido, cod_pagto, cod_cli, cod_prod, status_ped)
values (old.cod_pedido, old.quant_pedido, old.valor_total, old.data_pedido, old.cod_pagto, old.cod_cli, old.cod_prod, old.status_ped);
end $$
delimiter ;

delete from pedido where cod_pedido = 3;

-- criando a trigger para arquivar funcionarios
delimiter $$
create trigger arquivoFuncionario
before delete on funcionario for each row
begin
insert into arquivoFuncionario(nome_func, cpf_func, email_func, tel_func, endereco_func) values
(old.nome_func, old.cpf_func, old.email_func, old.tel_func, old.endereco_func);
end $$
delimiter ;

delete from funcionario where cod_func = 3;
select * from arquivoFuncionario;












select * from funcionario; 

drop procedure excluirFuncionario;

select * from funcionario;
select * from login;
select * from produto;










/*
-- Alterar Funcionario
 delimiter $$
 create procedure alterarFuncionario (in codigo int, nome varchar(50),cpf varchar(11),email varchar(50),telefone varchar (20),endereco varchar(200),usuario varchar(30),senha varchar(20))
 begin
	update funcionario 
    set nome_func = nome, cpf_func = cpf ,email_func = email ,tel_func = telefone, endereco_func = endereco, usuario = usuario, senha = senha
    where cod_func = codigo; 
    
    
 end $$
 delimiter ;
call alterarFuncionario(3,'teste', '00022244478', 'edigarmaia@gmail.com', 3645-4578, 'Rua da Imaginação, 150', 'edigarmaia', 'edigarmaia');
*/
 