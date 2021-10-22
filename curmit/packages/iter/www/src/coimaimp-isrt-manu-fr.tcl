ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Valentina Catte
    @creation-date   25/08/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimaimp-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom12 03/02/2021 Aggiunto controllo su PDR per il Comune di Salerno: deve iniziare per 1534.

    rom11 12/01/2021 Le particolarita' della Provincia di Salerno ora sono sostituite dalla condizione
    rom11            su tutta la Regione Campania.

    sim06 05/02/2020 Pod e Pdr non devono essere obbligatori se ad inserire l'impianto è l'ente

    rom10 09/07/2019 Messo obbligatorio il Proprietario anche per la Provincia di Salerno

    gac04 10/06/2019 Se associo un impianto ad un'altro esistente con la targa devo prevalorizzare
    gac04            i campi relativi al responsabile dell'impianto in base al flag_responsabile
    gac04            escluso il terzo responsabile

    gac03 07/06/2019 Mancava il controllo sull'obbligatorietà del POD.
    
    rom09 20/02/2019 La regione Marche ha chiesto durante la call del 18/02 di mettere
    rom09            obbligatorio il Proprietario. Corretto errore sul cmapo cod_potenza
    rom09            sulla Regione Marche.
    
    rom08 11/02/2019 Per la Regione Marche il campo potenza_utile non e' obbligatorio.
    rom08            Aggiunti i campi potenza_termica_nominale e potenza_assorbita_nominale
    rom08            visibili e obbligatori per tutti gli enti come detto da Sandro.

    rom07 04/02/2019 Per la Regione Marche il campo anno_costruzione non e' obbligatorio

    rom06 18/12/2018 Modificato intervento di sim05:l'installatore non e' mai obbligatorio ma
    rom06            se non viene inserito mando una mail all'autorità competente.           

    gac02 17/12/2018 Aggiunto controllo sulla data di installazione che deve essere superiore alla
    gac02            data di costruzione
    
    rom05 02/11/2018 Confermando l'inserimento non vengo piu' indirizzato direttamente sull'impianto
    rom05            ma in una pagina intermedia "coimaimp-gest-messaggio-intermedio".
    rom05            Per il momento lo faccio solo per la Regione Marche, va chiesto a Sandro se
    rom05            puo' andare bene per tutti.

    rom04M13/09/2018 Per gli impianti del freddo il combustibile deve essere solo "Pompa di calore"
    rom04M           Quindi nella tendina do solo questa opzione.(Guardare commento di rom02)

    gac01 29/06/2018 Modificate label

    sim05 13/06/2018 Se la data installazione è successiva al 1 luglio 2018 l'installatore è
    sim05            obbligatorio.

    rom03 08/06/2018 Solo per le Marche messo il campo cod_cted 'Cat. edificio' obbligatorio.

    rom02 11/05/2018 Aggiunto il campo targa solo per le Marche.
    rom02            In fase d'inserimento se la targa è vuota la valorizzo con il valore di
    rom02            cod_impianto_est e metto il valore di cod_impianto in cod_impianto_est
    rom02            solo per le Marche visto che hanno una gestione differente della targa.

    rom02 09/05/2019 Sviluppi per la BAT: modificata per tutti gli enti la scelta del combustibile.

    rom01m 18/04/2018 Aggiunti i campi POD e PDR  relativi controlli.

    rom01 10/01/2019 Quando inserisco il generatore metto il valore 1 nel campo num_circuiti.

    sim04 01/08/2017 Aggiunto la potenza utile del freddo che in un primo momento non era stata
    sim04            prevista.
    sim04            Dato che si era deciso di riusare il campo pot_utile_nom per la potenza di
    sim04            assorbimento ho dovuto usare il nuovo campo pot_utile_nom_freddo
    sim04            Per il freddo il controllo sulle potenze andrà fatto sul nuovo campo.
    sim04            Anche il totale sulla coimaimp sarà calcolato sul nuovo campo.

    gab04 03/07/2017 Se il flag_verifica_impianti è t i manutentori possono scegliere solo
    gab04            lo stato Da controllare.
    gab04            Modificato messaggio di errore per matricola già presente

    sim03 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim03            Reg. Marche CMJE.
    sim03            Per Comune di Senigalli: CMSE

    gab03 12/04/2017 Personaliz. per Provincia di Ancona: ricodificare gli impianti come da Legge
    gab03            Reg. Marche PRAN.

    gab02 07/04/2017 Faccio vedere nella tendina della fascia di potenza soltanto le potenze del
    gab02            freddo.

    gab01 08/02/2017 Personaliz. per Comune di Ancona: ricodificare gli impianti come da Legge
    gab01            Reg. Marche CMAN.    

    sim02 27/09/2016 Taranto ha il cod. impianto composto dalle ultime 3 cifre del codice istat
    sim02            + un progressivo

    nic05 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    nic04 03/12/2015 Per la provincia di massa, il cod_impianto_est va costruito in modo
    nic04            particolare

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.

    nic03 07/09/2015 Modificata valorizzazione di cod_impianto_est_new per CPESARO e PPU.
    
    nic02 16/05/2014 Comune di Rimini: se è attivo il parametro flag_gest_coimmode, deve
    nic02            comparire un menù a tendina con l'elenco dei modelli relativi al
    nic02            costruttore selezionato (tale menù a tendina deve essere rigenerato
    nic02            quando si cambia la scelta del costruttore).
    nic02            Ho dovuto aggiungere la gestione dei campi __refreshing_p e changed_field.
    
    nic01 03/02/2014 Matricola, Modello e Costruttore devono essere obbligatori come nel
    nic01            programma di modifica generatore.
} {
    {cod_impianto         ""}
    {last_cod_impianto    ""}
    {funzione            "I"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_aces             ""}
    {url_coimaces_list    ""}
    {stato_01             ""}
    {cod_impianto_est_new ""}
    {f_resp_cogn          ""} 
    {f_resp_nome          ""} 
    {f_comune             ""}
    {f_cod_via            ""}
    {f_desc_via           ""}
    {f_desc_topo          ""}
    {flag_ins_occu        ""}
    {flag_ins_prop        ""}
    {flag_ins_terzi       ""}
    {cod_as_resp          ""}
    {flag_tipo_impianto       "F"}
    pod
    {pdr                 ""}
    {targa               ""}
    {modello             ""}
    {cod_combustibile ""}
    {matricola     ""}
    {cod_cost      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

# if {$referrer == ""} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DISTLIST-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } 
# if {$id_utente != $id_utente_loggato_vero} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DISTLIST-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } else {
#	ns_log Notice "********AUTH-CHECK-DISTLIST-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    }
# ***

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_cod_aimp_auto  $coimtgen(flag_cod_aimp_auto)
set flag_ente           $coimtgen(flag_ente)
set sigla_prov          $coimtgen(sigla_prov)
set flag_codifica_reg   $coimtgen(flag_codifica_reg)
set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic05

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente � un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_aces {[export_url_vars nome_funz_caller]&[iter_set_url_vars $extra_par]}
set titolo           "Impianto"
switch $funzione {
    I {set button_label "Conferma Inserimento"
	set page_title  "Inserimento $titolo"}
}

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimaimp-list?$link_list "Lista Impianti"] \
			  "$page_title"]
}


set where_stat "";#gab04
set flag_da_controllare "f";#gab04
if {$coimtgen(flag_verifica_impianti) eq "t"} {#gab04 if e suo contenuto
    if {![string equal $cod_manutentore ""]} {
        set where_stat "where cod_imst = 'F'"
        set flag_da_controllare "t"
    }
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp"
set focus_field  "";#nic02
set readonly_key "readonly"
set readonly_fld "readonly"
set readonly_cod "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

if {$flag_cod_aimp_auto == "F"} {
    set readonly_cod \{\}
}

form create $form_name \
    -html    $onsubmit_cmd

#impianto 
element create $form_name cod_impianto_est \
    -label   "cod_impianto_est" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_cod {} class form_element" \
    -optional

#rom02 Visto che le marche hanno una gestione delle targhe differente faccio vedere il campo già in fase di inserimento dell'impianto
if {$coimtgen(regione) eq "MARCHE" } {#rom02 aggiunta if, else e loro contenuto
    element create $form_name targa \
        -label "targa" \
        -widget   text \
        -datatype text \
        -html    "size 20 maxlength 20 $readonly_cod {} class form_element" \
        -optional \
	-value $targa
} else {
    element create $form_name targa \
        -widget hidden \
        -datatype text \
        -optional
};#rom02


element create $form_name data_installaz \
    -label   "data_installaz" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name anno_costruzione \
    -label   "anno_costruzione" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

#rom02 per gli impianti del freddo il combustibile deve essere "Pompa di calore"
set where_cod_combustibile "where cod_combustibile ='88'";#rom02
element create $form_name cod_combustibile \
    -label   "cod_combustibile" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -value $cod_combustibile \
    -optional \
    -options [iter_selbox_from_table_wherec coimcomb cod_combustibile descr_comb descr_comb "$where_cod_combustibile"] \

if {$coimtgen(regione) eq "MARCHE"} {#gac01 aggiunto if e else e contenuto di else
    element create $form_name cod_tpim \
    -label   "tipologia" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimtpim cod_tpim descr_tpim]
} else {#gac01
    element create $form_name cod_tpim \
    -label   "tipologia" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimtpim cod_tpim descr_tpim cod_tpim "where cod_tpim = 'A' or cod_tpim = 'C'"]
};#gac01
#gab04 uso la proc iter_selbox_from_table_wherec
#gab04 options [iter_selbox_from_table coimimst cod_imst descr_imst cod_imst]
element create $form_name stato \
    -label   "stato" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 disabled {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimimst cod_imst descr_imst cod_imst $where_stat]

element create $form_name data_attivaz \
    -label   "data_attivaz" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name note \
    -label   "note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 80 rows 2 $readonly_fld {} class form_element" \
    -optional

#ubicazione

element create $form_name localita \
    -label   "Localita" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 40 $readonly_fld {} class form_element" \
    -optional

if {$coimtgen(flag_ente) == "P"} {
    element create $form_name cod_comune \
	-label   "Comune" \
	-widget   select \
	-options [iter_selbox_from_comu]\
	-datatype text \
	-html    "class form_element" \
	-optional
} else {
    element create $form_name cod_comune \
	-widget hidden \
	-datatype text \
	-optional

    element create $form_name descr_comu \
	-label   "Comune" \
	-widget   text \
	-datatype text \
	-html    "size 27 maxlength 40  readonly {} class form_element" \
	-optional
}

element create $form_name provincia \
    -label   "Prov" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 2  readonly {} class form_element" \
    -optional

element create $form_name cap \
    -label   "CAP" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name descr_via \
    -label   "Via" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 40 $readonly_fld {} class form_element" \
    -optional

element create $form_name descr_topo \
    -label   "Descrizione toponimo" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtopo descr_topo descr_topo]

element create $form_name numero \
    -label   "Numero" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name esponente \
    -label   "Esponente" \
    -widget   text \
    -datatype text \
    -html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name scala \
    -label   "Scala" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name piano \
    -label   "Piano" \
    -widget   text \
    -datatype text \
    -html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
    -optional

element create $form_name interno \
    -label   "Interno" \
    -widget   text \
    -datatype text \
    -html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
    -optional

#dati soggetti
#flag-responsabile
#gac01 tolto {Intestatario I}
element create $form_name flag_responsabile \
    -label   "responsabile" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Proprietario P} {Occupante O} {Amministratore A} {"Terzo responsabile" T}}

#intestatario
element create $form_name cognome_inte \
    -label   "Cognome intestatario" \
    -widget   text \
    -datatype text \
    -html    "size  18 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_inte \
    -label   "Nome intestatario" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
    -optional

#proprietario
element create $form_name cognome_prop \
    -label   "Cognome proprietario" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_prop \
    -label   "Nome proprietario" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
    -optional

#occupante
element create $form_name cognome_occ \
    -label   "Cognome occupante" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_occ \
    -label   "Nome occupante" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
    -optional

#amministratore
element create $form_name cognome_amm \
    -label   "Cognome amministratore" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_amm \
    -label   "Nome amministratore" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
    -optional

#terzi
element create $form_name cognome_terzi \
    -label   "Cognome terzi" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_terzi \
    -label   "Nome terzi" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
    -optional

#manutentore
if {[string equal $cod_manutentore ""]} {
    set sw_manu "f"
    set readonly_fld2 \{\}
    set cerca_manu  [iter_search $form_name coimmanu-list [list dummy cod_manu_manu dummy cognome_manu dummy nome_manu]]
} else {
    set sw_manu "t"
    set readonly_fld2 "readonly"
    set cerca_manu ""
}

element create $form_name cognome_manu \
    -label   "Cognome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 100 $readonly_fld2 {} class form_element" \
    -optional

element create $form_name nome_manu \
    -label   "Nome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 100 $readonly_fld2 {} class form_element" \
    -optional

#installatore
element create $form_name cognome_inst \
    -label   "Cognome installatore" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_inst \
    -label   "Nome installatore" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 40 $readonly_fld {} class form_element" \
    -optional

#progettista
element create $form_name cognome_prog \
    -label   "Cognome progettista" \
    -widget   text \
    -datatype text \
    -html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_prog \
    -label   "Nome progettista" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 40 $readonly_fld {} class form_element" \
    -optional

#dati generatore principale
element create $form_name matricola \
    -label   "matricola" \
    -widget   text \
    -datatype text \
    -html    "size 14 maxlength 35 $readonly_fld {} class form_element" \
    -optional \
    -value $matricola 

if {$coimtgen(flag_gest_coimmode) eq "F"} {#nic02
    element create $form_name modello \
	-label   "modello" \
	-widget   text \
	-datatype text \
	-html    "size 14 maxlength 40 $readonly_fld {} class form_element" \
	-value $modello \
	-optional

    element create $form_name cod_mode -widget hidden -datatype text -optional;#nic02

    set html_per_cod_cost "";#nic02
} else {;#nic02
    element create $form_name modello  -widget hidden -datatype text -optional;#nic02

    element create $form_name cod_mode \
            -label   "modello" \
            -widget   select \
            -datatype text \
            -html    "$disabled_fld {} class form_element" \
            -optional \
            -options "";#nic02

    set html_per_cod_cost "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='cod_cost';document.$form_name.submit.click()";#nic02
};#nic02


element create $form_name cod_cost \
    -label   "cod_cost" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element $html_per_cod_cost" \
    -optional \
    -value $cod_cost \
    -options [iter_selbox_from_table coimcost cod_cost descr_cost] \

element create $form_name potenza \
    -label   "potenza" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name potenza_utile \
    -label   "potenza_utile" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
    -optional

#sim04
element create $form_name potenza_utile_freddo \
    -label   "potenza_utile_freddo" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
    -optional

#gab02 inserisco nelle options solo le potenze del freddo.
#-options [iter_selbox_from_table coimpote cod_potenza descr_potenza potenza_min] 
element create $form_name cod_potenza \
    -label   "cod_potenza" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimpote cod_potenza descr_potenza potenza_min "where flag_tipo_impianto = 'F'"] \

#rom08
element create $form_name potenza_termica_nominale \
    -label   "Potenza termica nominale" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
    -optional
#rom08
element create $form_name potenza_termica_assorbita_nominale \
    -label   "Potenza termica assorbita nominale" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_dpr412 \
    -label   "dpr 412" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {No N} {S&igrave; S}}

element create $form_name cod_cted \
    -label   "cod_cted" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimcted cod_cted "cod_cted||' '||descr_cted"] \

element create $form_name tiraggio \
    -label   "tipo tiraggio" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Forzato F} {Naturale N}}

element create $form_name tipo_foco \
    -label   "tipo focolare" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Aperto A} {Chiuso C}}

#dati contratto
element create $form_name num_contratto \
    -label   "numero contratto" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_inizio_cont \
    -label   "data inizio contratto" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_fine_cont \
    -label   "data fine contratto" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_tpdu \
    -label   "Destinazione d'uso" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtpdu cod_tpdu descr_tpdu]

element create $form_name volimetria_risc \
    -label   "Volimetria riscaldata" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name n_generatori \
    -label   "n_generatori" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_utgi \
    -label   "Dest. d'uso generatore" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi]

element create $form_name cod_emissione \
    -label   "scarico fumi" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_obblig coimtpem cod_emissione descr_emissione cod_emissione] 

element create $form_name dati_scheda \
    -label   "Dati Scheda" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No N} {S&igrave; S}}

element create $form_name data_scheda \
    -label   "Data Scheda" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_tpco \
    -label   "cod_tpco" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtpco cod_tpco descr_tpco]

element create $form_name cod_flre \
    -label   "cod_flre" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimflre cod_flre sigla]

element create $form_name carica_refrigerante \
    -label   "carica_refrigerante" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name sigillatura_carica \
    -label   "sigillatura_carica" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {No N} {S&igrave; S}}
    
#rom01m 
element create $form_name pdr \
    -label   "PDR" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional \
    -value $pdr

#rom01m
element create $form_name pod \
    -label   "POD" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional \
    -value $pod


element create $form_name funzione             -widget hidden -datatype text -optional
element create $form_name caller               -widget hidden -datatype text -optional
element create $form_name nome_funz            -widget hidden -datatype text -optional
element create $form_name nome_funz_caller     -widget hidden -datatype text -optional
element create $form_name extra_par            -widget hidden -datatype text -optional
element create $form_name cod_impianto         -widget hidden -datatype text -optional
element create $form_name cod_provincia        -widget hidden -datatype text -optional
element create $form_name cod_citt_terzi       -widget hidden -datatype text -optional
element create $form_name cod_citt_inte        -widget hidden -datatype text -optional
element create $form_name cod_citt_prop        -widget hidden -datatype text -optional
element create $form_name cod_citt_occ         -widget hidden -datatype text -optional
element create $form_name cod_citt_amm         -widget hidden -datatype text -optional
element create $form_name cod_manu_manu        -widget hidden -datatype text -optional
element create $form_name cod_manut            -widget hidden -datatype text -optional
element create $form_name cod_manu_inst        -widget hidden -datatype text -optional
element create $form_name cod_prog             -widget hidden -datatype text -optional
element create $form_name dummy                -widget hidden -datatype text -optional
element create $form_name stato_01             -widget hidden -datatype text -optional
element create $form_name cod_impianto_est_new -widget hidden -datatype text -optional
element create $form_name f_resp_cogn          -widget hidden -datatype text -optional
element create $form_name f_resp_nome          -widget hidden -datatype text -optional
element create $form_name f_comune             -widget hidden -datatype text -optional
element create $form_name cod_as_resp          -widget hidden -datatype text -optional
element create $form_name f_cod_via            -widget hidden -datatype text -optional
element create $form_name f_desc_via           -widget hidden -datatype text -optional
element create $form_name f_desc_topo          -widget hidden -datatype text -optional
element create $form_name flag_ins_occu        -widget hidden -datatype text -optional
element create $form_name flag_ins_prop        -widget hidden -datatype text -optional
element create $form_name flag_ins_terzi       -widget hidden -datatype text -optional
element create $form_name nome_funz_new        -widget hidden -datatype text -optional
element create $form_name submit               -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto    -widget hidden -datatype text -optional
element create $form_name soloatt              -widget hidden -datatype text -optional
element create $form_name flag_conferma        -widget hidden -datatype text -optional
element create $form_name __refreshing_p       -widget hidden -datatype text -optional;#nic02
element create $form_name changed_field        -widget hidden -datatype text -optional;#nic02
element create $form_name flag_conferma_pdr     -widget hidden -datatype text -optional;#rom01m

#rom10 aggiunta condizione su Salerno
#rom11if {$coimtgen(regione) eq "MARCHE" || $coimtgen(ente) eq "PSA"} {}#rom09 aggiunte if, else e loro contenuto
if {$coimtgen(regione) in [list "MARCHE" "CAMPANIA"]} {#rom11 if ma non contenuto
    set ast_prop "<font color=red>*</font>"
} else {
    set ast_prop ""
};#rom09
# link per i cerca
set soloatt "s"
if {$coimtgen(flag_viario) eq "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune soloatt soloatt dummy dummy]]
} else {
    set cerca_viae ""
}

set cerca_inte  [iter_search $form_name coimcitt-filter [list dummy cod_citt_inte f_cognome cognome_inte f_nome nome_inte]]
set cerca_prop  [iter_search $form_name coimcitt-filter [list dummy cod_citt_prop f_cognome cognome_prop f_nome nome_prop]]
set cerca_occ   [iter_search $form_name coimcitt-filter [list dummy cod_citt_occ  f_cognome cognome_occ  f_nome nome_occ ]]
set cerca_amm   [iter_search $form_name coimcitt-filter [list dummy cod_citt_amm  f_cognome cognome_amm  f_nome nome_amm ]]

set cerca_terzi [iter_search $form_name coimmanu-list  [list dummy cod_citt_terzi f_cognome cognome_terzi f_nome nome_terzi] [list f_ruolo "M"]]
set cerca_inst  [iter_search $form_name coimmanu-list [list dummy cod_manu_inst dummy cognome_inst dummy nome_inst]]

set cerca_prog  [iter_search $form_name coimprog-list   [list dummy cod_prog dummy cognome_prog dummy nome_prog]]

set flag_ins_prop "S"
set flag_ins_terzi "S"

#link inserimento occupante
set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
element set_properties $form_name nome_funz_new   -value $nome_funz_new

set label_ins_sogg "Inserisci Sogg."
if {$coimtgen(regione) eq "MARCHE"} {
    set label_ins_sogg "Inserisci Sogg. <a href=\"#\" onclick=\"javascript:window.open('coimaimp-gest-help?caller=ins-sogg', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)\"><b>Vedi nota</b></a>"
}


#link inserimento occupante
set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occ nome nome_occ nome_funz nome_funz_new localita localita descr_via descr_via descr_topo descr_topo numero numero cap cap provincia provincia cod_comune cod_comune dummy cod_citt_occ] $label_ins_sogg]

#link inserimento proprietario
set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_prop dummy dummy flag_ins_prop flag_ins_prop] $label_ins_sogg]

#link inserimento terzi
#set link_ins_terzi [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_terzi dummy dummy dummy dummy  flag_ins_terzi flag_ins_terzi] "Inserisci Sogg."]

if {[form is_request $form_name]} {
    element set_properties $form_name flag_conferma    -value "s"
    element set_properties $form_name soloatt          -value "s"
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    element set_properties $form_name stato_01         -value $stato_01
    element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new    
    element set_properties $form_name cod_impianto_est -value $cod_impianto_est_new    
    element set_properties $form_name f_resp_cogn      -value $f_resp_cogn
    element set_properties $form_name f_resp_nome      -value $f_resp_nome
    element set_properties $form_name f_comune         -value $f_comune 
    element set_properties $form_name cod_as_resp      -value $cod_as_resp
    element set_properties $form_name f_cod_via        -value $f_cod_via
    element set_properties $form_name f_desc_via       -value $f_desc_via
    element set_properties $form_name f_desc_topo      -value $f_desc_topo
    element set_properties $form_name flag_ins_occu    -value $flag_ins_occu
    element set_properties $form_name flag_ins_prop    -value $flag_ins_prop
    element set_properties $form_name flag_ins_terzi   -value $flag_ins_terzi
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name n_generatori     -value "1"
    element set_properties $form_name __refreshing_p   -value 0;#nic02
    element set_properties $form_name changed_field    -value "";#nic02
    element set_properties $form_name flag_conferma_pdr -value "s";#rom01m

    if {$funzione == "I"} {
	if {[string equal $coimtgen(flag_ente) "C"]} {
	    #se l'ente e' un comune assegno alcuni default con i dati di ambiente
	    element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
	    element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
	}

        element set_properties $form_name provincia     -value $coimtgen(sigla_prov)
        element set_properties $form_name cod_provincia -value $coimtgen(cod_provincia)
	element set_properties $form_name flag_dpr412   -value "S"

	if {$flag_da_controllare eq "t"} {;#gab04 aggiunta if e contenuto
            element set_properties $form_name stato                 -value "F"
        } else {;#gab04 aggiunta else
	    element set_properties $form_name stato	            -value "A"
	}
	
	if {![string equal $cod_as_resp ""]} {
	    db_1row sel_as_resp "select a.cod_legale_rapp
                                       ,b.cognome as cognome_legale
                                       ,b.nome as nome_legale
                                       ,a.cod_manutentore
                                       ,d.cognome as cognome_manu
                                       ,d.nome as nome_manu
                                       ,a.toponimo
                                       ,a.indirizzo
                                       ,a.cod_via
                                       ,a.localita
                                       ,a.numero
                                       ,a.esponente
                                       ,a.scala
                                       ,a.piano
                                       ,a.interno
                                       ,a.cod_comune
                                       ,a.cod_responsabile
                                       ,c.cognome as cognome_prop
                                       ,c.nome as nome_prop
                                       ,iter_edit_num(a.potenza, 2) as potenza
                                       ,a.cod_utgi
                                   from coim_as_resp a
                        left outer join coimcitt b on b.cod_cittadino = a.cod_legale_rapp
                        left outer join coimcitt c on c.cod_cittadino = a.cod_responsabile
                        left outer join coimmanu d on d.cod_manutentore = a.cod_manutentore
                                  where cod_as_resp = :cod_as_resp"
	    element set_properties $form_name flag_responsabile -value "T"
	    element set_properties $form_name cognome_terzi    -value $cognome_legale
	    element set_properties $form_name nome_terzi       -value $nome_legale
	    element set_properties $form_name cod_citt_terzi   -value $cod_legale_rapp
	    element set_properties $form_name cognome_manu     -value $cognome_manu
	    element set_properties $form_name nome_manu        -value $nome_manu
	    element set_properties $form_name cod_manu_manu    -value $cod_manutentore
	    element set_properties $form_name descr_topo       -value $toponimo
	    element set_properties $form_name descr_via        -value $indirizzo
	    element set_properties $form_name f_cod_via        -value $cod_via
	    element set_properties $form_name localita         -value $localita
	    element set_properties $form_name numero           -value $numero
	    element set_properties $form_name esponente        -value $esponente
	    element set_properties $form_name scala            -value $scala
	    element set_properties $form_name piano            -value $piano
	    element set_properties $form_name interno          -value $interno
	    element set_properties $form_name cod_comune       -value $cod_comune
	    element set_properties $form_name cod_citt_prop    -value $cod_responsabile
	    element set_properties $form_name cognome_prop     -value $cognome_prop
	    element set_properties $form_name nome_prop        -value $nome_prop
	    element set_properties $form_name potenza          -value $potenza
	    element set_properties $form_name cod_utgi         -value $cod_utgi
	    element set_properties $form_name cod_tpco         -value $cod_tpco
	    element set_properties $form_name cod_flre         -value $cod_flre
	    element set_properties $form_name carica_refrigerante -value $carica_refrigerante
	    element set_properties $form_name sigillatura_carica  -value $sigillatura_carica
	    element set_properties $form_name targa            -value $targa;#rom02

	} else {

	    # se l'utente corrente e' un manutentore, allora valorizzo
	    # il relativo cognome nome
	    set cod_manu_manu [iter_check_uten_manu $id_utente]
	    if {![string is space $cod_manu_manu]
		&&   [db_0or1row sel_manu_nome ""] == 1
	    } {
		element set_properties $form_name cod_manu_manu -value $cod_manu_manu
		element set_properties $form_name cognome_manu  -value $cognome_manu
		element set_properties $form_name nome_manu     -value $nome_manu
	    }
	    
	    # valorizzo cognome e nome responsabile con cognome e nome dal filtro 
	    set cognome_occu $f_resp_cogn
	    set nome_occu    $f_resp_nome
	    
	    element set_properties $form_name cognome_occ      -value $cognome_occu
	    element set_properties $form_name nome_occ         -value $nome_occu

	    if {$targa eq ""} {#gac04 aggiunto solo la if e non il contenuto
		set resp_inte "O"
		element set_properties $form_name flag_responsabile -value $resp_inte
	    }
	    
	    element set_properties $form_name cod_comune -value $f_comune

	    # per ente Comune, il comune e' sempre valorizzato con la tgen
	    # la provincia (readonly) e' sempre valorizzata con la tgen
	    element set_properties $form_name descr_topo -value $f_desc_topo
	    element set_properties $form_name descr_via  -value $f_desc_via
	}
	if {$targa ne ""} {#gac04 aggiunta if e suo contenuto

	    	    db_0or1row q "select cod_cted   as cod_cted_ereditato
                               , localita   as localita_ereditato
                               , cod_comune as cod_comune_ereditato
                               , cap        as cap_ereditato
                               , cod_via    as cod_via_ereditato
                               , toponimo   as descr_topo_ereditato
                               , indirizzo  as descr_via_ereditato
                               , numero     as numero_ereditato
                               , esponente  as esponente_ereditato
                               , scala      as scala_ereditato
                               , piano      as piano_ereditato
                               , interno    as interno_ereditato
                            from coimaimp
                           where targa = :targa limit 1"

	    element set_properties $form_name cod_cted   -value $cod_cted_ereditato
	    element set_properties $form_name localita   -value $localita_ereditato
	    element set_properties $form_name cod_comune -value $cod_comune_ereditato
	    element set_properties $form_name cap        -value $cap_ereditato
	    element set_properties $form_name f_cod_via  -value $cod_via_ereditato
	    element set_properties $form_name descr_topo -options [list [list $descr_topo_ereditato $descr_topo_ereditato]]
	    element set_properties $form_name descr_topo -value $descr_topo_ereditato
	    element set_properties $form_name descr_via  -value $descr_via_ereditato
	    element set_properties $form_name numero     -value $numero_ereditato
	    element set_properties $form_name esponente  -value $esponente_ereditato
	    element set_properties $form_name scala      -value $scala_ereditato
	    element set_properties $form_name piano      -value $piano_ereditato
	    element set_properties $form_name interno    -value $interno_ereditato

	    set flag_responsabile_ereditato ""
	    db_0or1row q "select flag_resp as flag_responsabile_ereditato
                            , cod_proprietario
                            , cod_occupante
                            , cod_amministratore
                         from coimaimp 
                        where targa = :targa
                          and flag_resp != 'T' limit 1"
	    if {$flag_responsabile_ereditato ne ""} {
		element set_properties $form_name flag_responsabile -value $flag_responsabile_ereditato

		switch $flag_responsabile_ereditato {
		    "O" {
			db_1row q "select cognome as cognome_occ, nome as nome_occ from coimcitt where cod_cittadino = :cod_occupante"
			element set_properties $form_name cod_citt_occ -value $cod_occupante
			element set_properties $form_name cognome_occ -value $cognome_occ
			element set_properties $form_name nome_occ -value $nome_occ
		    }
		    "A" {
			db_1row q "select cognome as cognome_amm, nome as nome_amm from coimcitt where cod_cittadino = :cod_amministratore"
			element set_properties $form_name cod_citt_amm -value $cod_amministratore
			element set_properties $form_name cognome_amm -value $cognome_amm
			element set_properties $form_name nome_amm -value $nome_amm
		    }
		    "P" {
			db_1row q "select cognome as cognome_prop, nome as nome_prop from coimcitt where cod_cittadino = :cod_proprietario"
			element set_properties $form_name cod_citt_prop -value $cod_proprietario
			element set_properties $form_name cognome_prop -value $cognome_prop
			element set_properties $form_name nome_prop -value $nome_prop
			
		    }
		}

                if {$cod_proprietario ne ""} {
                    #si è deciso successivamente di ereditare sempre il proprietario
                    db_0or1row q "select cognome as cognome_prop, nome as nome_prop from coimcitt where cod_cittadino = :cod_proprietario"
                    element set_properties $form_name cod_citt_prop -value $cod_proprietario
                    element set_properties $form_name cognome_prop -value $cognome_prop
                    element set_properties $form_name nome_prop -value $nome_prop
                }	    
	    }
	}
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set __refreshing_p    [element::get_value $form_name __refreshing_p];#nic02
    set changed_field     [element::get_value $form_name changed_field];#nic02
    set cod_impianto_est  [string trim [element::get_value $form_name cod_impianto_est]]
    set stato             [string trim [element::get_value $form_name stato]]
    if {$flag_da_controllare eq "t"} {;#gab04 aggiunta if e contenuto
        set stato "F"
        element set_properties $form_name stato                 -value "F"
    } else {;#gab04 aggiunta else
	set stato "A"
	element set_properties $form_name stato			-value "A"
    }
    set note              [string trim [element::get_value $form_name note]]
    set localita          [string trim [element::get_value $form_name localita]]

    if {[string equal $coimtgen(flag_ente) "C"]} {
        set descr_comu    [string trim [element::get_value $form_name descr_comu]]
    }
    set cod_comune        [string trim [element::get_value $form_name cod_comune]]
    set provincia         [string trim [element::get_value $form_name provincia]]
    set cap               [string trim [element::get_value $form_name cap]]
    set descr_via         [string trim [element::get_value $form_name descr_via]]
    set descr_topo        [string trim [element::get_value $form_name descr_topo]]
    set numero            [string trim [element::get_value $form_name numero]]
    set esponente         [string trim [element::get_value $form_name esponente]]
    set scala             [string trim [element::get_value $form_name scala]]
    set piano             [string trim [element::get_value $form_name piano]]
    set interno           [string trim [element::get_value $form_name interno]]
    set flag_responsabile [string trim [element::get_value $form_name flag_responsabile]]
    set cognome_inte      [string trim [element::get_value $form_name cognome_inte]]
    set nome_inte         [string trim [element::get_value $form_name nome_inte]]
    set cognome_prop      [string trim [element::get_value $form_name cognome_prop]]
    set nome_prop         [string trim [element::get_value $form_name nome_prop]]
    set cognome_occ       [string trim [element::get_value $form_name cognome_occ]]
    set nome_occ          [string trim [element::get_value $form_name nome_occ]]
    set cognome_amm       [string trim [element::get_value $form_name cognome_amm]]
    set nome_amm          [string trim [element::get_value $form_name nome_amm]]
    set cognome_terzi     [string trim [element::get_value $form_name cognome_terzi]]
    set nome_terzi        [string trim [element::get_value $form_name nome_terzi]]
    set cognome_manu      [string trim [element::get_value $form_name cognome_manu]]
    set nome_manu         [string trim [element::get_value $form_name nome_manu]]
    set cognome_inst      [string trim [element::get_value $form_name cognome_inst]]
    set nome_inst         [string trim [element::get_value $form_name nome_inst]]
    set cognome_prog      [string trim [element::get_value $form_name cognome_prog]]
    set nome_prog         [string trim [element::get_value $form_name nome_prog]]
    set potenza           [string trim [element::get_value $form_name potenza]]
    set potenza_utile     [string trim [element::get_value $form_name potenza_utile]]
    set potenza_utile_freddo [string trim [element::get_value $form_name potenza_utile_freddo]];#sim04
    set potenza_termica_nominale [string trim [element::get_value $form_name potenza_termica_nominale]];#rom08
    set potenza_termica_assorbita_nominale [string trim [element::get_value $form_name potenza_termica_assorbita_nominale]];#rom08
    set cod_potenza       [string trim [element::get_value $form_name cod_potenza]]
    set cod_provincia     [string trim [element::get_value $form_name cod_provincia]]
    set cod_citt_inte     [string trim [element::get_value $form_name cod_citt_inte]]
    set cod_citt_prop     [string trim [element::get_value $form_name cod_citt_prop]]
    set cod_citt_occ      [string trim [element::get_value $form_name cod_citt_occ]]
    set cod_citt_amm      [string trim [element::get_value $form_name cod_citt_amm]]
    set cod_citt_terzi    [string trim [element::get_value $form_name cod_citt_terzi]]
    set cod_manu_manu     [string trim [element::get_value $form_name cod_manu_manu]]
    set cod_manu_inst     [string trim [element::get_value $form_name cod_manu_inst]]
    set cod_prog          [string trim [element::get_value $form_name cod_prog]]
    set f_cod_via         [string trim [element::get_value $form_name f_cod_via]]
    set cod_via           ""
    set flag_dpr412       [string trim [element::get_value $form_name flag_dpr412]]
    set cod_cted          [string trim [element::get_value $form_name cod_cted]]
    set matricola         [string trim [element::get_value $form_name matricola]]
    set modello           [string trim [element::get_value $form_name modello]]
    set cod_cost          [string trim [element::get_value $form_name cod_cost]]
    set provenienza_dati  "3"
    set data_installaz    [string trim [element::get_value $form_name data_installaz]]
    set anno_costruzione  [string trim [element::get_value $form_name anno_costruzione]]
    set cod_combustibile  [string trim [element::get_value $form_name cod_combustibile]]
    set cod_tpim          [string trim [element::get_value $form_name cod_tpim]]
    set tipo_foco         [string trim [element::get_value $form_name tipo_foco]]
    set tiraggio          [string trim [element::get_value $form_name tiraggio]]
    set cod_tpdu          [string trim [element::get_value $form_name cod_tpdu]]
    set volimetria_risc   [string trim [element::get_value $form_name volimetria_risc]]
    set n_generatori      [string trim [element::get_value $form_name n_generatori]]
    set cod_utgi          [string trim [element::get_value $form_name cod_utgi]]
    set cod_emissione     [string trim [element::get_value $form_name cod_emissione]]

    set num_contratto     [string trim [element::get_value $form_name num_contratto]]
    set data_inizio_cont  [string trim [element::get_value $form_name data_inizio_cont]]
    set data_fine_cont    [string trim [element::get_value $form_name data_fine_cont]]

    set dati_scheda       [string trim [element::get_value $form_name dati_scheda]]
    set data_scheda       [string trim [element::get_value $form_name data_scheda]]
    set flag_conferma     [string trim [element::get_value $form_name flag_conferma]]
    set cod_tpco          [string trim [element::get_value $form_name cod_tpco]]
    set cod_flre          [string trim [element::get_value $form_name cod_flre]]
    set carica_refrigerante [string trim [element::get_value $form_name carica_refrigerante]]
    set sigillatura_carica  [string trim [element::get_value $form_name sigillatura_carica]]
    set flag_conferma_pdr [element::get_value $form_name flag_conferma_pdr  ];#rom01m
    set pdr               [element::get_value $form_name pdr                ];#rom01m
    set pod               [element::get_value $form_name pod                ];#rom01m
    set targa             [string trim [element::get_value $form_name targa]];#rom02


    #Imposto ora le options di cod_mode perchè solo adesso ho a disposizione la var. cod_cost
    element set_properties $form_name cod_mode -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost]'" cod_mode descr_mode];#nic02
    set cod_mode          [element::get_value $form_name cod_mode];#nic02


    if {[string equal $__refreshing_p "1"]} {;#nic02
        if {$changed_field eq "cod_cost"} {;#nic02
            set focus_field "$form_name.cod_mode";#nic02
        };#nic02

        element set_properties $form_name __refreshing_p -value 0;#nic02
        element set_properties $form_name changed_field  -value "";#nic02

        ad_return_template;#nic02
        return;#nic02
    };#nic02


    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione eq "I"} {

	if {$coimtgen(regione) ne "MARCHE"} {
	    if {[string equal $flag_dpr412 ""]} {
		element::set_error $form_name flag_dpr412 "Inserire"
		incr error_num	    
	    }
	}
        if {[string equal $cod_impianto_est ""] &&  $flag_cod_aimp_auto == "F"} {
	    element::set_error $form_name cod_impianto_est "Inserire codice impianto"
	    incr error_num
	}

	if {[string equal $stato ""]} {
	    element::set_error $form_name stato "Inserire lo stato dell'impianto"
	    incr error_num
	}

        if {![string equal $cod_impianto_est ""] && [db_0or1row check_aimp ""] == 1} {
	    element::set_error $form_name cod_impianto_est "Esiste gi&agrave; un impianto con questo codice"
	    incr error_num
	}
	
        set flag_potenza_ok "f"
        if {![string equal $potenza ""]} {
	    set potenza [iter_check_num $potenza 2]
	    if {$potenza < "0.01"} {
                element::set_error $form_name potenza "deve essere diverso da 0,00"
                incr error_num
	    }
            if {$potenza == "Error"} {
                element::set_error $form_name potenza "numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $potenza] >=  [expr pow(10,7)]
		    ||  [iter_set_double $potenza] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza "Deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}
		
                set potenza_tot $potenza
		if {$flag_potenza_ok == "t"
		    &&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name potenza "Non compresa in nessuna fascia"
		    incr error_num
		}

                if {![string equal $potenza ""]} {
                    if {[string equal $cod_tpim ""]} {
			if {$potenza > 35} {
			    set cod_tpim "2"
			} else { 
			    set cod_tpim "1"
			}
		    }              
		}       
            }
        }


	set is_null_potenza_utile_p                    0;#sim07
	set is_null_potenza_p                          0;#sim07
	set is_null_potenza_termica_nominale_p         0;#sim07
	set is_null_potenza_termica_assorbita_nominale 0;#sim07
		
        if {[string equal $potenza_utile ""] && $coimtgen(regione) ne "MARCHE"} {#sim07 aggiunto condizione su regione marche
	    #sim04 element::set_error $form_name potenza_utile "Potenza utile > 0"
	    element::set_error $form_name potenza_utile "Inserire la potenza";#sim04
	    incr error_num
        }

	if {[string equal $potenza_utile ""] && $coimtgen(regione) eq "MARCHE"} {#sim07 if e suo contenuto
	    set is_null_potenza_utile_p 1
	}

	if {$coimtgen(regione) eq "MARCHE"} {#rom08 La Regione Marche, a differenza del resto dei clienti, deve usare solo la potenza di assorbimento e non la potenza utile del freddo
	    set potenza_utile_freddo $potenza_utile
	    set potenza_utile ""
	    set nome_potenza_per_errore "potenza_utile"
	} else {
	    set nome_potenza_per_errore "potenza_utile_freddo"
	}

        set flag_potenza_ok "f"
        if {[string equal $potenza_utile ""]} {
	    set potenza_utile 0
        } else {
            set potenza_utile [iter_check_num $potenza_utile 2]
            if {$potenza_utile == "Error"} {
                element::set_error $form_name potenza_utile "numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $potenza_utile] >=  [expr pow(10,7)]
		    ||  [iter_set_double $potenza_utile] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza_utile "deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}

                #sim04 set potenza_tot $potenza_utile 
		#sim04 if {$flag_potenza_ok == "t"
		#sim04     &&  [db_0or1row check_fascia_pote ""]== 0} {
		#sim04    element::set_error $form_name potenza_utile "Non compresa in nessuna fascia"
		#sim04    incr error_num
		#sim04}           
            }
        }

	if {1==0} {#sim04 il controllo deve essere fatto sulla potenza_utile_freddo quindi faccio in modo che il vecchio controllo venga sempre saltato
        if {![string equal $potenza_utile ""] && $potenza_utile != "Error"} {
	    set potenza_tot $potenza_utile
	    if {![string equal $cod_potenza ""] } {
		if {[db_0or1row check_fascia_pote2 ""]== 0} {
		    element::set_error $form_name potenza "Non compresa nella fascia di potenza"
		    incr error_num
		}
	    } else {
		if {[db_0or1row assegna_fascia ""]== 0} {
		    element::set_error $form_name potenza "Nessuna fascia disponibile"
		    incr error_num
		}
	    }
	} else {
	    if {[string equal $cod_potenza ""] } {
	        element::set_error $form_name potenza "Inserire la potenza"
	        incr error_num
	    }
	}
	}
        set flag_potenza_freddo_ok "f";#sim04
        if {[string equal $potenza_utile_freddo ""]} {#sim04 if else e loro contenuto
	    set potenza_utile_freddo ""
        } else {
            set potenza_utile_freddo [iter_check_num $potenza_utile_freddo 2]
            if {$potenza_utile_freddo == "Error"} {
                element::set_error $form_name $nome_potenza_per_errore "numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $potenza_utile_freddo] >=  [expr pow(10,7)]
		    ||  [iter_set_double $potenza_utile_freddo] <= -[expr pow(10,7)]} {
                    element::set_error $form_name $nome_potenza_per_errore "deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_freddo_ok "t"
		}

                set potenza_tot $potenza_utile_freddo 
		if {$flag_potenza_freddo_ok == "t"
		    &&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name $nome_potenza_per_errore "Non compresa in nessuna fascia"
		    incr error_num
		}           
            }
        }

	if {![string equal $potenza_utile_freddo ""] && $potenza_utile_freddo != "Error"} {#sim04 if else e loro contenuto
	    set potenza_tot $potenza_utile_freddo
	    if {![string equal $cod_potenza ""] } {
		if {[db_0or1row check_fascia_pote2 ""]== 0} {
		    element::set_error $form_name potenza_utile_freddo "Non compresa nella fascia di potenza"
		    incr error_num
		}
	    } else {
		if {[db_0or1row assegna_fascia ""]== 0} {
		    element::set_error $form_name potenza_utile_freddo "Nessuna fascia disponibile"
		    incr error_num
		}
	    }
	} else {
	    if {[string equal $cod_potenza ""] } {
		if {$coimtgen(regione) eq "MARCHE"} {#sim07 if e suo contenuto
		    set is_null_potenza_utile_p 1
		} else {#sim07 else ma non suo contenuto
		    element::set_error $form_name potenza "Inserire la potenza"
		    incr error_num
		}
	    }
	}

	#sim07 aggiunto condizione su MARCHE
	if {[string equal $potenza_utile_freddo ""] && $coimtgen(regione) ne "MARCHE"} {#sim04 if e suo contenuto
	    element::set_error $form_name potenza_utile_freddo "Potenza utile > 0"
	    incr error_num
        } 

	if {![string equal $cod_potenza ""] && [string equal $potenza ""]} {
	    if {[db_0or1row sel_pote ""] == 0} {
		set potenza 0
	    }
	}

	####rom08inizio controlli su potenze termiche#########
	if {$coimtgen(regione) eq "MARCHE"} {

	    if {[string equal $potenza ""]} {#sim07 if e suo contenuto
		set is_null_potenza_p 1
	    }

	    
	    if {[string equal $potenza_termica_nominale ""]} {	
#sim07		element::set_error $form_name potenza_termica_nominale "Inserire la potenza"
#sim07		incr error_num
		set is_null_potenza_termica_nominale_p 1;#sim07
	    } else {
		set potenza_termica_nominale [iter_check_num $potenza_termica_nominale 2]
		if {$potenza_termica_nominale == "Error"} {
		    element::set_error $form_name potenza_termica_nominale "numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $potenza_termica_nominale] >=  [expr pow(10,7)]
			||  [iter_set_double $potenza_termica_nominale] <= -[expr pow(10,7)]} {
			element::set_error $form_name potenza_termica_nominale "deve essere < di 10.000.000"
			incr error_num
		    }
		}
	    }
	    
	    if {[string equal $potenza_termica_assorbita_nominale ""]} {
#sim07		element::set_error $form_name potenza_termica_assorbita_nominale "Inserire la potenza"
#sim07		incr error_num
		set is_null_potenza_termica_assorbita_nominale 1;#sim07
	    } else {
		set potenza_termica_assorbita_nominale [iter_check_num $potenza_termica_assorbita_nominale 2]
		if {$potenza_termica_assorbita_nominale == "Error"} {
		    element::set_error $form_name potenza_termica_assorbita_nominale "numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $potenza_termica_assorbita_nominale] >=  [expr pow(10,7)]
			||  [iter_set_double $potenza_termica_assorbita_nominale] <= -[expr pow(10,7)]} {
			element::set_error $form_name potenza_termica_assorbita_nominale "deve essere < di 10.000.000"
			incr error_num
		    }
		}
	    }

	    set is_null_raffrescamento_p 0;#sim07
	    set is_null_riscaldamento_p  0;#sim07

	    #sim07 verifico se sono tutti nulli i campi relativi alla potenza del freddo
	    if {$is_null_potenza_utile_p && $is_null_potenza_p} {#sim07 if else e loro contenuto
		set is_null_raffrescamento_p 1
		#non avendo i dati del freddo, prendo come potenza_tot la potenza del caldo
		set potenza_tot $potenza_termica_nominale
	    } else {

		#se non sono tutti nulli devono essere tutti valorizzati.
		if {$is_null_potenza_utile_p || $is_null_potenza_p} {
		    incr error_num
		    element::set_error $form_name potenza "Inserire tutti i campi relativi al Raffrescamento"
		}
		
	    }

	    #sim07 verifico se sono tutti nulli i campi relativi alla potenza del caldo
	    if {$is_null_potenza_termica_nominale_p && $is_null_potenza_termica_assorbita_nominale} {#sim07 if else e loro contenuto
		set is_null_riscaldamento_p 1
	    } else {

		#se non sono tutti nulli devono essere tutti valorizzati.
		if {$is_null_potenza_termica_nominale_p || $is_null_potenza_termica_assorbita_nominale} {
		    incr error_num
		    element::set_error $form_name potenza_termica_nominale "Inserire tutti i campi relativi al Riscaldamento"
		}

	    }

	    #se sia i dati del caldo che i dati del freddo sono nulli do un messaggio di errore
	    if {$is_null_riscaldamento_p && $is_null_raffrescamento_p} {
		element::set_error $form_name potenza "Inserire i dati delle potenze di Raffrescamento e/o di Riscaldamento"	
		incr error_num

	    }
	    	    
	}
	####rom08fine   controlli su potenze termiche#########
	
        if {[string equal $data_installaz ""]} {
            element::set_error $form_name data_installaz "Inserire data"
            incr error_num
        } else {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data non corretta"
                incr error_num
            } else {#sim05 else e suo contenuto
                if {$coimtgen(regione) eq "MARCHE" && $data_installaz >= "20180601" && $cod_manu_inst eq ""} {
                    #rom06element::set_error $form_name cognome_inst "Inserire installatore"
                    #rom06incr error_num
                }
            }
        }
	if {[string equal $anno_costruzione ""]} {
	    if {$coimtgen(regione) ne "MARCHE"} {#rom07  aggiunta if ma non suo contenuto
		element::set_error $form_name anno_costruzione "Inserire data"
		incr error_num
	    }
        } else {
	    if {[string length $anno_costruzione] == 4} {#gac02
		set anno_costruzione "01/01/$anno_costruzione"
	    };#gac02
            set anno_costruzione [iter_check_date $anno_costruzione]
            if {$anno_costruzione == 0} {
                element::set_error $form_name anno_costruzione "Data non corretta"
                incr error_num
            }
        }

	if {$anno_costruzione ne "" && $data_installaz ne ""} {#gac02
	    if {$anno_costruzione > $data_installaz} {
		element::set_error $form_name data_installaz "Data installazione deve essere superiore alla data di costruzione"
		incr error_num
	    }
	};#gac02
	
	#        if {[string equal $data_installaz ""]} {
	#            element::set_error $form_name data_installaz "Inserire data"
	#            incr error_num
	#        } else {
	#            set data_installaz [iter_check_date $data_installaz]
	#            if {$data_installaz == 0} {
	#                element::set_error $form_name data_installaz "Data non corretta"
	#                incr error_num
	#            }
	#        }

	# se la via e' valorizzata, ma manca il comune: errore
	if {![string equal $descr_via  ""] ||  ![string equal $descr_topo ""]} {
	    if {[string equal $cod_comune ""]} {
		if {$coimtgen(flag_ente) == "P"} {
		    element::set_error $form_name cod_comune "valorizzare il Comune" 
		    incr error_num
		} else {
		    if {[string equal $coimtgen(flag_ente) "C"]} {
			element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
			element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
		    }
		    #		    element::set_error $form_name descr_comu "valorizzare il Comune"
		} 
	    } 
	}

	if {[string equal $coimtgen(flag_ente) "C"]} {
	    set cod_comune $coimtgen(cod_comu)
	}
	if {$coimtgen(flag_ente) == "P"} {
	    if {[string equal $cod_comune ""]} {
		element::set_error $form_name cod_comune "valorizzare il Comune" 
		incr error_num
	    }
	}

	if {[string equal $descr_via  ""]} {
	    element::set_error $form_name descr_via "valorizzare l'indirizzo" 
	    incr error_num
	}

	# si controlla la via solo se il primo test e' andato bene.
	# in questo modo si e' sicuri che f_comune e' stato valorizzato.
	if {$coimtgen(flag_viario) == "T"} {
	    if {[string equal $descr_via  ""] &&  [string equal $descr_topo ""]} {
		set f_cod_via ""
	    } else {
		# controllo codice via
		set chk_out_rc      0
		set chk_out_msg     ""
		set chk_out_cod_via ""
		set ctr_viae        0
		if {[string equal $descr_topo ""]} {
		    set eq_descr_topo  "is null"
		} else {
		    set eq_descr_topo  "= upper(:descr_topo)"
		}
		if {[string equal $descr_via ""]} {
		    set eq_descrizione "is null"
		} else {
		    set eq_descrizione "= upper(:descr_via)"
		}
		db_foreach sel_viae "" {
		    incr ctr_viae
		    if {$cod_via == $f_cod_via} {
			set chk_out_cod_via $cod_via
			set chk_out_rc       1
		    }
		}
		switch $ctr_viae {
		    0 { set chk_out_msg "Via non trovata"}
		    1 { set chk_out_cod_via $cod_via
			set chk_out_rc       1 }
		    default {
			if {$chk_out_rc == 0} {
			    set chk_out_msg "Trovate pi&ugrave; vie: usa il link cerca"
			}
		    }
		}
		set f_cod_via $chk_out_cod_via
		set cod_via   $chk_out_cod_via
		if {$chk_out_rc == 0} {
		    element::set_error $form_name descr_via $chk_out_msg
		    incr error_num
		}
	    }
	}

        if {![string equal $cap ""]} {
            set cap [iter_check_num $cap 0]
            if {$cap == "Error"} {
                element::set_error $form_name cap "numerico"
                incr error_num
	    }
	} else {
         if {[db_0or1row sel_comu_cap ""] == 0} {
		set cap ""
	    }
	}

        if {![string equal $numero ""]} {
            set numero [iter_check_num $numero 0]
            if {$numero == "Error"} {
                element::set_error $form_name numero "N. civ deve essere numerico"
                incr error_num
	    }
	}

        #routine generica per controllo codice soggetto
        set check_cod_citt {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_citt ""
            set ctr_citt         0
            if {[string equal $chk_inp_cognome ""]} {
                set eq_cognome "is null"
	    } else {
                set eq_cognome "= upper(:chk_inp_cognome)"
	    }
            if {[string equal $chk_inp_nome ""]} {
                set eq_nome    "is null"
	    } else {
                set eq_nome    "= upper(:chk_inp_nome)"
	    }
            db_foreach sel_citt "" {
                incr ctr_citt
                if {$cod_cittadino == $chk_inp_cod_citt} {
		    set chk_out_cod_citt $cod_cittadino
                    set chk_out_rc       1
		}
	    }
            switch $ctr_citt {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_msg "Esiste gi&agrave; un soggetto con il nominativo inserito,<br> verificarne la correttezza con il tasto cerca<br>o inserirne uno nuovo"
		    set chk_out_cod_citt $cod_cittadino
		    set chk_out_rc       1 }
		default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_inte ""] && [string equal $nome_inte ""]} {
            set cod_citt_inte ""
	} else {
	    set chk_inp_cod_citt $cod_citt_inte
	    set chk_inp_cognome  $cognome_inte
	    set chk_inp_nome     $nome_inte
	    eval $check_cod_citt
            set cod_citt_inte    $chk_out_cod_citt

	    switch $chk_out_rc {
		0 {
		    element::set_error $form_name cognome_inte $chk_out_msg
		    incr error_num
		}
		1 {
		    if {[string equal $chk_inp_cod_citt ""]} {
			element::set_error $form_name cognome_inte $chk_out_msg
			incr error_num
		    }
		}
	    }
	}
        if {[string equal $cognome_prop ""] && [string equal $nome_prop ""]} {
            set cod_citt_prop ""
	} else {
	    if {![string equal [string toupper $cognome_prop] [string toupper $cognome_occ]]
		||  ![string equal [string toupper $nome_prop] [string toupper $nome_occ]]
	    } {
		set chk_inp_cod_citt $cod_citt_prop
		set chk_inp_cognome  $cognome_prop
		set chk_inp_nome     $nome_prop
		eval $check_cod_citt
		set cod_citt_prop    $chk_out_cod_citt
		
		switch $chk_out_rc {
		    0 {
			element::set_error $form_name cognome_prop $chk_out_msg
			incr error_num
		    }
		    1 {
			if {[string equal $chk_inp_cod_citt ""]} {
			    element::set_error $form_name cognome_prop $chk_out_msg
			    incr error_num
			}
		    }
		}
	    }
	}
        ########
	# se il soggetto occupante non c'� lo inserisco con l'indirizzo
        # uguale all'ubicazione dell'impianto. se il soggetto � presente 
        # con piu' omonimi, la prima volta visualizzo il messaggio, la 
        # seconda volta lascio inserire il soggetto.
        # se c'� un solo soggetto occupante con cognome e nome uguale (e
        # l'occupante e' stato inserito senza l'utilizzo del cerca), visualizzo 
        # un messaggio che informa l'utente dell'esistenza di un soggetto
        # omonimo, invitando a verificare se il soggetto � corretto, in altro 
        # casol l'utente deve inserire il nuovo soggetto manualmente.

        if {[string equal $cognome_occ ""] && [string equal $nome_occ    ""]} {
            set cod_citt_occ ""
	} else {
	    set chk_inp_cod_citt $cod_citt_occ
	    set chk_inp_cognome  $cognome_occ
	    set chk_inp_nome     $nome_occ

	    eval $check_cod_citt
	    
            set cod_citt_occ     $chk_out_cod_citt
	    if {[db_0or1row sel_comu_desc ""] == 0} {
		set desc_comune ""
	    }

	    if {$flag_ins_occu == "T"} {
		db_1row sel_cod_citt ""
		set cod_citt_occ $cod_cittadino
		set indirizzo "$descr_topo $descr_via"
		#		set dml_ins_citt [db_map ins_citt]
	    } else {
		switch $chk_out_rc {
		    0 {
			if {[string equal $flag_ins_occu ""]
			    &&  $chk_out_msg   == "Trovati pi&ugrave; soggetti: usa il link cerca"
		        } {
			    element::set_error $form_name cognome_occ $chk_out_msg
			    incr error_num
			    #			    set flag_ins_occu "T"
			    #			    element set_properties $form_name flag_ins_occu -value $flag_ins_occu
		        } else {
			    if {$flag_ins_occu == ""} {
				element::set_error $form_name cognome_occ $chk_out_msg
				incr error_num
			    } else {
				# in questo caso il soggetto non esiste
				#				db_1row sel_cod_citt ""
				#				set cod_citt_occ $cod_cittadino
				#				set indirizzo "$descr_topo $descr_via"
				#				set dml_ins_citt [db_map ins_citt]
			    }
		        }
		    }
		    1 {
			if {[string equal $chk_inp_cod_citt ""]} {
			    element::set_error $form_name cognome_occ $chk_out_msg
			    incr error_num
			}
	 	    }
		}
	    }
	}

        if {[string equal $cognome_amm ""] && [string equal $nome_amm  ""]} {
            set cod_citt_amm ""
	} else {
	    set chk_inp_cod_citt $cod_citt_amm
	    set chk_inp_cognome  $cognome_amm
	    set chk_inp_nome     $nome_amm
	    eval $check_cod_citt
            set cod_citt_amm     $chk_out_cod_citt
	    switch $chk_out_rc {
		0 {
		    element::set_error $form_name cognome_amm $chk_out_msg
		    incr error_num
		}
		1 {
		    if {[string equal $chk_inp_cod_citt ""]} {
			element::set_error $form_name cognome_amm $chk_out_msg
			incr error_num
		    }
		}
	    }
	}

        if {[string equal $cognome_terzi ""] &&  [string equal $nome_terzi  ""]} {
            set cod_citt_terzi ""
	} else {
	    if {![string equal $flag_responsabile "T"]} {
		element::set_error $form_name cognome_terzi "non inserire terzo responsabile: non &egrave; il responsabile"
		incr error_num
	    } else {
		if {[string range $cod_citt_terzi 0 1] == "MA"} {
		    set cod_manut $cod_citt_terzi

		    element set_properties $form_name cod_manut   -value $cod_manut
		    if {[db_0or1row sel_cod_legale ""] == 0} {
			set link_ins_rapp [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy dummy dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy cod_manutentore cod_manut dummy dummy flag_ins_terzi flag_ins_terzi] "crea automaticamente legale rappresentante"]
			element::set_error $form_name cognome_terzi "aggiornare il manutentore con i dati del legale rappresentante <br>o $link_ins_rapp"
			incr error_num
		    } else {
			set chk_inp_cod_citt $cod_citt_terzi
			set chk_inp_cognome  $cognome_terzi
			set chk_inp_nome     $nome_terzi
			eval $check_cod_citt
			set cod_citt_terzi        $chk_out_cod_citt
			if {$chk_out_rc == 0} {
			    element::set_error $form_name cognome_terzi $chk_out_msg
			    incr error_num
			}
		    }
		}
	    }
	}
	#rom10 Aggiunta condizione per Salerno
	#rom11if {$coimtgen(regione) eq "MARCHE" || $coimtgen(ente) eq "PSA"} {}#rom09 aggiunta if e suo contenuto
	if {$coimtgen(regione) in [list "MARCHE" "CAMPANIA"]} {#rom11 if e contenuto
	    if {[string equal $cognome_prop ""] && [string equal $nome_prop ""]} {
		element::set_error $form_name cognome_prop "inserire proprietario"
		incr error_num
	    }
	};#rom09
	
        #congruenza cod_resp con rispettivo codice
        set cod_citt_resp ""
        switch $flag_responsabile {
	    "T" {
		if {[string equal $cognome_terzi ""]
		    &&  [string equal $nome_terzi ""]
		} {
		    element::set_error $form_name cognome_terzi "inserire terzi: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_terzi
		}
	    }
	    "P" {
		if {[string equal $cognome_prop ""]
		    &&  [string equal $nome_prop ""]
		} {
		    element::set_error $form_name cognome_prop "inserire proprietario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_prop
		}
	    }
	    "O" {
		if {[string equal $cognome_occ ""]
		    &&  [string equal $nome_occ ""]
		} {
		    element::set_error $form_name cognome_occ "inserire occupante: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_occ
		}
	    }
	    "A" {
		if {[string equal $cognome_amm  ""]
		    &&  [string equal $nome_amm     ""]
		} {
		    element::set_error $form_name cognome_amm "inserire amministratore: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_amm
		}
	    }
	    "I" {
		if {[string equal $cognome_inte  ""]
		    &&  [string equal $nome_inte     ""]
		} {
		    element::set_error $form_name cognome_inte "inserire intestatario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_inte
		}
	    }
	    default {
		#		if {$flag_dichiarato == "S"} {
		element::set_error $form_name flag_responsabile "Indicare responsabile"
		incr error_num 
		#		}
	    }
	}

        #routine generica per controllo codice manutentore
        set check_cod_manu {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_manu ""
            set ctr_manu         0
            if {[string equal $chk_inp_cognome ""]} {
                set eq_cognome "is null"
	    } else {
                set eq_cognome "= upper(:chk_inp_cognome)"
	    }
            if {[string equal $chk_inp_nome ""]} {
                set eq_nome    "is null"
	    } else {
                set eq_nome    "= upper(:chk_inp_nome)"
	    }
            db_foreach sel_manu "" {
                incr ctr_manu
                if {$cod_manutentore == $chk_inp_cod_manu} {
		    set chk_out_cod_manu $cod_manutentore
                    set chk_out_rc       1
		}
	    }
            switch $ctr_manu {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_manu $cod_manutentore
		    set chk_out_rc       1 }
		default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_manu ""]
	    &&  [string equal $nome_manu    ""]
	} {
            set cod_manu_manu ""
	} else {
	    set chk_inp_cod_manu $cod_manu_manu
	    set chk_inp_cognome  $cognome_manu
	    set chk_inp_nome     $nome_manu
	    eval $check_cod_manu
            set cod_manu_manu    $chk_out_cod_manu
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_manu $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_inst ""]
	    &&  [string equal $nome_inst    ""]
	} {
            set cod_manu_inst ""
	} else {
	    set chk_inp_cod_manu $cod_manu_inst
	    set chk_inp_cognome  $cognome_inst
	    set chk_inp_nome     $nome_inst
	    eval $check_cod_manu
            set cod_manu_inst    $chk_out_cod_manu
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_inst $chk_out_msg
                incr error_num
	    }
	}

        #routine per controllo codice progettista
        set check_cod_prog {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_prog ""
            set ctr_prog         0
            if {[string equal $chk_inp_cognome ""]} {
                set eq_cognome "is null"
	    } else {
                set eq_cognome "= upper(:chk_inp_cognome)"
	    }
            if {[string equal $chk_inp_nome ""]} {
                set eq_nome    "is null"
	    } else {
                set eq_nome    "= upper(:chk_inp_nome)"
	    }
            db_foreach sel_prog "" {
                incr ctr_prog
                if {$cod_progettista == $chk_inp_cod_prog} {
		    set chk_out_cod_prog $cod_progettista
                    set chk_out_rc       1
		}
	    }
            switch $ctr_prog {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_prog $cod_progettista
		    set chk_out_rc       1 }
		default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_prog ""]
	    &&  [string equal $nome_prog    ""]
	} {
            set cod_prog ""
	} else {
	    set chk_inp_cod_prog $cod_prog
	    set chk_inp_cognome  $cognome_prog
	    set chk_inp_nome     $nome_prog
	    eval $check_cod_prog
            set cod_prog         $chk_out_cod_prog
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_prog $chk_out_msg
                incr error_num
	    }
	}

	if {[string equal $volimetria_risc ""]} {
	    set volimetria_risc 0
	} else {
	    set volimetria_risc [iter_check_num $volimetria_risc 2]
	    if {$volimetria_risc == "Error"} {
		element::set_error $form_name volimetria_risc "numerico con al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $volimetria_risc] >=  [expr pow(10,7)]
		    ||  [iter_set_double $volimetria_risc] <= -[expr pow(10,7)]} {
		    element::set_error $form_name volimetria_risc "deve essere < di 10.000.000"
		    incr error_num
		}
	    }
	}
	
	if {![string equal $n_generatori ""]} {
	    set n_generatori [iter_check_num $n_generatori 0]
	    if {$n_generatori == "Error"} {
		element::set_error $form_name n_generatori "deve essere numerico"
		incr error_num
	    }
	}
	
        if {$matricola eq ""} {;#nic01
            element::set_error $form_name matricola "Inserire matricola";#nic01
            incr error_num;#nic01
        };#nic01

	if {![string equal $matricola ""]} {
	    if {$flag_conferma == "s"} {
		#gab04 uso la query già esistente per estrarre il cod_impianto_est andando in join sulla coimaimp
		if {[db_0or1row query "select i.cod_impianto_est as cod_impianto_est_esistente 
                                         from coimgend g
                                            , coimaimp i 
                                        where g.cod_impianto = i.cod_impianto
                                          and matricola = :matricola 
                                        limit 1"] == 1} {
		    #gab04 nel messaggio di errore mostro il cod_impianto_est dell'impianto con il generatore che ha 
		    #gab04 già la matricola
		    element::set_error $form_name matricola "Attenzione esiste a catasto un generatore sull'impianto $cod_impianto_est_esistente con la stessa matricola. Confermi l'inserimento?"
		    if {$error_num == 0} {
			element set_properties $form_name flag_conferma -value "n"
			element set_properties $form_name flag_conferma_pdr -value "n";#rom01m In questo modo si conferma solo una volta
		    }
		    incr error_num
		}
	    }
	}

        if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic02
	    if {$modello eq ""} {#nic01
		element::set_error $form_name modello "Inserire il modello";#nic01
		incr error_num;#nic01
	    };#nic01
        } else {;#nic02
            if {$cod_mode eq ""} {;#nic02
                element::set_error $form_name cod_mode "Selezionare il modello";#nic02
                incr error_num;#nic02
            } else {;#nic02
                # Devo comunque valorizzare la colonna coimgend.modello
                if {![db_0or1row query "select descr_mode as modello
                                          from coimmode
                                         where cod_mode = :cod_mode"]
                } {#nic02
                    element::set_error $form_name cod_mode "Modello non trovato in anagrafica";#nic02
                    incr error_num;#nic02
                };#nic02
            };#nic02
        };#nic02


        if {$cod_cost eq ""} {;#nic01
            element::set_error $form_name cod_cost "Selezionare il costruttore";#nic01
            incr error_num;#nic01
        };#nic01

        if {![string equal $data_scheda ""]} {
            set data_scheda [iter_check_date $data_scheda]
            if {$data_scheda == 0} {
                element::set_error $form_name data_scheda "Data non corretta"
                incr error_num
            }
        }
        if {![string equal $pdr ""]} {#rom01m if e suo contenuto
	    if {$flag_conferma_pdr == "s"} {
		if {[db_0or1row query "select 1
                                 from coimaimp
                                where pdr = :pdr
                                limit 1"] == 1} {
		    element::set_error $form_name pdr "Attenzione esiste a catasto un impianto con lo stesso PDR.<br>Confermi l'inserimento?"
		    if {$error_num == 0} {
			element set_properties $form_name flag_conferma_pdr -value "n"
		    }
		    incr error_num
		}
	    }
	}

	if {[string equal $pdr ""]} {#rom01m if e suo contenuto
	    #sim06 aggiunto condizione su PSA
	    #rom11 sostituito $coimtgen(ente) eq "PSA" con $coimtgen(regione) eq "CAMPANIA" 
	    if {[string equal $cod_combustibile "5"] && !($coimtgen(regione) eq "CAMPANIA" && [string equal $cod_manutentore ""])} {
		element::set_error $form_name pdr "Inserire PDR"
		incr error_num
	    }
	}
	if {![string equal $pdr ""]} {#rom01m if e suo contenuto
	    set pdr [string trim $pdr]
	    if {[string length $pdr] != 14} {
		element::set_error $form_name pdr "PDR deve essere di 14 caratteri"
		incr error_num
	    } else {#rom12 aggiunta else e contenuto
		if {$coimtgen(ente) eq "CSALERNO"} {
		    set controllo_cifre_iniziali_pdr [string range $pdr 0 3]
		    if {![string equal $controllo_cifre_iniziali_pdr "1534"]} {
			element::set_error $form_name pdr "PDR deve iniziare per 1534..."
			incr error_num
		    }
		}
	    };#rom12
	}
	    
	if {[string equal $pod ""]} {#gac03 aggiunta if e else, l'else l'ho integrato con il contenuto di un'altra if che faceva la stessa cosa
	    #sim06 aggiunto condizione su PSA
	    #rom11 sostituito $coimtgen(ente) eq "PSA" con $coimtgen(regione) eq "CAMPANIA"
	    if {!($coimtgen(regione) eq "CAMPANIA" && [string equal $cod_manutentore ""])} {
		element::set_error $form_name pod "Inserire POD"
		incr error_num
	    }
	} else {#gac03
	    set pod [string trim $pod]
	    if {[string length $pod] < 14 || [string length $pod] > 15 } {
		element::set_error $form_name pod "POD deve essere di 14 o 15 caratteri"
		incr error_num
	    }
	}
        if {![string equal $carica_refrigerante ""]} {
	    set carica_refrigerante [iter_check_num $carica_refrigerante 2]
            if {$carica_refrigerante == "Error"} {
                element::set_error $form_name carica_refrigerante "numerico, max 2 dec"
                incr error_num
            } else {
		if {$carica_refrigerante < "0.01"} {
		    element::set_error $form_name carica_refrigerante "deve essere &gt; di 0,00"
		    incr error_num
		} else {
		    if {[iter_set_double $carica_refrigerante] >=  [expr pow(10,8)]
		    ||  [iter_set_double $carica_refrigerante] <= -[expr pow(10,8)]} {
			element::set_error $form_name carica_refrigerante "Deve essere < di 100.000.000"
			incr error_num
		    }
		}
	    }
	}
	if {$coimtgen(regione) eq "MARCHE" && [string equal $cod_cted ""]} {#rom03 aggiunta if e suo contenuto
            element::set_error $form_name cod_cted "Inserire Categoria edificio"
            incr error_num
        };#rom03
	
    }
#    [template::form::get_errors $form_name] 
    if {$error_num > 0} {
	#[template::form::get_errors $form_name]
        ad_return_template
        return
    }

    if {[string equal [string toupper $cognome_prop] [string toupper $cognome_occ]]
	&&  [string equal [string toupper $nome_prop] [string toupper $nome_occ]]
    } {
	set cod_citt_prop $cod_citt_occ
    }
    
    #imposto i campi di default per inserimento
    set cod_catasto ""
    set cod_qua ""
    set cod_urb ""

    switch $funzione {
	#inserimento impianto
        I {
	    db_1row sel_dual_aimp ""

	    # inserimento impianto
	    if {$flag_codifica_reg == "T"} {
                #gab03 aggiunto alle condizioni la provincia di Ancona
		#gab01 aggiunto alle condizioni il comune di Ancona
		if {$coimtgen(regione) eq "MARCHE"} {#nic03 sim01:aggiunto contenuto della if
		    if {$coimtgen(ente) eq "CPESARO"} {
			set sigla_est "CMPS"
		    } elseif {$coimtgen(ente) eq "CFANO"} {
			set sigla_est "CMFA"
		    } elseif {$coimtgen(ente) eq "CANCONA"} {;#gab01
			set sigla_est "CMAN"
		    } elseif {$coimtgen(ente) eq "PAN"} {;#gab03
			set sigla_est "PRAN"
		    } elseif {$coimtgen(ente) eq "CJESI"} {;#sim04
			set sigla_est "CMJE"
		    } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim04
			set sigla_est "CMSE"
		    } elseif {$coimtgen(ente) eq "PPU"} {
			set sigla_est "PRPU"
		    } elseif {$coimtgen(ente) eq "PMC"} {
			set sigla_est "PRMC"
		    } elseif {$coimtgen(ente) eq "CMACERATA"} {
			set sigla_est "CMMC"
		    } elseif {$coimtgen(ente) eq "CCIVITANOVA MARCHE"} {
			set sigla_est "CMCM"
		    } elseif {$coimtgen(ente) eq "CASCOLI PICENO"} {
			set sigla_est "CMAP"
		    } elseif {$coimtgen(ente) eq "CSAN BENEDETTO DEL TRONTO"} {
			set sigla_est "CMSB"
		    } elseif {$coimtgen(ente) eq "PAP"} {
			set sigla_est "PRAP"
		    } elseif {$coimtgen(ente) eq "PFM"} {
			set sigla_est "PRFM"
		    } else {
			set sigla_est ""
		    }
		    
		    set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
		    
		    # devo fare l'lpad con una seconda query altrimenti mi andava in errore
		    #nic05 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
                    set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic05
		    set cod_impianto_est "$sigla_est$progressivo_est"

		} else {#sim01
		    db_1row sel_dati_comu ""

		    if {$coimtgen(ente) eq "PMS"} {#nic04: aggiunta if. Originale nell'else
			set progressivo [db_string query "select lpad(:progressivo, 5, '0')"];#nic04
			set cod_istat  "[string range $cod_istat 5 6]/";#nic04
		    } elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
			set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
			set fine_istat  [string length $cod_istat]
			set iniz_ist    [expr $fine_istat -3]
			set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
		    } else {#nic04

			# caso standard
			
			#sim01: la sel_dati_comu andava in errore sul lpad di progressivo.Quindi faccio lpad dopo la query
			set progressivo [db_string query "select lpad(:progressivo, 6, '0')"];#sim01
			
			#sim01 if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU"} {#nic03
			#sim01 set cod_istat [string range $cod_istat 3 5];#nic03 (fatto da Sandro)
			#sim01 };#nic03

		    };#nic04

		    if {![string equal $potenza "0.00"]
		    &&  ![string equal $potenza ""]
		    } {
			if {$potenza < 35} {
			    set tipologia "IN"
			} else {
			    set tipologia "CT"
			}
			set cod_impianto_est "$cod_istat$progressivo"
			set dml_comu [db_map upd_prog_comu]
		    } else {
			if {![string equal $cod_potenza "0"]
			&&  ![string equal $cod_potenza ""]
			} {
			    switch $cod_potenza {
				"B"  {set tipologia "IN"}
				"A"  {set tipologia "CT"}
				"MA" {set tipologia "CT"}
				"MB" {set tipologia "CT"}
			    }
			    
			    set cod_impianto_est "$cod_istat$progressivo"
			    set dml_comu [db_map upd_prog_comu]
			} else {
			    set cod_impianto_est "$cod_istat$progressivo"
			    set dml_comu         [db_map upd_prog_comu]
			}
		    }
		};#sim01
	    } else {
		db_1row get_cod_impianto_est ""
	    }
	    
	    if {$coimtgen(regione) eq "MARCHE"} {#rom02 aggiunta if e suo contenuto
		if {$targa eq ""} {
		    set targa $cod_impianto_est
		}
		set cod_impianto_est $cod_impianto
		set cod_potenza [db_string assegna_fascia ""];#rom100
	    };#rom02

	    set dml_sql_aimp [db_map ins_aimp]
	    # inserimento generatore
	    set gen_prog     1
	    set gen_prog_est 1
	    set num_circuiti 1;#rom01
	    set dml_sql_gend [db_map ins_gend]
	    if {![string equal $cod_as_resp ""]} {
		set dml_upd_asresp [db_map upd_as_resp]
	    }
	}
    }

    if {![string equal $cod_citt_inte ""]} {
	set cod_cittadino $cod_citt_inte
    }
    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql_aimp] &&  [info exists dml_sql_gend]} {
	with_catch error_msg {
	    db_transaction {

		db_dml dml_coimaimp $dml_sql_aimp 
		db_dml dml_coimaimp $dml_sql_gend 
		#		if {[info exists dml_ins_citt] } {
		#		    db_dml dml_coicitt $dml_ins_citt
		#		}
                if {[info exists dml_comu]} {
		    db_dml dml_coimcomu $dml_comu
		}
                if {[info exists dml_upd_asresp]} {
		    db_dml dml_coim_as_resp $dml_upd_asresp
		}
	    }
	} {
	    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }
    if {$coimtgen(regione) eq "MARCHE" && $cod_manu_inst eq "" && $cod_manutentore ne ""} {#rom06 aggiunta if e contenuto.
	iter_get_coimdesc
	db_1row q "select m.cognome  as cognome_manutentore
                        , m.nome     as nome_manutentore
                     from coimmanu m
                    where m.cod_manutentore = :cod_manutentore"
	set testo_mail "ATTENZIONE: il Manutentore $cognome_manutentore $nome_manutentore con codice $cod_manutentore ha inserito l'impianto $cod_impianto senza un Installatore."
	acs_mail_lite::send -send_immediately -to_addr "$coimdesc(email)" -from_addr "$coimdesc(email)" -subject "Inserimento Impianto senza Installatore" -body $testo_mail
    };#rom06

    set cod_impianto_old $cod_impianto
    if {$coimtgen(regione) eq "MARCHE"} {#rom05 aggiunta if e contenuto. Aggiunta else ma non contenuto
        set link_gest [export_url_vars cod_impianto cod_impianto_old nome_funz_caller extra_par]&nome_funz=impianti
        set return_url   "coimaimp-gest-messaggio-intermedio?funzione=V&$link_gest&caller=inserimento"
    } else {
	set link_gest [export_url_vars cod_impianto cod_impianto_old nome_funz_caller extra_par caller]&nome_funz=impianti
	
	set return_url   "coimaimp-gest?funzione=V&$link_gest"
    }
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template

