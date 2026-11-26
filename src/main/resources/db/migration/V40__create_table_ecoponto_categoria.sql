CREATE TABLE ecoponto_categoria (
 revisao_id uuid NOT NULL REFERENCES ecoponto_revisao(id),
 categoria_id uuid NOT NULL REFERENCES categoria_residuo(id),
 PRIMARY KEY(revisao_id,categoria_id)
);