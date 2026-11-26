CREATE TABLE pagamento_simulado (
 id uuid PRIMARY KEY,
 cotacao_id uuid NOT NULL,
 envio_id uuid NOT NULL,
 valor numeric(4,2) NOT NULL,
 estado text NOT NULL CHECK(estado IN ('APROVADO','FALHOU')),
 criado_em timestamptz NOT NULL DEFAULT now(),
 FOREIGN KEY(cotacao_id,envio_id,valor) REFERENCES cotacao_frete(id,envio_id,total), UNIQUE(id,valor)
);