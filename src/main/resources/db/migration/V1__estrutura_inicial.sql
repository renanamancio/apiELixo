-- E-Lixo | projeto técnico v0.4 | 21/11/2026 | RASCUNHO PARA REVISÃO
-- Fonte: consolidação v0.2 rev20 e aprovações posteriores. Contrato físico da Etapa 3.
-- Aplicar somente em banco vazio de desenvolvimento. UUIDs gerados pela aplicação ou, na rotina de troca, pelo banco.
-- NUMERIC(p,s) arredonda na conversão: a API DEVE rejeitar precisão excedente antes do INSERT.
-- Regras entre tabelas e autorização estão explicitadas em REGRAS.md.
-- Origem: contratos-originais-v0.4/schema.sql. O Flyway gerencia a transação desta migração.
CREATE SCHEMA elixo;
SET LOCAL search_path TO elixo, public;
CREATE DOMAIN texto_obrigatorio AS text CHECK (VALUE ~ '[^[:space:]]');
CREATE DOMAIN medida AS text CHECK (VALUE IN ('UNIDADES','KG'));
CREATE DOMAIN modalidade AS text CHECK (VALUE IN ('PRESENCIAL','CORREIOS_SIMULADO'));