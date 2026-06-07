-- Criar banco de dados loja
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'loja')
    CREATE DATABASE loja;
GO

USE loja;
GO

-- Criar login e usuário loja
IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = 'loja')
    CREATE LOGIN loja WITH PASSWORD = 'loja', CHECK_POLICY = OFF;
GO

IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = 'loja')
BEGIN
    CREATE USER loja FOR LOGIN loja;
    ALTER ROLE db_owner ADD MEMBER loja;
END
GO

-- Criar tabela Produto
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Produto')
BEGIN
    CREATE TABLE Produto (
        id          INT IDENTITY(1,1) PRIMARY KEY,
        nome        VARCHAR(100)   NOT NULL,
        quantidade  INT            NOT NULL DEFAULT 0,
        precoVenda  FLOAT          NOT NULL DEFAULT 0.0
    );
END
GO

-- Inserir dados de exemplo
IF NOT EXISTS (SELECT TOP 1 1 FROM Produto)
BEGIN
    INSERT INTO Produto (nome, quantidade, precoVenda) VALUES
        ('Notebook Dell', 10, 3500.00),
        ('Mouse sem fio', 50, 89.90),
        ('Teclado mecânico', 30, 249.90),
        ('Monitor 24"', 15, 1299.00),
        ('Headset gamer', 20, 399.90);
END
GO

PRINT 'Banco loja configurado com sucesso!';
