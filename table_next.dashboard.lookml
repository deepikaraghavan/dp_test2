
- dashboard: table_next_viz_test
  title: Table Next Viz Test
  layout: newspaper
  elements:
  - title: Table Next Subtotal
    name: Table Next Subtotal
    model: DP-Ecomm
    explore: order_items
    type: table_with_subtotals
    fields: [products.brand, products.category, products.count_xyz]
    sorts: [products.brand]
    subtotals: [products.brand]
    limit: 500
    query_timezone: Etc/GMT+2
    series_types: {}
    row: 0
    col: 0
    width: 8
    height: 6
