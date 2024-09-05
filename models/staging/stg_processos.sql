
{{ config(
    materialized='view'
) }}

SELECT
    cast(cnpj as int64) as cnpj
    ,assuntosCNJ
    ,upper(unidadeOrigem) as unidadeOrigem
    ,upper(citacaoTipo) as citacaoTipo
    ,upper(orgaoJulgador) as orgaoJulgador
    ,upper(comarca) as comarca
    ,upper(uf) as uf
    ,upper(julgamento) as julgamento
    ,upper(ultimoEstado) as ultimoEstado
    ,upper(area) as area
    ,cast(dataEncerramento as date) as dataEncerramento
    ,grauProcesso
    ,upper(tribunal) as tribunal
    ,valorPredicaoCondenacao
    ,valorCausa
FROM
    `case-neoway-434120.Empresas.processos`
WHERE
    cnpj is not null