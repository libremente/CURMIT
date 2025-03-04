--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimrife
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,RUOLO                         CHAR(1) NULLIF (RUOLO = BLANKS)
,DATA_FIN_VALID                DATE(10) "YYYY-MM-DD" NULLIF (DATA_FIN_VALID = BLANKS)
,COD_SOGGETTO                  CHAR(8) NULLIF (COD_SOGGETTO = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)
