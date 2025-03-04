--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimesit
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_BATC                      DECIMAL EXTERNAL(9) NULLIF (COD_BATC = BLANKS)
,CTR                           DECIMAL EXTERNAL(5) NULLIF (CTR = BLANKS)
,NOM                           CHAR(30) NULLIF (NOM = BLANKS) "RTRIM(:NOM)"
,URL                           CHAR(100) NULLIF (URL = BLANKS) "RTRIM(:URL)"
,PAT                           CHAR(200) NULLIF (PAT = BLANKS) "RTRIM(:PAT)"
)
