CREATE TABLE anexo_denuncia (
 denuncia_id uuid NOT NULL REFERENCES denuncia(id),
 arquivo_id uuid NOT NULL REFERENCES arquivo(id),
 ordem smallint NOT NULL CHECK(ordem BETWEEN 1 AND 5),
 PRIMARY KEY(denuncia_id,ordem),
 UNIQUE(denuncia_id,arquivo_id)
);