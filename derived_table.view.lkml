view: derived_table {
  derived_table: {
    datagroup_trigger: dp_datagroup
    sql: SELECT
        orders.id  AS `orders.id`,
        COUNT(DISTINCT products.id ) AS `products.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

      GROUP BY 1
      ORDER BY COUNT(DISTINCT products.id ) DESC
      LIMIT 500
       ;;
      indexes: ["orders.id"]
  }

  dimension: dt_sql_reference_Test {
    type: string
    sql: ${derived_table.SQL_TABLE_NAME}.orders.id ;;
  }

  dimension: orders_id_dt {
    type: number
    primary_key: yes
    sql: ${TABLE}.`orders.id` ;;
  }

  dimension: products_count_dt {
    type: number
    sql: ${TABLE}.`products.count` ;;
  }

  measure: count_orders_derived_dt {
    type: count_distinct
    sql: ${products_count_dt} ;;
  }

}
