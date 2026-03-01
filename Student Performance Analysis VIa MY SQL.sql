-- Switch to the correct database
USE new_schema;

-- 1. Total number of students
SELECT COUNT(*) AS Total_Students
FROM cleaned_student_file;

-- 2. List all final results
SELECT Final_Result
FROM cleaned_student_file;

-- 3. Count of students by final result
SELECT COUNT(*) AS Total_Pass
FROM cleaned_student_file
WHERE Final_Result = 'Pass';

SELECT COUNT(*) AS Total_Fail
FROM cleaned_student_file
WHERE Final_Result = 'Fail';

-- 4. Attendance analysis
SELECT `Attendance_%`
FROM cleaned_student_file;

SELECT COUNT(*) AS Attendance_Above_80
FROM cleaned_student_file
WHERE `Attendance_%` > 80;

SELECT COUNT(*) AS Attendance_Above_60
FROM cleaned_student_file
WHERE `Attendance_%` > 60;

SELECT COUNT(*) AS Attendance_60_Or_Less
FROM cleaned_student_file
WHERE `Attendance_%` <= 60;

-- Fail students grouped by attendance
SELECT 
    CASE
        WHEN `Attendance_%` < 60 THEN 'Low (<60)'
        WHEN `Attendance_%` BETWEEN 60 AND 80 THEN 'Medium (60-80)'
        ELSE 'High (>80)'
    END AS Attendance_Group,
    COUNT(*) AS Total_Fail_Students
FROM cleaned_student_file
WHERE Final_Result = 'Fail'
GROUP BY Attendance_Group;

-- 5. Study hours analysis
SELECT Study_Hours_per_Week
FROM cleaned_student_file;

SELECT COUNT(*) AS Students_20_Plus
FROM cleaned_student_file
WHERE Study_Hours_per_Week >= 20;

SELECT COUNT(*) AS Students_10_19
FROM cleaned_student_file
WHERE Study_Hours_per_Week > 10 
  AND Study_Hours_per_Week < 20;

SELECT COUNT(*) AS Students_10_Or_Less
FROM cleaned_student_file
WHERE Study_Hours_per_Week <= 10;

-- Fail students grouped by study hours
SELECT 
    Study_hours_group,
    COUNT(*) AS Total_Fail_Students
FROM
(
    SELECT 
        CASE
            WHEN Study_Hours_per_Week >= 20 THEN 'Studied 20+ Hours'
            WHEN Study_Hours_per_Week > 10 THEN 'Studied 10-19 Hours'
            ELSE 'Less than 10 Hours'
        END AS Study_hours_group
    FROM cleaned_student_file
    WHERE Final_Result = 'Fail'
) AS grouped_data
GROUP BY Study_hours_group;

-- Fail students grouped by attendance and study hours
SELECT 
    CASE
        WHEN `Attendance_%` < 60 THEN 'Low (<60)'
        WHEN `Attendance_%` BETWEEN 60 AND 80 THEN 'Medium (60-80)'
        ELSE 'High (>80)'
    END AS Attendance_Group,

    CASE
        WHEN Study_Hours_per_Week > 15 THEN 'Studied 15+ Hours'
        ELSE 'Less than 15 Hours'
    END AS Study_Hours_Group,

    COUNT(*) AS Total_Fail_Students

FROM cleaned_student_file
WHERE Final_Result = 'Fail'
GROUP BY 
    CASE
        WHEN `Attendance_%` < 60 THEN 'Low (<60)'
        WHEN `Attendance_%` BETWEEN 60 AND 80 THEN 'Medium (60-80)'
        ELSE 'High (>80)'
    END,
    CASE
        WHEN Study_Hours_per_Week > 15 THEN 'Studied 15+ Hours'
        ELSE 'Less than 15 Hours'
    END;

-- 6. Fail students grouped by internal marks
SELECT 
    CASE
        WHEN Internal_Marks > 80 THEN 'Marks between 80 and 100'
        WHEN Internal_Marks BETWEEN 50 AND 80 THEN 'Marks b/w 50 and 80'
        ELSE 'Marks less than 50'
    END AS Marks_Group,
    COUNT(*) AS Total_Fail_Students
FROM cleaned_student_file
WHERE Final_Result = 'Fail'
GROUP BY Marks_Group;

-- 7. Combined summary: Attendance vs Study Hours with total and fail counts
SELECT 
    Attendance_Group,
    Study_Hours_Group,
    COUNT(*) AS Total_Students,
    SUM(CASE WHEN Final_Result = 'Fail' THEN 1 ELSE 0 END) AS Total_Fail_Students
FROM
(
    SELECT 
        *,
        CASE
            WHEN `Attendance_%` < 60 THEN 'Low (<60)'
            WHEN `Attendance_%` BETWEEN 60 AND 80 THEN 'Medium (60-80)'
            ELSE 'High (>80)'
        END AS Attendance_Group,

        CASE
            WHEN Study_Hours_per_Week >= 20 THEN 'Studied 20+ Hours'
            WHEN Study_Hours_per_Week > 10 THEN 'Studied 10-19 Hours'
            ELSE 'Less than 10 Hours'
        END AS Study_Hours_Group
    FROM cleaned_student_file
) AS grouped_data
GROUP BY 
    Attendance_Group,
    Study_Hours_Group
ORDER BY
    Attendance_Group,
    Study_Hours_Group;