--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimfunp
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(NOME_FUNZ                     CHAR(50) NULLIF (NOME_FUNZ = BLANKS) "RTRIM(:NOME_FUNZ)"
,DESC_FUNZ                     CHAR(60) NULLIF (DESC_FUNZ = BLANKS) "RTRIM(:DESC_FUNZ)"
)
