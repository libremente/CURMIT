--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimtdoc
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(TIPO_DOCUMENTO                CHAR(2) NULLIF (TIPO_DOCUMENTO = BLANKS)
,DESCRIZIONE                   CHAR(100) NULLIF (DESCRIZIONE = BLANKS)
,FLAG_MODIFICA                 CHAR(1) NULLIF (FLAG_MODIFICA = BLANKS)
)
