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