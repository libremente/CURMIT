--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimcqua
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_QUA                       CHAR(8) NULLIF (COD_QUA = BLANKS)
,COD_COMUNE                    CHAR(8) NULLIF (COD_COMUNE = BLANKS)
,DESCRIZIONE                   CHAR(50) NULLIF (DESCRIZIONE = BLANKS)
)
