--Some DateTime Examples

SELECT GETDATE() AS [GetDate], 
		SYSDATETIME() AS [SysDateTime],
		SYSUTCDATETIME() AS [SysUtcDateTime],
		SYSDATETIMEOFFSET() AS [SysDateTimeOffset],
		GETUTCDATE() AS [GetUtcDate],
		CURRENT_TIMESTAMP AS [Current_TimeStamp]

SELECT DAY(GETDATE()) AS [Today's Date], 
		DAY('12/31/2022') AS [Day],
		MONTH('12/31/2022') AS [Month],
		YEAR('12/31/2022') AS [Year],
		DATENAME(DAY, GETDATE()) AS [DateName],			-- DATENAME() returns NVARCHAR
		DATENAME(WEEK, GETDATE()) AS [WeekNumber],
		DATENAME(WEEKDAY, '06/10/1986') AS [WeekDayName],
		DATENAME(MONTH, GETDATE()) AS [MonthName]

SELECT DATEPART(DAY, GETDATE()) AS [DayNumber],			-- DATEPART() returns INT
		DATEPART(WEEK, GETDATE()) AS [WeekNumber],
		DATEPART(WEEKDAY, GETDATE()) AS [WeekDayNumber],
		DATEPART(MONTH, GETDATE()) AS [MonthNumber],
		DATEPART(YEAR, GETDATE()) AS [YearNumber]

SELECT DATEADD(DAY, 20, '08/30/2023') AS [AddedDaysInDate],	-- DATEADD() used to add some interval into given date
		DATEADD(DAY, -20, '08/30/2023') AS [SubtractedDaysInDate],
		DATEADD(MONTH, 1, '08/30/2023') AS [AddedMonthInDate],
		DATEADD(YEAR, 1, '08/30/2023') AS [AddedYearInDate],
		DATEADD(WEEK, 2, '08/30/2023') AS [AddedWeeksInDate],
		DATEADD(HOUR, 2, '2023-08-29 04:26:33.000') AS [AddedHoursInDate],
		DATEADD(MINUTE, 3, '2023-08-29 04:26:33.000') AS [AddedMinutesInDate],
		DATEADD(SECOND, 10, '2023-08-29 04:26:33.000') AS [AddedSecondsInDate]

SELECT DATEDIFF(DAY, '04/30/2021','08/30/2023') AS DaysDiff,	-- DATEDIFF() used to find difference between dates/times in given intervals
		DATEDIFF(MONTH, '04/30/2021', '08/30/2023') AS MonthsDiff,
		DATEDIFF(YEAR, '04/30/2021', '08/30/2023') AS YearsDiff,
		DATEDIFF(WEEK, '04/30/2021', '08/30/2023') AS WeeksDiff,
		DATEDIFF(HOUR, '2023-08-29 02:26:33.000', '2023-08-29 04:16:33.000') AS HoursDiff,
		DATEDIFF(MINUTE, '2023-08-29 06:26:33.000', '2023-08-29 04:16:33.000') AS MinutesDiff,
		DATEDIFF(SECOND, '2023-08-29 02:26:33.000', '2023-08-29 04:16:33.000') AS SecondsDiff

--Example of getting date of birth
DECLARE @BirthDate DATETIME = '1986-06-10', @TempDate DateTime, @Days INT, @Months INT, @Years INT, @TodayDate DATETIME =  GETDATE()
SET @TempDate = @BirthDate
SELECT @Years = DATEDIFF
				(
					YEAR, @TempDate, @TodayDate - 
					CASE
						WHEN 
							(MONTH(@BirthDate) > MONTH(@TodayDate)) OR
							(MONTH(@BirthDate) = MONTH(@TodayDate) AND DAY(@BirthDate) > DAY(@TodayDate))
						THEN 1
						ELSE 0
					END
				)
SELECT @TempDate = DATEADD(YEAR, @Years, @TempDate)
SELECT @Months = DATEDIFF
				 (
					MONTH, @TempDate, @TodayDate -
					CASE
						WHEN
							DAY(@BirthDate) > DAY(@TodayDate)
						THEN 1
						ELSE 0
					END
				 )
SELECT @TempDate = DATEADD(MONTH, @Months, @TempDate)
SELECT @Days = DATEDIFF(DAY, @TempDate, @TodayDate)
SELECT @BirthDate AS DateOfBirth, @TodayDate AS DateToday, 
	CONVERT(NVARCHAR, @Years) + ' Years ' + CONVERT(NVARCHAR, @Months) + ' Months ' + CONVERT(NVARCHAR, @Days) + ' Days' AS Age

DECLARE @DOB DATE = '1986-06-10'
DECLARE @CurrentDate DATE = GETDATE()
SELECT
    DATEDIFF(YEAR, @DOB, @CurrentDate) AS AgeYears,
    DATEDIFF(MONTH, @DOB, @CurrentDate) % 12 AS AgeMonths,
    DATEDIFF(DAY, DATEADD(MONTH, DATEDIFF(MONTH, @DOB, @CurrentDate), @DOB), @CurrentDate) AS AgeDays