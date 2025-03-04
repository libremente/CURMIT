--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimsrcg
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_CIMP                      CHAR(8) NULLIF (COD_CIMP = BLANKS) "RTRIM(:COD_CIMP)"
,ACCESSO_ESTERNO               CHAR(1) NULLIF (ACCESSO_ESTERNO = BLANKS)
,PIANO_GRIGLIATO               CHAR(1) NULLIF (PIANO_GRIGLIATO = BLANKS)
,INTERCAPEDINE                 CHAR(1) NULLIF (INTERCAPEDINE = BLANKS)
,PORTAINCOMB_ACC_ESTERNO       CHAR(1) NULLIF (PORTAINCOMB_ACC_ESTERNO = BLANKS)
,PORTAINCOMB_ACC_ESTERNO_MAG116CHAR(1) NULLIF (PORTAINCOMB_ACC_ESTERNO_MAG116 = BLANKS)
,DIMENSIONI_PORTA              CHAR(1) NULLIF (DIMENSIONI_PORTA = BLANKS)
,ACCESSO_INTERNO               CHAR(1) NULLIF (ACCESSO_INTERNO = BLANKS)
,DISIMPEGNO                    CHAR(1) NULLIF (DISIMPEGNO = BLANKS)
,STRUTTURA_DISIMP_VERIFICABILE CHAR(1) NULLIF (STRUTTURA_DISIMP_VERIFICABILE = BLANKS)
,DA_DISIMPEGNO_CON_LATO        CHAR(1) NULLIF (DA_DISIMPEGNO_CON_LATO = BLANKS)
,DA_DISIMPEGNO_SENZA_LATO      CHAR(1) NULLIF (DA_DISIMPEGNO_SENZA_LATO = BLANKS)
,AERAZIONE_DISIMPEGNO          CHAR(1) NULLIF (AERAZIONE_DISIMPEGNO = BLANKS)
,AERAZIONE_TRAMITE_CONDOTTO    CHAR(1) NULLIF (AERAZIONE_TRAMITE_CONDOTTO = BLANKS)
,PORTA_DISIMPEGNO              CHAR(1) NULLIF (PORTA_DISIMPEGNO = BLANKS)
,PORTA_CALDAIA                 CHAR(1) NULLIF (PORTA_CALDAIA = BLANKS)
,LOC_CALDAIA_REI_60            CHAR(1) NULLIF (LOC_CALDAIA_REI_60 = BLANKS)
,LOC_CALDAIA_REI_120           CHAR(1) NULLIF (LOC_CALDAIA_REI_120 = BLANKS)
,VALVOLA_STRAPPO               CHAR(1) NULLIF (VALVOLA_STRAPPO = BLANKS)
,INTERRUTTORE_GASOLIO          CHAR(1) NULLIF (INTERRUTTORE_GASOLIO = BLANKS)
,ESTINTORE                     CHAR(1) NULLIF (ESTINTORE = BLANKS)
,BOCCA_DI_LUPO                 CHAR(1) NULLIF (BOCCA_DI_LUPO = BLANKS)
,PARETE_CONFINANTE_ESTERNO     CHAR(1) NULLIF (PARETE_CONFINANTE_ESTERNO = BLANKS)
,ALTEZZA_LOCALE                CHAR(1) NULLIF (ALTEZZA_LOCALE = BLANKS)
,ALTEZZA_230                   CHAR(1) NULLIF (ALTEZZA_230 = BLANKS)
,ALTEZZA_250                   CHAR(1) NULLIF (ALTEZZA_250 = BLANKS)
,DISTANZA_GENERATORI           CHAR(1) NULLIF (DISTANZA_GENERATORI = BLANKS)
,DISTANZA_SOFF_INVOL_BOLLIT    CHAR(1) NULLIF (DISTANZA_SOFF_INVOL_BOLLIT = BLANKS)
,DISTANZA_SOFF_INVOL_NO_BOLLIT CHAR(1) NULLIF (DISTANZA_SOFF_INVOL_NO_BOLLIT = BLANKS)
,PAVIMENTO_IMPERM_SOGLIA       CHAR(1) NULLIF (PAVIMENTO_IMPERM_SOGLIA = BLANKS)
,APERT_VENT_SINO_500000        CHAR(1) NULLIF (APERT_VENT_SINO_500000 = BLANKS)
,APERT_VENT_SINO_750000        CHAR(1) NULLIF (APERT_VENT_SINO_750000 = BLANKS)
,APERT_VENT_SUP_750000         CHAR(1) NULLIF (APERT_VENT_SUP_750000 = BLANKS)
,CERTIF_ISPELS                 CHAR(1) NULLIF (CERTIF_ISPELS = BLANKS)
,CERTIF_CPI                    CHAR(1) NULLIF (CERTIF_CPI = BLANKS)
,SERBATOIO_ESTERNO             CHAR(1) NULLIF (SERBATOIO_ESTERNO = BLANKS)
,SERBATOIO_INTERNO             CHAR(1) NULLIF (SERBATOIO_INTERNO = BLANKS)
,SERBATOIO_LOC_CALDAIA         CHAR(1) NULLIF (SERBATOIO_LOC_CALDAIA = BLANKS)
,SFIATO_RETICELLA_H            CHAR(1) NULLIF (SFIATO_RETICELLA_H = BLANKS)
,SEGN_VALVOLA_STRAPPO          CHAR(1) NULLIF (SEGN_VALVOLA_STRAPPO = BLANKS)
,SEGN_INTERRUT_GENERALE        CHAR(1) NULLIF (SEGN_INTERRUT_GENERALE = BLANKS)
,SEGN_ESTINTORE                CHAR(1) NULLIF (SEGN_ESTINTORE = BLANKS)
,SEGN_CENTRALE_TERMICA         CHAR(1) NULLIF (SEGN_CENTRALE_TERMICA = BLANKS)
)
