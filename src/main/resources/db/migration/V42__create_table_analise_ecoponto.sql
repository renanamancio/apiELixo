CREATE TABLE analise_ecoponto (
 id uuid PRIMARY KEY,
 revisao_id uuid NOT NULL UNIQUE REFERENCES ecoponto_revisao(id),
 gestor_id uuid NOT NULL REFERENCES usuario(id),
 decisao text NOT NULL CHECK(decisao IN ('APROVAR','REJEITAR')),
 justificativa texto_obrigatorio NOT NULL CHECK(char_length(justificativa)<=2000),
 criada_em timestamptz NOT NULL DEFAULT now()
);