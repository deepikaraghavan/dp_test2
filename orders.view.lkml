view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: random_number {
    type: number
    sql: round(rand(),2) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,day_of_week,day_of_week_index
    ]
    sql: ${TABLE}.created_at ;;
  }

  measure:filtered_by_date {
    type: count
    filters: {
      field: created_date
      value: "yesterday"
    }
  }

#   dimension: hourextract {
#     type: date
#     sql: EXTRACT(HOUR FROM ${created_raw}) ;;
#
#   }

  dimension: until_today {
    type: yesno
    sql: ${created_day_of_week_index}<= WEEKDAY(NOW()) AND ${created_day_of_week_index}>=0 ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;

  }

  measure: count_complete_lastmonth {
    type: count
    filters: {
      field: status
      value: "complete"
    }
    filters: {
      field: created_month
      value: "last month"
    }
  }

  filter: status_filter {
    type: string
    suggest_dimension: orders.status
    suggest_explore: order_items
  }

  dimension: status_satisfies_filter{
    type: yesno
    hidden: yes
    sql: {% condition status_filter %} ${status} {% endcondition %} ;;
  }

  measure: count_statusselected {
    type: count
    filters: {
      field: status_satisfies_filter
      value: "no"
#     link: {
#       label: "clickme"
#       url: "/dashboards/1242?embed_domain=https://localhost:8000"

    }
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count_abc {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
