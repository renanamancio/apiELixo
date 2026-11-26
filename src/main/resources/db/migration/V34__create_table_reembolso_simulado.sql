CREATE TABLE reembolso_simulado (
 id uuid PRIMARY KEY,
 pagamento_id uuid NOT NULL UNIQUE,
 valor numeric(4,2) NOT NULL,
 criado_em timestamptz NOT NULL DEFAULT now(),
 FOREIGN KEY(pagamento_id,valor) REFERENCES pagamento_simulado(id,valor)
);