--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimprof
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(NOME_MENU                     CHAR(20) NULLIF (NOME_MENU = BLANKS)
,SETTORE                       CHAR(20) NULLIF (SETTORE = BLANKS)
,RUOLO                         CHAR(20) NULLIF (RUOLO = BLANKS)
)
