CREATE FUNCTION conferir_escrita_conversa() RETURNS trigger LANGUAGE plpgsql AS $func$
DECLARE encerramento timestamptz;
BEGIN
 SELECT encerrada_em INTO encerramento FROM elixo.conversa WHERE id=NEW.conversa_id FOR UPDATE;
 IF encerramento IS NOT NULL THEN RAISE EXCEPTION 'CONVERSA_SOMENTE_LEITURA'; END IF;
 RETURN NEW;
END $func$;