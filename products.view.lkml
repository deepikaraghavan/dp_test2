view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: CanParameterBeAnyField {
    type: string
    sql: {% parameter brand %} ;;
  }

  dimension: brand{
    label: "BrandName"
    type: string
    sql: ${TABLE}.brand ;;
#     html: <b><font size="50" color="#166088">{{value}}</font></b> ;;
#     required_access_grants: [dp_access_grant]
  }
  dimension: brand_link {
  type: string
  sql: ${TABLE}.brand ;;
  html: <a href="https://www.google.com/search?q={{value}}">{{value}}</a> ;;
  }

  dimension: todays_Date {
    type: date
    sql: curdate() ;;
  }

  dimension: link {
    type: string
    sql: "Click Here";;
    link: {
      label: "/dashboards/1852?ProductCategory={{ _filters['products.category'] | url_encode}}&Brand={{ _filters['products.brand'] | url_encode}}&Item={{ _filters['products.item_name'] | url_encode}}"
      url: "/dashboards/1852?ProductCategory={{ _filters['products.category'] | url_encode}}&Brand={{ _filters['products.brand'] | url_encode}}&Item={{ _filters['products.item_name'] | url_encode}}"
    }
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    html: <a href="/dashboards/1821?Product Category={{ value }}">{{ value }}</a> ;;
#     order_by_field: brand
  }



  dimension: orderstatus {
    type: string
    sql: ${deepika.status} ;;
  }

  measure: filteredMeasure{
    type: sum
    sql: ${retail_price} ;;
    value_format_name: decimal_0
    filters: {
      field: category
      value: "Accessories"
    }
  }

  measure: filteredMeasure_countdistinct{
    type: count_distinct
    sql: ${id} ;;
    value_format_name: decimal_0
    filters: {
      field: category
      value: "Accessories"
    }
  }
  measure: retailprice {
    type: sum
    sql: ${retail_price} ;;
#     value_format_name: decimal_0
  }

  filter: templatedfilter {
    type: string
    suggest_dimension: category
    suggest_explore: products
  }

  dimension: templateyesno {
    type: yesno
    sql: {% condition templatedfilter %} ${category} {% endcondition %} ;;
  }

  dimension: categorylinktoexplore{
    type: string
    sql: ${TABLE}.category ;;
    html: <a href="https://master.dev.looker.com/explore/DP-Ecomm/products?fields=products.half_price,products.category,products.item_name&f[products.category]={{value | url_encode}}">{{ value }}</a> ;;
  }
  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: Days_from_Event_Today {
    type: date
    sql: CURDATE() ;;
  }

  dimension: retail_price {
    type: number
    sql: round(${TABLE}.retail_price,0) ;;
  }

  dimension: mm_ss_test {
    type: number
    sql: round(${TABLE}.retail_price,0) ;;
    html: {% assign seconds= value | modulo: 60 %}
    {{ value | divided_by: 60 | floor }}:{% if seconds < 10 %}0{% endif %}{{seconds }} ;;
  }
  measure: half_price_content_validator {
    type: number
    sql: ${retail_price}/2 ;;
    value_format_name: usd_0
    html: <font color="green">{{rendered_value}}</font> ;;
  }

  dimension: float_value_x_axis_test {
    type: number
    sql: ${TABLE}.retail_price*1.234566778889995
  }

  measure: retailprice {
    type: max
    sql: ${TABLE}.retail_price ;;
    value_format_name: decimal_2
#     html:
#     {% if value < 10 %}
#     <font color="red">{{rendered_value}}</font>
#     {% elsif value < 20 and value >= 10 %}
#     <font color="blue">{{rendered_value}}</font>
#     {% elsif value < 30 and value >= 20 %}
#     <font color="green">{{rendered_value}}</font>
#     {% else %}
#     <font color="maroon">{{rendered_value}}</font>
#     {% endif %}
#     ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
    html: <div style="width:150px"> {{value}} </div> ;;
  }

  measure: count_xyz {
    type: count
    drill_fields: [department, inventory_items.count]
    html: <a href="{{ link }}&f[inventory_items.count]=>=300">{{ rendered_value }}</a> ;;
  }

  measure: average {
    type: number
    sql: avg(${retail_price});;
    value_format_name: decimal_0
  }

  parameter: choose_the_measure {
    type: string
    allowed_value: {
      value: "count"
    }
    allowed_value: {
    value: "half_price"
    }
  }

  measure: selected_measure {
    label_from_parameter: choose_the_measure
    type: number
    sql: case when {% parameter choose_the_measure %}='count' THEN ${count_xyz}
    when {% parameter choose_the_measure %}='half_price' THEN ${half_price_content_validator}
    else null
    end;;
  }

  filter: date_test {
    type: date
  }
}
