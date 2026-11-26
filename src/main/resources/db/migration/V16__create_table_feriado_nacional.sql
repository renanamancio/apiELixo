CREATE TABLE feriado_nacional (
 calendario_id uuid NOT NULL REFERENCES calendario(id),
 data date NOT NULL,
 nome text NOT NULL,
 fonte text NOT NULL,
 PRIMARY KEY(calendario_id,data)
); 