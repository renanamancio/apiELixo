CREATE TABLE movimentacao_saldo (
 id uuid PRIMARY KEY,
 anuncio_id uuid NOT NULL REFERENCES anuncio(id),
 acordo_id uuid REFERENCES acordo(id),
 tipo text NOT NULL CHECK(tipo IN ('INICIAL','ACRESCIMO','RESERVA','CONSUMO','BLOQUEIO','LIBERACAO')),
 quantidade numeric(9,3) NOT NULL CHECK(quantidade>0 AND quantidade<=999999.999),
 ator_id uuid REFERENCES usuario(id),
 criada_em timestamptz NOT NULL DEFAULT now(),
 CHECK((tipo IN ('INICIAL','ACRESCIMO') AND acordo_id IS NULL) OR (tipo NOT IN ('INICIAL','ACRESCIMO') AND acordo_id IS NOT NULL))
);