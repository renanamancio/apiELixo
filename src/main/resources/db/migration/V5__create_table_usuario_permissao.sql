CREATE TABLE usuario_permissao (
 usuario_id uuid NOT NULL REFERENCES usuario(id),
 permissao text NOT NULL CHECK(permissao IN ('GESTOR','SUPERUSUARIO')),
 PRIMARY KEY(usuario_id,permissao)
);