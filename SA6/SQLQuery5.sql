create database ContabilidadeDB
go

use ContabilidadeDB
go

create table Clientes(
id_cliente int primary key identity(1,1),
nome_cliente varchar(255),
tipo_cliente varchar(50),
telefone_cliente varchar(20),
endereco_cliente varchar(255)
);

create table Servicos(
id_servico int primary key identity(1,1),
descricao_servico varchar(255),
taxa_servico decimal(10,2)
);

create table TransacoesFinanceiras(
id_transacao int primary key identity(1,1),
id_cliente int,
tipo_transacao varchar(50),
data_transacao datetime,
valor_transacao decimal(10,2),
foreign key (id_cliente) references Clientes (id_cliente)
);

create table DeclaracoesFinanceiras(
id_declaracao int primary key identity(1,1),
id_cliente int,
tipo_declaracao varchar(50),
data_declaracao datetime,
conteudo_declaracao varchar(255),
foreign key (id_cliente) references Clientes (id_cliente)
);

create table Funcionarios(
id_funcionario int primary key identity(1,1),
nome_funcionario varchar(255),
cargo_funcionario varchar(255),
telefone_funcionario varchar(20),
departamento varchar(255)
);
