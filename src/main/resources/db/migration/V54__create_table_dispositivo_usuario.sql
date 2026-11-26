CREATE TABLE dispositivo_usuario (
 id uuid PRIMARY KEY,
 usuario_id uuid NOT NULL REFERENCES usuario(id),
 token_push text NOT NULL UNIQUE,
 plataforma text NOT NULL DEFAULT 'ANDROID' CHECK(plataforma='ANDROID'),
 atualizado_em timestamptz NOT NULL DEFAULT now()
);