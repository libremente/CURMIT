--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimopve
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_OPVE                      CHAR(8) NULLIF (COD_OPVE = BLANKS) "RTRIM(:COD_OPVE)"
,COD_ENVE                      CHAR(8) NULLIF (COD_ENVE = BLANKS) "RTRIM(:COD_ENVE)"
,COGNOME                       CHAR(40) NULLIF (COGNOME = BLANKS) "RTRIM(:COGNOME)"
,NOME                          CHAR(40) NULLIF (NOME = BLANKS) "RTRIM(:NOME)"
,MATRICOLA                     CHAR(10) NULLIF (MATRICOLA = BLANKS) "RTRIM(:MATRICOLA)"
,STATO                         CHAR(1) NULLIF (STATO = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,TELEFONO                      CHAR(15) NULLIF (TELEFONO = BLANKS) "RTRIM(:TELEFONO)"
,CELLULARE                     CHAR(15) NULLIF (CELLULARE = BLANKS) "RTRIM(:CELLULARE)"
,RECAPITO                      CHAR(100) NULLIF (RECAPITO = BLANKS) "RTRIM(:RECAPITO)"
,CODICE_FISCALE                CHAR(16) NULLIF (CODICE_FISCALE = BLANKS) "RTRIM(:CODICE_FISCALE)"
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS) "RTRIM(:NOTE)"
,MARCA_STRUM                   CHAR(50) NULLIF (MARCA_STRUM = BLANKS) "RTRIM(:MARCA_STRUM)"
,MODELLO_STRUM                 CHAR(50) NULLIF (MODELLO_STRUM = BLANKS) "RTRIM(:MODELLO_STRUM)"
,MATR_STRUM                    CHAR(50) NULLIF (MATR_STRUM = BLANKS) "RTRIM(:MATR_STRUM)"
,DT_TAR_STRUM                  DATE(10) "YYYY-MM-DD" NULLIF (DT_TAR_STRUM = BLANKS)
,STRUMENTO                     CHAR(100) NULLIF (STRUMENTO = BLANKS) "RTRIM(:STRUMENTO)"
)
