create database coffeeShop;
use coffeeShop;

create table Funcionario (
cod_func int primary key auto_increment,
nome_func varchar(50),
cpf_func varchar(11),
email_func varchar(50),
tel_func varchar (20),
endereco_func varchar(200),
usuario varchar(30),
senha varchar(20)
);

create table Login (
usuario varchar(30),
senha varchar(20)
);


-- Procedure para inserir funcionario e login
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
insert into Funcionario(nome_func, cpf_func, email_func, tel_func, endereco_func)
values (nome_func, cpf_func, email_func, tel_func, endereco_func);

insert into Login(usuario, senha) values (usuario, senha);
end $$
delimiter ;

call inserirFuncLogin('Edigar Maia', '00022244478', 'edigarmaia@gmail.com', 3645-4578, 'Rua da Imaginação, 150', 'edigarmaia', 'edigarmaia');
select * from Funcionario;
select * from login;