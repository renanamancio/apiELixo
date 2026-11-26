CREATE TABLE idempotencia (
 usuario_id uuid NOT NULL REFERENCES usuario(id),
 operacao text NOT NULL,
 chave uuid NOT NULL,
 hash_requisicao text NOT NULL,
 estado text NOT NULL CHECK(estado IN ('PROCESSANDO','CONCLUIDA')),
 status_http integer CHECK(status_http BETWEEN 100 AND 599),
 resposta jsonb,
 criado_em timestamptz NOT NULL DEFAULT now(),
 concluida_em timestamptz,
 confirmacao_id uuid UNIQUE,
 PRIMARY KEY(usuario_id,operacao,chave),
 FOREIGN KEY(confirmacao_id,usuario_id) REFERENCES confirmacao_entrega(id,usuario_id),
 CHECK((estado='PROCESSANDO' AND concluida_em IS NULL AND status_http IS NULL AND resposta IS NULL)
    OR (estado='CONCLUIDA' AND concluida_em IS NOT NULL AND concluida_em>=criado_em AND status_http IS NOT NULL)),
 CHECK((confirmacao_id IS NOT NULL) = (operacao='post_acordos_id_confirmacoes' AND
       estado='CONCLUIDA' AND status_http BETWEEN 200 AND 299))
);