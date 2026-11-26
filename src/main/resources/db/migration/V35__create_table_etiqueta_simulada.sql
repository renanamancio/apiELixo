CREATE TABLE etiqueta_simulada (
 id uuid PRIMARY KEY,
 envio_id uuid NOT NULL UNIQUE REFERENCES envio(id),
 pagamento_id uuid NOT NULL UNIQUE REFERENCES pagamento_simulado(id),
 arquivo_id uuid NOT NULL REFERENCES arquivo(id),
 aviso text NOT NULL DEFAULT 'SIMULAÇÃO — SEM VALIDADE PARA POSTAGEM'
 CHECK(aviso='SIMULAÇÃO — SEM VALIDADE PARA POSTAGEM'),
 invalidada_em timestamptz
);