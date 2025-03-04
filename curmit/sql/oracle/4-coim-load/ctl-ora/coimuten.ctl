--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimuten
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(ID_UTENTE                     CHAR(10) NULLIF (ID_UTENTE = BLANKS) "RTRIM(:ID_UTENTE)"
,COGNOME                       CHAR(40) NULLIF (COGNOME = BLANKS) "RTRIM(:COGNOME)"
,NOME                          CHAR(40) NULLIF (NOME = BLANKS) "RTRIM(:NOME)"
,PASSWORD                      CHAR(15) NULLIF (PASSWORD = BLANKS) "RTRIM(:PASSWORD)"
,ID_SETTORE                    CHAR(20) NULLIF (ID_SETTORE = BLANKS) "RTRIM(:ID_SETTORE)"
,ID_RUOLO                      CHAR(20) NULLIF (ID_RUOLO = BLANKS) "RTRIM(:ID_RUOLO)"
,LINGUA                        CHAR(2) NULLIF (LINGUA = BLANKS) "RTRIM(:LINGUA)"
,E_MAIL                        CHAR(100) NULLIF (E_MAIL = BLANKS) "RTRIM(:E_MAIL)"
,ROWS_PER_PAGE                 DECIMAL EXTERNAL(9) NULLIF (ROWS_PER_PAGE = BLANKS)
,"DATA"                        DATE(10) "YYYY-MM-DD" NULLIF ("DATA" = BLANKS)
,LIVELLO                       DECIMAL EXTERNAL(2) NULLIF (LIVELLO = BLANKS)
)
