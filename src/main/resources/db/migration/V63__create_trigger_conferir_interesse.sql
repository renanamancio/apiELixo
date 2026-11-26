CREATE TRIGGER conferir_interesse BEFORE INSERT OR UPDATE OF estado ON interesse
 FOR EACH ROW EXECUTE FUNCTION conferir_estado_interesse();