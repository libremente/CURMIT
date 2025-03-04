--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimstub
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS) "RTRIM(:COD_IMPIANTO)"
,DATA_FIN_VALID                DATE(10) "YYYY-MM-DD" NULLIF (DATA_FIN_VALID = BLANKS)
,COD_UBICAZIONE                CHAR(8) NULLIF (COD_UBICAZIONE = BLANKS) "RTRIM(:COD_UBICAZIONE)"
,LOCALITA                      CHAR(40) NULLIF (LOCALITA = BLANKS) "RTRIM(:LOCALITA)"
,COD_VIA                       CHAR(8) NULLIF (COD_VIA = BLANKS) "RTRIM(:COD_VIA)"
,TOPONIMO                      CHAR(20) NULLIF (TOPONIMO = BLANKS) "RTRIM(:TOPONIMO)"
,INDIRIZZO                     CHAR(100) NULLIF (INDIRIZZO = BLANKS) "RTRIM(:INDIRIZZO)"
,NUMERO                        CHAR(8) NULLIF (NUMERO = BLANKS) "RTRIM(:NUMERO)"
,ESPONENTE                     CHAR(3) NULLIF (ESPONENTE = BLANKS) "RTRIM(:ESPONENTE)"
,SCALA                         CHAR(5) NULLIF (SCALA = BLANKS) "RTRIM(:SCALA)"
,PIANO                         CHAR(5) NULLIF (PIANO = BLANKS) "RTRIM(:PIANO)"
,INTERNO                       CHAR(3) NULLIF (INTERNO = BLANKS) "RTRIM(:INTERNO)"
,COD_COMUNE                    CHAR(8) NULLIF (COD_COMUNE = BLANKS) "RTRIM(:COD_COMUNE)"
,COD_PROVINCIA                 CHAR(8) NULLIF (COD_PROVINCIA = BLANKS) "RTRIM(:COD_PROVINCIA)"
,CAP                           CHAR(5) NULLIF (CAP = BLANKS) "RTRIM(:CAP)"
,COD_CATASTO                   CHAR(20) NULLIF (COD_CATASTO = BLANKS) "RTRIM(:COD_CATASTO)"
,COD_TPDU                      CHAR(8) NULLIF (COD_TPDU = BLANKS) "RTRIM(:COD_TPDU)"
,COD_QUA                       CHAR(8) NULLIF (COD_QUA = BLANKS) "RTRIM(:COD_QUA)"
,COD_URB                       CHAR(8) NULLIF (COD_URB = BLANKS) "RTRIM(:COD_URB)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
)
