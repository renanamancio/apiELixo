CREATE TABLE outbox (
 id uuid PRIMARY KEY,
 agregado_tipo text NOT NULL,
 agregado_id uuid NOT NULL,
 evento_tipo text NOT NULL,
 esquema_versao integer NOT NULL DEFAULT 1,
 payload jsonb NOT NULL,
 criado_em timestamptz NOT NULL DEFAULT now(),
 publicado_em timestamptz,
 tentativas integer NOT NULL DEFAULT 0 CHECK(tentativas>=0),
 proxima_tentativa_em timestamptz NOT NULL DEFAULT now()
);