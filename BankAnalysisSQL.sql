--Business Scenario Q1: Customer Account Balances Overview
--The bank management wants to have a comprehensive view of all customers along with their account details and current balances.
--This information is crucial for identifying high-value customers, understanding the distribution of account balances, and planning targeted marketing campaigns.

SELECT *
FROM FINANCE.FB.Customers
JOIN FINANCE.FB.Accounts
ON
	Accounts.CustomerID = Customers.CustomerID
ORDER BY Balance


--Business Scenario Q2: High-Value Customers Identification
--The bank management wants to identify all customers who have a balance greater than $5,000 in their accounts. 
--This information is critical for understanding the high-value customer segment, offering them tailored financial products, and providing them with premium customer services
SELECT *
FROM FINANCE.FB.Customers
JOIN FINANCE.FB.Accounts
ON
	Accounts.CustomerID = Customers.CustomerID
WHERE Balance > 5000
ORDER BY Balance

--Business Scenario Q3: Transactions in 2022
--The bank management wants to analyse all transactions made in the year 2022 to understand customer behaviour, transaction volumes, and financial flows during that period.
--This analysis will help in identifying trends, detecting anomalies, and planning future strategies.

SELECT T.AccountID, T.TransactionID,C.CustomerID,T.TransactionType,T.Amount,T.TransactionDate
FROM FINANCE.FB.Transactions T
JOIN FINANCE.FB.Accounts A
ON
	A.AccountID = T.AccountID
JOIN FINANCE.FB.Customers C
ON
	A.CustomerID = C.CustomerID
WHERE TransactionDate BETWEEN '2022-01-01' AND '2022-12-31'

--Business Scenario Q4: Monthly Deposit Summary
--The bank management wants to calculate the total amount deposited in all accounts for the month of May 2022. 
--This information is essential for monitoring cash inflows, assessing the bank's liquidity position, and planning for future financial needs.

SELECT TransactionType, SUM(Amount) AS Total_Deposit
FROM FINANCE.FB.Transactions 
WHERE TransactionType = 'Deposit'
AND TransactionDate BETWEEN '2022-05-01' AND '2022-05-31'
GROUP BY TransactionType

--Business Scenario Q5: Customer Loan Details
--The bank management wants to retrieve the details of all loans taken by a customer with ID “C0768”. 
--This information is crucial for understanding the customer's borrowing behaviour, managing their credit risk, and providing them with tailored loan products.
SELECT *
FROM FINANCE.FB.Loans
JOIN FINANCE.FB.Payments
ON 
	Loans.LoanID = Payments.LoanID
WHERE CustomerID = 'C0768'

--Business Scenario Q6: Branch-Specific Employee List
--The bank management wants to retrieve a list of all employees working in a branch having an ID “B0851”.
--This information is useful for branch managers to understand their team composition, manage human resources effectively, and plan for staffing needs.

SELECT *
FROM FINANCE.FB.Employees E
JOIN FINANCE.FB.Branches B
ON 
	E.BranchID = B.BranchID
WHERE E.BranchID = 'B0851'

--Business Scenario Q7: Total Credit Cards Issued
--The bank management wants to determine the total number of credit cards issued by the bank. 
--This information is important for understanding the bank's reach in the credit card market, evaluating the success of their credit card products, and planning future marketing campaigns.

SELECT COUNT(CardID) AS TotalCardIssued
FROM FINANCE.FB.Credit_cards

--Business Scenario Q8: Average Interest Rate for Loans
--The bank management wants to calculate the average interest rate for all loans. 
--This information is essential for assessing the overall cost of borrowing for customers, comparing it with industry benchmarks, 
--and making decisions about future loan product offerings and interest rate adjustments.

SELECT ROUND(AVG(InterestRate), 2) AS Average_InterestRate
FROM FINANCE.FB.Loans

--Business Scenario Q9: Active Customers in 2020
--The bank management wants to identify and retrieve the details of all customers who have made at least one transaction in the year 2020.
--This information is valuable for understanding customer activity, identifying engaged customers, and planning targeted marketing and customer retention strategies.

SELECT DISTINCT C.CustomerID,C.FirstName, C.LastName, C.DateOfBirth, C.Email, C.Gender, C.PhoneNumber
FROM FINANCE.FB.Transactions T
JOIN FINANCE.FB.Accounts A
ON
	A.AccountID = T.AccountID
JOIN FINANCE.FB.Customers C
ON
	A.CustomerID = C.CustomerID
WHERE TransactionDate BETWEEN '2020-01-01' AND '2021-01-01'

--Business Scenario Q10: Inactive Accounts Between 2019 and 2023
--The bank management wants to identify all accounts that have had no transactions between the years 2019 and 2023. 
--This information is important for understanding long-term account inactivity, identifying dormant accounts, and planning strategies to reactivate these accounts.

SELECT *
FROM FINANCE.FB.Accounts A
WHERE A.AccountID NOT IN
(SELECT T.AccountID
FROM FINANCE.FB.Transactions T
WHERE T.TransactionDate BETWEEN '2019-01-01' AND '2024-01-01')

--Business Scenario Q11: Total Loan Payments in 2015
--The bank management wants to calculate the total amount of payments made towards loans in the year 2015. 
--This information is essential for understanding the cash flow related to loan repayments,
--assessing the bank's financial performance for that year, and making strategic decisions based on loan repayment trends.

SELECT ROUND(SUM(Amount),2) AS Total_LoanPaid
FROM FINANCE.FB.Payments P
WHERE P.PaymentDate BETWEEN '2015-01-01' AND '2016-01-01'


--Business Scenario Q12: Customer Investments in Mutual Funds
--The bank management wants to retrieve the details of all investments made by customers in mutual funds. 
--This information is valuable for understanding the investment preferences of customers, assessing the performance of mutual fund products, and planning targeted investment offerings.

SELECT C.CustomerID, I.CustomerID,I.InvestmentType, I.Amount
FROM FINANCE.FB.Customers C
JOIN FINANCE.FB.Investments I
ON 
	C.CustomerID = I.CustomerID
WHERE I.InvestmentType = 'Mutual Funds'

SELECT SUM(Amount) AS Total_Investments
FROM FINANCE.FB.Investments I
WHERE I.InvestmentType = 'Mutual Funds'

--Business Scenario Q13: Transaction Count by Account Type
--The bank management wants to find the total number of transactions for each account type (Checking, Savings, Credit).
--This information is important for understanding the transaction activity across different types of accounts, 
--identifying popular account types, and making strategic decisions related to product offerings and customer engagement.

SELECT DISTINCT AccountType
FROM FINANCE.FB.Accounts

SELECT DISTINCT(AccountType), COUNT(AccountType) AS Number_Of_Account
FROM FINANCE.FB.Accounts
GROUP BY AccountType
ORDER BY 2


--Business Scenario Q14: Employee Count by Branch
--The bank management wants to list all branches along with the number of employees working in each branch. 
--This information is essential for understanding branch staffing levels, identifying branches that may need additional staffing, and optimising human resource allocation.

SELECT DISTINCT B.BranchID, B.BranchName,COUNT(EmployeeID) AS Emp_Count
FROM FINANCE.FB.Branches B
JOIN FINANCE.FB.Employees E
ON 
	B.BranchID = E.BranchID
GROUP BY B.BranchID,B.BranchName,EmployeeID

--Business Scenario Q15: Total Outstanding Loan Amount by Customer
--The bank management wants to calculate the total outstanding loan amount for each customer.
--This information is crucial for assessing individual customer debt levels, managing credit risk, and making informed decisions about loan approvals and customer credit limits.

SELECT SUM(L.LoanAmount) AS OutstandingLoanAmount
FROM FINANCE.FB.Loans L
WHERE L.LoanID NOT IN
(SELECT P.LoanID
FROM FINANCE.FB.Payments P)

--Business Scenario Q16: Customers with Multiple Account Types
--The bank management wants to retrieve the details of all customers who have more than one type of account. 
--This information is important for understanding customer engagement, identifying cross-selling opportunities, and analysing the diversity of customer portfolios.

SELECT DISTINCT(C.CustomerID),C.FirstName, C.LastName, C.PhoneNumber, COUNT(A.AccountType) AS AccountTypeCount
FROM FINANCE.FB.Customers C
JOIN FINANCE.FB.Accounts A
ON 
	C.CustomerID = A.CustomerID
GROUP BY C.CustomerID, C.FirstName,C.LastName, C.PhoneNumber
HAVING COUNT(A.AccountType) > 1

--Business Scenario Q17: Total Number of Loans Approved in 2017
--The bank management wants to find the total number of loans approved in the year 2017. 
--This information is essential for assessing the bank's lending activity for that year, understanding market demand, and planning future loan offerings and strategies.

SELECT COUNT(LoanID) AS ApprovedLoan
FROM FINANCE.FB.Loans L
WHERE L.LoanDate LIKE '2017%'

SELECT COUNT(LoanID) AS ApprovedLoan
FROM FINANCE.FB.Loans L
WHERE L.LoanDate BETWEEN '2017-01-01' AND '2018-01-01'


--Business Scenario Q18: Average Balance of Savings Accounts
--The bank management wants to calculate the average balance of all savings accounts. 
--This information is important for understanding the typical balance held by customers in savings accounts,
--assessing the bank's liquidity, and making informed decisions about interest rates and savings account products.

SELECT A.AccountType, AVG(A.Balance) AverageBalance
FROM FINANCE.FB.Accounts A
WHERE A.AccountType = 'Savings'
GROUP BY A.AccountType

--Business Scenario Q19: Customers with Stock Investments
--The bank management wants to retrieve the details of all customers who have investments in stocks. 
--This information is valuable for understanding customer investment behaviour, identifying customers interested in equity markets, 
--and planning targeted marketing campaigns for stock-related financial products.

SELECT C.CustomerID,I.InvestmentID,C.FirstName,C.LastName,I.Amount,C.Gender,C.PhoneNumber,C.Email,C.DateOfBirth
FROM FINANCE.FB.Customers C
JOIN FINANCE.FB.Investments I
ON
	C.CustomerID = I.CustomerID
WHERE I.InvestmentType = 'Stocks'
ORDER BY C.FirstName, I.Amount

--Business Scenario Q20: Total Interest Earned on Loans in 2012
--The bank management wants to calculate the total interest earned on all loans in the year 2012. 
--This information is crucial for understanding the revenue generated from loan interest during that period, 
--evaluating the profitability of the bank's lending activities, and making informed financial planning and strategic decisions.

SELECT ROUND((SUM(InterestRate*LoanAmount)/100),2) AS Total_InterestEarned
FROM FINANCE.FB.Loans
WHERE LoanDate LIKE '2012%'

--Business Scenario Q21: Total Number of Deposits in a Specific Branch
--The bank management wants to calculate the total number of deposit transactions made in a branch with ID “B0036”. 
--This information is essential for understanding the deposit activity within a branch, assessing branch performance, and planning resource allocation.

--NO SOLUTION, NO LINK BETWEEN TRANSACTION WITH BRANCH

--Business Scenario Q22: Employees Hired in 2018
--The bank management wants to retrieve the details of all employees who were hired in the year 2018. 
--This information is important for understanding hiring trends, analysing employee retention, and planning future hiring strategies.

SELECT *
FROM FINANCE.FB.Employees
WHERE HireDate LIKE '2018%'
ORDER BY HireDate

--Business Scenario Q23: Total Amount of Investments Made by All Customers
--The bank management wants to calculate the total amount of investments made by all customers.
--This information is crucial for understanding the overall investment activity,
--evaluating the bank's investment product performance, and making strategic decisions regarding investment offerings

SELECT SUM(Amount) AS Total_Investment
FROM FINANCE.FB.Investments

--Business Scenario Q24: Customers with Multiple Loans
--The bank management wants to retrieve the details of all customers who have more than one loan.
--This information is important for understanding customer borrowing behaviour, identifying high-risk customers, and providing targeted financial services.

SELECT DISTINCT C.CustomerID,C.FirstName,C.LastName,C.Email,C.PhoneNumber
FROM FINANCE.FB.Customers C
JOIN
(SELECT CustomerID
FROM FINANCE.FB.Loans
GROUP BY CustomerID
HAVING COUNT(LoanID)>1 ) L
ON
	C.CustomerID = L.CustomerID

--Business Scenario Q25: Accounts with Low Balances
--The bank management wants to list all accounts that have a balance less than $500.
--This information is important for identifying accounts that may require attention, 
--such as those at risk of becoming inactive or needing additional financial products and services to encourage higher balances.

SELECT *
FROM FINANCE.FB.Accounts
WHERE Balance < 500
ORDER BY Balance

--Business Scenario Q26: Total Amount of Withdrawals in January 2022
--The bank management wants to calculate the total amount of withdrawals made in January 2022.
--This information is essential for understanding cash outflows, assessing liquidity needs, and planning for financial management and customer service strategies.

SELECT T.TransactionType,SUM(Amount) AS TotalAmounT
FROM FINANCE.FB.Transactions T
WHERE T.TransactionDate LIKE '2022-01%' AND T.TransactionType ='Withdrawal'
GROUP BY T.TransactionType

--Business Scenario Q27: Customers Making Payments Using Bank Transfers
--The bank management wants to retrieve the details of all customers who have made payments using bank transfers. 
--This information is important for understandingcustomer payment preferences, identifying trends in payment methods, 
--and planning targeted services and promotions for bank transfer users.

SELECT C.CustomerID,C.FirstName,C.LastName,C.Gender, C.PhoneNumber, P.PaymentMethod
FROM FINANCE.FB.Customers C
JOIN FINANCE.FB.Loans L
ON
	C.CustomerID = L.CustomerID
JOIN FINANCE.FB.Payments P
ON 
	L.LoanID = P.LoanID
WHERE P.PaymentMethod = 'Bank Transfer'
ORDER BY 2

--Business Scenario Q28: Total Number of Credit Card Transactions in 2022
--The bank management wants to find the total number of credit card transactions made in the year 2022.
--This information is important for understanding the usage and popularity of credit cards among customers, 
--assessing transaction volumes, and planning marketing strategies for credit card products.

SELECT COUNT(CR.CardID) AS TOTALCRTRANS
FROM FINANCE.FB.Transactions T
JOIN FINANCE.FB.Accounts A
ON T.AccountID = A.AccountID
JOIN FINANCE.FB.Credit_cards CR
ON A.CustomerID = CR.CustomerID
WHERE T.TransactionDate LIKE '2022%'

--Business Scenario Q29: Average Credit Limit of Credit Cards
--The bank management wants to calculate the average credit limit of all credit cards.
--This information is essential for understanding the distribution of credit limits among customers,
--assessing the bank's credit exposure, and making informed decisions about credit card policies and offerings.

SELECT ROUND(AVG(CreditLimit),2) AverageCRLimit
FROM FINANCE.FB.Credit_cards

--Business Scenario Q30: Customers with Bond Investments
--The bank management wants to retrieve the details of all customers who have investments in bonds. 
--This information is valuable for understanding customer investment preferences, identifying potential opportunities for targeted marketing of bond-related financial products, 
--and analysing the popularity of bonds among customers.

SELECT C.CustomerID, C.FirstName, C.LastName, C.Gender, C.Email, C.PhoneNumber, C.DateOfBirth
FROM FINANCE.FB.Customers C
JOIN FINANCE.FB.Investments I
ON
	C.CustomerID = I.CustomerID
WHERE I.InvestmentType = 'Bonds'
ORDER BY 1,2

--Business Scenario Q31: Total Number of Loans Approved by Loan Type
--The bank management wants to calculate the total number of loans approved for each loan type (Personal, Mortgage, Auto, Student). 
--This information is crucial for understanding the distribution of loan approvals across different types, 
--evaluating the demand for various loan products, and making informed decisions about future loan offerings.

SELECT DISTINCT LoanType, COUNT(LoanID) ApprovedLoan
FROM FINANCE.FB.Loans
GROUP BY LoanType
ORDER BY ApprovedLoan

--Business Scenario Q32: List of Employees Working as Loan Officers
--The bank management wants to list all employees who work as loan officers. 
--This information is essential for understanding the workforce composition, managing human resources,
--and planning targeted training and development programs for loan officers.

SELECT *
FROM FINANCE.FB.Employees
WHERE Position = 'Loan Officer'

--Business Scenario Q33: Total Number of Accounts Opened in 2014
--The bank management wants to find the total number of accounts that were opened in the year 2014. 
--This information is important for understanding the growth in the customer base during that year, 
--evaluating the success of marketing campaigns, and making informed decisions about future strategies to attract new customers.

SELECT COUNT(AccountID) TOotal_OpenedAccount
FROM FINANCE.FB.Accounts
WHERE OpenDate LIKE '2014%'

--Business Scenario Q34: Average Transaction Amount by Transaction Type
--The bank management wants to calculate the average transaction amount for each transaction type. 
--This information is essential for understanding customer behaviour, identifying transaction trends, and making informed decisions about fee structures and service offerings.

SELECT TransactionType, ROUND(AVG(Amount), 2) AS AverageTransAmount
FROM FINANCE.FB.Transactions
GROUP BY TransactionType
ORDER BY AverageTransAmount

--Business Scenario Q35: Identify High-Value Customers
--The bank management wants to identify high-value customers, defined as the top 10% of customers based on their total account balances and investments.
--This information is crucial for targeted marketing, offering premium services, and personalised financial products to these valuable customers.

WITH CustBal
AS
( SELECT TOP 10 PERCENT A.CustomerID, SUM(A.Balance) AS TotalBal
FROM FINANCE.FB.Accounts A
GROUP BY A.CustomerID),
CustInvest AS
(SELECT TOP 10 PERCENT I.CustomerID, SUM(I.Amount) AS TotalInvest
FROM FINANCE.FB.Investments I
GROUP BY I.CustomerID),
CustTotalVal AS
(SELECT CB.CustomerID, (CB.TotalBal + COALESCE(CI.TotalInvest, 0)) AS TotalValue
FROM CustBal CB
LEFT JOIN CustInvest CI
ON CB.CustomerID = CI.CustomerID
)
SELECT C.CustomerID, C.FirstName, C.LastName, C.Gender, C.Email, C.PhoneNumber, CT.TotalValue
FROM FINANCE.FB.Customers C
JOIN CustTotalVal CT
ON C.CustomerID = CT.CustomerID
ORDER BY CT.TotalValue DESC

--Business Scenario Q36: Customer Segmentation
--The bank management wants to categorise customers into segments (e.g., low, medium, high value) based on their account balances, transaction frequency, and investment amounts.
--This information is crucial for targeted marketing, personalised service offerings, and enhancing customer satisfaction.

WITH CustBal AS
(
SELECT A.CustomerID, SUM(A.Balance) AS TotalBal
FROM FINANCE.FB.Accounts A
GROUP BY A.CustomerID
),
CustomerTrans AS
(
SELECT A.CustomerID, COUNT(T.TransactionID) as TransactionCount
FROM FINANCE.FB.Transactions T
JOIN FINANCE.FB.Accounts A
ON T.AccountID = A.AccountID
GROUP BY A.CustomerID
),
CustomerInvest AS
(
SELECT I.CustomerID, SUM(I.Amount) AS TotalInvest
FROM FINANCE.FB.Investments I
GROUP BY I.CustomerID
),
CustomerMetrics AS
(
SELECT CB.CustomerID, CB.TotalBal, COALESCE(CT.TransactionCount,0) AS TransactionCount, COALESCE(CI.TotalInvest,0) AS TotalInvest
FROM CustBal CB
LEFT JOIN CustomerTrans CT
ON CB.CustomerID = CT.CustomerID
LEFT JOIN CustomerInvest CI
ON CB.CustomerID = CI.CustomerID
)
SELECT CM.CustomerID, CM.TotalBal, CM.TransactionCount, CM.TotalInvest,
CASE
	WHEN CM.TotalBal >=100000 OR CM.TotalInvest >= 50000 THEN 'High Value'
	WHEN CM.TotalBal >=50000 OR CM.TotalInvest >= 25000 THEN 'Mediun Value'
	ELSE 'Low Value'
END AS CustomerSegment
FROM CustomerMetrics CM

--Business Scenario Q37: Account Activity Summary
--The bank management wants to retrieve a summary of account activity for each customer.
--This summary should include the total deposits, total withdrawals, and the current balance for each customer's accounts. 
--This information is crucial for understanding customer behaviour, monitoring account health, and providing personalised financial advice.

WITH TotalDeposits AS (
    SELECT T.AccountID, SUM(T.Amount) AS TotalDepositAmount
    FROM FINANCE.FB.Transactions T
    WHERE T.TransactionType = 'Deposit'
    GROUP BY T.AccountID
),
TotalWithdrawal AS (
    SELECT T.AccountID, SUM(T.Amount) AS TotalWithdrawalAmount
    FROM FINANCE.FB.Transactions T
    WHERE T.TransactionType = 'Withdrawal'
    GROUP BY T.AccountID
)

SELECT 
    C.CustomerID, 
    C.FirstName, 
    C.LastName,
    COALESCE(SUM(TD.TotalDepositAmount), 0) AS TotalDeposit,
    COALESCE(SUM(TW.TotalWithdrawalAmount), 0) AS TotalWithdrawal,
    COALESCE(SUM(TD.TotalDepositAmount), 0) - COALESCE(SUM(TW.TotalWithdrawalAmount), 0) AS CurrentBalance
FROM FINANCE.FB.Customers C
LEFT JOIN FINANCE.FB.Accounts A ON C.CustomerID = A.CustomerID
LEFT JOIN TotalDeposits TD ON A.AccountID = TD.AccountID
LEFT JOIN TotalWithdrawal TW ON A.AccountID = TW.AccountID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY C.CustomerID