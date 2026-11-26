CREATE TABLE decisao_acordo (
 id uuid PRIMARY KEY,
 analise_id uuid NOT NULL REFERENCES analise_acordo(id),
 gestor_id uuid NOT NULL REFERENCES usuario(id),
 decisao text NOT NULL CHECK(decisao IN ('CONCLUIR','CANCELAR','MANTER_AGUARDANDO','ENCERRAR_SEM_ENTREGA')),
 justificativa texto_obrigatorio NOT NULL CHECK(char_length(justificativa)<=2000),
 criada_em timestamptz NOT NULL DEFAULT now()
);