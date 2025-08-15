SELECT *
FROM [Healthcare].[dbo].[MarketRecords]

--Market Segment Distribution
SELECT MarketSegment, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY MarketSegment
ORDER BY Count DESC;

--Geographic Opportunities
SELECT Region, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY Region
ORDER BY Count DESC;

--Analysis Type Popularity
SELECT AnalysisType, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY AnalysisType
ORDER BY COUNT DESC;

--Trend Directions by Market Segment
SELECT MarketSegment, TrendDirection, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY MarketSegment, TrendDirection
ORDER BY MarketSegment DESC, count DESC;

--Opportunity Level by Region
SELECT Region, OpportunityLevel, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY Region, OpportunityLevel
Order BY Region DESC, COUNT DESC ;

--Top Competitors by Analysis Count
SELECT Competitor, COUNT(*) AS Analyses
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY Competitor
ORDER BY Analyses DESC;

--Product Stage Mix
SELECT ProductStage, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY ProductStage
ORDER BY COUNT DESC;

--Priority Level Spread Across Product Life Cycle
SELECT ProductStage, PriorityLevel, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY ProductStage, PriorityLevel
ORDER BY ProductStage DESC , COUNT DESC;

--Critical/High Priority Growth Markets
SELECT MarketSegment, COUNT(*) AS HighOrCritical
FROM [Healthcare].[dbo].[MarketRecords]
WHERE PriorityLevel IN ('Critical','High')
GROUP BY MarketSegment
ORDER BY HighOrCritical DESC;

--Competitive Benchmarking vs. Feature Analysis
SELECT AnalysisType, OpportunityLevel, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
WHERE AnalysisType IN ('Competitive Benchmarking','Product Feature Analysis')
GROUP BY AnalysisType, OpportunityLevel
ORDER BY COUNT DESC;

--Customer Sentiment Distribution
SELECT CustomerFeedback, COUNT(*) AS FeedbackCount
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY CustomerFeedback
ORDER BY FeedbackCount DESC;

--Feedback vs. Opportunity Level
SELECT CustomerFeedback, OpportunityLevel, COUNT(*) AS Count
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY CustomerFeedback, OpportunityLevel
ORDER BY CustomerFeedback DESC, COUNT DESC;

--Top Issues in High Opportunity Markets
SELECT MarketSegment, CustomerFeedback, COUNT(*) AS Issues
FROM [Healthcare].[dbo].[MarketRecords]
WHERE OpportunityLevel = 'High Opportunity' AND CustomerFeedback = 'Negative'
GROUP BY MarketSegment, CustomerFeedback
ORDER BY  Issues DESC;

--Assignment Load by Analyst/Owner
SELECT Owner, COUNT(*) AS ReportsHandled
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY Owner
ORDER BY ReportsHandled DESC;

--Upcoming and Recent Review Frequencies
SELECT YEAR(ReviewDate) AS Year, COUNT(*) AS Reviews
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY YEAR(ReviewDate)
ORDER BY YEAR;

--Average Market Size by Segment
SELECT MarketSegment, AVG(EstimatedMarketSizeUSD) AS AvgMarketSize
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY MarketSegment
ORDER BY AvgMarketSize DESC;

--Segments with Highest Projected Growth
SELECT MarketSegment, AVG(ProjectedGrowthPercent) AS AvgGrowth
FROM [Healthcare].[dbo].[MarketRecords]
GROUP BY MarketSegment
ORDER BY AvgGrowth DESC;

--High Growth/High Opportunity/Positive Sentiment Products
SELECT ProductStage, COUNT(*) AS COUNT
FROM [Healthcare].[dbo].[MarketRecords]
WHERE ProjectedGrowthPercent > 10 AND OpportunityLevel = 'High Opportunity' AND CustomerFeedback = 'Positive'
GROUP BY ProductStage
ORDER BY COUNT DESC;

--Critical Priority with Declining Trends
SELECT AnalysisID, MarketSegment, PriorityLevel, TrendDirection
FROM [Healthcare].[dbo].[MarketRecords]
WHERE PriorityLevel = 'Critical' AND TrendDirection = 'Declining';

--Review of Low Opportunity, High Market Size Products
SELECT AnalysisID, MarketSegment, EstimatedMarketSizeUSD, OpportunityLevel
FROM [Healthcare].[dbo].[MarketRecords]
WHERE OpportunityLevel = 'Low Opportunity'
  AND EstimatedMarketSizeUSD = (SELECT MAX(EstimatedMarketSizeUSD) FROM [Healthcare].[dbo].[MarketRecords] WHERE OpportunityLevel = 'Low Opportunity');
