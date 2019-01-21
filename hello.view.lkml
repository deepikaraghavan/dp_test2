view: hello {
  sql_table_name: public.hello ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
