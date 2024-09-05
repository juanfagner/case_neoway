-- Macro para tratar campos nulos e em branco e trás resultado em caixa alta.

{% macro tratar_nulo_brancos(field, default_value) %}
    UPPER(COALESCE(NULLIF({{ field }}, ''), {{ default_value }}))
{% endmacro %}