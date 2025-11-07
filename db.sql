CREATE DATABASE petshop_db;
USE petshop_db;


CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  email VARCHAR(255),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );


CREATE TABLE pet (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  nome VARCHAR(120) NOT NULL,
  especie ENUM('cachorro','gato','ave','peixe','outro') NOT NULL,
  porte ENUM('pequeno','medio','grande') NOT NULL,
  nascimento DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pet_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE  servico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE,
  preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
  duracao_min INT NOT NULL CHECK (duracao_min > 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ;

CREATE TABLE IF NOT EXISTS agendamento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pet_id INT NOT NULL,
  servico_id INT NOT NULL,
  data_hora DATETIME NOT NULL,
  status ENUM('agendado','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  observacoes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_agendamento_pet FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_agendamento_servico FOREIGN KEY (servico_id) REFERENCES servico(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (status IN ('agendado','concluido','cancelado'))
) ;

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
('Mariana Silva','123.456.789-00','(11) 91234-5678','mariana@example.com'),
('Carlos Oliveira','987.654.321-11','(21) 99876-5432','carlos@example.com'),
('Ana Pereira','111.222.333-44','(31) 91111-2222','ana@example.com');

INSERT INTO servico (nome, preco, duracao_min) VALUES
('Banho simples', 50.00, 30),
('Tosa completa', 120.00, 60),
('Vacina anti-rábica', 80.00, 15);

INSERT INTO pet (cliente_id, nome, especie, porte, nascimento) VALUES
(1, 'Rex', 'cachorro', 'medio', '2019-06-10'),
(2, 'Mia', 'gato', 'pequeno', '2021-03-25'),
(3, 'Nina', 'ave', 'pequeno', '2020-11-05');

INSERT INTO agendamento (pet_id, servico_id, data_hora, status, observacoes) VALUES
(1, 1, '2025-11-10 10:00:00', 'agendado', 'Banho com condicionador'),
(2, 2, '2025-11-12 14:30:00', 'agendado', 'Tosa de verão'),
(3, 3, '2025-11-15 09:00:00', 'agendado', 'Vacina anual');
