CREATE TRIGGER conferir_conversa_antes_da_mensagem BEFORE INSERT ON mensagem
 FOR EACH ROW EXECUTE FUNCTION conferir_escrita_conversa();