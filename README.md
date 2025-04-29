# TASK-6-Sales-Trend-Analysis-Using-Aggregations
1.Created Sample Dataset:
  A table named online_sales was created with columns: order_id, order_date, amount, and product_id.
  The order_id was designed as an alphanumeric sequence (e.g., 'ORD1001') using text to support textual IDs.

2.Data Insertion with UPSERT:
  Sample data was inserted into the table.
  Used INSERT ... ON CONFLICT ... DO UPDATE  to insert new records or update existing ones based on the order_date.

3.Date Extraction for Time-Based Grouping:
  Used extract(year from order_date) and extract(month from order_date) to extract the year and month from the order_date column.
  These extracted values were used directly in the GROUP BY clause to aggregate data monthly.

4.Sales Aggregation:
  Used SUM(amount) to calculate the total revenue for each month.
  Used COUNT(DISTINCT order_id) to determine the number of unique orders placed each month.

5.Top Month Filtering:
  Sorted the aggregated results in descending order of total revenue using ORDER BY.
  Applied LIMIT 3 to fetch the top 3 months by revenue.

📊 Output Example (Based on Sample Data)

Year	Month	Total Sales	Order Volume
2024	03	1120.00	3
2024	04	1030.00	3
2024	01	700.00	2
