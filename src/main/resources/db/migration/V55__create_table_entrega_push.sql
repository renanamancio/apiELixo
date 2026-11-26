CREATE TABLE entrega_push (
 id uuid PRIMARY KEY,
 notificacao_id uuid NOT NULL REFERENCES notificacao(id),
 dispositivo_id uuid NOT NULL REFERENCES dispositivo_usuario(id),
 estado text NOT NULL CHECK(estado IN ('PENDENTE','ENVIADO','FALHOU','DESCARTADO')),
 tentativas integer NOT NULL DEFAULT 0 CHECK(tentativas>=0),
 UNIQUE(notificacao_id,dispositivo_id)
);