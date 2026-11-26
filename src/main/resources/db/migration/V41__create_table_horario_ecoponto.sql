CREATE TABLE horario_ecoponto (
 id uuid PRIMARY KEY,
 revisao_id uuid NOT NULL REFERENCES ecoponto_revisao(id),
 dia_semana smallint NOT NULL CHECK(dia_semana BETWEEN 1 AND 7),
 abre time NOT NULL,
 fecha time NOT NULL,
 CHECK(fecha>abre),
 UNIQUE(revisao_id,dia_semana,abre,fecha)
);