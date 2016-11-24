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
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co cu) */ country_name FROM
sh.countries cu join sh.customers co on cu.country_id = co.country_id WHERE CUST_YEAR_OF_BIRTH = 10 GROUP BY country_name;

-- SELECT STATEMENT +  +                                                  
--  HASH + GROUP BY +                                                    
--    HASH JOIN +  +                                                     
--      TABLE ACCESS + FULL + COUNTRIES                                  
--      INLIST ITERATOR +  +                                             
--        TABLE ACCESS + BY INDEX ROWID + CUSTOMERS                      
--          BITMAP CONVERSION + TO ROWIDS +                              
--            BITMAP INDEX + SINGLE VALUE + CUSTOMERS_YOB_BIX
SELECT /*+ INDEX_COMBINE(co CUSTOMERS_YOB_BIX) USE_HASH(co cu) */ country_name FROM
sh.countries cu join sh.customers co on cu.country_id = co.country_id WHERE CUST_YEAR_OF_BIRTH in (1, 10) GROUP BY country_name;
