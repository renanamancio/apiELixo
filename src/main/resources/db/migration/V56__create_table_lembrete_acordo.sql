CREATE TABLE lembrete_acordo (
 id uuid PRIMARY KEY,
 acordo_id uuid NOT NULL REFERENCES acordo(id),
 vencimento_referencia timestamptz NOT NULL,
 disparar_em timestamptz NOT NULL,
 estado text NOT NULL CHECK(estado IN ('PENDENTE','ENVIADO','SUBSTITUIDO','CANCELADO')),
 UNIQUE(acordo_id,vencimento_referencia),
 CHECK(disparar_em=vencimento_referencia-interval '24 hours')
);