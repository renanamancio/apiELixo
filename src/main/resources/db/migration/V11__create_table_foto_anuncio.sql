CREATE TABLE foto_anuncio (
 anuncio_id uuid NOT NULL REFERENCES anuncio(id),
 arquivo_id uuid NOT NULL REFERENCES arquivo(id),
 ordem smallint NOT NULL CHECK(ordem BETWEEN 1 AND 6),
 PRIMARY KEY(anuncio_id,ordem),
 UNIQUE(anuncio_id,arquivo_id)
);