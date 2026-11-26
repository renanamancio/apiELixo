CREATE TABLE decisao_denuncia (
 id uuid PRIMARY KEY,
 denuncia_id uuid NOT NULL UNIQUE REFERENCES denuncia(id),
 gestor_id uuid NOT NULL REFERENCES usuario(id),
 resposta texto_obrigatorio NOT NULL CHECK(char_length(resposta)<=2000),
 criada_em timestamptz NOT NULL DEFAULT now()
);