--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coiminst
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_INST                      CHAR(1) NULLIF (COD_INST = BLANKS)
,DESCR_INST                    CHAR(40) NULLIF (DESCR_INST = BLANKS) "RTRIM(:DESCR_INST)"
)
