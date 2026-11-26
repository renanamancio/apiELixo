CREATE TABLE documento_usuario (
 usuario_id uuid PRIMARY KEY REFERENCES usuario(id),
 tipo text NOT NULL CHECK(tipo IN ('CPF','CNPJ')),
 valor texto_obrigatorio NOT NULL UNIQUE,
 UNIQUE(usuario_id,tipo),
 CHECK((tipo='CPF' AND valor ~ '^[0-9]{11}$') OR
       (tipo='CNPJ' AND valor ~ '^[A-Z0-9]{12}[0-9]{2}$'))
);