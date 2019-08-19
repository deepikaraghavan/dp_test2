connection: "thelook"

# include all the views
include: "*.view"
include: "*.dashboard"
# include: "schema_migrations/schema_migrations.view"
access_grant: deepika1 {
  allowed_values: ["yes"]
  user_attribute: dp
}
access_grant: deepika2 {
  allowed_values: ["yes"]
  user_attribute: dp_access_grant
}
datagroup: dp_datagroup {
  sql_trigger: SELECT CURDATE() ;;
  max_cache_age: "1 hour"
}
# access_grant: dp_access_grant {
#   user_attribute: dp_access_grant
#   allowed_values: ["Rajan"]
# }
# persist_with: test_folders_default_datagroup
explore: extendedview {}
explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: inventory_items {
  fields: [ALL_FIELDS*,-products.orderstatus]
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  fields: [ALL_FIELDS*,-products.orderstatus]
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: derived_table {
    type: left_outer
    sql_on: ${orders.id} = ${derived_table.orders_id_dt} ;;
    relationship: many_to_one

  }
  join: dt2_test {
    type: left_outer
    sql_on: ${derived_table.orders_id_dt}=${dt2_test.orders_id_dt2} ;;
    relationship: many_to_one
  }
}

explore: deepika {
  from: orders
  join: users {
    type: left_outer
    sql_on: ${deepika.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  fields: [ALL_FIELDS*,-products.orderstatus]
  }

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}
