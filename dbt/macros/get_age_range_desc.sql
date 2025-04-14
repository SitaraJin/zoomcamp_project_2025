{#
    This macro returns the description of the age_range 
#}

{% macro get_age_range_desc(age) -%}

    case {{ dbt.safe_cast("Age", api.Column.translate_type("integer")) }}  
        when 1 then 'Under 18'
        when 18 then '18-24'
        when 25 then '25-34'
        when 35 then '35-44'
        when 45 then '45-49'
        when 50 then '50-55'
        when 56 then '56+'
        else 'EMPTY'
    end

{%- endmacro %}