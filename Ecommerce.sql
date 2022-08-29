-- criação do banco de dados para o cenário do E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(30),
    City VARCHAR(30),
    State VARCHAR(30),
    UF CHAR(2),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);    

-- criar tabela produto
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(20),
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimentos', 'Móveis') NOT NULL,
    avaliação FLOAT DEFAULT 0,
    size VARCHAR(10),
	Address VARCHAR(30),
    City VARCHAR(30),
    State VARCHAR(30),
    UF CHAR(2)
); 

-- criar tabela pagamento
CREATE TABLE payments(
	idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Cartão', 'PIX'),
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, id_Payment)
);

-- criar tabela pedido
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
	orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients (idClient)
);

-- criar tabela estoque
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- criar tabela fornecedor
CREATE TABLE supplier(
	socialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE(CNPJ)
);

-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
	socialName VARCHAR(255) NOT NULL,
    abstName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15),
    CPF CHAR(9),
	Address VARCHAR(30),
    City VARCHAR(30),
    State VARCHAR(30),
    UF CHAR(2),
    contact VARCHAR(20) NOT NULL,
    CONSTRAINT unique_cnpj_supplier UNIQUE(CNPJ),
    CONSTRAINT unique_cpf_supplier UNIQUE(CPF)
);

-- criar tabela produto vendedor
CREATE TABLE productSeller(
	idPseller INT,
    idPproduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idPproduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)    
);

-- criar tabela produto pedido
CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productorder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- criar tabela localização pedido
CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
	Address VARCHAR(30),
    City VARCHAR(30),
    State VARCHAR(30),
    UF CHAR(2),
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

show tables;





