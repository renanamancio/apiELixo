CREATE TABLE interesse (
 id uuid PRIMARY KEY,
 anuncio_id uuid NOT NULL,
 coletor_id uuid NOT NULL REFERENCES usuario(id),
 tipo_medida medida NOT NULL,
 modalidade modalidade NOT NULL,
 quantidade numeric(9,3) NOT NULL CHECK(quantidade>0 AND quantidade<=999999.999),
 estado text NOT NULL CHECK(estado IN ('PENDENTE','ACEITO','DESISTIDO','REJEITADO','ENCERRADO')),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 criado_em timestamptz NOT NULL DEFAULT now(),
 CHECK(tipo_medida<>'UNIDADES' OR (quantidade=trunc(quantidade) AND quantidade<=999999)),
 FOREIGN KEY(anuncio_id,tipo_medida) REFERENCES anuncio(id,tipo_medida),
 motivo_encerramento text,
 CHECK(motivo_encerramento IS NULL OR (estado='ENCERRADO' AND motivo_encerramento='MUDANCA_MODALIDADE')),
 UNIQUE(id,anuncio_id,coletor_id,tipo_medida,modalidade,quantidade)
);