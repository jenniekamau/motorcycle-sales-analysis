# motorcycle-sales-analysis
SQL analysis and Tableau interactive dashboard evaluating motorcycle parts sales performance
Motorcycle Parts Sales & Revenue AnalyticsAn end-to-end business intelligence and data analytics solution evaluating sales performance, inventory drivers, warehouse operations, and payment trends for a motorcycle parts company during peak summer operations (June – August).📸 Executive Dashboard📌 Business Context & Strategic GoalsThe organization needed data-driven visibility into its operations across three regional warehouses (Central, North, West) and two primary sales channels (Wholesale, Retail).🎯 Key Objectives:Warehouse Efficiency: Determine which warehouse locations drive high cash flow versus high transaction/shipping volume.Product Performance: Identify high-margin revenue drivers versus high-volume inventory movers across product lines.Customer Segmentation & Payment Analysis: Map client buying behavior and payment channel preferences across Wholesale vs. Retail.Revenue Momentum: Track monthly growth trajectories to optimize cash flow forecasting.🛠️ Tech Stack & Analytical ToolsDatabase Engine: PostgreSQL (pgAdmin 4)Query Language: SQL (Data Aggregation, Type Casting, Multi-dimensional Grouping)Visualization: Tableau Public / DesktopDocumentation: Markdown & GitHub📊 Exploratory Data Analysis & SQL QueriesBelow are the key SQL queries developed to extract business insights from the dataset:1. Warehouse Revenue vs. Volume PerformanceEvaluates financial contribution alongside operational workload per warehouse location.SQLSELECT 
    warehouse,
    client_type,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(total::NUMERIC), 2) AS gross_revenue,
    ROUND(AVG(total::NUMERIC), 2) AS avg_order_value
FROM sales
GROUP BY warehouse, client_type
ORDER BY gross_revenue DESC;
Key Finding: Central Warehouse is the primary financial engine, generating £283.97K in gross revenue across both client segments.2. Product Line Classification (Margin vs. Volume Drivers)Distinguishes high-value catalog items from bulk inventory movers.SQLSELECT 
    product_line,
    SUM(quantity) AS volume_driver,
    ROUND(AVG(unit_price::NUMERIC), 2) AS avg_unit_price,
    ROUND(SUM(total::NUMERIC), 2) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;
Key Finding: Suspension & Traction (£146.03K) and Frame & Body (£138.05K) bring in the vast majority of total cash flow, making them core revenue drivers.3. Payment Method & Client Segment ContributionAnalyzes transaction volume and revenue contribution by payment channel.SQLSELECT 
    payment,
    client_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(total::NUMERIC), 2) AS total_revenue,
    ROUND(100.0 * SUM(total) / (SELECT SUM(total) FROM sales), 2) AS pct_share_of_total
FROM sales
GROUP BY payment, client_type
ORDER BY total_revenue DESC;
Key Finding: Transfer payments account for the highest dollar volume (£319.28K), heavily driven by B2B Wholesale buyers who make large-value purchases.4. Monthly Revenue Velocity TrendTracks month-over-month revenue performance split by client type.SQLSELECT 
    TO_CHAR(date, 'YYYY-MM') AS sales_month,
    client_type,
    ROUND(SUM(total::NUMERIC), 2) AS total_monthly_revenue,
    ROUND(AVG(total::NUMERIC), 2) AS avg_order_value
FROM sales
GROUP BY TO_CHAR(date, 'YYYY-MM'), client_type
ORDER BY sales_month ASC, total_monthly_revenue DESC;
Key Finding: Wholesale sales accelerated sharply into August, reaching £122.91K, showing strong peak-season demand.📈 Key Insights & Strategic RecommendationsInsight AreaAnalytical FindingStrategic Action ItemLogisticsCentral Warehouse generates ~49% of total revenue.Prioritize inventory safety stock and staffing allocation at the Central distribution point.Product StrategySuspension, Traction, and Frame parts are high-value category leaders.Bundle low-volume accessories (e.g., Miscellaneous) with high-value suspension items to increase AOV.Payment OperationsWholesale clients depend heavily on bank transfers (£319K+).Ensure fast-track invoice verification for transfer transactions to prevent order delays.Customer ChannelsWholesale order values (£122K/mo) far exceed Retail volume.Introduce dedicated account management for top Wholesale accounts to sustain summer momentum.
