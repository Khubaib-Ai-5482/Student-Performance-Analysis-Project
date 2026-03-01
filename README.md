# Student Performance Analysis Project

## Overview
This project analyzes student performance data to identify the key factors affecting failure rates.  
The analysis focuses mainly on Attendance and Study Hours, while also exploring additional features using SQL, Machine Learning, and Power BI.

The goal is to detect at-risk students and provide data-driven recommendations.

---

## Dataset Summary
- Total Students: 1200  
- Passed: 995  
- Failed: 205  
- Overall Fail Rate: 17.08%

### Key Features Used
- Attendance Percentage  
- Study Hours  
- LMS Login Frequency  
- Assignments Submitted  
- Travel Minutes  
- Parent Education Level  
- Part-Time Job Status  
- Final Result (Pass/Fail)

---

## Project Workflow

### 1. SQL (Data Preparation)
- Data cleaning and filtering  
- Grouping students by attendance and study hours  
- Calculating fail rates using aggregate queries  
- Creating summary tables for dashboard use  

### 2. Machine Learning
- Target Variable: Pass/Fail  
- Feature Selection: Attendance, Study Hours, LMS usage, etc.  
- Model Used: Classification model to predict student failure risk  
- Model Evaluation: Accuracy, confusion matrix, and performance metrics  
- Outcome: Identified high-risk student groups  

### 3. Power BI Dashboard
- Interactive dashboard for visual analysis  
- Visuals included:
  - Attendance vs Fail Rate (Bar Chart)  
  - Study Hours vs Fail Rate (Bar Chart)  
  - Combined Attendance + Study Analysis (Matrix/Heatmap)  
  - LMS & Assignment Trends  
  - Travel Time Impact  
  - Parent Education & Part-Time Job Analysis  
- Slicers added for dynamic filtering  

---

## Key Insights
- Students with attendance below 60% have the highest failure risk.  
- Lower study hours strongly increase fail probability.  
- Low attendance + low study hours = highest risk group.  
- LMS engagement and assignment submission improve performance.  

---

## Technologies Used
- SQL (Data Cleaning & Aggregation)  
- Python (Machine Learning – Classification)  
- Power BI (Data Visualization & Dashboard)  

---

## Project Outcome
This project demonstrates how data analytics, machine learning, and business intelligence tools can be combined to:
- Identify at-risk students  
- Improve academic decision-making  
- Support performance monitoring through dashboards  

---

## Future Improvements
- Add advanced ML models for better prediction  
- Perform feature importance analysis  
- Deploy model as a web-based prediction tool  
- Automate data pipeline  

---

## Author
Khubaib  
Aspiring AI Engineer | Data Science Enthusiast
