CREATE DOMAIN texto_obrigatorio AS text
    CHECK (VALUE ~ '[^[:space:]]');

CREATE DOMAIN medida AS text
    CHECK (VALUE IN ('UNIDADES', 'KG'));

CREATE DOMAIN modalidade AS text
    CHECK (VALUE IN ('PRESENCIAL', 'CORREIOS_SIMULADO'));