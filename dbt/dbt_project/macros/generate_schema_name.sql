{% macro generate_schema_name(custom_schema_name, node) -%}

    {{ macrobrew.generate_schema_name(custom_schema_name, node) }}

{%- endmacro %}
