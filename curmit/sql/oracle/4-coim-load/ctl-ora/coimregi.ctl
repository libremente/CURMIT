--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimregi
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_REGIONE                   CHAR(8) NULLIF (COD_REGIONE = BLANKS) "RTRIM(:COD_REGIONE)"
,DENOMINAZIONE                 CHAR(40) NULLIF (DENOMINAZIONE = BLANKS) "RTRIM(:DENOMINAZIONE)"
,FLAG_VAL                      CHAR(1) NULLIF (FLAG_VAL = BLANKS)
,COD_ISTAT                     CHAR(7) NULLIF (COD_ISTAT = BLANKS) "RTRIM(:COD_ISTAT)"
)
