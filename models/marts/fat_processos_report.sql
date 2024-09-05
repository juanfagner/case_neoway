{{ config(
    materialized='table'
) }}

WITH processos_base AS (
    SELECT
        cnpj
        ,assuntosCNJ
        ,unidadeOrigem
        ,citacaoTipo
        ,orgaoJulgador
        ,comarca
        ,uf
        ,julgamento
        ,ultimoEstado
        ,area
        ,dataEncerramento
        ,grauProcesso
        ,tribunal
        ,count(distinct case when dataEncerramento is not null then concat(dataEncerramento, '-', cnpj) else null end) as processosEncerrados
        ,count(distinct case when dataEncerramento is null then cnpj else null end) as processosEmAberto
        ,valorPredicaoCondenacao
        ,valorCausa
    FROM
        {{ ref('stg_processos') }}

   GROUP BY
        cnpj
        ,assuntosCNJ
        ,unidadeOrigem
        ,citacaoTipo
        ,orgaoJulgador
        ,comarca
        ,uf
        ,julgamento
        ,ultimoEstado
        ,area
        ,dataEncerramento
        ,grauProcesso
        ,tribunal
        ,valorPredicaoCondenacao
        ,valorCausa
)

SELECT
    *
FROM
    processos_base