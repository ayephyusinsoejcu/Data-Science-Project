# Apple Stock Analysis Dashboard | RStudio & Power BI

An end-to-end data analytics project exploring **Apple Inc. (AAPL) historical stock performance** through data cleaning, transformation, and interactive visualization. I used **RStudio** to prepare and validate stock market data and **Power BI** to build a three-page dashboard highlighting price trends, trading activity, annual returns, and volatility.

## Project Overview

- **Period analyzed:** January 2015 – December 2024
- **Dataset:** 2,516 daily trading records after cleaning
- **Tools:** R, RStudio, Power BI, CSV
- **Focus:** Data quality, financial data analysis, KPI reporting, and interactive dashboards

The goal is to make historical stock performance easier to understand and explore, not to predict future prices.

## Dashboard Features

### 1. Stock Performance Overview
- Latest and highest closing price KPIs
- Average daily trading volume
- Closing price trends over time
- Annual trading volume and daily price range visuals

### 2. Detailed Stock Insights
- Best and worst annual returns
- Average daily return
- Annual returns comparison
- Closing price versus 30-day moving average (MA30)
- Monthly volatility analysis
- Trading volume versus absolute daily return

### 3. Interactive Stock Analysis
- Year and date-range slicers
- Dynamic KPI cards and closing-price trends
- Monthly average daily return visuals
- Detailed trading records with open, high, low, close, volume, and daily return

## Data Cleaning & Analysis

Using RStudio, I:
1. Imported the raw CSV and converted date and numeric columns into appropriate formats.
2. Removed a non-data row and checked missing values, duplicate dates, and invalid price or volume entries.
3. Sorted the dataset chronologically for accurate time-series calculations.
4. Created derived fields including year, month, quarter, daily price range, daily returns, absolute returns, and MA30.
5. Calculated annual returns and monthly volatility, then exported the cleaned datasets for Power BI.

**Prepared outputs:** 2,516 records across 13 columns, 10 annual-return records, and 120 monthly-volatility records.

## Key Insights

| Metric | Result |
| --- | ---: |
| Latest available closing price (31 Dec 2024) | $249.53 |
| Highest recorded closing price | $258.10 |
| Average daily trading volume | 117.09 million shares |
| Mean daily return | ~0.11% |
| Best annual return | 2019: +88.74% |
| Worst annual return | 2022: −28.20% |
| Highest monthly volatility | March 2020: ~6.50% |

*These values describe the supplied historical dataset, not live market prices.*

## Repository Files

| File | Description |
| --- | --- |
| `Apple_Stock_Dashboard.pbix` | Interactive three-page Power BI report |
| `AAPL_stock_2015_2025.csv` | Original downloaded stock dataset |
| `AAPL_stock_clean.R` | R data cleaning, validation, and transformation script |
| `AAPL_cleaned.csv` | Cleaned daily stock data and calculated indicators |
| `AAPL_annual_returns.csv` | Annual price-return summary |
| `AAPL_monthly_volatility.csv` | Monthly volatility summary |

## How to Explore

1. Download `Apple_Stock_Dashboard.pbix` and open it in **Power BI Desktop**.
2. Navigate between the three dashboard pages to explore different perspectives on stock performance.
3. Use the year and date slicers to explore selected periods.
4. To reproduce the data preparation, open `AAPL_stock_clean.R` in **RStudio**, run it, and select the original CSV when prompted.

## Data Source & Limitations

Source: [Apple AAPL Stock Prices 2015–2025 on Kaggle](https://www.kaggle.com/datasets/saibhossain/apple-aapl-stock-prices-20152025).

Although the dataset title mentions 2025, the available records end on **31 December 2024**. The source does not confirm whether historical prices are adjusted for stock splits. Annual returns compare each year's first and last trading-day closing prices and exclude dividends; monthly volatility is the standard deviation of daily returns. This dashboard is intended for **historical exploration**, not financial advice or forecasting.

## Skills Demonstrated

**Data Cleaning · Data Validation · R Programming · Time-Series Analysis · Data Transformation · Power BI · Dashboard Design · Data Visualization · Financial Data Analysis**

---

**Created by Aye Phyu Sin Soe**  
Personal Data Analytics Portfolio Project
