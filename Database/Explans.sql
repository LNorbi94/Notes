-- 8. feladat

-- SELECT STATEMENT +  +                                                  
--  HASH JOIN +  +                                                       
--    TABLE ACCESS + FULL + COUNTRIES                                    
--    TABLE ACCESS + FULL + CUSTOMERS
SELECT /*+ HASH JOIN */ * FROM sh.countries co, sh.customers cu where co.country_id = cu.country_id;

-- SELECT STATEMENT +  +                                                  
--  NESTED LOOPS +  +                                                    
--    TABLE ACCESS + FULL + COUNTRIES                                    
--    TABLE ACCESS + FULL + CUSTOMERS
SELECT /*+ use_nl(co, cu) */ * FROM sh.countries cu join sh.customers co on cu.country_id = co.country_id;

-- SELECT STATEMENT +  +                                                  
--  MERGE JOIN +  +                                                      
--    TABLE ACCESS + BY INDEX ROWID + COUNTRIES                          
--      INDEX + FULL SCAN + COUNTRIES_PK                                 
--    SORT + JOIN +                                                      
--      TABLE ACCESS + FULL + CUSTOMERS
SELECT /*+ USE_MERGE(cu, co) INDEX(cu) */ * FROM sh.countries cu join sh.customers co on cu.country_id = co.country_id;

-- SELECT STATEMENT +  +                              
--  HASH + GROUP BY +                                
--    HASH JOIN +  +                                 
--      TABLE ACCESS + FULL + COUNTRIES              
--      TABLE ACCESS + FULL + CUSTOMERS
SELECT /*+ HASH JOIN */ country_name, COUNT(*) FROM
sh.countries cu join sh.customers co on cu.country_id = co.country_id GROUP BY country_name;

-- SELECT STATEMENT +  +                                                  
--  HASH + GROUP BY +                                                    
--    HASH JOIN +  +                                                     
--      TABLE ACCESS + FULL + COUNTRIES                                  
--      TABLE ACCESS + BY INDEX ROWID + CUSTOMERS                        
--        BITMAP CONVERSION + TO ROWIDS +                                
--          BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co cu) */ country_name
  FROM sh.countries cu join sh.customers co on cu.country_id = co.country_id
WHERE CUST_YEAR_OF_BIRTH = 10 GROUP BY country_name;

-- SELECT STATEMENT +  +                                                  
--  HASH + GROUP BY +                                                    
--    HASH JOIN +  +                                                     
--      TABLE ACCESS + FULL + COUNTRIES                                  
--      INLIST ITERATOR +  +                                             
--        TABLE ACCESS + BY INDEX ROWID + CUSTOMERS                      
--          BITMAP CONVERSION + TO ROWIDS +                              
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co cu) */ country_name
  FROM sh.countries cu join sh.customers co on cu.country_id = co.country_id
WHERE CUST_YEAR_OF_BIRTH in (1, 10) GROUP BY country_name;

-- SELECT STATEMENT +  +
--  SORT + ORDER BY +
--    TABLE ACCESS + BY INDEX ROWID + CUSTOMERS
--      BITMAP CONVERSION + TO ROWIDS +
--        BITMAP AND +  +
--          BITMAP INDEX + SINGLE VALUE + CUSTOMERS_MARITAL_BIX
--          BITMAP OR +  +
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX CUSTOMERS_MARITAL_BIX) USE_HASH(co cu) */ country_name
  FROM sh.countries cu join sh.customers co on cu.country_id = co.country_id
WHERE CUST_MARITAL_STATUS = 'married'
  AND (CUST_YEAR_OF_BIRTH = 1 OR CUST_YEAR_OF_BIRTH = 10 OR CUST_YEAR_OF_BIRTH = 100) GROUP BY country_name;

-- SELECT STATEMENT +  +
--  HASH + GROUP BY +
--    HASH JOIN +  +
--      INLIST ITERATOR +  +
--        TABLE ACCESS + BY INDEX ROWID + CUSTOMERS
--          BITMAP CONVERSION + TO ROWIDS +
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
--      PARTITION RANGE + ALL +
--        TABLE ACCESS + FULL + SALES
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co sa) NO_INDEX(sa) */ cust_first_name
  FROM sh.sales sa join sh.customers co on sa.cust_id = co.cust_id
WHERE co.CUST_YEAR_OF_BIRTH in ( 1967, 1977 )
  GROUP BY cust_first_name;
  
-- SELECT STATEMENT +  +
--  SORT + AGGREGATE +
--    HASH JOIN +  +
--      TABLE ACCESS + FULL + PRODUCTS
--      HASH JOIN +  +
--        TABLE ACCESS + BY INDEX ROWID + CUSTOMERS
--          BITMAP CONVERSION + TO ROWIDS +
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
--        PARTITION RANGE + ALL +
--          TABLE ACCESS + FULL + SALES
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) NO_INDEX(sa) USE_HASH(pu co) */ cust_first_name
FROM sh.PRODUCTS pu,
(SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co sa) */ * FROM
sh.sales sa, sh.customers co where sa.cust_id = co.cust_id)
WHERE CUST_YEAR_OF_BIRTH = 1967
 GROUP BY cust_first_name
 ORDER BY cust_first_name;

-- SELECT STATEMENT +  +
--  SORT + ORDER BY +
--    HASH + GROUP BY +
--      HASH JOIN + ANTI +
--        PARTITION RANGE + SINGLE +
--          TABLE ACCESS + BY LOCAL INDEX ROWID + SALES
--            BITMAP CONVERSION + TO ROWIDS +
--              BITMAP INDEX + SINGLE VALUE + SALES_TIME_BIX
--        TABLE ACCESS + FULL + CHANNELS
