--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimruol
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(ID_RUOLO                      CHAR(20) NULLIF (ID_RUOLO = BLANKS)
,DESCRIZIONE                   CHAR(50) NULLIF (DESCRIZIONE = BLANKS)
)
