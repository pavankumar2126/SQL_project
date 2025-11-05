Energy Consumption Analysis (SQL Project)
📌 Project Overview

This project focuses on analyzing global energy consumption, production, emissions, GDP, and population trends using structured datasets integrated into a MySQL database.
The analysis helps uncover patterns and correlations between economic growth, energy usage, and environmental impact across different countries.

🎯 Objective

The main objective of this project is to:

Analyze worldwide energy metrics from trusted datasets (EIA).

Understand how GDP, population, and energy consumption influence carbon emissions.

Identify countries that manage to grow economically while keeping emissions low.

Provide insights that support sustainable and eco-friendly policy planning.

🛠️ Tech Stack
Component	Description
Database	MySQL
Query Language	SQL
Tools Used	MySQL Workbench / SQL Developer
Visualization (Optional)	Power BI / Excel / Tableau
🗄️ Database Design
Tables Used
Table Name	Description
country	Stores country information (Country Name, ID)
consum	Yearly energy consumption by energy type
production	Annual energy production values
emission	Total and per-capita emissions
population	Year-wise population of each country
gdp_dd	GDP data by country and year
ER Diagram (Conceptual)
country ←→ emission
country ←→ population
country ←→ production
country ←→ gdp_dd
country ←→ consum


The country table acts as the central reference for all relationships.

📊 Key Analysis Performed (Use Cases)

Total emission per country (latest year)

Top 5 countries by GDP

Comparison of energy production vs consumption

Highest emitting energy sources

Year-over-year global emission trends

GDP growth patterns by country

Effect of population growth on emissions

Change in energy consumption for major economies

Per-capita emissions trends

Emission-to-GDP efficiency of countries

Each query result was analyzed and visualized to derive meaningful business insights.

✅ Key Findings

Economic growth strongly correlates with energy consumption and emissions.

Countries with lower emission-to-GDP ratio show better energy efficiency.

Population growth significantly increases energy demand and emissions.

Shifting to renewable energy sources is critical for sustainable growth.

Major energy-consuming nations must adopt cleaner technologies to reduce per-capita emissions.

💡 Recommendations
Recommendation	Purpose
Invest in renewable energy	Reduce dependency on fossil fuels
Improve energy efficiency policies	Help reduce emission per GDP
Promote awareness and green living	Reduce per-capita energy usage
Encourage global sustainability collaborations	Support climate action goals
🧭 Conclusion

This project demonstrates how data-driven analysis can help governments and industries understand the relationship between economic development and environmental sustainability.
The findings reinforce the need for efficient energy usage and clean energy transitions to ensure a sustainable future.
