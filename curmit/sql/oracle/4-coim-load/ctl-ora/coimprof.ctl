--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimprof
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(NOME_MENU                     CHAR(20) NULLIF (NOME_MENU = BLANKS) "RTRIM(:NOME_MENU)"
,SETTORE                       CHAR(20) NULLIF (SETTORE = BLANKS) "RTRIM(:SETTORE)"
,RUOLO                         CHAR(20) NULLIF (RUOLO = BLANKS) "RTRIM(:RUOLO)"
)
