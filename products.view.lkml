view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    html: <a href="/dashboards/1821?Product Category={{ value }}">{{ value }}</a> ;;
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

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  measure: half_price {
    type: number
    sql: ${retail_price}/2 ;;
    value_format_name: usd_0
    html: <font color="green">{{rendered_value}}</font> ;;
  }

  measure: retailprice {
    type: sum
    sql: ${retail_price} ;;
    html:
    {% if value < 10 %}
    <font color="red">{{rendered_value}}</font>
    {% elsif value < 20 and value >= 10 %}
    <font color="blue">{{rendered_value}}</font>
    {% elsif value < 30 and value >= 20 %}
    <font color="green">{{rendered_value}}</font>
    {% else %}
    <font color="maroon">{{rendered_value}}</font>
    {% endif %}
    ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [department, inventory_items.count]
    html: <a href="{{ link }}&f[inventory_items.count]=>=300">{{ rendered_value }}</a> ;;
  }
}
