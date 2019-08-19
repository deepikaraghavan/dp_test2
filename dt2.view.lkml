view: dt2_test {
  derived_table: {
    indexes: ["orders.id"]
    datagroup_trigger: dp_datagroup
    sql: SELECT
          orders.id  AS `orders.id`,
          COUNT(DISTINCT products.id ) AS `products.count`
          FROM ${derived_table.SQL_TABLE_NAME}
          group by 1;;
    }
dimension: orders_id_dt2 {
  type: number
  primary_key: yes
  sql: ${TABLE}.`orders.id` ;;
}

dimension: products_count_dt2 {
  type: number
  sql: ${TABLE}.`products.count` ;;
}
}
