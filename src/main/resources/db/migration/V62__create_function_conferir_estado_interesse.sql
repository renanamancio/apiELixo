CREATE FUNCTION conferir_estado_interesse() RETURNS trigger LANGUAGE plpgsql AS $func$
DECLARE modalidade_atual elixo.modalidade;
BEGIN
 IF TG_OP='UPDATE' THEN
   IF NEW.estado=OLD.estado THEN RETURN NEW; END IF;
   IF NEW.estado='PENDENTE' OR (NEW.estado='ACEITO' AND OLD.estado<>'PENDENTE') THEN
     RAISE EXCEPTION 'INTERESSE_NAO_PENDENTE';
   END IF;
 END IF;
 SELECT modalidade INTO STRICT modalidade_atual FROM elixo.anuncio WHERE id=NEW.anuncio_id FOR UPDATE;
 IF NEW.estado IN ('PENDENTE','ACEITO') AND NEW.modalidade<>modalidade_atual THEN
   RAISE EXCEPTION 'MODALIDADE_DESATUALIZADA';
 END IF;
 IF (TG_OP='INSERT' AND NEW.estado='PENDENTE') OR (TG_OP='UPDATE' AND OLD.estado='PENDENTE') THEN
   UPDATE elixo.anuncio SET versao=versao+1 WHERE id=NEW.anuncio_id;
 END IF;
 RETURN NEW;
END $func$;