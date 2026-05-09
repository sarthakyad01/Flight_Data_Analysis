# ✈️ Global Airline Schedule & Network Analytics (Snowflake SQL)

## 📌 Overview
This project analyzes the **OAG Global Airline Schedules dataset** available via Snowflake Marketplace to uncover insights into airline network structure, route importance, airport hub activity, and capacity distribution.

Using advanced SQL, the analysis focuses on **flight schedules, seat capacity, aircraft usage, and route-level performance** to evaluate how airlines operate globally and how air travel supply is distributed across markets.

---

## 🎯 Objectives
- Analyze global airline network structure and route connectivity  
- Identify major airport hubs and high-traffic routes  
- Evaluate airline capacity and fleet strategies  
- Understand domestic vs international market dynamics  
- Assess premium vs economy seat distribution  
- Detect operational patterns across airlines and regions  

---

## 🗂️ Dataset
Source: **Snowflake Marketplace – OAG Global Airline Schedules**

### Key Fields:
- **CARRIER / FLTNO** → Airline and flight identifiers  
- **DEPAPT / ARRAPT** → Departure and arrival airports  
- **DEPCTRY / ARRCTRY** → Country-level geography  
- **FLIGHT_DATE** → Scheduled flight date  
- **ELPTIM / DISTANCE** → Flight duration and route length  
- **INPACFT / EQUIPMENT_CD_ICAO** → Aircraft type  
- **TOTAL_SEATS** → Total seat capacity  
- **FIRST_CLASS_SEATS, BUSINESS_CLASS_SEATS, etc.** → Cabin distribution  
- **DOMINT** → Domestic vs international indicator  

---

## 🛠️ Tools & Technologies
- **SQL (Snowflake)**
- Data Aggregation & KPI Analysis  
- Window Functions  
- CTEs (Common Table Expressions)  
- Route & Network Modeling  

---

## 📊 Key Analyses Performed

### 1. Network & Flight Activity
- Total scheduled flights  
- Unique routes across the network  
- Flights operated by each airline  
- Departure and arrival activity by airport  

---

### 2. Airport Hub Analysis
- Identification of major global hubs (inbound + outbound traffic)  
- Airport activity ranking based on total flight volume  
- Hub concentration across regions  

---

### 3. Route & Connectivity Insights
- Most frequently operated routes  
- Routes with highest total seat capacity  
- Long-haul vs short-haul route segmentation  
- Identification of high-frequency vs high-capacity routes  

---

### 4. Airline Performance & Market Share
- Total seat capacity by airline  
- Airline dominance on specific routes  
- Fleet diversity (aircraft types used per airline)  
- Average aircraft size per airline  

---

### 5. Capacity & Fleet Strategy
- Aircraft type utilization across the network  
- Average seats per flight by airline  
- Premium vs economy cabin distribution  
- High-capacity vs low-capacity route patterns  

---

### 6. Geographic Analysis
- Outbound capacity by country  
- Inbound capacity by country  
- Domestic vs international flight distribution  
- Regional airline network concentration  

---

### 7. Advanced Analytics
- Route-level airline market share (window functions)  
- Hub identification using combined inbound/outbound traffic  
- Premium seat share analysis by airline  
- Aircraft diversity and operational complexity analysis  
- Capacity trends over time  

---

## 🔍 Sample Business Insights
- Identified major global hub airports based on combined traffic activity  
- Highlighted dominant airlines controlling key high-capacity routes  
- Revealed differences in airline fleet strategies (large vs small aircraft usage)  
- Identified routes with high frequency but lower capacity (regional focus)  
- Uncovered premium cabin distribution trends across airlines  

---

## 📈 Key SQL Techniques Used
- Common Table Expressions (CTEs)  
- Window Functions (ROW_NUMBER, RANK)  
- Aggregations (SUM, AVG, COUNT)  
- Conditional Logic (CASE WHEN)  
- String concatenation for route construction  
- Multi-step analytical queries  

---

## 🚀 How to Run
1. Open **Snowflake Console**  
2. Access dataset via **Snowflake Marketplace (OAG Schedules)**  
3. Select your database and schema  
4. Run queries from `OAG_Analysis.sql`  

---

## 💼 Business Value
This project demonstrates the ability to:
- Analyze large-scale global transportation datasets  
- Perform network and route-level analytics  
- Evaluate capacity planning and airline strategy  
- Apply SQL to real-world operational datasets  
- Generate insights for aviation, logistics, and infrastructure planning  

---

## 📌 Future Enhancements
- Build interactive dashboards (Power BI / Tableau)  
- Integrate demand-side data (passenger or booking data)  
- Perform route profitability modeling  
- Add forecasting models for capacity planning  
- Conduct airline competition and pricing analysis  
