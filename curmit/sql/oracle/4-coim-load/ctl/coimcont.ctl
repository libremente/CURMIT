--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimcont
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_CONTRATTO                 CHAR(8) NULLIF (COD_CONTRATTO = BLANKS)
,NUM_CONTRATTO                 CHAR(8) NULLIF (NUM_CONTRATTO = BLANKS)
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,COD_MANUTENTORE               CHAR(8) NULLIF (COD_MANUTENTORE = BLANKS)
,COD_SOGGETTO                  CHAR(8) NULLIF (COD_SOGGETTO = BLANKS)
,DATA_INIZIO_VALID             DATE(10) "YYYY-MM-DD" NULLIF (DATA_INIZIO_VALID = BLANKS)
,DATA_FINE_VALID               DATE(10) "YYYY-MM-DD" NULLIF (DATA_FINE_VALID = BLANKS)
,STATO                         CHAR(1) NULLIF (STATO = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)
