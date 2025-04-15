# 📊 Netflix Data Analysis

This project involves analyzing Netflix's dataset using SQL to derive insights such as popular genres, user preferences, trends over time, and content breakdown. The analysis is designed to assist business decisions and content recommendations by uncovering hidden patterns in the data.

---

## 🎯 Project Objective

To explore and analyze Netflix’s dataset using SQL queries, and extract meaningful information about movies, TV shows, content distribution, and user trends.

---

## 🧠 Queries and Algorithms Used

### 1. **Data Selection & Filtering**
- Basic `SELECT` statements to inspect and fetch specific columns
- `WHERE` clause to filter data by conditions such as country, release year, or type

### 2. **Aggregation & Grouping**
- `GROUP BY` and `COUNT()` to calculate frequency (e.g., number of movies per genre or year)
- `AVG()` to find average durations, ratings, etc.

### 3. **Sorting and Ranking**
- `ORDER BY` to rank data (e.g., most recent releases, most produced genres)
- `LIMIT` to fetch top-N results

### 4. **Joins**
- `INNER JOIN` / `LEFT JOIN` to combine datasets (e.g., linking shows with director info or country)

### 5. **String Operations**
- `LIKE`, `SUBSTRING()`, `TRIM()` to extract or filter based on titles or descriptions

### 6. **Date-Based Queries**
- Use of `YEAR()`, `MONTH()` on date fields to perform time series analysis
- Filtering shows added or released in specific years

### 7. **Conditional Logic**
- `CASE WHEN` used to categorize shows by type or duration

---

## 🔍 Step-by-Step Process

### Step 1: Data Inspection
- Select initial rows from the dataset using:
  ```sql
  SELECT * FROM netflix_titles LIMIT 10;
Step 2: Content Overview
Count total number of Movies vs. TV Shows:

sql
Copy
Edit
SELECT type, COUNT(*) FROM netflix_titles GROUP BY type;
Step 3: Country-wise Content Distribution
Top countries by content volume:

sql
Copy
Edit
SELECT country, COUNT(*) as total FROM netflix_titles GROUP BY country ORDER BY total DESC LIMIT 10;
Step 4: Genre Analysis
Most popular genres/categories:

sql
Copy
Edit
SELECT listed_in, COUNT(*) FROM netflix_titles GROUP BY listed_in ORDER BY COUNT(*) DESC;
Step 5: Temporal Trends
Content additions per year:

sql
Copy
Edit
SELECT YEAR(date_added) as year, COUNT(*) FROM netflix_titles GROUP BY year ORDER BY year;
Step 6: Duration & Rating
Average duration by content type:

sql
Copy
Edit
SELECT type, AVG(duration) FROM netflix_titles WHERE duration IS NOT NULL GROUP BY type;
Step 7: Top Directors
Most featured directors:

sql
Copy
Edit
SELECT director, COUNT(*) FROM netflix_titles WHERE director IS NOT NULL GROUP BY director ORDER BY COUNT(*) DESC LIMIT 10;
