--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimbatc
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_BATC                      DECIMAL EXTERNAL(9) NULLIF (COD_BATC = BLANKS)
,NOM                           CHAR(30) NULLIF (NOM = BLANKS)
,FLG_STAT                      CHAR(1) NULLIF (FLG_STAT = BLANKS)
,NUM_COMM                      DECIMAL EXTERNAL(9) NULLIF (NUM_COMM = BLANKS)
,DAT_PREV                      DATE(10) "YYYY-MM-DD" NULLIF (DAT_PREV = BLANKS)
,ORA_PREV                      CHAR(8) NULLIF (ORA_PREV = BLANKS)
,DAT_INIZ                      DATE(10) "YYYY-MM-DD" NULLIF (DAT_INIZ = BLANKS)
,ORA_INIZ                      CHAR(8) NULLIF (ORA_INIZ = BLANKS)
,DAT_FINE                      DATE(10) "YYYY-MM-DD" NULLIF (DAT_FINE = BLANKS)
,ORA_FINE                      CHAR(8) NULLIF (ORA_FINE = BLANKS)
,COD_UTEN_SCH                  CHAR(10) NULLIF (COD_UTEN_SCH = BLANKS)
,COD_UTEN_INT                  CHAR(10) NULLIF (COD_UTEN_INT = BLANKS)
,NOM_PROG                      CHAR(50) NULLIF (NOM_PROG = BLANKS)
,PAR                           CHAR(1000) NULLIF (PAR = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS)
)
