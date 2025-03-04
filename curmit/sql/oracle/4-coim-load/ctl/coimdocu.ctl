--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimdocu
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_DOCUMENTO                 CHAR(8) NULLIF (COD_DOCUMENTO = BLANKS)
,TIPO_DOCUMENTO                CHAR(2) NULLIF (TIPO_DOCUMENTO = BLANKS)
,TIPO_SOGGETTO                 CHAR(1) NULLIF (TIPO_SOGGETTO = BLANKS)
,COD_SOGGETTO                  CHAR(8) NULLIF (COD_SOGGETTO = BLANKS)
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,DATA_STAMPA                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_STAMPA = BLANKS)
,DATA_DOCUMENTO                DATE(10) "YYYY-MM-DD" NULLIF (DATA_DOCUMENTO = BLANKS)
,DATA_PROT_01                  DATE(10) "YYYY-MM-DD" NULLIF (DATA_PROT_01 = BLANKS)
,PROTOCOLLO_01                 CHAR(20) NULLIF (PROTOCOLLO_01 = BLANKS)
,DATA_PROT_02                  DATE(10) "YYYY-MM-DD" NULLIF (DATA_PROT_02 = BLANKS)
,PROTOCOLLO_02                 CHAR(20) NULLIF (PROTOCOLLO_02 = BLANKS)
,FLAG_NOTIFICA                 CHAR(1) NULLIF (FLAG_NOTIFICA = BLANKS)
,DATA_NOTIFICA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_NOTIFICA = BLANKS)
,CONTENUTO                     ERROR--BLOB NULLIF (CONTENUTO = BLANKS)
,TIPO_CONTENUTO                CHAR(30) NULLIF (TIPO_CONTENUTO = BLANKS)
,DESCRIZIONE                   CHAR(50) NULLIF (DESCRIZIONE = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)
