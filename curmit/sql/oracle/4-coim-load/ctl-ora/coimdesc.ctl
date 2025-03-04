--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimdesc
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_DESC                      DECIMAL EXTERNAL(9) NULLIF (COD_DESC = BLANKS)
,NOME_ENTE                     CHAR(80) NULLIF (NOME_ENTE = BLANKS) "RTRIM(:NOME_ENTE)"
,TIPO_UFFICIO                  CHAR(80) NULLIF (TIPO_UFFICIO = BLANKS) "RTRIM(:TIPO_UFFICIO)"
,ASSESSORATO                   CHAR(80) NULLIF (ASSESSORATO = BLANKS) "RTRIM(:ASSESSORATO)"
,INDIRIZZO                     CHAR(80) NULLIF (INDIRIZZO = BLANKS) "RTRIM(:INDIRIZZO)"
,TELEFONO                      CHAR(50) NULLIF (TELEFONO = BLANKS) "RTRIM(:TELEFONO)"
,RESP_UFF                      CHAR(40) NULLIF (RESP_UFF = BLANKS) "RTRIM(:RESP_UFF)"
,UFF_INFO                      CHAR(80) NULLIF (UFF_INFO = BLANKS) "RTRIM(:UFF_INFO)"
,DIRIGENTE                     CHAR(40) NULLIF (DIRIGENTE = BLANKS) "RTRIM(:DIRIGENTE)"
)
