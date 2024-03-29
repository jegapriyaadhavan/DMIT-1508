--Simple Select Exercise 3
-- This sample set illustrates the GROUP BY syntax and the use of Aggregate functions
-- with GROUP BY.
-- It also demonstrates the HAVING clause to filter on aggregate values.
USE [A01-School]
GO


-- 1. Select the average mark for each course. Display the CourseID and the average mark
--   Let's begin by exploring the Registration table to see the data we are working with.
SELECT  CourseId, Mark
FROM    Registration
ORDER BY CourseId
--  Answer to #1
SELECT CourseId,                   -- This column is a non-aggregate
        AVG(Mark) AS 'Average Mark' -- This column performs Aggregate (produce 1 value)
FROM    Registration
GROUP BY CourseId                   -- Group by the non-aggregate columns
-- When performing an Aggregate function in the SELECT clause, if you have any other 
-- non-aggregate columns in the SELECT clause, then these must be listed in the GROUP BY clause.

-- 2. How many payments were made for each payment type.
--   Display the Payment Type ID and the count
SELECT  PaymentTypeID,                              -- Non-aggregate column (btw, it's a FK)
        COUNT(PaymentTypeID) AS 'Count of Pay Type' -- Aggregate column
FROM    Payment
GROUP BY PaymentTypeID
-- 2a. Do the same as above, but sort it from most frequent payment type to the least frequent
SELECT  PaymentTypeID                            -- Non-aggregate column (btw, it's a FK)
        ,COUNT(PaymentTypeID) AS 'Count of Pay Type' -- Aggregate column
FROM    Payment
GROUP BY PaymentTypeID
ORDER BY COUNT(PaymentTypeID) DESC
/* A note on ORDER BY
   - The ORDER BY clause will, by default, do the sorting in ascending order.
     You can also sort by more than one column (more on that later).
     You can be explicit in your desired sort order by adding ASC for ascending
     or DESC for descending after each column you identify in the sort order.
 */

-- 3. Select the average Mark for each studentID. Display the StudentId and their average mark
-- TODO: Student Answer Here....
SELECT StudentID,
      AVG(Mark) AS 'Avg Mark'
FROM   Registration
GROUP BY StudentID

-- 4. Select the same data as question 3 but only show the studentID's and averages that are > 80
SELECT StudentID,
       AVG(Mark) AS 'Avg Mark'
FROM   Registration
GROUP BY StudentID
-- The HAVING clause is where we do filtering of Aggregate information
HAVING AVG(Mark) > 80

-- 5. How many students are from each city? Display the City and the count.
SELECT  City,
        COUNT(StudentID) AS 'Student Count'
FROM    Student
GROUP BY City

-- 6. Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having do not need to be selected.....)
SELECT  City
--      , COUNT(StudentID) AS 'Student Count'
FROM    Student
GROUP BY City
HAVING COUNT(StudentID) >= 2

-- 7. What is the highest, lowest and average payment amount for each payment type? 
SELECT MAX(Amount) AS 'Highest',
       MIN(Amount) AS 'Lowest',
       AVG(Amount) AS 'Average'
--       , PaymentTypeID
FROM   Payment
GROUP BY PaymentTypeID


-- 8. How many students are there in each club? Show the clubID and the count
SELECT  ClubId,
        COUNT(StudentID) AS 'Student Count'
FROM    Activity
GROUP BY ClubId -- My Answer

 SELECT  A.ClubId,
        COUNT(A.StudentID) AS 'Student Count'
FROM    Activity AS A
GROUP BY A.ClubId  /* Its options, its just saying inside this particular table, I see all the data. THIS ONE IS SIR'S STYLE. */

-- Check your answer by manually grouping students by their club membership and counting them
SELECT  ClubId, StudentID
FROM    Activity

-- 9. Which clubs have 3 or more students in them?
-- TODO: Student Answer Here....
-- TODO: Student Answer Here....
SELECT  ClubId,
        COUNT(StudentID) AS 'Student Count'
FROM    Activity
GROUP BY ClubId
HAVING COUNT(StudentID) >= 3 -- My answer


SELECT  A.ClubId,
        COUNT(A.StudentID) AS 'Student Count'
FROM    Activity AS A
GROUP BY A.ClubId
HAVING COUNT(A.StudentID) >= 3 


--10. Grouping the courses by the number of hours in each course, what is the average cost of those courses? Display the course hours and the average cost.
SELECT  C.CourseHours,
        AVG(C.CourseCost) AS 'Average Cost'
FROM    Course AS C
GROUP BY C.CourseHours

--11. Which teachers are getting the best results from the courses they teach? Display the staff ID and the average course mark, sorted by the course mark from highest to lowest.

SELECT R.StaffID, AVG(R.Mark) AS 'Average Course Mark'
FROM Registration AS R
GROUP BY R.StaffID
ORDER BY AVG(R.Mark) DESC

--12. How many male and female students do we have?

--SELECT * FROM Student
SELECT S.Gender, COUNT(S.StudentID) AS 'Gender Count'
FROM Student AS S
GROUP BY S.Gender

--13. Show the average balance owing for male and female students.
SELECT S.Gender, AVG(S.BalanceOwing)
FROM Student AS S
GROUP BY S.Gender

--14. How many students participate in school clubs? Display the club id and the number of students. (Hint: You should be using the Activity table for this question.)

SELECT  ClubId,
        COUNT(StudentID) AS 'Student Count'
FROM    Activity
GROUP BY ClubId
