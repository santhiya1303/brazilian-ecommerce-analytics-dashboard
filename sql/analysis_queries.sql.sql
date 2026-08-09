CREATE DATABASE IF NOT EXISTS olist_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE olist_db;

DROP TABLE IF EXISTS olist_master;

CREATE TABLE olist_master (
    order_id                        CHAR(32)      NOT NULL,
    order_item_id                   INT           NOT NULL,
    product_id                      CHAR(32)      NOT NULL,
    seller_id                       CHAR(32)      NOT NULL,
    shipping_limit_date             DATETIME      NULL,
    price                           DECIMAL(10,2) NULL,
    freight_value                   DECIMAL(10,2) NULL,
    customer_id                     CHAR(32)      NOT NULL,
    order_status                    VARCHAR(20)   NULL,
    order_purchase_timestamp        DATETIME      NULL,
    order_approved_at               DATETIME      NULL,
    order_delivered_carrier_date    DATETIME      NULL,
    order_delivered_customer_date   DATETIME      NULL,
    order_estimated_delivery_date   DATE          NULL,
    product_category_name           VARCHAR(100)  NULL,
    product_name_lenght             INT           NULL,
    product_description_lenght      INT           NULL,
    product_photos_qty              INT           NULL,
    product_weight_g                INT           NULL,
    product_length_cm               INT           NULL,
    product_height_cm               INT           NULL,
    product_width_cm                INT           NULL,
    product_category_name_english   VARCHAR(50)   NULL,
    seller_zip_code_prefix          INT           NULL,
    seller_city                     VARCHAR(50)   NULL,
    seller_state                    CHAR(2)       NULL,
    customer_unique_id               CHAR(32)      NULL,
    customer_zip_code_prefix        INT           NULL,
    customer_city                   VARCHAR(50)   NULL,
    customer_state                  CHAR(2)       NULL,
    payment_value                   DECIMAL(10,2) NULL,
    payment_installments            INT           NULL,
    payment_type                    VARCHAR(20)   NULL,
    review_score                    TINYINT       NULL,
    delivery_delay_days             INT           NULL,
    PRIMARY KEY (order_id, order_item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

USE olist_db;

SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'C:/Users/santh/OneDrive/Files/Python files/Portfolio Projects/olist_master.csv'
INTO TABLE olist_master
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id, order_item_id, product_id, seller_id,
    @shipping_limit_date, @price, @freight_value,
    customer_id, order_status, @order_purchase_timestamp,
    @order_approved_at, @order_delivered_carrier_date,
    @order_delivered_customer_date, @order_estimated_delivery_date,
    @product_category_name, @product_name_lenght, @product_description_lenght,
    @product_photos_qty, @product_weight_g, @product_length_cm,
    @product_height_cm, @product_width_cm, @product_category_name_english,
    @seller_zip_code_prefix, @seller_city, @seller_state,
    @customer_unique_id, @customer_zip_code_prefix, @customer_city, @customer_state,
    @payment_value, @payment_installments, @payment_type,
    @review_score, @delivery_delay_days
)
SET
    shipping_limit_date            = NULLIF(@shipping_limit_date,''),
    price                           = NULLIF(@price,''),
    freight_value                   = NULLIF(@freight_value,''),
    order_purchase_timestamp        = NULLIF(@order_purchase_timestamp,''),
    order_approved_at               = NULLIF(@order_approved_at,''),
    order_delivered_carrier_date    = NULLIF(@order_delivered_carrier_date,''),
    order_delivered_customer_date   = NULLIF(@order_delivered_customer_date,''),
    order_estimated_delivery_date   = NULLIF(@order_estimated_delivery_date,''),
    product_category_name           = NULLIF(@product_category_name,''),
    product_name_lenght             = NULLIF(@product_name_lenght,''),
    product_description_lenght      = NULLIF(@product_description_lenght,''),
    product_photos_qty              = NULLIF(@product_photos_qty,''),
    product_weight_g                = NULLIF(@product_weight_g,''),
    product_length_cm               = NULLIF(@product_length_cm,''),
    product_height_cm               = NULLIF(@product_height_cm,''),
    product_width_cm                = NULLIF(@product_width_cm,''),
    product_category_name_english   = NULLIF(@product_category_name_english,''),
    seller_zip_code_prefix          = NULLIF(@seller_zip_code_prefix,''),
    seller_city                     = NULLIF(@seller_city,''),
    seller_state                    = NULLIF(@seller_state,''),
    customer_unique_id               = NULLIF(@customer_unique_id,''),
    customer_zip_code_prefix        = NULLIF(@customer_zip_code_prefix,''),
    customer_city                   = NULLIF(@customer_city,''),
    customer_state                  = NULLIF(@customer_state,''),
    payment_value                   = NULLIF(@payment_value,''),
    payment_installments            = NULLIF(@payment_installments,''),
    payment_type                    = NULLIF(@payment_type,''),
    review_score                    = NULLIF(@review_score,''),
    delivery_delay_days             = NULLIF(@delivery_delay_days,'');
    
    SET GLOBAL local_infile = 1;
    
    
SELECT COUNT(*) FROM olist_master;          -- should show 112650
   SELECT * FROM olist_master LIMIT 5;

-- ============================================================
-- Olist Brazilian E-Commerce — Phase B (MySQL)
-- Load olist_master.csv (from Phase A notebook) and run analysis queries
-- ============================================================

-- ------------------------------------------------------------
-- STEP 0: Create database
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS olist_project;
USE olist_project;

-- ------------------------------------------------------------
-- STEP 1: Create table matching olist_master.csv columns
-- (from Phase A notebook output)
-- ------------------------------------------------------------
DROP TABLE IF EXISTS olist_master;

CREATE TABLE olist_master (
    order_id                        VARCHAR(50),
    order_item_id                   INT,
    product_id                      VARCHAR(50),
    seller_id                       VARCHAR(50),
    shipping_limit_date             DATETIME,
    price                           DECIMAL(10,2),
    freight_value                   DECIMAL(10,2),
    customer_id                     VARCHAR(50),
    order_status                    VARCHAR(30),
    order_purchase_timestamp        DATETIME,
    order_approved_at               DATETIME,
    order_delivered_carrier_date    DATETIME,
    order_delivered_customer_date   DATETIME,
    order_estimated_delivery_date   DATETIME,
    product_category_name           VARCHAR(100),
    product_name_lenght             INT,
    product_description_lenght      INT,
    product_photos_qty              INT,
    product_weight_g                INT,
    product_length_cm               INT,
    product_height_cm               INT,
    product_width_cm                INT,
    product_category_name_english   VARCHAR(100),
    seller_zip_code_prefix          VARCHAR(10),
    seller_city                     VARCHAR(100),
    seller_state                    VARCHAR(5),
    customer_unique_id              VARCHAR(50),
    customer_zip_code_prefix        VARCHAR(10),
    customer_city                   VARCHAR(100),
    customer_state                  VARCHAR(5),
    payment_value                   DECIMAL(10,2),
    payment_installments             INT,
    payment_type                    VARCHAR(30),
    review_score                    INT,
    delivery_delay_days             INT
);

-- ------------------------------------------------------------
-- STEP 2: Load the CSV
-- ------------------------------------------------------------
-- Option A: MySQL Workbench "Table Data Import Wizard" — easiest, just point it
-- at olist_master.csv and match columns. Use this if LOAD DATA gives permission errors.

-- Option B: LOAD DATA (run from MySQL client / Workbench)
-- If you get a "secure-file-priv" or "local infile" error, either:
--   1) move the csv into MySQL's secure-file-priv folder (check with: SHOW VARIABLES LIKE 'secure_file_priv';)
--   2) or enable local infile: SET GLOBAL local_infile = 1;  then connect with --local-infile

LOAD DATA LOCAL INFILE 'olist_master.csv'
INTO TABLE olist_master
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_item_id, product_id, seller_id, @shipping_limit_date, price, freight_value,
 customer_id, order_status, @order_purchase_timestamp, @order_approved_at,
 @order_delivered_carrier_date, @order_delivered_customer_date, @order_estimated_delivery_date,
 product_category_name, product_name_lenght, product_description_lenght, product_photos_qty,
 product_weight_g, product_length_cm, product_height_cm, product_width_cm,
 product_category_name_english, seller_zip_code_prefix, seller_city, seller_state,
 customer_unique_id, customer_zip_code_prefix, customer_city, customer_state,
 payment_value, payment_installments, payment_type, review_score, delivery_delay_days)
SET
 shipping_limit_date = NULLIF(@shipping_limit_date, ''),
 order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
 order_approved_at = NULLIF(@order_approved_at, ''),
 order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
 order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
 order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

-- Quick check
SELECT COUNT(*) AS row_count FROM olist_master;
SELECT * FROM olist_master LIMIT 5;



-- Q1. Monthly revenue trend with Month-over-Month % change

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m-01') AS order_month,
        ROUND(SUM(price + freight_value), 2) AS total_revenue
    FROM olist_master
    WHERE order_status NOT IN ('canceled', 'unavailable')
    GROUP BY order_month
    ORDER BY order_month
)
SELECT
    order_month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month))
        / LAG(total_revenue) OVER (ORDER BY order_month) * 100, 2
    ) AS mom_pct_change
FROM monthly_revenue
ORDER BY order_month;


-- Q2. Top 10 categories by revenue AND by order count 
-- By revenue
SELECT
    product_category_name_english AS category,
    ROUND(SUM(price + freight_value), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_count
FROM olist_master
WHERE order_status NOT IN ('canceled', 'unavailable')
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;

-- By order count
SELECT
    product_category_name_english AS category,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(price + freight_value), 2) AS total_revenue
FROM olist_master
WHERE order_status NOT IN ('canceled', 'unavailable')
GROUP BY category
ORDER BY order_count DESC
LIMIT 10;

-- Q3. Delivery performance by state — actual vs estimated, late delivery %

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS delivered_orders,
    ROUND(AVG(delivery_delay_days), 1) AS avg_delay_days,
    ROUND(
        SUM(CASE WHEN delivery_delay_days > 0 THEN 1 ELSE 0 END) * 100.0
        / COUNT(DISTINCT order_id), 2
    ) AS late_delivery_pct
FROM olist_master
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY customer_state
ORDER BY late_delivery_pct DESC;


-- Q4. Customer RFM segmentation
-- Recency = days since last order (from a fixed reference date = max order date in dataset)
-- Frequency = distinct order count
-- Monetary = total spend
-- NTILE(4) scores each dimension 1-4, then combined into a segment label

WITH ref_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date FROM olist_master
),
customer_rfm AS (
    SELECT
        m.customer_unique_id,
        DATEDIFF((SELECT max_date FROM ref_date), MAX(m.order_purchase_timestamp)) AS recency_days,
        COUNT(DISTINCT m.order_id) AS frequency,
        ROUND(SUM(m.price + m.freight_value), 2) AS monetary
    FROM olist_master m
    WHERE m.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY m.customer_unique_id
),
rfm_scored AS (
    SELECT
        customer_unique_id,
        recency_days,
        frequency,
        monetary,
	
        NTILE(4) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(4) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(4) OVER (ORDER BY monetary ASC) AS m_score
    FROM customer_rfm
)
SELECT
    customer_unique_id,
    recency_days, frequency, monetary,
    r_score, f_score, m_score,
    (r_score + f_score + m_score) AS rfm_total,
    CASE
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Champion'
        WHEN (r_score + f_score + m_score) >= 7  THEN 'Loyal'
        WHEN (r_score + f_score + m_score) >= 4  THEN 'At Risk'
        ELSE 'Lost'
    END AS rfm_segment
FROM rfm_scored
ORDER BY rfm_total DESC;

-- Q5. Seller performance ranking within each category

WITH seller_revenue AS (
    SELECT
        seller_id,
        product_category_name_english AS category,
        ROUND(SUM(price + freight_value), 2) AS seller_revenue,
        COUNT(DISTINCT order_id) AS orders_fulfilled
    FROM olist_master
    WHERE order_status NOT IN ('canceled', 'unavailable')
    GROUP BY seller_id, category
)
SELECT
    seller_id,
    category,
    seller_revenue,
    orders_fulfilled,
    RANK() OVER (PARTITION BY category ORDER BY seller_revenue DESC) AS rank_in_category
FROM seller_revenue
ORDER BY category, rank_in_category
LIMIT 200;   


-- Q6. Repeat customer rate

WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM olist_master
    WHERE order_status NOT IN ('canceled', 'unavailable')
    GROUP BY customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS repeat_customer_rate_pct
FROM customer_orders;

