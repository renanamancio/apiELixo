CREATE TRIGGER preservar_confirmacao BEFORE INSERT OR UPDATE ON idempotencia
 FOR EACH ROW EXECUTE FUNCTION proteger_resposta_confirmacao();