ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdimp"
    @author          Giulio Laurenzi
    @creation-date   00/08/2006

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                       navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimdimp-1b-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim40 30/09/2020 Su richiesta della Regione Marche � stato cambiato il messaggio di errore
    sim40            in caso di impianto non attivo. Va bene per tutti gli enti.

    sim39 08/05/2017 Firenze pu� avere sia RCT che 1B quindi gestico il doppio flag_tracciato

    sim38 27/02/2017 Ancona ha il campo pdr obbligatorio nel caso in cui il combustibile � metano

    sim36 15/02/2017 Corretto errore su refresh presente per Calabria

    sim35 14/02/2017 Tolto per Provincia di Barletta il controllo sui 45 giorni

    sim34 09/02/2017 Rivisto le scadenze della Toscana

    sim33 07/02/2017 Corretto errore su cancellazione

    sim32 02/02/2017 Messo il calcolo del n_prot in una db_transaction per evitare doppioni

    sim31 02/02/2017 Solo PFI pu� inserire manualmente il costo del bollino (anche manutentori)
    sim31            perch� devono recuperare il pregresso

    sim30 23/01/2017 Per firenze il tiraggio deve essere obbligatorio.
    sim30            Anche il campo tipo_a_c � obbligatorio

    sim29 20/01/2017 Massa pu� mettere il controllo fumi non effettuato

    sim28 19/01/2017 Gestito scadenze Regione Toscana.

    sim27 17/11/2016 Gestito la potenza in base al flag_tipo_impianto
   
    sim26 22/12/2016 Quando si fa il calcolo degli 8 anni per la tariffa � necessario utilizzare
    sim26            la data del controllo e non la data odierna.
    sim26            Manteniamo la data odierna nel calcolo solo in fase di on_request della pagina

    sim25 13/12/2016 Livorno deve porter inserire un rcee senza bollino per un impianto
    sim25            che ha gia' un rcee nello stesso giorno su un altro generatore del medesimo impianto

    sim24 12/12/2016 Corretto errore su on_change del flag_status

    sim23 10/11/2016 Per gli enti della Regione Calabria, se si sta facendo l'inserimento
    sim23            di un rcee su un impianto che ha gi� un rcee nello stesso giorno su un
    sim23            altro generatore del medesimo impianto, la tariffa deve essere 0.

    sim22 24/10/2016 Gestito le scadenze della provincia di Barletta come le scadenze della
    sim22            Regione Marche.

    sim21 20/10/2016 Anche Reggio calabria non ha il controllo sui 45 giorni quindi correggo
    sim21            quanto fatto in precedenza per la sim14.

    mis01 17/10/2016 Messo * in campi obbligatori

    sim20 17/10/2016 Messo controllo su Pod e Pdr anche per la Regione Calabria e PRC

    nic09 15/10/2016 Corretto errore capitato a causa della modifica degli impianti vecchi

    nic08 14/10/2016 Per qualche giorno, la Regione Calabria vuole togliere il controllo di
    nic08            obbligatorieta' della targa.

    sim19 04/10/2016 Per la Regione Calabria e per Reggio calabria se l'impianto non e'
    sim19            funzionante la tariffa � 0. Per evitare che i manutentori prima mettino
    sim19            funzionante no e poi lo cambino in si per evitare di pagare, metto il
    sim19            flag_status non modificabile.

    sim18 03/10/2016 Se il combustibile e' COMBUSTIBILE SOLIDO, LEGNA, NON NOTO o ALTRO
    sim18            la prova dei fumi non e' mai obbligatoria.

    sim17 03/10/2016 Aggiunta gestione scadenze di Massa

    sim16 30/09/2016 Corretto controllo su Intestatario per Taranto

    sim15 29/09/2016 Aggiunta la gestione della data scadenza per Taranto.

    sim14 12/09/2016 Sandro ha detto di togliere il controllo sui 45 giorni per gli enti della
    sim14            Regione Calabria escluso Reggio Calabria (sono clienti diversi).

    sim13 07/09/2016 Se il parmetro flag_gest_targa e' attivo,
    sim13            verifico che la targa sia valorizzata.

    san06 31/08/2016 Se altri dati valgono 0, li considero nulli.

    sim12 29/08/2016 Se il riferimento del bollino vale 0, bisogna considerarlo nullo.

    sim11 29/08/2016 Come richiesto da Sandro, faccio in modo che in fase di inserimento il
    sim11            rendimento combustione minimo di legge venga calcolato in automatico.

    sim10 01/07/2016 Aggiunta la gestione della data scadenza per la Regione Calabria

    sim09 29/06/2016 Se il manutentore non ha il patentino, non puo' inserire impianti con
    sim09            potenza maggiore di 232 KW.
    sim09            Il controllo va fatto sulla potenza gestita dal parametro
    sim09            coimtgen(flag_potenza)

    sim08 27/06/2016 Se flag_tariffa_impianti_vecchi eq "t" e il combustibile e' Gas o Metano
    sim08            devo verificare se l'impianto e' vecchio e quindi usare un'altra tariffa.

    san05 07/06/2016 Personalizzati controlli su pdr e pod per Provincia di Taranto.

    san04 11/05/2016 Aggiunta e gestita data_prox_manut.

    sim07 13/04/2016 Aggiunto controllo personalizzato per il comune di Pesaro che
    sim07            effettua il controllo sul bollino rilasciato al manutentore con la sola
    sim07            parte numerica escludendo le prime 5 lettere (es.CMPSA000512)

    sim06 24/03/2016 Aggiunto controllo bloccante sul bollino anche per Caserta

    san03 26/02/2016 Aggiunti controlli su pdr e pod per Provincia di Livorno.

    sim05 11/03/2016 Se � attivo il portafoglio va abilitato solo il bollettino virtuale e il
    sim05            costo deve essere non modificabile.

    nic07 12/02/2016 Livorno ha chiesto che fino al 30/06/2016 sia possibile inserire RCT
    nic07            rilasciati dal 01/01/2016 al 29/02/2016. Per il resto e' invariato.

    nic06 12/02/2016 Gestito parametro coimtgen(flag_potenza) per utilizzo potenza nominale
    nic06            al focolare oppure utile.

    sim04 12/02/2016 Per Livorno controllo che il bollino sia pagato.

    sim03 12/02/2016 Livorno ha chiesto che fino al 31/03/2016 sia possibile inserire RCT
    sim03            piu' vecchi di 90 giorni.
    sim03            Dopo questa data deve essere di 31 giorni.
  
    san01 22/01/2016 Non si controlla il codice fiscale se nato all'estero

    sim02 24/09/2015 Gestita data scadenza per provincia e comune di Pesaro e Urbino

    sim01 21/11/2014 Quando si sceglie col cerca un nuovo responsabile deve venire aggiornato
    sim01            in automatico anche il suo codice fiscale.

    nic05 12/09/2014 Come chiesto da Chiara Paravan di UCIT, il controllo se un bollino
    nic05            e' gia' usato, va fatto anche sull'istanza collegata.

    nic04 21/07/2014 Come chiesto da Chiara Paravan di UCIT e come gia' fatto sul modello F,
    nic04            se sto inserendo un impianto > 350, ci sono n generatori attivi e c'e'
    nic04            gia' un modello con data controllo negli ultimi 4 mesi, va impostato il
    nic04            costo a 26,22 euro.

    nic03 24/05/2014 Devo esporre ed aggiornare le potenze del generatore e non dell'impianto

    nic02 23/05/2014 Se presente pi� di un generatore, l'utente deve scegliere a quale si
    nic02            riferisce

    nic01 17/03/2014 Comune di Rimini: se � attivo il parametro flag_gest_coimmode, deve
    nic01            comparire un men� a tendina con l'elenco dei modelli relativi al
    nic01            costruttore selezionato (tale men� a tendina deve essere rigenerato
    nic01            quando si cambia la scelta del costruttore).
    nic01            Ho dovuto aggiungere la gestione dei campi __refreshing_p e changed_field.
     
} {
    {cod_dimp             ""}
    {last_cod_dimp        ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {flag_no_link        "F"}
    {url_gage             ""}
    {cod_opma             ""}
    {data_ins             ""}
    {cod_impianto_est_new ""}
    {gen_prog             ""}
    {flag_modello_h       ""}
    {flag_tracciato       ""}
    {tabella              ""}
    {cod_dimp_ins         ""}
    {transaz_eff          ""}
    {flag_tipo_impianto   "R"}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

ad_return_if_another_copy_is_running

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

#modifica del 120913
if {$funzione eq "I"} {
    db_1row query "select stato as stato_imp from coimaimp where cod_impianto = :cod_impianto"    
    if {$stato_imp ne "A" } {
#sim40        iter_return_complaint "
#sim40        Funzione impossibile per impianti annullati/Non attivi/Rottamati"  
	iter_return_complaint "Sar� possibile trasmettere RCEE e altri moduli solo dopo la riattivazione/validazione dell'impianto da parte dell'ente";#sim40
	ad_script_abort
    }
}
#fine modifica

if {$funzione ne "I"} {
    db_1row query "select stato_dich
                        , gen_prog -- nic02
                     from coimdimp
                    where cod_dimp = :cod_dimp"    
    if {$stato_dich eq "A" || $stato_dich eq "X" || $stato_dich eq "R"} {
	set funzione "V"
	set menu 0
    } else {
	set menu 1
    }
} else {
    set menu 1
}

set flag_errore_data_controllo "f"
if {[exists_and_not_null tabella]} {
    if {![exists_and_not_null cod_dimp]} {
	set cod_dimp $cod_dimp_ins
    }
    db_1row query "select data_controllo, stato_dich  from coimdimp where cod_dimp = :cod_dimp"    
    if {$data_controllo < "2008-08-01"} {
	iter_return_complaint "
        Funzione possibile solo per dichiarazioni con data controllo successiva all '01/08/2008'."  
	ad_script_abort
    }
    if {![exists_and_not_null gen_prog]} {#nic02
        iter_return_complaint "Storno impossibile. Generatore mancante ";#nic02
        ad_script_abort;#nic02
    };#nic02
    set stn "_stn"
    set funzione_stn " "
    if {[db_0or1row query "select 1 from coimanom where cod_cimp_dimp = :cod_dimp limit 1"] == 1} {
	iter_return_complaint "Presenti anomalie. Funzione di storno impossibile"
    }		
    if {[db_0or1row query "select 1 from coimdimp_stn where cod_dimp = :cod_dimp"]==0} {
	set funzione "I"
	set cod_dimp_ins $cod_dimp
    }
    if {$stato_dich != ""} {
	if {$funzione == "I"} {
	    iter_return_complaint "Dichiarazione sostitutiva non inseribile per dichiarazioni gia oggetto di storno"
	} else {
	    set funzione "V"
	}   
    }		
} else {
    set stn " "
    set funzione_stn " "
    set tabella ""
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_ma [string range $id_utente 0 1]

db_1row query "select id_settore
                    , id_ruolo
                 from coimuten
                where id_utente = :id_utente"

iter_get_coimtgen
set flag_ente        $coimtgen(flag_ente)         
set sigla_prov       $coimtgen(sigla_prov)
set cod_comu         $coimtgen(cod_comu)
set gg_scad_pag_mh   $coimtgen(gg_scad_pag_mh)
set flag_agg_sogg    $coimtgen(flag_agg_sogg)
set flag_dt_scad     $coimtgen(flag_dt_scad)
set flag_gg_modif_mh $coimtgen(flag_gg_modif_mh)
set flag_gg_modif_rv $coimtgen(flag_gg_modif_rv)
set flag_gest_targa  $coimtgen(flag_gest_targa);#sim13


if {$flag_tracciato eq "G"} {;#sim39 if e suo contenuto
    if {$coimtgen(ente) eq "PFI"} {
	set flag_tracciato "1B"
    } else {
	set flag_tracciato "R1"
    }
}


if {$coimtgen(flag_potenza) eq "pot_utile_nom"} {#nic06 Aggiunta if ed il suo contenuto
    set nome_col_aimp_potenza potenza_utile
    set error_nome_col_potenza "potenza";#sim09
} else {
    set nome_col_aimp_potenza potenza
    set error_nome_col_potenza "pot_focolare_nom";#sim09
}

set controllo_tariffa {#sim08
    
    set cod_listino 0
    set flag_impianto_vecchio 0
    if {[db_0or1row sel_tari ""] == 0} {
	set tariffa ""
	set flag_tariffa_impianti_vecchi "";#sim08
	set anni_fine_tariffa_base       "";#sim08
	set tariffa_impianti_vecchi      "";#sim08
    }
    
    #il controllo sugli anni va fatto solo se l'apposito flag e' true e solo per GAS e METANO
    if {$flag_tariffa_impianti_vecchi eq "t" && ($combustibile eq "4" || $combustibile eq "5")} {#sim08: aggiunta if e suo contenuto

	#nic09 set data_insta_controllo [db_string q "select coalesce(:data_insta::date,'1900-01-01')"]    

	#sim24 aggiuntocondizione su __refreshing_p
	if {[form is_request $form_name] || 
            [string equal $__refreshing_p "1"]} {#nic09: aggiunta in emergenza if e suo contenuto
	    #In questo punto data_insta e' in formato dd/mm/yyyy)
	    if {$data_insta eq ""} {
		set data_insta_controllo "1900-01-01"
	    } else {
		set data_insta_controllo [iter_check_date $data_insta]
		set data_insta_controllo "[string range $data_insta_controllo 0 3]-[string range $data_insta_controllo 4 5]-[string range $data_insta_controllo 6 7]"
	    }
	} else {
	    #In questo punto data_insta e' in formato yyyymmdd)
	    set data_insta_controllo [db_string q "select coalesce(:data_insta::date,'1900-01-01')"]    
	}

	ns_log notice "coimdimp-1b-gest;data_insta_controllo:$data_insta_controllo"
	
	if {$flag_errore_data_controllo eq "f" && $data_controllo ne ""} {;#sim26
	    set oggi $data_controllo;#sim26
	} else {;#sim26
	    set oggi         [iter_set_sysdate]
	};#sim26

	#sim26 set dt_controllo [clock format [clock scan "$oggi - $anni_fine_tariffa_base years"] -format "%Y%m%d"]
	set dt_controllo [clock format [clock scan "$oggi - $anni_fine_tariffa_base years"] -format "%Y-%m-%d"];#sim26
	if {$data_insta_controllo < $dt_controllo} {
	    set tariffa               $tariffa_impianti_vecchi
	    set flag_impianto_vecchio 1
	}
    }
    
    if {[info exist __refreshing_p] && [string equal $__refreshing_p "1"]} {;#sim36
        set data_controllo_sec_gen [iter_check_date $data_controllo]
		set data_controllo_sec_gen "[string range $data_controllo_sec_gen 0 3]-[string range $data_controllo_sec_gen 4 5]-[string range $data_controllo_sec_gen 6 7]"
    } else {
        set data_controllo_sec_gen $data_controllo
    }

    #sim23 verifico se gi� esiste un rcee sull'impianto con la stessa data controllo ma su un generatore diverso.
    if {$flag_errore_data_controllo eq "f" && [db_0or1row q "select 1
                         from coimdimp
                        where cod_impianto   = :cod_impianto
                         --sim36 and data_controllo = :data_controllo
                          and data_controllo = :data_controllo_sec_gen --sim36
                          and gen_prog      != :gen_prog
                          and (costo        != 0   
                               or flag_status = 'N') --condizione per non sbiancare il costo in fase di modifica del rcee inserito per primo
                        limit 1"]} {;#sim23 if e else e loro contenuto
	set rcee_su_secondo_gen "t"
    } else {
	set rcee_su_secondo_gen "f"
    }

    #sim23 aggiunto condizione su rcee_su_secondo_gen
    if {($coimtgen(regione) eq "CALABRIA") && ($flag_status eq "N" || $rcee_su_secondo_gen eq "t") } {#sim19 if else e loro contenuto
	set tariffa 0
	set esente "t"
    } else {
	set esente "f"
    }
}


set link_gest [export_url_vars cod_dimp last_cod_dimp nome_funz nome_funz_caller extra_par caller cod_impianto url_list_aimp url_aimp url_gage flag_no_link cod_opma data_ins tabella cod_dimp_ins]

# valorizzo pack_dir che sara' utilizzata sull'adp per fare i link.
set pack_key  [iter_package_key]
set pack_dir  [apm_package_url_from_key $pack_key]
append pack_dir "src"

set msg_limite ""

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$transaz_eff == "T"} {
    set report "Transazione effettuata con successo"
    set report1 "Attenzione - La tue dichiarazioni verranno accettate anche se il credito disponibile sul tuo Portafoglio manutentore non &egrave; al momento sufficiente. Ti verra&grave; quindi contabilizzato un debito che dovrai rifondere alla prima ricarica del tuo Portafoglio. In questa occasione ti sar&agrave; detratta automaticamente la quota negativa accumulata."
} else {
    set report ""
    set report1 ""
}

# imposto la proc per i link e per il dettaglio impianto
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp  {} $flag_tracciato]
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set link_list_script {[export_url_vars tariffa_reg nome_funz_caller nome_funz cod_impianto url_list_aimp url_aimp last_cod_dimp caller tabella cod_dimp_ins]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_gest_dimp $link_gest
set link_list_dimp $link_list

set link_anom "[export_url_vars cod_impianto gen_prog last_cod_cimp nome_funz_caller extra_par caller url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]&nome_funz=[iter_get_nomefunz coimanom-list]&cod_cimp_dimp=$cod_dimp&flag_origine=MH"

if {$coimtgen(ente) eq "PPD"} {
    set link_d_anom ""
} {
    set link_d_anom "[export_url_vars cod_impianto gen_prog last_cod_cimp nome_funz_caller extra_par caller url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]&nome_funz=[iter_get_nomefunz coim_d_anom-list]&cod_cimp_dimp=$cod_dimp&flag_origine=MH"
}

set ast "<font color=red>*</font>";#--- mis01
set sw_iterprfi [string match "*iterprfi_pu*" [db_get_database]];#--mis01 =1trovato 0=nontrovato

if {$coimtgen(ente)    eq "PFI"} {;#sim30 if else e loro contenuto
    set ast_PFI "<font color=red>*</font>"
} else {
    set ast_PFI ""
}

# agg dob cind
db_1row sel_mod_gend "select flag_mod_gend,flag_cind from coimtgen"

set titolo "RCEE Tipo 1"
switch $funzione {
    M {set button_label "Conferma Modifica"
	set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
	set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
	set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

db_1row sel_tgen_portafoglio "select flag_portafoglio from coimtgen"
set flag_combo_tipibol $flag_portafoglio;#sim05
if {[exists_and_not_null tabella]} {
    set flag_portafoglio "F"
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimp"
set focus_field  "";#nic01
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
    "M" {set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

if {$funzione_stn eq "I"} {
    set readonly_key \{\}
    set readonly_fld \{\}
    set disabled_fld \{\}
}

form create $form_name \
    -html    $onsubmit_cmd 

element create $form_name cognome_manu \
    -label   "Cognome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_manu \
    -label   "Nome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name cognome_opma \
    -label   "Cognome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 200 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_opma \
    -label   "Nome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

set cod_manu [iter_check_uten_manu $id_utente]

if {($funzione == "I" || $funzione == "M") && [string equal $cod_manu ""]} { 
    if {$flag_portafoglio == "T"} {
	set cerca_manu [iter_search $form_name [ad_conn package_url]/src/coimmanu-list [list dummy cod_manutentore f_cognome cognome_manu dummy nome_manu dummy saldo_manu dummy cod_portafoglio]]
    } else {
	set cerca_manu [iter_search $form_name [ad_conn package_url]/src/coimmanu-list [list dummy cod_manutentore f_cognome cognome_manu dummy nome_manu]]
    }
} else {
    set cerca_manu ""
}

if {[string range $id_utente 0 1] == "AM"} {
    set cod_manu $id_utente
}

if {$funzione == "I" || $funzione == "M"} { 
    set fstato 0
    set cerca_opma [iter_search $form_name [ad_conn package_url]/src/coimopma-list [list cod_manutentore cod_manutentore dummy cod_opmanu_new f_cognome nome_opma f_nome cognome_opma] &fstato=$fstato]
 
} else {
    set cerca_opma ""
}

element create $form_name cognome_resp \
    -label   "Cod responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_resp \
    -label   "Cod responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_fiscale_resp \
    -label   "Cod fiscale responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 readonly {} class form_element" \
    -optional

if {$funzione == "I" || $funzione == "M"} {
    #sim01: aggiunto dummy perch� se valorizzo il filtro del codice fiscale la pagina 
    #       di filtro soggetti segnala che sono stati compilati troppi filtri.
    #       Aggiunto cod_fiscale_resp per valorizzare tale campo quando si seleziona il sogg.
    set cerca_resp [iter_search $form_name [ad_conn package_url]/src/coimcitt-filter [list dummy cod_responsabile f_cognome cognome_resp f_nome nome_resp dummy cod_fiscale_resp]]
} else {
    set cerca_resp ""
}

element create $form_name cognome_prop \
    -label   "Cod proprietario" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_prop \
    -label   "Cod proprietario" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name consumo_annuo \
    -label   "Consumo annuo" \
    -widget   text \
    -datatype text \
    -html    "size 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name consumo_annuo2 \
    -label   "Consumo annuo" \
    -widget   text \
    -datatype text \
    -html    "size 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name stagione_risc \
    -label   "stagione_risc" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
    -optional

element create $form_name stagione_risc2 \
    -label   "stagione_risc" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
    -optional

# agg dob cind
element create $form_name cod_cind \
    -label   "campagna" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimcind cod_cind descrizione]

if {$flag_mod_gend == "S"} {
    element create $form_name matricola \
	-label   "Matricola" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 35 $readonly_fld {} class form_element" \
	-optional

    if {$coimtgen(flag_gest_coimmode) eq "F"} {#nic01
	element create $form_name modello \
	    -label   "Modello" \
	    -widget   text \
	    -datatype text \
	    -html    "size 15 maxlength 40 $readonly_fld {} class form_element" \
	    -optional

        element create $form_name cod_mode -widget hidden -datatype text -optional;#nic01

        set html_per_costruttore "";#nic01
    } else {;#nic01
        element create $form_name modello  -widget hidden -datatype text -optional;#nic01

        element create $form_name cod_mode \
                -label   "modello" \
                -widget   select \
                -datatype text \
                -html    "$disabled_fld {} class form_element" \
                -optional \
                -options "";#nic01

        set html_per_costruttore "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='costruttore';document.$form_name.submit.click()";#nic01
    };#nic01

    element create $form_name costruttore \
	-label   "costruttore" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element $html_per_costruttore" \
	-optional \
	-options [iter_selbox_from_table coimcost cod_cost descr_cost]
  

    #modifica sandro del 08-05-13  
    set l_of_l  [db_list_of_lists query "select descr_comb
                                              , cod_combustibile 
                                           from coimcomb 
                                          where cod_combustibile <> '0' 
                                            and cod_combustibile in ('6','12','112','211')"]
    set cod_com  [linsert $l_of_l 0 [list "" ""]]
    element create $form_name combustibile \
	-label   "combustibile" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options $cod_com
    # fine

    element create $form_name tiraggio \
	-label   "tipo tiraggio" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {Forzato F} {Naturale N}}

    element create $form_name tipo_a_c \
	-label   "Tipo aperto/chiuso" \
	-widget   select \
	-options  {{Aperto A} {Chiuso C} {{} {}}} \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional

    element create $form_name data_insta \
	-label   "Data installazione" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
	-optional

    element create $form_name destinazione \
	-label   "cod_utgi" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi] 

#    element create $form_name locale \
#	-label   "Locale" \
#	-widget   select \
#	-options {{{} {}} {Tecnico T} {Esterno E} {Interno I}} \
#	-datatype text \
#	-html    "$disabled_fld {} class form_element" \
#	-optional
    
    element create $form_name data_costruz_gen \
	-label   "Data costruzione generatore" \
	-widget   text \
	-datatype text \
	-html    "size 10 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name marc_effic_energ \
	-label   "Marcatura efficienza energetica" \
	-widget   text \
	-datatype text \
	-html    "size 4 maxlength 10 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name volimetria_risc \
	-label   "Volimetria riscaldata" \
	-widget   text \
	-datatype text \
	-html    "size 10 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name pot_focolare_nom \
	-label   "potenza_focolare" \
	-widget   text \
	-datatype text \
	-html    "size 10 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name potenza \
	-label   "Potenza" \
	-widget   text \
	-datatype text \
	-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
	-optional
} else {
    element create $form_name costruttore \
	-label   "Costruttore" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 readonly {} class form_element" \
	-optional

    element create $form_name modello \
	-label   "Modello" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 readonly {} class form_element" \
	-optional

    element create $form_name cod_mode -widget hidden -datatype text -optional;#nic01
    
    element create $form_name matricola \
	-label   "Matricola" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 readonly {} class form_element" \
	-optional
    
    element create $form_name combustibile \
	-label   "Combustibile" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 readonly {} class form_element" \
	-optional
    
    element create $form_name tiraggio \
	-label   "Tiraggio" \
	-widget   select \
	-options  {{Naturale N} {Forzato F} {{} {}}} \
	-datatype text \
	-html    "disabled {} class form_element" \
	-optional
    
    element create $form_name tipo_a_c \
	-label   "Tipo A/C" \
	-widget   select \
	-options  {{Aperto A} {Chiuso C} {{} {}}} \
	-datatype text \
	-html    "disabled {} class form_element" \
	-optional
    
    element create $form_name data_insta \
	-label   "Data installazione" \
	-widget   text \
	-datatype text \
	-html    "size 15 maxlength 100 readonly {} class form_element" \
	-optional
    
    element create $form_name destinazione \
	-label   "Destinazione" \
	-widget   text \
	-datatype text \
	-html    "size 40 maxlength 100 readonly {} class form_element" \
	-optional
    
#    element create $form_name locale \
#	-label   "Locale" \
#	-widget   select \
#	-options {{{} {}} {Tecnico T} {Esterno E} {Interno I}} \
#	-datatype text \
#	-html    "disabled {} class form_element" \
#	-optional
    
    element create $form_name data_costruz_gen \
	-label   "Data costruzione generatore" \
	-widget   text \
	-datatype text \
	-html    "size 10 readonly {} class form_element" \
	-optional
    
    element create $form_name marc_effic_energ \
	-label   "Marcatura efficienza energetica" \
	-widget   text \
	-datatype text \
	-html    "size 4 readonly {} class form_element" \
	-optional
    
    element create $form_name volimetria_risc \
	-label   "Volimetria riscaldata" \
	-widget   text \
	-datatype text \
	-html    "size 10 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name pot_focolare_nom \
	-label   "potenza_focolare" \
	-widget   text \
	-datatype text \
	-html    "size 10  readonly {} class form_element" \
	-optional
    
    element create $form_name potenza \
	-label   "Potenza" \
	-widget   text \
	-datatype text \
	-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
	-optional
}

if {$funzione == "I" || $funzione == "M"} {
    set cerca_prop [iter_search $form_name [ad_conn package_url]/src/coimcitt-filter [list dummy cod_proprietario f_cognome cognome_prop f_nome nome_prop]]

} else {
    set cerca_prop ""
}

element create $form_name cognome_occu \
    -label   "Cod occupante" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_occu \
    -label   "Cod occupante" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

if {$funzione == "I" || $funzione == "M"} {
    set cerca_occu [iter_search $form_name [ad_conn package_url]/src/coimcitt-filter [list dummy cod_occupante f_cognome cognome_occu f_nome nome_occu]]
} else {
    set cerca_occu ""
}

#intestatario
set readonly_inte $readonly_fld
if {($coimtgen(ente) eq "PPO" || [string match "*iterprfi_pu*" [db_get_database]])
} {#Nicola 20/08/2014
    set readonly_inte "readonly";#Nicola 20/08/2014
};#Nicola 20/08/2014

set readonly_costo $readonly_fld;#sim05
if {$flag_combo_tipibol eq "T"} {;#sim05 if e suo contenuto
    set readonly_costo "readonly"
}

element create $form_name cognome_contr \
    -label   "Cod intestatario" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_inte {} class form_element" \
    -optional

element create $form_name nome_contr \
    -label   "Cod intestatario" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_inte {} class form_element" \
    -optional

if {$funzione == "I" || $funzione == "M"} {
    set cerca_contr [iter_search $form_name [ad_conn package_url]/src/coimcitt-filter [list dummy cod_int_contr f_cognome cognome_contr f_nome nome_contr]]
    if {$readonly_inte eq "readonly"} {#Nicola 20/08/2014
	set cerca_contr "";#Nicola 20/08/2014
    };#Nicola 20/08/2014
} else {
    set cerca_contr ""
}

db_1row sel_anom_count2 ""

if {$funzione == "I" || $funzione == "V" || $funzione == "D"
    || ( $funzione == "M" && $conta_anom_2 == 0)} {
    set vis_desc_contr "f"

    set disabled_fld_status $disabled_fld;#sim19
    if {$coimtgen(regione) eq "CALABRIA"} {;#sim19 if else e loro contenuto
	set html_change_flag_status "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='flag_status';document.$form_name.submit.click()"

	if {$funzione == "M" && $id_ruolo eq "manutentore"} {
	    set disabled_fld_status "disabled"
	}

    } else {
	set html_change_flag_status ""
    }
	
    #sim01 aggiunto html_change_flag_status e messo disabled_fld_status al posto di disabled_fld
    element create $form_name flag_status \
	-label   "status" \
	-widget   select \
	-options  {{{} {}} {S&igrave; P} {No N}} \
	-datatype text \
	-html    "$disabled_fld_status {} class form_element $html_change_flag_status" \
	-optional
} else {
    set vis_desc_contr "t"
    element create $form_name flag_stat \
	-label   "flag_stat" \
	-widget   text \
	-datatype text \
	-html    "size 10 readonly {} class form_element" \
	-optional 

    element set_properties $form_name flag_stat -value "Negativo"
    element create $form_name flag_status -widget hidden -datatype text -optional
}

element create $form_name garanzia \
    -label   "Garanzia" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name conformita \
    -label   "Conformit&agrave;" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lib_impianto \
    -label   "Libretto impianto" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lib_uso_man \
    -label   "Libretto uso/manut." \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name inst_in_out \
    -label   "Idoneita dei locali" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {ES. E} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name idoneita_locale \
    -label   "Idoneit&agrave; del locale" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. E} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_dur_acqua \
    -label   "Durezza totale dell'acqua" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name rct_tratt_in_risc \
    -label   "Trattamento in riscaldamento" \
    -widget   select \
    -options  {{NonRichiesto R} {Assente A} {Filtrazione F}  {Addolcimento D} {Cond.Chimico C} {Filtr.+Addolc. K} {Filtr.+Cond.Ch. J} {Cond.Ch.+Addolc. W} {Filt.+Cond.Ch.+Addolc. T} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_tratt_in_acs \
    -label   "Trattamento in acs" \
    -widget   select \
    -options  {{NonRichiesto R} {Assente A} {Filtrazione F}  {Addolcimento D} {Cond.Chimico C} {Filtr.+Addolc. K} {Filtr.+Cond.Ch. J} {Cond.Ch.+Addolc. W} {Filt.+Cond.Ch.+Addolc. T} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_install_interna \
    -label   "Installazione Interna" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_install_esterna \
    -label   "Installazione Interna" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name ap_vent_ostruz \
    -label   "Apertura ventilazione areaz. ostruita" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name ap_ventilaz \
    -label   "Dimensioni aperture" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name rct_canale_fumo_idoneo  \
    -label   "canale_fumo_idoneo " \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_sistema_reg_temp_amb \
    -label   "sistema_reg_temp_ambi" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_flag_dep_combust_solido \
    -label   "lg_flag_dep_combust_solido" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_flag_puliz_camino \
    -label   "lg_flag_puliz_camino" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_flag_sep_gen \
    -label   "lg_flag_sep_gen" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_flag_sollecit_termiche \
    -label   "lg_flag_sollecit_termiche" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_condensazione \
    -label   "lg_condensazione" \
    -widget   select \
    -options  {{Presente P} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_vaso_espa \
    -label   "lg_vaso_espa" \
    -widget   select \
    -options  {{Aperto A} {Chiuso C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_marcatura_ce \
    -label   "lg_marcatura_ce" \
    -widget   select \
    -options  {{Presente P} {Assente A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_placca_cam \
    -label   "lg_placca_cam" \
    -widget   select \
    -options  {{Presente P} {Assente A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_caric_comb \
    -label   "lg_caric_comb" \
    -widget   select \
    -options  {{Automatica A} {Manuale M} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_mod_evac_fumi \
    -label   "lg_mod_evac_fumi" \
    -widget   select \
    -options  {{Naturale N} {Forzata F} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lg_aria_comburente \
    -label   "lg_aria_comburente" \
    -widget   select \
    -options  {{{Da esterno} E} {{Da locale istallazione} I} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_gruppo_termico \
    -label   "Gruppo Termico" \
    -widget   select \
    -options  {{Singolo S} {Modulare M} {Tubo/Nastro T}  {Aria_calda A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name disp_comando \
    -label   "Dispositivi di comando" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name disp_sic_manom \
    -label   "Dispositivi di sicurezza non manomessi" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name rct_valv_sicurezza \
    -label   "rct_valv_sicurezza" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_scambiatore_lato_fumi \
    -label   "rct_scambiatore_lato_fumi" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_riflussi_comb \
    -label   "rct_riflussi_comb" \
    -widget   select \
    -options  {{No N} {S&igrave; S} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_uni_10389 \
    -label   "rct_uni_10389" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name rct_lib_uso_man_comp \
    -label   "lib_uso_man_comp" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name id_tplg \
    -label   "Tipologia" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtplg id_tplg descrizione]

element create $form_name note_tplg_altro \
    -label   "Note tplg altro" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name scar_ca_si \
    -label   "Scarico camino singolo" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name libretto_manutenz \
    -label   "Istruzioni uso e manutenzione dell'impianto presenti" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{S&igrave; S} {No N} {{} {}}}

element create $form_name doc_prev_incendi \
    -label   "SCIA o CPI antincendio" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{S&igrave; S} {No N} {N.C. C} {{} {}}}

element create $form_name dich_152_presente \
    -label   "Documentazione art. 284 del Dlgs 152/06 presente" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{S&igrave; S} {No N} {N.C. C} {{} {}}}

element create $form_name doc_ispesl \
    -label   "Pratica INAIL (ex ISPESL)" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{S&igrave; S} {No N} {N.C. C} {{} {}}}

element create $form_name sezioni \
    -label   "Scarico camino singolo" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional
element create $form_name conservazione \
    -label   "Scarico camino singolo" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name lunghezza \
    -label   "Scarico camino singolo" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name curve \
    -label   "Scarico camino singolo" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name scar_parete \
    -label   "Scarico a parete" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name riflussi_locale \
    -label   "Riflussi nel locale" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name assenza_perdite \
    -label   "Assenza perdite" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name pulizia_ugelli \
    -label   "Pulizia ugelli" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name antivento \
    -label   "Antivento" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name scambiatore \
    -label   "Scambiatore" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name accens_reg \
    -label   "Accensione regolare" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name ass_perdite \
    -label   "Assenza perdite" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name valvola_sicur \
    -label   "Valvoal di sicurezza" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name vaso_esp \
    -label   "Vaso espansore" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional



element create $form_name organi_integri \
    -label   "Organi integri" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name circ_aria \
    -label   "Circolazione aria" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name guarn_accop \
    -label   "Guarnizione di accoppiamento integra" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name assenza_fughe \
    -label   "Assenza di fughe" \
    -widget   select \
    -options  {{Pos P} {Neg N} {N.A. A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name coibentazione \
    -label   "Coibentazione" \
    -widget   select \
    -options  {{Pos P} {Neg N} {N.A. A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name eff_evac_fum \
    -label   "Efficenza evacuazione fumi" \
    -widget   select \
    -options  {{Pos P} {Neg N} {N.A. A} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


#sim29 aggiunto if per massa
if {$id_ruolo eq "manutentore"
&&  $coimtgen(ente) ne "PPO"
&&  $coimtgen(ente) ne "PPU"
&&  $coimtgen(ente) ne "CPESARO"
&&  $coimtgen(ente) ne "PFI"
&&  $coimtgen(ente) ne "PMS"
&& ![string match "*iterprfi_pu*" [db_get_database]]
} {
    element create $form_name cont_rend \
	-label   "Controllo rendimento" \
	-widget   select \
	-options  {{Effettuato S}} \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional
} else {
    element create $form_name cont_rend \
	-label   "Controllo rendimento" \
	-widget   select \
	-options  {{Effettuato S} {{Non effettuato} N} {{} {}}} \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional
}

element create $form_name pot_focolare_mis \
    -label   "Potenza focolare misurata" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name portata_comb_mis \
    -label   "Portata combustibile misurata" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name pendenza \
    -label   "Portata combustibile misurata" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional
element create $form_name temp_fumi \
    -label   "Temperatura fumi" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_ambi \
    -label   "Temperatura ambiente" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name o2 \
    -label   "o2" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name co2 \
    -label   "co2" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name bacharach \
    -label   "Bacharach" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name co \
    -label   "co" \
    -widget   text \
    -datatype text \
    -html    "size 6 maxlength 14 $readonly_fld {} class form_element" \
    -optional

element create $form_name rend_combust \
    -label   "Rendimento combustibile" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name rct_rend_min_legge \
    -label   "Rendimento combustibile minimo" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name rct_modulo_termico \
    -label   "Modulo termico" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create  $form_name  rct_check_list_1 \
    -label   "check list 1" \
    -widget   select \
    -options  {{S S} {N N}  {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional
element create  $form_name  rct_check_list_2 \
    -label   "check list 2" \
    -widget   select \
    -options  {{S S} {N N}  {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional
element create  $form_name  rct_check_list_3 \
    -label   "check list 3" \
    -widget   select \
    -options  {{S S} {N N}  {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional
element create  $form_name  rct_check_list_4 \
    -label   "check list 4" \
    -widget   select \
    -options  {{S S} {N N}  {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional


element create $form_name osservazioni \
    -label   "Osservazioni" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name raccomandazioni \
    -label   "Raccomandazioni" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name prescrizioni \
    -label   "Prescrizioni" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_utile_inter \
    -label   "Data utile intervento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_controllo \
    -label   "Data controllo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_key {} class form_element" \
    -optional

set readonly_n_prot "readonly"
if {$coimtgen(ente) eq "PPD"} {#Nicola 06/11/2014
    set readonly_n_prot $readonly_fld;#Nicola 06/11/2014
};#Nicola 06/11/2014

element create $form_name n_prot \
    -label   "Num. protocollo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_n_prot {} class form_element" \
    -optional

element create $form_name data_prot \
    -label   "Data protocollo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name saldo_manu \
    -label   "saldo_manu" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name cod_portafoglio \
    -label   "saldo_manu" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 25 readonly {} class form_element" \
    -optional

element create $form_name delega_resp \
    -label   "Delega responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 50 $readonly_fld {} class form_element" \
    -optional

element create $form_name delega_manut \
    -label   "Delega manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 50 $readonly_fld {} class form_element" \
    -optional

element create $form_name riferimento_pag \
    -label   "Rif. n bollino" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name costo \
    -label   "Costo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_costo {} class form_element" \
    -optional

element create $form_name data_prox_manut \
    -label   "Data prossima Manutenzione" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional;#san04

if {$flag_portafoglio == "T"} {

    #    if {$funzione == "I"
    #	&& [db_0or1row sel_old_dimp ""] == 0} {
    #	element create $form_name tariffa_reg \
				   #	    -label   "Tipo costo" \
				   #	    -widget   select \
				   #	    -datatype text \
				   #	    -html    {onChange "document.coimdimp.__refreshing_p.value='1';document.coimdimp.submit.click()"} \
				   #	    -optional \
				   #	    -options { {{Contributo Regionale} 7} {{Prima accensione} 8}}
    #    } else {
    element create $form_name tariffa_reg \
	-label   "Tipo costo" \
	-widget   select \
	-datatype text \
	-html    "disabled {} class form_element" \
	-optional \
	-options { {{Contributo Regionale} 7} {{Prima accensione} 8}}
    #    }
    element create $form_name importo_tariffa \
	-label   "Costo" \
	-widget   text \
	-datatype text \
	-html    "size 10 maxlength 10 readonly {} class form_element" \
	-optional
}

set l_of_l [db_list_of_lists sel_lol "select descrizione, cod_tipo_pag from coimtp_pag order by ordinamento"]
set options_cod_tp_pag [linsert $l_of_l 0 [list "" ""]]

if {$flag_combo_tipibol eq "T"} {#sim05 if e suo contenuto
    set options_cod_tp_pag [db_list_of_lists sel_lol "select descrizione, cod_tipo_pag from coimtp_pag where cod_tipo_pag = 'LM'"]
}
element create $form_name tipologia_costo \
    -label   "Tipo pagamento" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $options_cod_tp_pag

element create $form_name flag_pagato \
    -label   "Pagato" \
    -widget   select \
    -options  {{No N} {S&igrave; S}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

if {$id_ruolo ==  "manutentore"} {
    set data_scad_pagamento_readonly "readonly"
} else {
    set data_scad_pagamento_readonly $readonly_fld
}

element create $form_name data_scad_pagamento \
    -label   "Data scadenza pagamento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $data_scad_pagamento_readonly {} class form_element" \
    -optional


element create $form_name scar_can_fu \
    -label   "scarico canna fumaria ramificata" \
    -widget   select \
    -options  {{S&igrave; S} {No N} {N.C. C} {{} {}}} \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name tiraggio_fumi \
    -label   "Tiraggio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name ora_inizio \
    -label   "Ora inizio" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name ora_fine \
    -label   "Ora fine" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
    -optional

if {$id_ruolo ==  "manutentore"} {
    set data_scadenza_autocert_readonly "readonly"
} else {
    set data_scadenza_autocert_readonly $readonly_fld
}

element create $form_name data_scadenza_autocert \
    -label   "Data scad. autocert." \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $data_scadenza_autocert_readonly {} class form_element" \
    -optional

element create $form_name num_autocert \
    -label   "Numero autocertificazione" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_arrivo_ente \
    -label   "Data di arrivo all'ente" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional


element create $form_name prog_anom_max \
    -widget   hidden \
    -datatype text \
    -optional

element create $form_name tabella \
    -widget   hidden \
    -datatype text \
    -optional

element create $form_name cod_dimp_ins \
    -widget   hidden \
    -datatype text \
    -optional

set conta 0
multirow create multiple_form conta

while {$conta < 5} {
    incr conta

    multirow append multiple_form $conta

    element create $form_name prog_anom.$conta \
	-widget   hidden \
	-datatype text \
	-optional

    element create $form_name cod_anom.$conta \
	-label    "anomalia" \
	-widget   select \
	-datatype text \
	-html     "$disabled_fld {} class form_element" \
	-optional \
	-options [iter_selbox_from_table_wherec coimtano cod_tano "cod_tano||' - '||descr_breve" "" "where (flag_modello = 'S'
                                                                                                   or flag_modello is null)
                                                                                         and (data_fine_valid > current_date
                                                                                          or data_fine_valid is null)"]

    element create $form_name data_ut_int.$conta \
	-label    "data utile intervento" \
	-widget   text \
	-datatype text \
	-html     "size 10 maxlength 10 $readonly_fld {} class form_element" \
	-optional 
}

element create $form_name flag_tracciato   -widget hidden -datatype text -optional
element create $form_name list_anom_old    -widget hidden -datatype text -optional
element create $form_name cod_opma         -widget hidden -datatype text -optional
element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name data_ins         -widget hidden -datatype text -optional
element create $form_name cod_dimp         -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
#nic01 element create $form_name submitbut -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit";#nic01
element create $form_name last_cod_dimp    -widget hidden -datatype text -optional
element create $form_name cod_responsabile -widget hidden -datatype text -optional
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name cod_opmanu_new   -widget hidden -datatype text -optional
element create $form_name cod_proprietario -widget hidden -datatype text -optional
element create $form_name cod_occupante    -widget hidden -datatype text -optional
element create $form_name url_list_aimp    -widget hidden -datatype text -optional
element create $form_name url_aimp         -widget hidden -datatype text -optional
element create $form_name url_gage         -widget hidden -datatype text -optional
element create $form_name flag_no_link     -widget hidden -datatype text -optional
element create $form_name flag_modifica    -widget hidden -datatype text -optional
element create $form_name cod_int_contr    -widget hidden -datatype text -optional
element create $form_name gen_prog         -widget hidden -datatype text -optional
element create $form_name flag_modello_h   -widget hidden -datatype text -optional
element create $form_name nome_funz_new    -widget hidden -datatype text -optional
element create $form_name nome_funz_gest   -widget hidden -datatype text -optional
element create $form_name flag_ins_prop    -widget hidden -datatype text -optional
element create $form_name flag_ins_occu    -widget hidden -datatype text -optional
element create $form_name __refreshing_p   -widget hidden -datatype text -optional
element create $form_name changed_field    -widget hidden -datatype text -optional;#nic01
element create $form_name locale           -widget hidden -datatype text -optional;#sim17
element create $form_name esente           -widget hidden -datatype text -optional;#sim19

set cod_manu [iter_check_uten_manu $id_utente]

if {[string range $id_utente 0 1] == "AM"} {
    set cod_manu $id_utente
}
if {$flag_portafoglio == "T"
    && ![string equal $cod_manu ""]} {
    #ricavo il portafoglio manutentore
    set url "lotto/balance?iter_code=$cod_manu"
    
    set data [iter_httpget_wallet $url]
    array set result $data
    #    ns_return 200 text/html "$result(page)"
    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
    if {$risultato == "OK"} {
	set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
	set saldo [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
	set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
    } else {
	set saldo ""
	set conto_manu ""
    }

    element set_properties $form_name saldo_manu  -value $saldo
    element set_properties $form_name cod_portafoglio  -value $conto_manu
} else {
    set saldo ""
}


set current_date [iter_set_sysdate]

if {$funzione != "I"
    &&  [db_0or1row sel_dimp_esito ""] != 0
} {
    switch $flag_status {
	"P" {set esit "Positivo"}
	"N" {set esit "<font color=red><b>Negativo</b></font>"}
	default {set esit ""}
    }
    set esito "Esito controllo: $esit"   
} else {
    set esito ""

}

set misura_co "(&\#037;)(ppm)"

set url_dimp        [list [ad_conn url]?[export_ns_set_vars url]]
set url_dimp        [export_url_vars url_dimp]    

if {$funzione != "I"} {
    # leggo riga
    if {[db_0or1row sel_dimp ""] == 0} {
	iter_return_complaint "Record non trovato"
    }

    set cod_potenza_old $cod_potenza;#sim08

} else {
    # valorizzo il default dei soggetti
    if {[db_0or1row sel_aimp_old ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }
}

set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
element set_properties $form_name nome_funz_new   -value $nome_funz_new
set nome_funz_gest [iter_get_nomefunz coimcitt-gest]
element set_properties $form_name nome_funz_gest  -value $nome_funz_gest

set flag_ins_prop "S"
set flag_modello_h "T"
element set_properties $form_name flag_modello_h  -value $flag_modello_h
element set_properties $form_name flag_ins_prop  -value $flag_ins_prop


if {$funzione == "I" || $funzione == "M"} {
    #link inserimento occupante
    # Questo non va perche' mancano i campi localita, ..., cod_comune.
    #set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occ nome nome_occ nome_funz nome_funz_new localita localita descr_via descr_via descr_topo descr_topo numero numero cap cap provincia provincia cod_comune cod_comune dummy cod_citt_occ] "Inserisci Sogg."]
    # Questo link funziona
    set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occu nome nome_occu nome_funz nome_funz_new dummy cod_occupante flag_ins_prop flag_ins_prop dummy flag_modello_h] "Inserisci Sogg."]

    #link inserimento proprietario
    set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy cod_proprietario flag_ins_prop flag_ins_prop dummy flag_modello_h] "Inserisci Sogg."]

    set link_gest_resp [iter_link_ins $form_name coimcitt-gest [list cod_cittadino cod_responsabile nome_funz nome_funz_gest flag_modello_h] "Gest."]
} else {
    set link_ins_occu ""
    set link_ins_prop ""
    set link_gest_resp ""
}


if {[form is_request $form_name]} {
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name url_list_aimp    -value $url_list_aimp
    element set_properties $form_name url_aimp         -value $url_aimp    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_dimp    -value $last_cod_dimp
    element set_properties $form_name url_gage         -value $url_gage
    element set_properties $form_name flag_no_link     -value $flag_no_link
    element set_properties $form_name cod_opma         -value $cod_opma   
    element set_properties $form_name data_ins         -value $data_ins
    element set_properties $form_name gen_prog         -value $gen_prog;#nic02
    element set_properties $form_name flag_tracciato   -value $flag_tracciato
    element set_properties $form_name __refreshing_p   -value 0;#nic01
    element set_properties $form_name changed_field    -value "";#nic01


    if {$funzione == "I"} {#nic02: aggiunto tutto questo blocco (copiato da coimdimp-f-gest)
	# gen_prog non e' mai valorizzato ad eccezione del caso in cui
	# non sia stata effettuata la scelta del generatore tramite
	# il programma coimcimp-gend-list qui sotto richiamato.
	if {[exists_and_not_null tabella]} {
	    set gen_prog [db_string query "select gen_prog from coimdimp where cod_dimp = :cod_dimp_ins"]
     	}

	# agg dob cind
	set cod_cind [db_string query "select max(cod_cind) from coimcind where stato = '1'" -default ""]  

    	if {[string equal $gen_prog ""]} {
	    # se esiste un solo generatore attivo, predispongo l'inserimento
	    # del rapporto di verifica relativo a tale generatore
     	    set ctr_gend 0
      	    db_foreach sel_gend_list "" {
      		incr ctr_gend
     	    }
	    # se ho un solo generatore ho gia' reperito gen_prog con la query
	    # se ne ho piu' di uno, invece richiamo coimdimp-gend-list
	    # per scegliere su quale generatore si vuole inserire il R.V.
	    # se non ho nessun generatore non posso inserire il R.V.
	    if {$ctr_gend == 1} {
		# gen_prog e' gia' stato valorizzato con sel_gend_list
    	    } else {
    		if {$ctr_gend > 1} {
		    # richiamo il programma che permette di scegliere gen_prog
		    set link_gend "flag_tracciato=$flag_tracciato&[export_url_vars cod_impianto last_cod_cimp nome_funz nome_funz_caller tabella cod_dimp extra_par caller url_aimp url_list_aimp]"
     		    ad_returnredirect [ad_conn package_url]src/coimdimp-gend-list?$link_gend
     		    ad_script_abort
		} else {
     		    iter_return_complaint "Non trovato nessun generatore attivo: inserirlo"
     		}
     	    }
     	}
    };#nic02 (fine del blocco copiato da coimdimp-f-gest)


    #nic02 if {$funzione == "I"} {
    #nic02     set where_gen " and flag_attivo = 'S' limit 1"
    #nic02 } else {
    #nic02     set where_gen " and a.gen_prog = :gen_prog"
    #nic02 }

    if {$flag_mod_gend == "S"} {
	set sel_gend [db_map sel_gend_mod]
    } else {
	set sel_gend [db_map sel_gend_no_mod]
    }

    if {[db_0or1row sel_generatore $sel_gend] == 0} {
	set gend_zero        0
	set costruttore      ""
	set modello          ""
        set cod_mode         "";#nic01
	set matricola        ""
	set combustibile     ""
	set data_insta       ""
	set tiraggio         ""
	set destinazione     ""
	set tipo_a_c         ""
	set gen_prog         ""
        set locale           ""
        set data_costruz_gen ""
        set marc_effic_energ ""
        set volimetria_risc  ""
        set consumo_annuo    ""
	set consumo_annuo2   ""
	set stagione_risc    ""
	set stagione_risc2   ""
        set pot_focolare_nom ""
    } else {
	element set_properties $form_name costruttore      -value $costruttore
	element set_properties $form_name modello          -value $modello
	element set_properties $form_name matricola        -value $matricola
	element set_properties $form_name combustibile     -value $combustibile
	element set_properties $form_name data_insta       -value $data_insta
	element set_properties $form_name tiraggio         -value $tiraggio
	element set_properties $form_name destinazione     -value $destinazione
	element set_properties $form_name tipo_a_c         -value $tipo_a_c
	element set_properties $form_name gen_prog         -value $gen_prog       
        element set_properties $form_name locale           -value $locale
        element set_properties $form_name data_costruz_gen -value $data_costruz_gen
        element set_properties $form_name marc_effic_energ -value $marc_effic_energ
        element set_properties $form_name volimetria_risc  -value $volimetria_risc
        element set_properties $form_name consumo_annuo    -value $consumo_annuo
	element set_properties $form_name pot_focolare_nom -value $pot_focolare_nom

        # Imposto ora le options di cod_mode perch� solo adesso ho a disposiz. la var. costruttore
	if {![string is space $costruttore]} {
	    element set_properties $form_name cod_mode     -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $costruttore]'" cod_mode descr_mode];#nic01
	}
        element set_properties $form_name cod_mode         -value $cod_mode;#nic01
    }

    if {$combustibile eq "12" || 
	$combustibile eq "6"  ||
	$combustibile eq "0"  ||
	$combustibile eq "2"} {#mis01                         
	set conbustibile_solido "S"
    } else {
	set conbustibile_solido "N"
    }

    set descr_combustibile [db_string query "select descr_comb from coimcomb where cod_combustibile = :combustibile" -default ""];#--- mis01 estratta descrizione e modificata condizione sotto (origine && $cobustibile=="GASOLIO")

    #ns_log notice "bubu1|$data_insta|"
    #ns_return 200 text/html "$tiraggio, $data_insta" ; return
    if {$funzione == "I"} {
	# valorizzo alcuni default

	#Calcolo, se possibile, il valore del rendimento minimo per il generatore in questione
	set rendimento_minimo "";#sim11
	set rendimento_min_notice "<font color=blue>Rend.to min. calcolato<br>automaticamente</font>";#sim11
	
	with_catch msg_errore {;#sim11: aggiunta witch_catch e suo contenuto (non togliere il ; prima di questo commento, altrimenti va in errore
	    set rendimento_minimo [iter_calc_rend $cod_impianto $gen_prog]
	} {
	    set rendimento_min_notice $msg_errore
	}

	element set_properties $form_name rct_rend_min_legge -value $rendimento_minimo;#sim11 
	element::set_error     $form_name rct_rend_min_legge $rendimento_min_notice;#sim11
    
	#sim19 spostato qui il flag_status
	# di default esito_verifica Positivo
	set flag_status "P"
	element set_properties $form_name flag_status      -value $flag_status
	

	# valorizzo data controllo con data_prevista del controllo
	# se richiamato da coimgage-gest
	if {[db_0or1row sel_gage ""] == 0} {
	    if {![string is space $cod_opma]} {
		iter_return_complaint "Controllo manutentore non trovato"
	    } else {
		set data_prevista ""
	    }
	}
	set data_controllo $data_prevista

	# valorizzo il default dei soggetti
	if {[db_0or1row sel_aimp_old ""] == 0} {
	    iter_return_complaint "Impianto non trovato"
	}

	set potenza_old_edit [iter_edit_num $potenza_old 2]
	# valorizzo la tariffa di default in base alla potenza dell'impianto

	# imposto il codice listino a 0 perche' per ora il listino destinato ai costi 
        # e' il listino con codice 0 (zero) se in futuro ci sara' una diversificazione
        # sara' da creare una function o una procedura che renda dinamico il codice_listino
	set cod_listino 0

	# agg dob cind
	set cod_cind [db_string query "select max(cod_cind) from coimcind where stato = '1'" -default ""]  

	eval $controllo_tariffa;#sim08

	if {$flag_portafoglio == "T"} {
	    if {[db_0or1row sel_tari_contributo ""] == 0} {
		#san05 set importo_tariffa ""
		set importo_tariffa "0";#san05
		set tariffa_reg ""
	    } else {
		set tariffa_reg "7"
	    }
	}

	set cod_manu [iter_check_uten_manu $id_utente]
	if {[string range $id_utente 0 1] == "AM"} {
	    set cod_manu $id_utente
	}
	if {$flag_portafoglio == "T"
	    && ![string equal $cod_manutentore_old ""]} {
	    if {![string equal $cod_manu ""]} {
		set url "lotto/balance?iter_code=$cod_manu"
	    } else {
		set url "lotto/balance?iter_code=$cod_manutentore_old"
	    }
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    #	        ns_return 200 text/html "$result(page)"
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    if {$risultato == "OK"} {
		set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
		set saldo [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
		set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]

		db_1row sel_limiti_tgen "select flag_limite_portaf, valore_limite_portaf from coimtgen"
		if {$flag_limite_portaf == "S"} {
		    if {[iter_check_num $saldo 2] < $valore_limite_portaf} {
			set msg_limite "Attenzione - Il credito residuo disponibile sul tuo Portafoglio sta per terminare. Prima di completare l'inserimento delle dichiarazioni controlla l'importo necessario per il contributo. Se il credito residuo risulta insufficiente la dichiarazione non verr&agrave; accettata."
		    }
		}
	    } else {
		set saldo ""
		set conto_manu ""
	    }

	    element set_properties $form_name saldo_manu  -value $saldo
	    element set_properties $form_name cod_portafoglio  -value $conto_manu
	} else {
	    set saldo ""
	}

	if {$coimtgen(ente) eq "PPO" || [string match "*iterprfi_pu*" [db_get_database]]} {
	    set tipologia_costo ""
	    set flag_pagato ""
	    set costo 0
	} else {
	    set tipologia_costo "BO"
	    set flag_pagato ""
	}

	element set_properties $form_name data_controllo   -value $data_controllo
	element set_properties $form_name cod_manutentore  -value $cod_manutentore_old
	element set_properties $form_name cognome_manu     -value $cognome_manu_old
	element set_properties $form_name nome_manu        -value $nome_manu_old
	element set_properties $form_name cod_responsabile -value $cod_responsabile_old
	element set_properties $form_name cognome_resp     -value $cognome_resp_old
	element set_properties $form_name nome_resp        -value $nome_resp_old
	element set_properties $form_name cod_proprietario -value $cod_proprietario_old
	element set_properties $form_name cognome_prop     -value $cognome_prop_old
	element set_properties $form_name nome_prop        -value $nome_prop_old
	element set_properties $form_name cod_occupante    -value $cod_occupante_old
	element set_properties $form_name cognome_occu     -value $cognome_occu_old
	element set_properties $form_name nome_occu        -value $nome_occu_old
	element set_properties $form_name cod_fiscale_resp -value $cod_fiscale_resp_old
        element set_properties $form_name cod_int_contr    -value $cod_int_contr_old
        element set_properties $form_name nome_contr       -value $nome_contr_old
        element set_properties $form_name cognome_contr    -value $cognome_contr_old
	element set_properties $form_name locale           -value $locale;#sim17

	if {$flag_portafoglio == "T"} {
	    element set_properties $form_name importo_tariffa   -value $importo_tariffa
	    element set_properties $form_name tariffa_reg       -value $tariffa_reg
	}

	element set_properties $form_name costo            -value $tariffa

	if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO"} {#nic04: aggiunta questa if ed il suo contenuto (copiandola da coimdimp-f-gest di Udine)
	    db_1row query "select potenza from coimaimp where cod_impianto = :cod_impianto"
	    db_1row query "select count(*) as num_gend_attivi from coimgend where cod_impianto = :cod_impianto and flag_attivo = 'S'"
	    set dt_recente [db_string query "select to_char(current_date - interval '4 months', 'yyyymmdd')"]
	    db_1row query "select count(*) as num_dich_recenti from coimdimp where cod_impianto = :cod_impianto and data_controllo > :dt_recente"
	    ns_log Notice "coimdimp-1b-gest 1.1;potenza:$potenza|num_gend_attivi:$num_gend_attivi|num_dich_recedenti:$num_dich_recenti|cod_impianto:$cod_impianto|dt_recente:$dt_recente|"
	    if {$potenza > 350 && $num_gend_attivi > 1 && $num_dich_recenti > 1} {
		set costo "26,22"
		element set_properties $form_name costo    -value $costo
	    }
	};#nic04

	element set_properties $form_name tipologia_costo  -value $tipologia_costo
	element set_properties $form_name flag_pagato      -value $flag_pagato
#nic03	element set_properties $form_name potenza          -value $potenza_old_edit
        element set_properties $form_name potenza          -value $pot_utile_nom;#nic03
 	element set_properties $form_name cod_int_contr    -value $cod_int_contr_old
	element set_properties $form_name tabella          -value $tabella
	element set_properties $form_name cod_dimp_ins     -value $cod_dimp_ins
	# agg dob cind
	element set_properties $form_name cod_cind         -value $cod_cind

	db_1row sel_tgen_cont "select flag_default_contr_fumi from coimtgen"
	if {$flag_default_contr_fumi == "S"} {
	    element set_properties $form_name cont_rend    -value "S"
	    set cont_rend "S";#mis01
	} else {
	    element set_properties $form_name cont_rend    -value "N"
	    set cont_rend "N";#mis01
	}
	set conta 0
	while {$conta < 5} {
	    incr conta
	    element set_properties $form_name prog_anom.$conta -value $conta
	}
    } else {

	# leggo riga
	set cod_docu_distinta ""
	if {[db_0or1row sel_dimp ""] == 0} {
	    iter_return_complaint "Record non trovato"
	}
	# leggo aimp per dati progettista
	#	if {[db_0or1row sel_aimp ""] == 0} {
	#	    iter_return_complaint "Impianto non trovato"
	#	}

	# la query seguente e' temporanea e puo' essere tolta
	#db_1row query "select cod_fiscale as cod_fiscale_resp from coimcitt where cod_cittadino = :cod_responsabile "


	if {[iter_check_date $data_controllo] < "20080801"} {
	    set message "<td><table border=2 cellspacing=0 cellpadding=2 bordercolor=red><tr><td nowrap>Importo non dovuto data controllo antecedente 01/08/2008</td></tr></table></td>"
	} else {
	    set message "<td>&nbsp;</td>"
	}

 	set cod_manu [iter_check_uten_manu $id_utente]
	if {[string equal $cod_manu ""]} {
	    set cod_manu $cod_manutentore
	}
	if {[string range $id_utente 0 1] == "AM"} {
	    set cod_manu $id_utente
	}
	if {$flag_portafoglio == "T"
	    && ![string equal $cod_manu ""]} {
	    #ricavo il portafoglio manutentore
	    set url "lotto/balance?iter_code=$cod_manu"
	    
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    #    ns_return 200 text/html "$result(page)"
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    if {$risultato == "OK"} {
		set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
		set saldo [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
		set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
	    } else {
		set saldo ""
		set conto_manu ""
	    }

	    element set_properties $form_name saldo_manu  -value $saldo
	    element set_properties $form_name cod_portafoglio  -value $conto_manu
	} else {
	    set saldo ""
	}
	
	set data_scad_mod [clock format [clock scan "$data_ins $flag_gg_modif_mh day"] -f %Y%m%d]

	set cod_man [iter_check_uten_manu $id_utente]
	if {![string equal $cod_man ""] || $id_settore == "regione"} {
	    if {$data_scad_mod < $current_date || ![string equal $cod_docu_distinta ""]} {
		set flag_modifica "F"
	    } else {
		set flag_modifica "T"
	    }
	} else {
	    set flag_modifica "T"
	}
	
	if {$flag_co_perc == "t"} {
	    set co [expr $co / 10000.0000]
	    set misura_co "(&\#037;)"
	    set co [iter_edit_num $co 4]
	} else {
	    set misura_co "(ppm)"
	    set co [iter_edit_num $co 0]
	}
	if {$funzione == "M"} {
	    set misura_co "(&\#037;)(ppm)"
	}
	
	element set_properties $form_name flag_status      -value $flag_status

	if {($coimtgen(regione) eq "CALABRIA") && $flag_status eq "N"} {#mis01 if else e loro contenuto
	    set esente "t"
	} else {
	    set esente "f"
	}
	
	element set_properties $form_name cod_dimp         -value $cod_dimp
	element set_properties $form_name cod_impianto     -value $cod_impianto
	element set_properties $form_name data_controllo   -value $data_controllo
	element set_properties $form_name cod_manutentore  -value $cod_manutentore
	element set_properties $form_name cod_opmanu_new   -value $cod_opmanu_new
	element set_properties $form_name cod_responsabile -value $cod_responsabile
	element set_properties $form_name garanzia         -value $garanzia
	element set_properties $form_name conformita       -value $conformita
	element set_properties $form_name lib_impianto     -value $lib_impianto
	element set_properties $form_name lib_uso_man      -value $lib_uso_man
	element set_properties $form_name rct_lib_uso_man_comp    -value $rct_lib_uso_man_comp
	element set_properties $form_name inst_in_out      -value $inst_in_out
	element set_properties $form_name idoneita_locale  -value $idoneita_locale
	element set_properties $form_name ap_ventilaz      -value $ap_ventilaz
	element set_properties $form_name ap_vent_ostruz   -value $ap_vent_ostruz
	element set_properties $form_name pendenza         -value $pendenza
	element set_properties $form_name sezioni          -value $sezioni
	element set_properties $form_name curve            -value $curve
	element set_properties $form_name lunghezza        -value $lunghezza
	element set_properties $form_name conservazione    -value $conservazione
	element set_properties $form_name scar_ca_si       -value $scar_ca_si
	element set_properties $form_name scar_parete      -value $scar_parete
	element set_properties $form_name riflussi_locale  -value $riflussi_locale
	element set_properties $form_name assenza_perdite  -value $assenza_perdite
	element set_properties $form_name pulizia_ugelli   -value $pulizia_ugelli
	element set_properties $form_name antivento        -value $antivento
	element set_properties $form_name scambiatore      -value $scambiatore
	element set_properties $form_name accens_reg       -value $accens_reg
	element set_properties $form_name disp_comando     -value $disp_comando
	element set_properties $form_name ass_perdite      -value $ass_perdite
	element set_properties $form_name valvola_sicur    -value $valvola_sicur
	element set_properties $form_name vaso_esp         -value $vaso_esp
	element set_properties $form_name disp_sic_manom   -value $disp_sic_manom
	element set_properties $form_name organi_integri   -value $organi_integri
	element set_properties $form_name circ_aria        -value $circ_aria
	element set_properties $form_name guarn_accop      -value $guarn_accop
	element set_properties $form_name assenza_fughe    -value $assenza_fughe
	element set_properties $form_name coibentazione    -value $coibentazione
	element set_properties $form_name eff_evac_fum     -value $eff_evac_fum
	element set_properties $form_name cont_rend        -value $cont_rend
	element set_properties $form_name pot_focolare_mis -value $pot_focolare_mis
	element set_properties $form_name portata_comb_mis -value $portata_comb_mis
	element set_properties $form_name temp_fumi        -value $temp_fumi
	element set_properties $form_name temp_ambi        -value $temp_ambi
	element set_properties $form_name o2               -value $o2
	element set_properties $form_name co2              -value $co2
	element set_properties $form_name bacharach        -value $bacharach
	element set_properties $form_name co               -value $co
	element set_properties $form_name rend_combust     -value $rend_combust
	element set_properties $form_name osservazioni     -value $osservazioni
	element set_properties $form_name raccomandazioni  -value $raccomandazioni
	element set_properties $form_name prescrizioni     -value $prescrizioni
	element set_properties $form_name data_utile_inter -value $data_utile_inter
	element set_properties $form_name n_prot           -value $n_prot
	element set_properties $form_name data_prot        -value $data_prot
	element set_properties $form_name delega_resp      -value $delega_resp
	element set_properties $form_name delega_manut     -value $delega_manut
	element set_properties $form_name cognome_manu     -value $cognome_manu
	element set_properties $form_name cognome_opma     -value $cognome_opma
	element set_properties $form_name cognome_resp     -value $cognome_resp
	element set_properties $form_name nome_manu        -value $nome_manu
	element set_properties $form_name nome_opma        -value $nome_opma
	element set_properties $form_name nome_resp        -value $nome_resp
	element set_properties $form_name cod_fiscale_resp -value $cod_fiscale_resp
	element set_properties $form_name cod_proprietario -value $cod_proprietario
	element set_properties $form_name cod_occupante    -value $cod_occupante
	element set_properties $form_name cognome_prop     -value $cognome_prop
	element set_properties $form_name cognome_occu     -value $cognome_occu
	element set_properties $form_name nome_prop        -value $nome_prop
	element set_properties $form_name nome_occu        -value $nome_occu
	if {$flag_portafoglio == "T"} {
	    element set_properties $form_name importo_tariffa -value $importo_tariffa
	    element set_properties $form_name tariffa_reg     -value $tariffa_reg
	}
	element set_properties $form_name costo            -value $costo
	element set_properties $form_name tipologia_costo  -value $tipologia_costo
	element set_properties $form_name riferimento_pag  -value $riferimento_pag
	element set_properties $form_name data_scad_pagamento -value $data_scad
	element set_properties $form_name flag_pagato      -value $flag_pagato
	element set_properties $form_name potenza          -value $potenza
	element set_properties $form_name cod_int_contr    -value $cod_int_contr
	element set_properties $form_name nome_contr       -value $nome_contr
	element set_properties $form_name cognome_contr    -value $cognome_contr
	element set_properties $form_name scar_can_fu      -value $scar_can_fu  
	element set_properties $form_name tiraggio_fumi    -value $tiraggio_fumi     
	element set_properties $form_name ora_inizio       -value $ora_inizio   
	element set_properties $form_name ora_fine         -value $ora_fine     
	element set_properties $form_name data_scadenza_autocert  -value $data_scadenza_autocert
	element set_properties $form_name num_autocert     -value $num_autocert 
	element set_properties $form_name volimetria_risc  -value $volimetria_risc 
	element set_properties $form_name consumo_annuo    -value $consumo_annuo
	element set_properties $form_name consumo_annuo2   -value $consumo_annuo2
	element set_properties $form_name stagione_risc    -value $stagione_risc
	element set_properties $form_name stagione_risc2   -value $stagione_risc2
	element set_properties $form_name data_arrivo_ente -value $data_arrivo_ente
	element set_properties $form_name tabella          -value $tabella
	element set_properties $form_name cod_dimp_ins     -value $cod_dimp_ins
	element set_properties $form_name rct_dur_acqua    -value $rct_dur_acqua
	element set_properties $form_name rct_tratt_in_risc         -value $rct_tratt_in_risc
	element set_properties $form_name rct_tratt_in_acs          -value $rct_tratt_in_acs
	element set_properties $form_name rct_install_interna       -value $rct_install_interna
	element set_properties $form_name rct_install_esterna       -value  $rct_install_esterna
	element set_properties $form_name rct_canale_fumo_idoneo    -value $rct_canale_fumo_idoneo
	element set_properties $form_name rct_sistema_reg_temp_amb  -value $rct_sistema_reg_temp_amb
	element set_properties $form_name rct_valv_sicurezza        -value $rct_valv_sicurezza
	element set_properties $form_name rct_scambiatore_lato_fumi -value $rct_scambiatore_lato_fumi
	element set_properties $form_name rct_riflussi_comb         -value $rct_riflussi_comb
	element set_properties $form_name rct_uni_10389             -value $rct_uni_10389
	element set_properties $form_name rct_rend_min_legge        -value $rct_rend_min_legge	
	element set_properties $form_name rct_modulo_termico        -value $rct_modulo_termico
	element set_properties $form_name rct_check_list_1          -value $rct_check_list_1
	element set_properties $form_name rct_check_list_2           -value $rct_check_list_2
	element set_properties $form_name rct_check_list_3           -value $rct_check_list_3
	element set_properties $form_name rct_check_list_4           -value $rct_check_list_4
	element set_properties $form_name rct_gruppo_termico         -value $rct_gruppo_termico
	element set_properties $form_name data_prox_manut            -value $data_prox_manut;#san04
        element set_properties $form_name locale                     -value $locale;#sim17
        element set_properties $form_name lg_flag_dep_combust_solido -value $lg_flag_dep_combust_solido
        element set_properties $form_name lg_flag_puliz_camino       -value $lg_flag_puliz_camino
        element set_properties $form_name lg_flag_sep_gen            -value $lg_flag_sep_gen
        element set_properties $form_name lg_flag_sollecit_termiche  -value $lg_flag_sollecit_termiche
        element set_properties $form_name id_tplg                    -value $id_tplg
        element set_properties $form_name note_tplg_altro            -value $note_tplg_altro
        element set_properties $form_name lg_condensazione           -value $lg_condensazione
        element set_properties $form_name lg_vaso_espa               -value $lg_vaso_espa
        element set_properties $form_name lg_marcatura_ce            -value $lg_marcatura_ce
        element set_properties $form_name lg_placca_cam              -value $lg_placca_cam
        element set_properties $form_name lg_caric_comb              -value $lg_caric_comb
        element set_properties $form_name lg_mod_evac_fumi           -value $lg_mod_evac_fumi
        element set_properties $form_name lg_aria_comburente         -value $lg_aria_comburente         
        element set_properties $form_name libretto_manutenz          -value $libretto_manutenz
	element set_properties $form_name doc_prev_incendi           -value $doc_prev_incendi
	element set_properties $form_name dich_152_presente          -value $dich_152_presente
	element set_properties $form_name doc_ispesl                 -value $doc_ispesl

	# agg dob cind
	element set_properties $form_name cod_cind            -value $cod_cind

	set nome_utente_ins ""
        set data_ins_edit ""
	if {$utente_ins ne ""} {
	    db_1row sel_utente_ins ""
	}
	if {$data_ins ne ""} {
	    db_1row sel_edit_data "select iter_edit_data(:data_ins) as data_ins_edit"
	}
	
	set conta     0
	set prog_anom 0
	set list_anom_old [list]
	db_foreach sel_anom "" {
	    incr conta
	    lappend list_anom_old $cod_tanom
	    element set_properties $form_name prog_anom.$conta   -value $prog_anom
	    element set_properties $form_name cod_anom.$conta    -value $cod_tanom
	    element set_properties $form_name data_ut_int.$conta -value $dat_utile_inter
	}
	element set_properties $form_name prog_anom_max -value $prog_anom
	element set_properties $form_name list_anom_old -value $list_anom_old
	element set_properties $form_name flag_modifica -value $flag_modifica
	
	# valorizzo comunque prog_anom delle righe di anom eventualmente
	# non ancora inserite
	while {$conta < 5} {
	    incr conta
	    incr prog_anom
	    element set_properties $form_name prog_anom.$conta -value $prog_anom
	}
    }
}

if {[form is_valid $form_name]} {

    # form valido dal punto di vista del templating system
    set __refreshing_p   [element::get_value $form_name __refreshing_p];#nic01
    set changed_field    [element::get_value $form_name changed_field];#nic01
    set cod_dimp         [string trim [element::get_value $form_name cod_dimp]]
    set cod_impianto     [string trim [element::get_value $form_name cod_impianto]]
    set data_controllo   [string trim [element::get_value $form_name data_controllo]]
    set cod_manutentore  [string trim [element::get_value $form_name cod_manutentore]]
    set cod_opmanu_new                [element::get_value $form_name cod_opmanu_new]
    set cod_responsabile [string trim [element::get_value $form_name cod_responsabile]]
    set cod_occupante    [string trim [element::get_value $form_name cod_occupante]]
    set cod_proprietario [string trim [element::get_value $form_name cod_proprietario]]
    set flag_status      [string trim [element::get_value $form_name flag_status]]
    set garanzia         [string trim [element::get_value $form_name garanzia]]
    set conformita       [string trim [element::get_value $form_name conformita]]
    set lib_impianto     [string trim [element::get_value $form_name lib_impianto]]
    set lib_uso_man      [string trim [element::get_value $form_name lib_uso_man]]
    set inst_in_out      [string trim [element::get_value $form_name inst_in_out]]
    set idoneita_locale  [string trim [element::get_value $form_name idoneita_locale]]
    set ap_ventilaz      [string trim [element::get_value $form_name ap_ventilaz]]
    set ap_vent_ostruz   [string trim [element::get_value $form_name ap_vent_ostruz]]
    set pendenza         [string trim [element::get_value $form_name pendenza]]
    set sezioni          [string trim [element::get_value $form_name sezioni]]
    set curve            [string trim [element::get_value $form_name curve]]
    set lunghezza        [string trim [element::get_value $form_name lunghezza]]
    set conservazione    [string trim [element::get_value $form_name conservazione]]
    set scar_ca_si       [string trim [element::get_value $form_name scar_ca_si]]
    set scar_parete      [string trim [element::get_value $form_name scar_parete]]
    set riflussi_locale  [string trim [element::get_value $form_name riflussi_locale]]
    set assenza_perdite  [string trim [element::get_value $form_name assenza_perdite]]
    set pulizia_ugelli   [string trim [element::get_value $form_name pulizia_ugelli]]
    set antivento        [string trim [element::get_value $form_name antivento]]
    set scambiatore      [string trim [element::get_value $form_name scambiatore]]
    set accens_reg       [string trim [element::get_value $form_name accens_reg]]
    set disp_comando     [string trim [element::get_value $form_name disp_comando]]
    set ass_perdite      [string trim [element::get_value $form_name ass_perdite]]
    set valvola_sicur    [string trim [element::get_value $form_name valvola_sicur]]
    set vaso_esp         [string trim [element::get_value $form_name vaso_esp]]
    set disp_sic_manom   [string trim [element::get_value $form_name disp_sic_manom]]
    set organi_integri   [string trim [element::get_value $form_name organi_integri]]
    set circ_aria        [string trim [element::get_value $form_name circ_aria]]
    set guarn_accop      [string trim [element::get_value $form_name guarn_accop]]
    set assenza_fughe    [string trim [element::get_value $form_name assenza_fughe]]
    set coibentazione    [string trim [element::get_value $form_name coibentazione]]
    set eff_evac_fum     [string trim [element::get_value $form_name eff_evac_fum]]
    set cont_rend        [string trim [element::get_value $form_name cont_rend]]
    set pot_focolare_mis [string trim [element::get_value $form_name pot_focolare_mis]]
    set portata_comb_mis [string trim [element::get_value $form_name portata_comb_mis]]
    set temp_fumi        [string trim [element::get_value $form_name temp_fumi]]
    set temp_ambi        [string trim [element::get_value $form_name temp_ambi]]
    set o2               [string trim [element::get_value $form_name o2]]
    set co2              [string trim [element::get_value $form_name co2]]
    set bacharach        [string trim [element::get_value $form_name bacharach]]
    set co               [string trim [element::get_value $form_name co]]
    set rend_combust     [string trim [element::get_value $form_name rend_combust]]
    set osservazioni     [string trim [element::get_value $form_name osservazioni]]
    set raccomandazioni  [string trim [element::get_value $form_name raccomandazioni]]
    set prescrizioni     [string trim [element::get_value $form_name prescrizioni]]
    set data_utile_inter [string trim [element::get_value $form_name data_utile_inter]]
    set n_prot           [string trim [element::get_value $form_name n_prot]]
    set data_prot        [string trim [element::get_value $form_name data_prot]]
    set delega_resp      [string trim [element::get_value $form_name delega_resp]]
    set delega_manut     [string trim [element::get_value $form_name delega_manut]]
    set cognome_manu     [string trim [element::get_value $form_name cognome_manu]]
    regsub -all "!" $cognome_manu "'" cognome_manu
    set cognome_opma     [element::get_value $form_name cognome_opma]
    set cognome_resp     [string trim [element::get_value $form_name cognome_resp]]
    set nome_manu        [string trim [element::get_value $form_name nome_manu]]
    set nome_opma                     [element::get_value $form_name nome_opma]
    set nome_resp        [string trim [element::get_value $form_name nome_resp]]
    set cod_fiscale_resp [string trim [element::get_value $form_name cod_fiscale_resp]]
    set cognome_occu     [string trim [element::get_value $form_name cognome_occu]]
    set cognome_prop     [string trim [element::get_value $form_name cognome_prop]]
    set nome_occu        [string trim [element::get_value $form_name nome_occu]]
    set nome_prop        [string trim [element::get_value $form_name nome_prop]]
    set esente           [string trim [element::get_value $form_name esente]];#sim19

    # agg dob cind
    set cod_cind         [element::get_value $form_name cod_cind]
    if {$flag_portafoglio == "T"} {
	set importo_tariffa  [string trim [element::get_value $form_name importo_tariffa]]
	set tariffa_reg      [string trim [element::get_value $form_name tariffa_reg]]
	set cod_manu [iter_check_uten_manu $id_utente]
	if {[string range $id_utente 0 1] == "AM"} {
	    set cod_manu $id_utente
	}
	if {![string equal $cod_manutentore ""]} {
	    if {![string equal $cod_manu ""]} {
		set url "lotto/balance?iter_code=$cod_manu"
	    } else {
		#ricavo il portafoglio manutentore
		set url "lotto/balance?iter_code=$cod_manutentore"
	    }
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    #    ns_return 200 text/html "$result(page)"
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    if {$risultato == "OK"} {
		set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
		set saldo [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
		set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
		
		db_1row sel_limiti_tgen "select flag_limite_portaf, valore_limite_portaf from coimtgen"
		if {$flag_limite_portaf == "S"} {
		    if {[iter_check_num $saldo 2] < $valore_limite_portaf} {
			set msg_limite "Attenzione - Il credito residuo disponibile sul tuo Portafoglio sta per terminare. Prima di completare l'inserimento delle dichiarazioni controlla l'importo necessario per il contributo regionale. Se il credito residuo risulta insufficiente la dichiarazione non verr&agrave; accettata."
		    }
		}
	    }
	}
    }
        
    set costo             [string trim [element::get_value $form_name costo]]
    set tipologia_costo   [string trim [element::get_value $form_name tipologia_costo]]
    if {$tipologia_costo == "BO"} {
	element::set_value $form_name flag_pagato "S"
    }
    set flag_pagato       [string trim [element::get_value $form_name flag_pagato]]
    set riferimento_pag   [string trim [element::get_value $form_name riferimento_pag]]
    set data_scad_pagamento [string trim [element::get_value $form_name data_scad_pagamento]]
    set potenza           [string trim [element::get_value $form_name potenza]]
    set prog_anom_max     [string trim [element::get_value $form_name prog_anom_max]]
    set list_anom_old     [string trim [element::get_value $form_name list_anom_old]]
    set flag_modifica     [string trim [element::get_value $form_name flag_modifica]]
    set cod_int_contr     [string trim [element::get_value $form_name cod_int_contr]]
    set cognome_contr     [string trim [element::get_value $form_name cognome_contr]]
    set nome_contr        [string trim [element::get_value $form_name nome_contr]]
    set gen_prog          [string trim [element::get_value $form_name gen_prog]]
    set flag_tracciato    [string trim [element::get_value $form_name flag_tracciato]]
    set scar_can_fu       [string trim [element::get_value $form_name scar_can_fu]]
    set tiraggio_fumi     [string trim [element::get_value $form_name tiraggio_fumi]]
    set ora_inizio        [string trim [element::get_value $form_name ora_inizio]]
    set ora_fine          [string trim [element::get_value $form_name ora_fine]]
    set data_scadenza_autocert    [string trim [element::get_value $form_name data_scadenza_autocert]]
    set num_autocert      [string trim [element::get_value $form_name num_autocert]]
    set volimetria_risc   [string trim [element::get_value $form_name volimetria_risc]]
    set consumo_annuo     [string trim [element::get_value $form_name consumo_annuo]]
    set consumo_annuo2    [string trim [element::get_value $form_name consumo_annuo2]]
    set data_arrivo_ente  [element::get_value $form_name data_arrivo_ente]
    set stagione_risc     [element::get_value $form_name stagione_risc]
    set stagione_risc2    [element::get_value $form_name stagione_risc2]
    set tabella           [string trim [element::get_value $form_name tabella]]
    set cod_dimp_ins      [string trim [element::get_value $form_name cod_dimp_ins]]
    set rct_dur_acqua            [string trim [element::get_value $form_name rct_dur_acqua]]
    set rct_tratt_in_risc        [string trim [element::get_value $form_name rct_tratt_in_risc]]
    set rct_tratt_in_acs         [string trim [element::get_value $form_name rct_tratt_in_acs]]
    set rct_install_interna      [string trim [element::get_value $form_name rct_install_interna]]
    set rct_install_esterna      [string trim [element::get_value $form_name rct_install_esterna]]
    set rct_canale_fumo_idoneo   [string trim [element::get_value $form_name rct_canale_fumo_idoneo]]
    set rct_sistema_reg_temp_amb [string trim [element::get_value $form_name rct_sistema_reg_temp_amb]]
    set rct_valv_sicurezza        [string trim [element::get_value $form_name rct_valv_sicurezza]]
    set rct_scambiatore_lato_fumi [string trim [element::get_value $form_name rct_scambiatore_lato_fumi]]
    set rct_riflussi_comb         [string trim [element::get_value $form_name rct_riflussi_comb]]
    set rct_uni_10389             [string trim [element::get_value $form_name rct_uni_10389]]
    set rct_rend_min_legge        [string trim [element::get_value $form_name rct_rend_min_legge]]
    set rct_modulo_termico        [string trim [element::get_value $form_name rct_modulo_termico]]
    set rct_check_list_1          [string trim [element::get_value $form_name rct_check_list_1]]
    set rct_check_list_2          [string trim [element::get_value $form_name rct_check_list_2]]
    set rct_check_list_3          [string trim [element::get_value $form_name rct_check_list_3]]
    set rct_check_list_4          [string trim [element::get_value $form_name rct_check_list_4]]
    set rct_gruppo_termico        [string trim [element::get_value $form_name rct_gruppo_termico]]
    set rct_lib_uso_man_comp      [string trim [element::get_value $form_name rct_lib_uso_man_comp]]
    set data_prox_manut           [string trim [element::get_value $form_name data_prox_manut]];#san04
    set locale                    [element::get_value $form_name locale];#sim17
    set lg_flag_dep_combust_solido [string trim [element::get_value $form_name lg_flag_dep_combust_solido]]
    set lg_flag_puliz_camino       [string trim [element::get_value $form_name lg_flag_puliz_camino]]
    set lg_flag_sep_gen            [string trim [element::get_value $form_name lg_flag_sep_gen]]
    set lg_flag_sollecit_termiche  [string trim [element::get_value $form_name lg_flag_sollecit_termiche]]
    set id_tplg                    [string trim [element::get_value $form_name id_tplg]]
    set note_tplg_altro            [string trim [element::get_value $form_name note_tplg_altro]]
    set lg_condensazione           [string trim [element::get_value $form_name lg_condensazione]]
    set lg_vaso_espa               [string trim [element::get_value $form_name lg_vaso_espa]]
    set lg_marcatura_ce            [string trim [element::get_value $form_name lg_marcatura_ce]]
    set lg_placca_cam              [string trim [element::get_value $form_name lg_placca_cam]]
    set lg_caric_comb              [string trim [element::get_value $form_name lg_caric_comb]]
    set lg_mod_evac_fumi           [string trim [element::get_value $form_name lg_mod_evac_fumi]]
    set lg_aria_comburente         [string trim [element::get_value $form_name lg_aria_comburente]]
    set libretto_manutenz          [string trim [element::get_value $form_name libretto_manutenz]]
    set doc_prev_incendi           [string trim [element::get_value $form_name doc_prev_incendi]]
    set dich_152_presente          [string trim [element::get_value $form_name dich_152_presente]]
    set doc_ispesl                 [string trim [element::get_value $form_name doc_ispesl]]

    if {$flag_mod_gend == "S"} {
	set costruttore      [element::get_value $form_name costruttore]
	set modello          [element::get_value $form_name modello]
	set matricola        [element::get_value $form_name matricola]
	set combustibile     [element::get_value $form_name combustibile]
	set data_insta       [element::get_value $form_name data_insta]
	set tiraggio         [element::get_value $form_name tiraggio]
	set tipo_a_c         [element::get_value $form_name tipo_a_c]
	set destinazione     [element::get_value $form_name destinazione]
	set locale           [element::get_value $form_name locale]
	set data_costruz_gen [element::get_value $form_name data_costruz_gen]
	set marc_effic_energ [element::get_value $form_name marc_effic_energ]
	set volimetria_risc  [element::get_value $form_name volimetria_risc]
	set consumo_annuo    [element::get_value $form_name consumo_annuo]
	set consumo_annuo2   [element::get_value $form_name consumo_annuo2]
	set stagione_risc    [element::get_value $form_name stagione_risc]
	set stagione_risc2   [element::get_value $form_name stagione_risc2]
	set potenza          [element::get_value $form_name potenza]
	#ns_return 200 text/html "bubu4|$combustibile|$data_insta|" ; return

        #Imposto ora le options di cod_mode perch� solo adesso ho a disposizione la var. costruttore
	if {![string is space $costruttore]} {
	    element set_properties $form_name cod_mode -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $costruttore]'" cod_mode descr_mode];#nic01
	}
        set cod_mode         [element::get_value $form_name cod_mode];#nic01
    } else {
	#Nicola 23/06/2014: se $flag_mod_gend == "N" devo valoriz. la var. tiraggio
	#altrimenti il pgm va in errore perche' in tal caso non viene letta la var. tiraggio
	#Andava in errore su iterprfi-dev (ho trovato la soluzione nel sorgente
	#coimdimp-g-gest personalizzato)
        if {[string equal $gen_prog ""]} {
            db_1row query "select min(gen_prog) as gen_prog
                             from coimgend
                            where flag_attivo = 'S'
                              and cod_impianto = :cod_impianto"
	    if {$gen_prog eq ""} {
                set gen_prog 1
            }
        }
	if {![db_0or1row query "select a.tiraggio
                                     , c.descr_comb as combustibile
                                     , a.tipo_foco  as tipo_a_c -- 14/10/2014 per CBARLETTA
                                   --  C'era su PFI ma finche' non va in errore non lo uso
                                   --, a.cod_combustibile
                                  from coimgend a
                            inner join coimaimp b on b.cod_impianto     = a.cod_impianto
                             left join coimcomb c on c.cod_combustibile = b.cod_combustibile
                                 where a.cod_impianto = :cod_impianto
                                   and a.gen_prog     = :gen_prog"]
	} {
	    set tiraggio     ""
	    set combustibile ""
	}
    }

    if {$combustibile eq "12" || 
	$combustibile eq "6"  ||
	$combustibile eq "0"  ||
	$combustibile eq "2"} {#sim24                         
	set conbustibile_solido "S"
    } else {
	set conbustibile_solido "N"
    }

    set pot_focolare_nom [element::get_value $form_name pot_focolare_nom]
    element set_properties $form_name garanzia         -value $garanzia
    element set_properties $form_name conformita       -value $conformita
    element set_properties $form_name lib_impianto     -value $lib_impianto
    element set_properties $form_name lib_uso_man      -value $lib_uso_man
    element set_properties $form_name inst_in_out      -value $inst_in_out
    element set_properties $form_name idoneita_locale  -value $idoneita_locale
    element set_properties $form_name ap_ventilaz      -value $ap_ventilaz
    element set_properties $form_name ap_vent_ostruz   -value $ap_vent_ostruz
    element set_properties $form_name pendenza         -value $pendenza
    element set_properties $form_name sezioni          -value $sezioni
    element set_properties $form_name curve            -value $curve
    element set_properties $form_name lunghezza        -value $lunghezza
    element set_properties $form_name conservazione    -value $conservazione
    element set_properties $form_name scar_ca_si       -value $scar_ca_si
    element set_properties $form_name scar_can_fu      -value $scar_can_fu
    element set_properties $form_name scar_parete      -value $scar_parete
    element set_properties $form_name riflussi_locale  -value $riflussi_locale
    element set_properties $form_name assenza_perdite  -value $assenza_perdite
    element set_properties $form_name pulizia_ugelli   -value $pulizia_ugelli
    element set_properties $form_name antivento        -value $antivento
    element set_properties $form_name scambiatore      -value $scambiatore
    element set_properties $form_name accens_reg       -value $accens_reg
    element set_properties $form_name disp_comando     -value $disp_comando
    element set_properties $form_name ass_perdite      -value $ass_perdite
    element set_properties $form_name valvola_sicur    -value $valvola_sicur
    element set_properties $form_name vaso_esp         -value $vaso_esp
    element set_properties $form_name disp_sic_manom   -value $disp_sic_manom
    element set_properties $form_name organi_integri   -value $organi_integri
    element set_properties $form_name circ_aria        -value $circ_aria
    element set_properties $form_name guarn_accop      -value $guarn_accop
    element set_properties $form_name assenza_fughe    -value $assenza_fughe
    element set_properties $form_name coibentazione    -value $coibentazione
    element set_properties $form_name eff_evac_fum     -value $eff_evac_fum
    element set_properties $form_name cont_rend        -value $cont_rend
    element set_properties $form_name rct_dur_acqua             -value $rct_dur_acqua
    element set_properties $form_name rct_tratt_in_risc         -value $rct_tratt_in_risc
    element set_properties $form_name rct_tratt_in_acs          -value $rct_tratt_in_acs
    element set_properties $form_name rct_install_interna       -value $rct_install_interna
    element set_properties $form_name rct_install_esterna       -value $rct_install_esterna
    element set_properties $form_name rct_canale_fumo_idoneo    -value $rct_canale_fumo_idoneo
    element set_properties $form_name rct_sistema_reg_temp_amb  -value $rct_sistema_reg_temp_amb
    element set_properties $form_name rct_valv_sicurezza        -value $rct_valv_sicurezza
    element set_properties $form_name rct_scambiatore_lato_fumi -value $rct_scambiatore_lato_fumi
    element set_properties $form_name rct_riflussi_comb         -value $rct_riflussi_comb
    element set_properties $form_name rct_uni_10389             -value $rct_uni_10389
    element set_properties $form_name rct_rend_min_legge        -value $rct_rend_min_legge
    element set_properties $form_name rct_modulo_termico        -value $rct_modulo_termico
    element set_properties $form_name rct_check_list_1          -value $rct_check_list_1
    element set_properties $form_name rct_check_list_2          -value $rct_check_list_2
    element set_properties $form_name rct_check_list_3          -value $rct_check_list_3
    element set_properties $form_name rct_check_list_4          -value $rct_check_list_4
    element set_properties $form_name rct_gruppo_termico        -value $rct_gruppo_termico
    element set_properties $form_name rct_lib_uso_man_comp      -value $rct_lib_uso_man_comp
    element set_properties $form_name data_prox_manut           -value $data_prox_manut;#san04
    element set_properties $form_name lg_flag_dep_combust_solido -value $lg_flag_dep_combust_solido
    element set_properties $form_name lg_flag_puliz_camino       -value $lg_flag_puliz_camino
    element set_properties $form_name lg_flag_sep_gen            -value $lg_flag_sep_gen
    element set_properties $form_name lg_flag_sollecit_termiche  -value $lg_flag_sollecit_termiche
    element set_properties $form_name id_tplg                    -value $id_tplg
    element set_properties $form_name note_tplg_altro            -value $note_tplg_altro
    element set_properties $form_name lg_condensazione           -value $lg_condensazione
    element set_properties $form_name lg_vaso_espa               -value $lg_vaso_espa
    element set_properties $form_name lg_marcatura_ce            -value $lg_marcatura_ce
    element set_properties $form_name lg_placca_cam              -value $lg_placca_cam
    element set_properties $form_name lg_caric_comb              -value $lg_caric_comb
    element set_properties $form_name lg_mod_evac_fumi           -value $lg_mod_evac_fumi
    element set_properties $form_name lg_aria_comburente         -value $lg_aria_comburente
    element set_properties $form_name libretto_manutenz          -value $libretto_manutenz
    element set_properties $form_name doc_prev_incendi           -value $doc_prev_incendi
    element set_properties $form_name dich_152_presente          -value $dich_152_presente
    element set_properties $form_name doc_ispesl                 -value $doc_ispesl

    set conta 0
    while {$conta < 5} {
	incr conta
	set prog_anom($conta)   [element::get_value $form_name prog_anom.$conta]
	set cod_anom($conta)    [element::get_value $form_name cod_anom.$conta]
	set data_ut_int($conta) [element::get_value $form_name data_ut_int.$conta]
    }


    if {[string equal $__refreshing_p "1"]} {;#nic01
        if {$changed_field eq "costruttore"} {;#nic01
            set focus_field "$form_name.cod_mode";#nic01
        };#nic01

	if {$changed_field eq "flag_status"} {;#sim19 if e suo contenuto
	    set focus_field "$form_name.costo"
	    eval $controllo_tariffa
	    ns_log notice "simone4 $tariffa $flag_status"
	    element set_properties $form_name costo            -value $tariffa
	    element set_properties $form_name esente           -value $esente
	}

        element set_properties $form_name __refreshing_p -value 0;#nic01
        element set_properties $form_name changed_field  -value "";#nic01

        ad_return_template;#nic01
        return;#nic01
    };#nic01

    
    set error_num 0


    #if {$flag_portafoglio == "T" && $funzione == "I"} {
    #	if {[string equal $__refreshing_p 0] || [string equal $__refreshing_p ""]} {
    #	} else {
    #	    set error_num 1
    #	    if {$tariffa_reg == "8"} {
    #		set importo_tariffa "0,00"
    #	    } else {
    #		if {[db_0or1row sel_tari_contributo ""] == 0} {
    #		    set importo_tariffa ""
    #		}
    #	    }
    #	    element set_properties $form_name importo_tariffa   -value $importo_tariffa
    #	    set __refreshing_p "0"
    #	    element set_properties $form_name __refreshing_p   -value $__refreshing_p
    #	}
    #}    
    # gen_prog e num_bollo non sono piu' usati, valorizzati sempre a null

    set num_bollo ""

    # controlli standard su numeri e date, per Ins ed Upd
    set flag_errore_data_controllo "f"

    if {$riferimento_pag eq "0"} {#sim12: aggiunta if e suo contenuto
	set riferimento_pag ""
    }

    if {$flag_gest_targa eq "T"} {#sim13: aggiunta if e suo contenuto
	
	if {![db_0or1row query "
            select targa
              from coimaimp
             where cod_impianto        = :cod_impianto
               and coalesce(targa,'') != ''"]
	} {
	    #nic08 element::set_error $form_name num_autocert "Inserire la targa dell'impianto nei dati generali"
	    #nic08 incr error_num
	}
    }

    if {$flag_portafoglio == "T"} {
	if {![string equal $importo_tariffa ""]} {
	    set importo_tariffa [iter_check_num $importo_tariffa 2]
	    if {$importo_tariffa == "Error"} {
		element::set_error $form_name importo_tariffa "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $importo_tariffa] >=  [expr pow(10,7)]
		    ||  [iter_set_double $importo_tariffa] <= -[expr pow(10,7)]} {
		    element::set_error $form_name importo_tariffa "Deve essere inferiore di 10.000.000"
		    incr error_num
		}
	    }
	}
    }

    set sw_costo_null "f"
    if {![string equal $costo ""]} {
	set costo [iter_check_num $costo 2]
	if {$costo == "Error"} {
	    element::set_error $form_name costo "Deve essere numerico, max 2 dec"
	    incr error_num
	} else {
	    if {[iter_set_double $costo] >=  [expr pow(10,7)] || [iter_set_double $costo] <= -[expr pow(10,7)]} {
		element::set_error $form_name costo "Deve essere inferiore di 10.000.000"
		incr error_num
	    } else {
		if {$costo == 0} {
		    set sw_costo_null "t"
		}
	    }
	}
    } else {
	set sw_costo_null "t"
    }
    
    if {$funzione == "I" && $coimtgen(ente) ne "PPD"} {

	db_transaction {;#sim32

	    set dml_upd_tppt [db_map upd_tppt]
	    db_dml dml_upd_tppt $dml_upd_tppt
	    set n_prot [db_string query "select descr || '/' || progressivo from coimtppt where cod_tppt = 'UC'"]
	    
	}
	#sim32 set n_prot [db_string query "select descr || '/' || progressivo + 1 from coimtppt where cod_tppt = 'UC'"]
	set data_prot [db_string query "select iter_edit_data(current_date)"]
    }
    
    if {$funzione == "I" || $funzione == "M"} {
        set sw_pot_focolare_nom_ok ""

	# dob cind
	if {$flag_cind == "S" && $cod_cind == "" && $funzione == "I"} {
	    element::set_error $form_name cod_cind "Inserire campagna di riferimento"
	    incr error_num	    
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
	
        set check_cod_opma {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_opma ""
            set ctr_opma         0
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
	    db_foreach sel_opma "" {
		incr ctr_opma
		if {$cod_opma == $chk_inp_cod_opma} {
		    set chk_out_cod_opma $cod_opma
		    set chk_out_rc       1
		}
	    }
	    switch $ctr_opma {
		0 { set chk_out_msg "Soggetto non trovato"}
		1 { set chk_out_cod_opma $cod_opma
		    set chk_out_rc       1 }
		default {
		    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
		}
	    }
	}
    	
        if {[string equal $cognome_manu ""] && [string equal $nome_manu ""]} {
	    element::set_error $form_name cognome_manu "Inserire il manutentore"
            incr error_num
	} else {
	    if {[string equal $cognome_manu ""] && [string equal $nome_manu ""]} {
		set cod_manutentore ""
	    } else {
		set chk_inp_cod_manu $cod_manutentore
		set chk_inp_cognome  $cognome_manu
		set chk_inp_nome     $nome_manu
		eval $check_cod_manu
		set cod_manutentore  $chk_out_cod_manu
		if {$chk_out_rc == 0} {
		    element::set_error $form_name cognome_manu $chk_out_msg
		    incr error_num
		}
	    }
	}
    	
	#cod_opma obbligatorio   	
	if {$cod_opmanu_new eq ""} {
	    # La provincia di Livorno ha chiesto il 23/07/2014 che l'operatore non sia obblig.
	    # La provincia di Venezia l'ha chiesto il 04/08/2014
	    # La provincia di Caserta l'ha chiesto il 04/08/2014
	    # Publies (PPO e iterprfi_pu) l'ha chiesto il 01/09/2014
            # Barletta l'ha chiesto il 01/02/2017
	    if {$coimtgen(ente) ne "PLI"
	    &&  $coimtgen(ente) ne "PVE"
	    &&  $coimtgen(ente) ne "PCE"
	    &&  $coimtgen(ente) ne "PPO"
	    &&  ![string match "*iterprfi_pu*" [db_get_database]]
	    &&  $coimtgen(ente) ne "PPD"
            &&  $coimtgen(ente) ne "PBT"
	    } {
		element::set_error $form_name cognome_opma "Devi utilizzare il Cerca"
		incr error_num
	    }
	    #![string equal $cognome_opma ""] && ![string equal $nome_opma ""]
	    # set cod_opma ""
	} else {
	    set chk_inp_cod_opma $cod_opma
	    set chk_inp_cognome  $cognome_opma
	    set chk_inp_nome     $nome_opma
	    eval $check_cod_opma
	    set cod_opma  $chk_out_cod_opma
	    if {$chk_out_rc == 0} {
		element::set_error $form_name cognome_opma $chk_out_msg
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
	 	1 { set chk_out_cod_citt $cod_cittadino
		    set chk_out_rc       1 }
		default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}
	
        if {[string equal $cognome_resp ""] &&  [string equal $nome_resp ""]} {
            set cod_responsabile ""
	} else {
	    set chk_inp_cod_citt $cod_responsabile
	    set chk_inp_cognome  $cognome_resp
	    set chk_inp_nome     $nome_resp
	    eval $check_cod_citt
            set cod_responsabile $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_resp $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_prop ""] && [string equal $nome_prop ""]} {
            set cod_proprietario ""
	} else {
	    set chk_inp_cod_citt $cod_proprietario
	    set chk_inp_cognome  $cognome_prop
	    set chk_inp_nome     $nome_prop
	    eval $check_cod_citt
            set cod_proprietario $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_prop $chk_out_msg
                incr error_num
	    }
	}
	
        if {[string equal $cognome_occu ""] && [string equal $nome_occu ""]} {
            set cod_occupante ""
	} else {
	    set chk_inp_cod_citt $cod_occupante
	    set chk_inp_cognome  $cognome_occu
	    set chk_inp_nome     $nome_occu
	    eval $check_cod_citt
            set cod_occupante    $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_occu $chk_out_msg
                incr error_num
	    }
	}
	
        if {[string equal $cognome_contr ""] && [string equal $nome_contr ""]} {
            set cod_int_contr ""
	} else {
	    set chk_inp_cod_citt $cod_int_contr
	    set chk_inp_cognome  $cognome_contr
	    set chk_inp_nome     $nome_contr
	    eval $check_cod_citt
            set cod_int_contr    $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_contr $chk_out_msg
                incr error_num
	    }
	}
	
	if {![string equal $volimetria_risc ""]} {
	    set volimetria_risc [iter_check_num $volimetria_risc 2]
            if {$volimetria_risc == "Error"} {
                element::set_error $form_name volimetrica_risc "Volumetria stanza misurata deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num 
	    }
	}
	
	if {![string equal $consumo_annuo ""]} {
	    set consumo_annuo [iter_check_num $consumo_annuo 2]
            if {$consumo_annuo == "Error"} {
                element::set_error $form_name consumo_annuo "Consumo annuo deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num	    
	    }
	}
	
	if {![string equal $consumo_annuo2 ""]} {
	    set consumo_annuo2 [iter_check_num $consumo_annuo2 2]
	    if {$consumo_annuo2 == "Error"} {
		element::set_error $form_name consumo_annuo2 "Consumo annuo deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num	    
	    }
	}
	
	set sw_data_controllo_ok "f"
        if {[string equal $data_controllo ""]} {
	    set flag_errore_data_controllo "t"
            element::set_error $form_name data_controllo "Inserire Data controllo"
            incr error_num
        } else {
            set data_controllo [iter_check_date $data_controllo]
            if {$data_controllo == 0} {
		set flag_errore_data_controllo "t"
                element::set_error $form_name data_controllo "Data controllo deve essere una data"
                incr error_num
            } else {
		if {$data_controllo > $current_date} {
		    set flag_errore_data_controllo "t"
		    element::set_error $form_name data_controllo "Data controllo deve essere inferiore alla data odierna"
		    incr error_num
		}
            }
	}


	if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO"} {
	    # Per Udine e Gorizia non va fatto il controllo sul codice fiscale
	} else {
	    # Caso Standard
	    if {$flag_errore_data_controllo == "f" && $data_controllo >= "20090801"} {
		if {[db_0or1row query "select natura_giuridica as natura_r, cod_fiscale as fisc_r, cod_piva as piva_r, stato_nas from coimcitt where cod_cittadino = :cod_responsabile"]} {
		    set fisc_r [string trim $fisc_r]
		    if {$stato_nas eq "1"} {#san01
			if {$fisc_r eq ""} {
			    element::set_error $form_name cognome_resp "Il responsabile non ha il Codice Fiscale: e' obbligatorio per i modelli con data controllo superiore al 31 Luglio 2009"
			    incr error_num
			}
		    };#san01
		}
	    }
	}
	
	if {$funzione eq "I"} {
	    if {$id_utente_ma eq "MA" && $flag_errore_data_controllo eq "f"} {
		# set oggi50 [db_string query "select :data_controllo::date + 50" -default ""]
		# set oggi50 [clock format [clock scan "$ggad" -base [clock scan $data_controllo]] -f "%Y%m%d"]
		#sim14 aggiunto || su CALABRIA
		#sim21 tolto && $coimtgen(ente) ne "PRC" su la || della calabria
		#sim35 aggiunto || su Barletta 
		set num_gg_post_data_controllo_per_messaggio 45
                if {$coimtgen(ente)    eq "PFI"
		||  $coimtgen(ente)    eq "PPO"
		||  [string match "*iterprfi_pu*" [db_get_database]]
		||  $coimtgen(ente)    eq "CRIMINI"
                ||  $coimtgen(ente)    eq "CBARLETTA"
                ||  $coimtgen(regione) eq "MARCHE"
                ||  $coimtgen(ente) eq "PTA"
		||  $coimtgen(regione) eq "CALABRIA"
                ||  $coimtgen(ente) eq "PBT"
		} {#Sandro 24/07/2014
		    set oggi50 [clock format [clock scan "$data_controllo +2000 days"] -format "%Y%m%d"];#Sandro 24/07/2014
		} elseif {$coimtgen(ente) eq "PLI"} {#Sandro 28/07/2014
		    
		    if {$current_date <= 20160331} {#sim03 Aggiunta if e suo comtenuto
			set num_gg_post_data_controllo_per_messaggio 90
		    } else {
			set num_gg_post_data_controllo_per_messaggio 31
		    }
		    set oggi50 [clock format [clock scan "$data_controllo + $num_gg_post_data_controllo_per_messaggio  days"] -format "%Y%m%d"];#sim03
		    #sim03 set oggi50 [clock format [clock scan "$data_controllo +60   days"] -format "%Y%m%d"];#Sandro 28/07/2014
		    #sim03 set num_gg_post_data_controllo_per_messaggio 60
		} else {#Sandro 24/07/2014
		    set oggi50 [clock format [clock scan "$data_controllo +50   days"] -format "%Y%m%d"]
		};#Sandro 24/07/2014
		if {$current_date > $oggi50} {
		    if {$coimtgen(ente) eq "PLI"
		    &&  $current_date   <= "20160630"
		    } {#nic07
			if {$data_controllo < "20160101" || $data_controllo > "20160229"} {#nic07: aggiunta if ed il suo contenuto
                            # Qui entra se la data_controllo e' piu' vecchia di 31 gg e
                            # non e' compresa tra il 01/01/2016 ed il 29/02/2016.
                            element::set_error $form_name num_autocert "Non � possibile inserire rapporti di controllo tecnico oltre i $num_gg_post_data_controllo_per_messaggio giorni dalla data di effettuazione del controllo (ad eccezione dei rapporti di controllo tecnico rilasciati dal 01/01/2016 al 29/02/2016)"
                            incr error_num
                        }
                    } else {#nic07
                        # caso standard
			element::set_error $form_name num_autocert "Non � possibile inserire rapporti di controllo tecnico oltre i $num_gg_post_data_controllo_per_messaggio giorni dalla data di effettuazione del controllo"
			incr error_num
		    };#nic07
		}
	    }
	}

	# Nel caso di due impianti differenti con stesso indirizzo che
	# vengono inseriti come un solo impianto e che di conseguenza
	# ci troviamo con un impianto con potenza < 35 kW e due generatori,
	# permettiamo l'inserimento di piu' modelli h nella stessa data
	if {[string equal $data_controllo ""]} {
	    set where_gen_prog " and gen_prog is null"
	} else {
	    set where_gen_prog " and gen_prog = :gen_prog"
	}
	
	if {$flag_errore_data_controllo == "f"} {
	    if {$funzione == "I"
	    &&  [db_0or1row sel_dimp_check_data_controllo ""] != 0
	    } {
		set flag_errore_data_controllo "t"
		element::set_error $form_name data_controllo "Esiste gi&agrave; un mod. con questa data"
		incr error_num
	    } else {
		set sw_data_controllo_ok "t"
	    }
	}
	
	if {[string equal $gen_prog ""]} {
	    # set gen_prog 1
            db_1row query "select min(gen_prog) as gen_prog
                             from coimgend
                            where flag_attivo = 'S'
                              and cod_impianto = :cod_impianto"
            if {$gen_prog eq ""} {
                set gen_prog 1
            }

      	}
	#ns_log notice "bubu3|$data_insta|"
	#sandro 080512
	#	if {$flag_mod_gend == "S"} {
	#	    if {$data_insta == ""} {
	#		db_0or1row sel_data_insta_gen "select coalesce(iter_edit_data(data_installaz), '01/01/1900') as data_insta from coimgend where cod_impianto = :cod_impianto and gen_prog = :gen_prog"
	#	    }
	#	}
	#fine sandro

	#Nicola 23/06/2014: se $flag_mod_gend == "N" devo valoriz. la var. data_insta
	#altrimenti il pgm va in errore perche' in tal caso non viene letta la var. data_insta
	#Andava in errore su iterprfi-dev (ho trovato la soluzione nel sorgente
	#coimdimp-g-gest personalizzato)
	if {$flag_mod_gend == "N"} {
	    if {![db_0or1row query "select data_installaz as data_insta
                                      from coimgend
                                     where cod_impianto = :cod_impianto
                                       and gen_prog = :gen_prog"]
	    } {
		set data_insta ""
	    } else {
		set data_insta [string range $data_insta 0 3][string range $data_insta 5 6][string range $data_insta 8 9]
		set data_insta [iter_edit_date $data_insta]
	    }
	}

	set err_insta 0
	if {$data_insta ne ""} {
	    set data_insta_contr [iter_check_date $data_insta]
	    if {$data_insta_contr == 0} {
		set err_insta 1
	    }
	} else {
	    set err_insta 1
	}

	if {$flag_portafoglio == "T"} {
	    if {$sw_data_controllo_ok == "t" && $err_insta == 0} {
		if {$data_controllo < "20080801"} {
		    set importo_tariffa ""
		    set tariffa_reg ""
		} else {
		    set dat_inst_gend [iter_check_date $data_insta]
		    if {![string equal $dat_inst_gend ""]} {
			set data_insta_check [db_string sel_dat "select to_char(add_months(:dat_inst_gend, '1'), 'yyyymmdd')"]
			if {$data_controllo <= $data_insta_check} {
			    set importo_tariffa "0.00"
			    set tariffa_reg "8"
			}
		    }
		}
	    }
	}
	#ns_log notice " mariano  $data_insta"
	if  {[string equal $sw_data_controllo_ok "t"] && $err_insta == 0} {
	    #set anno_insta [expr [string range $data_insta 6 9] + 1]
	    #set data_insta_contr [string range $data_insta 0 5]$anno_insta
            #set data_insta_contr [iter_check_date $data_insta_contr]
	    set dat_inst_gend [iter_check_date $data_insta]
	    #set data_insta_contr [db_string query "select :dat_inst_gend::date + 365" -default ""]
	    
	    #	    if {$data_controllo > $data_insta_contr
	    #			&& [string equal $riferimento_pag ""]
	    #	    } {
            db_1row sel_tgen_boll "select flag_bollino_obb from coimtgen"
	    if {$tipologia_costo == "BO"
		&& [string equal $riferimento_pag ""]
		&& $flag_bollino_obb == "T"} {
		element::set_error $form_name riferimento_pag "Inserire n. bollino"
		incr error_num
	    }
	    #	    }
	}
	
        if {$coimtgen(ente) eq "PLI"
        && [string equal $riferimento_pag ""] && $flag_errore_data_controllo eq "f"
        } {

            if {![db_0or1row q "select 1
                                  from coimdimp
                                 where cod_impianto   = :cod_impianto
                                   and data_controllo = :data_controllo
                                   and gen_prog      != :gen_prog"]} {;#sim25
		element::set_error $form_name riferimento_pag "Bollino obbligatorio"
		incr error_num
	    };#sim25
        }

        if {![string equal $pot_focolare_mis ""]} {
            set pot_focolare_mis [iter_check_num $pot_focolare_mis 2]
            if {$pot_focolare_mis == "Error"} {
                element::set_error $form_name pot_focolare_mis "Potenza focolare misurata deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
		if {$pot_focolare_mis == "0,00"} {
		    element::set_error $form_name pot_focolare_mis "La potenza deve essere maggiore di 0,00"
		    incr error_num
		}
                if {[iter_set_double $pot_focolare_mis] >=  [expr pow(10,4)]
		    ||  [iter_set_double $pot_focolare_mis] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_focolare_mis "Potenza focolare misurata deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
	
	#sandro 230513
	if {[string equal $tiraggio "N"]
	    && [string equal $assenza_perdite  "S"]} {
	    element::set_error $form_name assenza_perdite "Incongruenza con il tiraggio"
	    incr error_num
	    
	}
	
	if {[string equal $tiraggio "F"]
	    && [string equal $riflussi_locale  "S"]} {
	    element::set_error $form_name riflussi_locale "Incongruenza con il tiraggio"
	    incr error_num
	    
	}
	#sandro fine

        if {![string equal $portata_comb_mis ""]} {
            set portata_comb_mis [iter_check_num $portata_comb_mis 2]
            if {$portata_comb_mis == "Error"} {
                element::set_error $form_name portata_comb_mis "Portata combustibile misurata deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $portata_comb_mis] >=  [expr pow(10,4)]
		    ||  [iter_set_double $portata_comb_mis] <= -[expr pow(10,4)]} {
                    element::set_error $form_name portata_comb_mis "Portata combustibile misurata deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
	
	#sim24 Spostato in alto perch� altrimenti andava in errore la modifica fatta da Missora nell'adp in caso di refresh
	#if {$combustibile eq "12" || 
	#    $combustibile eq "6"  ||
	#    $combustibile eq "0"  ||
	#    $combustibile eq "2"} {#sim18 if else e loro contenuto
	#    set conbustibile_solido "S"
	#} else {
	#    set conbustibile_solido "N"
	#}

	# se il flag prova di combustione e' valorizzato a SI, obbligo 
        # l'inserimento dei valori numerici riguardanti il controllo dei 
        # fumi. per ora il bacharach non lo rendo obligatorio essendo un 
        # valore riferito agli impianti a combustibile liquido.
	if {$cont_rend == "S" && $conbustibile_solido eq "N"} {
	    #san06: aggiunta || "0"
	    if {[string equal $temp_fumi ""] || [string equal $temp_fumi "0"]} {
		element::set_error $form_name temp_fumi "Inserire"
		incr error_num
	    }

	    #san06: aggiunta || "0"
	    if {[string equal $temp_ambi ""] || [string equal $temp_ambi "0"]} {
		element::set_error $form_name temp_ambi "Inserire"
		incr error_num
	    }
	    
	    #san06: aggiunta || "0"
	    if {[string equal $o2 ""] || [string equal $o2 "0"]} {
		element::set_error $form_name o2 "Inserire"
		incr error_num		
	    }
	    
	    if {[string equal $co2 ""]} {
		element::set_error $form_name co2 "Inserire"
		incr error_num		
	    }

	    #san06: aggiunta || "0"
	    if {[string equal $rend_combust ""] || [string equal $rend_combust "0"]} {
		element::set_error $form_name rend_combust "Inserire"
		incr error_num		
	    }

	    #san06: aggiunta || "0"
	    if {[string equal $rct_rend_min_legge ""] || [string equal $rct_rend_min_legge "0"]} {
		element::set_error $form_name rct_rend_min_legge "Inserire"
		incr error_num		
	    }
	    
	    if {[info exist gend_zero] && $gend_zero == 0} {
		set tipo_a_c         ""
	    }

	    #modifica assurda per dpr 74 Tiraggio solo per GAS METANO
	    #ns_return 200 text/html "$combustibile"
	    if {$combustibile == "5"} {
		if {[info exist tiraggio] && [string equal $tiraggio "N"] &&
		    [info exist tipo_a_c] && [string equal $tipo_a_c "A"]} {
		    if {[string equal $tiraggio_fumi ""]} {
			element::set_error $form_name tiraggio_fumi "Inserire"
			incr error_num
		    }
		}
	    }

	    if {[string equal $co ""]} {
		element::set_error $form_name co "Inserire"
		incr error_num
	    }
	}

	if {![string equal $rct_dur_acqua ""]} {
	    set rct_dur_acqua [iter_check_num $rct_dur_acqua 2]
	    if {$rct_dur_acqua == "Error"} {
		element::set_error $form_name rct_dur_acqua "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
            } else {
                if {[iter_set_double $rct_dur_acqua] >=  [expr pow(10,8)]
	        ||  [iter_set_double $rct_dur_acqua] <= -[expr pow(10,8)]
		} {
                    element::set_error $form_name rct_dur_acqua "Deve essere inferiore di 100.000.000"
                    incr error_num
		}
	    }
	}

	if {![string equal $temp_fumi ""]} {
	    set temp_fumi [iter_check_num $temp_fumi 2]
	    if {$temp_fumi == "Error"} {
		element::set_error $form_name temp_fumi "Temperatura fumi deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $temp_fumi] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_fumi] <= -[expr pow(10,4)]} {
		    element::set_error $form_name temp_fumi "Temperatura fumi deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}
	
	if {![string equal $temp_ambi ""]} {
	    set temp_ambi [iter_check_num $temp_ambi 2]
	    if {$temp_ambi == "Error"} {
		element::set_error $form_name temp_ambi "Temperatura ambiente deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $temp_ambi] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_ambi] <= -[expr pow(10,4)]} {
		    element::set_error $form_name temp_ambi "Temperatura ambiente deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}
    
	if {$flag_mod_gend == "S"} {
	    if {![string equal $data_insta ""]} {
		set data_insta [iter_check_date $data_insta]
		if {$data_insta == 0} {
		    element::set_error $form_name data_insta "Data installazione errata"
		    incr error_num
		}
	    } else {
		element::set_error $form_name data_insta "Data installazione mancante"
		incr error_num
	    }
	    if {![string equal $data_costruz_gen ""]} {
		set data_costruz_gen [iter_check_date $data_costruz_gen]
		if {$data_costruz_gen == 0} {
		    element::set_error $form_name data_costruz_gen "Data costr. deve essere una data"
		    incr error_num
		}
	    }
	    if {$costruttore == ""} {
		element::set_error $form_name costruttore "Costruttore obbligatorio"
		incr error_num
	    }

            if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic01
		if {$modello == ""} {
		    element::set_error $form_name modello "Modello obbligatorio"
		    incr error_num
		}
            } else {;#nic01
                if {$cod_mode eq ""} {;#nic01
                    element::set_error $form_name cod_mode "Modello obbligatorio";#nic01
                    incr error_num;#nic01
                } else {;#nic01
                    # Devo comunque valorizzare la colonna coimgend.modello
                    if {![db_0or1row query "select descr_mode as modello
                                              from coimmode
                                             where cod_mode = :cod_mode"]
                    } {#nic01
                        element::set_error $form_name cod_mode "Modello non trovato in anagrafica";#nic01
                        incr error_num;#nic01
                    };#nic01
                };#nic01
            };#nic01

	    if {$matricola == ""} {
		element::set_error $form_name matricola "Matricola obbligatoria"
		incr error_num
	    }
	    if {$combustibile == ""} {
		element::set_error $form_name combustibile "Combustibile obbligatorio"
		incr error_num
	    }

	    if {$coimtgen(ente)    eq "PFI"} {;##sim30

		if {$tiraggio == ""} {;#sim30
		    element::set_error $form_name tiraggio "Tiraggio obbligatorio"
		    incr error_num
		}

		if {$tipo_a_c  == ""} {;#sim30
		    element::set_error $form_name tipo_a_c "Tipo obbligatorio"
		    incr error_num
		}
	    }

	} else {
	    # serena
	    ns_log notice "SERENA|$flag_mod_gend|$combustibile|$bacharach|"
	    set descr_combustibile [db_string query "select descr_comb from coimcomb where cod_combustibile = :combustibile" -default ""];#--- mis01 estratta descrizione e modificata condizione sotto (origine && $cobustibile=="GASOLIO")
	    if {$flag_mod_gend == "N" && $descr_combustibile eq "GASOLIO"} {
		if {$bacharach eq ""} {
		    element::set_error $form_name bacharach "Campo obbligatorio"
		    incr error_num
		}
	    }
	}
    	
	if {[string equal $pot_focolare_nom ""]} {
	    element::set_error $form_name pot_focolare_nom "Inserire potenza"
	    incr error_num	    
	} else {
	    set pot_focolare_nom [iter_check_num $pot_focolare_nom 2]
	    if {[string equal $pot_focolare_nom "0.00"]} {
		element::set_error $form_name pot_focolare_nom "Deve essere diverso da 0,00"
		incr error_num
	    } elseif {$pot_focolare_nom == "Error"} {
		element::set_error $form_name pot_focolare_nom "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num	    
	    } else {
		set sw_pot_focolare_nom_ok "t"
	    }
	}
        	
	if {![string equal $o2 ""]} {
	    set o2 [iter_check_num $o2 2]
	    if {$o2 == "Error"} {
		element::set_error $form_name o2 "o<sub><small>2</small></sub> deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $o2] >  [expr pow(10,2)]
		    ||  [iter_set_double $o2] < -[expr pow(10,2)]} {
		    element::set_error $form_name o2 "o<sub><small>2</small></sub> deve essere inferiore di 100"
		    incr error_num
		}
	    }
	}
    
	if {![string equal $co2 ""]} {
	    set co2 [iter_check_num $co2 2]
	    if {$co2 == "Error"} {
		element::set_error $form_name co2 "co<sub><small>2</small></sub> deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $co2] >  [expr pow(10,2)]
		    ||  [iter_set_double $co2] < -[expr pow(10,2)]} {
		    element::set_error $form_name co2 "co<sub><small>2</small></sub> deve essere inferiore di 100"
		    incr error_num
		}
	    }
	}
    
	if {![string equal $bacharach ""]} {
	    set bacharach [iter_check_num $bacharach 2]
	    if {$bacharach == "Error"} {
		element::set_error $form_name bacharach "Bacharach deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $bacharach] >=  [expr pow(10,4)]
		    ||  [iter_set_double $bacharach] <= -[expr pow(10,4)]} {
		    element::set_error $form_name bacharach "Bacharach deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}
    
	set flag_co_perc "f"
	if {![string equal $co ""]} {
	    set co [iter_check_num $co 4]
	    if {$co == "Error"} {
		element::set_error $form_name co "co deve essere numerico e pu&ograve; avere al massimo 4 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $co] >=  [expr pow(10,7)]
		    ||  [iter_set_double $co] <= -[expr pow(10,7)]} {
		    element::set_error $form_name co "co deve essere inferiore di 1.000.000"
		    incr error_num
		} else {
		    if {$co < 1} {
			set co [expr $co * 10000]
			set flag_co_perc "t"
		    }
		}
	    }
	}
    	
	if {![string equal $rend_combust ""]} {
	    set rend_combust [iter_check_num $rend_combust 2]
	    if {$rend_combust == "Error"} {
		element::set_error $form_name rend_combust "Rendimento combustibile deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		#if {[iter_set_double $rend_combust] >  [expr pow(10,2)]
		# || [iter_set_double $rend_combust] < -[expr pow(10,2)]} {
		#    element::set_error $form_name rend_combust "Rendimento combustibile deve essere inferiore di 100"
		#    incr error_num
		#}
	    }
	}

	if {![string equal $rct_rend_min_legge ""]} {
	    set rct_rend_min_legge [iter_check_num $rct_rend_min_legge 2]
	    if {$rct_rend_min_legge == "Error"} {
		element::set_error $form_name rct_rend_min_legge "Rend.to combustione minimo di legge deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		#if {[iter_set_double $rct_rend_min_legge] >  [expr pow(10,2)]
		# || [iter_set_double $rct_rend_min_legge] < -[expr pow(10,2)]} {
		#    element::set_error $form_name rct_rend_min_legge "Rend.to combustione minimo di legge deve essere inferiore di 100"
		#    incr error_num
		#}
	    }
	}
        	
	#nic06: Sandro ha deciso di renderla obbligatoria
	#nic06 if {![string equal $potenza ""]}
        if {[string equal $potenza ""]} {
            element::set_error $form_name potenza "Inserire potenza"
            incr error_num
        } else {
            set potenza [iter_check_num $potenza 2]
            if {$potenza == "Error"} {
                element::set_error $form_name potenza "La potenza deve essere numerica e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } elseif {$potenza== "0,00"} {
		element::set_error $form_name potenza "La potenza deve essere maggiore di 0,00"
		incr error_num
	    } elseif {[iter_set_double $potenza] >=  [expr pow(10,7)]
	          ||  [iter_set_double $potenza] <= -[expr pow(10,7)]} {
		element::set_error $form_name potenza "Potenza deve essere inferiore di 10.000.000"
		incr error_num
	    } else {
		#sandro 230513
		if {$sw_pot_focolare_nom_ok eq "t"
                &&  $potenza > $pot_focolare_nom } {
		    element::set_error $form_name potenza "Potenza focolare utile > della nominale"
		    incr error_num
		    set sw_pot_focolare_nom_ok "f"
		}
		# fine sandro 230513
            }
        }

        if {![string equal $data_utile_inter ""]} {
            set data_utile_inter [iter_check_date $data_utile_inter]
            if {$data_utile_inter == 0} {
                element::set_error $form_name data_utile_inter "Data utile intervento deve essere una data"
                incr error_num
            }
        }

        if {![string equal $data_arrivo_ente ""]} {
            set data_arrivo_ente [iter_check_date $data_arrivo_ente]
            if {$data_arrivo_ente == 0} {
                element::set_error $form_name data_arrivo_ente "Data arrivo ente deve essere una data"
                incr error_num
            }
        }

        if {![string equal $data_prot ""]} {
            set data_prot [iter_check_date $data_prot]
            if {$data_prot == 0} {
                element::set_error $form_name data_prot "Data protocollo deve essere una data"
                incr error_num
            }
        } else {
	    if {$data_prot > $current_date} {
		element::set_error $form_name data_prot "Data protocollo deve essere inferiore alla data odierna"
		incr error_num
	    }
	}

	# costo e' obbligatorio se sono stati indicati gli altri estremi
	# del pagamento
	#sim19 aggiunto condizione su esente
	if {$sw_costo_null == "t" && $esente eq "f"} {
	    if {![string equal $tipologia_costo ""] || $flag_pagato == "S"} {
		element::set_error $form_name costo "Inserire il costo"
		incr error_num
	    }
	}

	# tipologia costo e' obbligatoria se sono stati indicati
	# gli altri estremi del pagamento
	if {[string equal $tipologia_costo ""]} {
	    if {$sw_costo_null == "f" || $flag_pagato == "S"} {
		element::set_error $form_name tipologia_costo "Inserire la tipologia del costo"
		incr error_num
	    }
	}
    
	# Sandro, 01/07/2014 per tutti gli enti prima del controllo del bollino calcolo la
	# potenza dell'impianto, per il momento quella nominale.
	# Prima veniva usata la pot_focolare_nom ma non andava bene (segnalazione di UCIT)

	db_1row query "select $nome_col_aimp_potenza as potenza_impianto
                         from coimaimp
                        where cod_impianto = :cod_impianto" 
    
	# se viene indicato il bollino (riferimento pagamento valorizzato e
	# tipologia costo = 'BO').
	set note_todo_boll ""
	if {![string equal $riferimento_pag ""] && $tipologia_costo == "BO"} {
	    # controlli sui bollini disattivati per CPADOVA, PRO, PLI
	    #	    if { ( $flag_ente == "P" && ( $sigla_prov == "RO" || $sigla_prov == "LI")
	    #		|| (   $flag_ente == "C" && $cod_comu == "8761") ) } 
	    # vieto l'inserimento del bollino se il manutentore non e' convenz.
	    if {[db_0or1row sel_manu_flag_convenzionato ""] == 0} {
		set flag_convenzionato ""
	    } 
	    if {$flag_convenzionato == "N"} {
		element::set_error $form_name riferimento_pag "Manutentore non convenzionato all'utilizzo dei bollini"
		incr error_num
	    }
	    
	    # verifico che non esistano altri modelli H con lo stesso bollino
	    # segnalando l'eventuale incongruenza solamente su un TODO
	    # (Savazzi dice che verra' controllato solo per una quadratura dei
	    # pagamenti).
	    if {$funzione == "M"} {
		set where_codice "and cod_dimp <> :cod_dimp"
	    } else {
		set where_codice ""
	    }
	    
	    db_1row sel_dimp_check_riferimento_pag ""
	    if {$count_riferimento_pag > 0} {
		if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO"} {
		    #modifica 080114
		    if {$funzione != "M" && $id_ruolo !=  "admin"} {#08114
			element::set_error $form_name riferimento_pag "Bollino gia' presente in altri allegati"
			incr error_num
		    };#08114
		} elseif {$coimtgen(ente) eq "PLI"} {
		    element::set_error $form_name riferimento_pag "Bollino gi� presente in altri allegati"
		    incr error_num
		} elseif {$coimtgen(ente) eq "PCE"} {#sim06
                    element::set_error $form_name riferimento_pag "Bollino gi� presente in altri allegati";#sim06
                    incr error_num;#sim06
		} else {
		    # Caso standard
		    append note_todo_boll "Il bollino applicato sulla dichiarazione e' gia' stato applicato precedentemente su un'altro modello"
		}
	    }

	    set dbn_ente_collegato "";#nic05
	    if {$coimtgen(ente) eq "PUD"} {#nic05
		set dbn_ente_collegato "iterprgo";#nic05
	    } elseif {$coimtgen(ente) eq "PGO"} {#nic05
		set dbn_ente_collegato "iterprud";#nic05
	    };#nic05
	    if {$dbn_ente_collegato ne ""} {#nic05
		db_1row -dbn $dbn_ente_collegato sel_dimp_check_riferimento_pag "";#nic05
		if {$count_riferimento_pag > 0} {#nic05
		    if {$funzione != "M" && $id_ruolo !=  "admin"} {#nic05
			element::set_error $form_name riferimento_pag "Bollino gia' presente in altri allegati inseriti sull'altro ente";#nic05
			incr error_num;#nic05
		    };#nic05
		};#nic05
	    };#nic05

	    set flag_boll_compreso "f"
	    set flag_boll_pagato "t";#sim04
	    if {$flag_ente == "C" && $coimtgen(denom_comune) == "RIMINI"}  {
		#controllo del sul prefisso
		set anno_boll  [string range $riferimento_pag 0 4]
		if {$tipologia_costo == "BO"
		&& ($anno_boll != "2008/" && $anno_boll != "2009/" && $anno_boll != "2010/" && $anno_boll != "2011/" && $anno_boll != "2012/" && $anno_boll != "2013/"  &&  $anno_boll != "2014/" && $anno_boll != "2015/")
		} {
		    element::set_error $form_name riferimento_pag "Incongruenza Bollino/Tipologia Costo   es. anno/xxxx"
		    incr error_num
		}
		#fine controllo prefisso 

		set bol_nudo [string range $riferimento_pag 5 10]
		set bol_nudo [iter_check_num $bol_nudo 0]
		db_foreach sel_boll_manu "" {
		    set matricola_da [iter_check_num $matricola_da 0]
		    set matricola_a [iter_check_num $matricola_a 0]
		    if {$matricola_da != 0 && $matricola_a != 0 && $bol_nudo != "Error"} {
			if {$matricola_da <= $bol_nudo
			&&  $matricola_a  >= $bol_nudo
			} {
			    set flag_boll_compreso "t"
			}
		    }
		}

		#inizio boap                 
		if {$flag_boll_compreso == "f"} {
		    db_foreach sel_boll_boap "" {
			if {$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag} {
			    # ns_log Notice "coimdimp-g-gest;$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag"
			    set flag_boll_compreso "t"
			}
		    }
		}
		# fine boap

		if {$flag_boll_compreso == "f"} {
		    element::set_error $form_name riferimento_pag "Il bollino applicato sulla Dichiarazione non e' stato rilasciato al manutentore che ha compilato il modulo es. anno/xxxx"
		    incr error_num
		}
	
	    } elseif {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO"} {
		set prosegui "t"
		# se il manutentore non ha bollini, non pu� inserire una dichiarazione
		if {[db_string query "select count(*) from coimboll where cod_manutentore = :cod_manutentore"] == 0} {
		    element::set_error $form_name riferimento_pag "Se non si e' in possesso di bollini, non si puo' inserire alcuna dichiarazione"
		    incr error_num
		    set prosegui "f"
		}

		if {$sw_pot_focolare_nom_ok eq "f"} {
		    set prosegui "f"
		}

		#13.09.2012
		if {$prosegui eq "t" && $potenza_impianto < 35.00} {
		    set riferimento_pag        [string trim $riferimento_pag]
		    set riferimento_pag_prefix [string range $riferimento_pag 0 0]
		    set riferimento_pag_suffix [string range $riferimento_pag 1 end]
		    
		    if {$riferimento_pag_prefix                   ne "G"
		    ||  [string length   $riferimento_pag]        ne 7
		    || ![string is digit $riferimento_pag_suffix]
		    } {
			element::set_error $form_name riferimento_pag "Num.Bollino errato: deve essere nel formato 'G' seguito da 6 cifre"
			incr error_num
			set prosegui "f"
		    }
		
		    if {$prosegui eq "t"} {
			# controllo sull'esistenza o meno di quel Bollino per quella ditta di manutenzione
			    
			# verifico che il numero bollino sia compreso tra le matricole
			# dei blocchetti rilasciati al manutentore indicato
			# (Savazzi dice che verra' controllato solo per una quadratura dei pagamenti).
			    
			set riferimento_pag_num [string trimleft $riferimento_pag_suffix "0"]
			set flag_boll_compreso "f"
			db_foreach sel_boll_manu "" {
			    if {$matricola_da <= $riferimento_pag_num && $matricola_a >= $riferimento_pag_num} {
				#ns_log Notice "coimdimp-g-gest;$matricola_da <= $riferimento_pag_num && $matricola_a >= $riferimento_pag_num"
				set flag_boll_compreso "t"
			    }
			}
			
			#inizio boap                 
			if {$flag_boll_compreso == "f"} {
			    db_foreach sel_boll_boap "" {
				if {$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag} {
				   # ns_log Notice "coimdimp-g-gest;$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag"
				    set flag_boll_compreso "t"
				}
			    }
			}
			# fine boap
			
			if {$flag_boll_compreso == "f"} {
			    #append note_todo_boll "Il bollino applicato sul modello  non e' stato rilasciato al manutentore che ha compilato il modulo Inoltre verificare: deve essere nel formato 'G' seguito da un numero"
			    element::set_error $form_name riferimento_pag "Num.Bollino non rilasciato al manutentore - Inoltre verificare: deve essere nel formato 'G' seguito da 6 cifre"
			    incr error_num
			}

		    }
		}
			
		if {$prosegui eq "t" && $potenza_impianto >= 35.00} {
		    set riferimento_pag        [string trim $riferimento_pag]
		    set riferimento_pag_prefix [string range $riferimento_pag 0 0]
		    if {$riferimento_pag_prefix eq "E"} {
			set riferimento_pag_suffix [string range $riferimento_pag 1 end]
			if {[string length   $riferimento_pag] ne 7
			|| ![string is digit $riferimento_pag_suffix]
			} {
			    element::set_error $form_name riferimento_pag "Num.Bollino errato: deve essere nel formato 'F1', 'F2', 'E' seguito da 6 cifre"
			    incr error_num
			    set prosegui "f"
			}
		    } else {
			set riferimento_pag_prefix [string range $riferimento_pag 0 1]
			set riferimento_pag_suffix [string range $riferimento_pag 2 end]
			if {$riferimento_pag_prefix ni [list "F1" "F2"]
			||  [string length   $riferimento_pag] ne 8
			|| ![string is digit $riferimento_pag_suffix]
			} {
			    element::set_error $form_name riferimento_pag "Num.Bollino errato: deve essere nel formato 'F1', 'F2', 'E' seguito da 6 cifre"
			    incr error_num
			    set prosegui "f"
			}
		    }
		    
		    # 22/07/2013 (Controllo richiesto tramite e-mail di Chiara Paravan di Ucit)
		    if {$prosegui eq "t"} {
			# Mail di Chiara Paravan del 17/07/2014: il controllo va fatto sulla potenza termica nominale al focolare del generatore (come per il modello F) e non sulla potenza_impianto
			if {$pot_focolare_nom < 350.00} {
			    if {[string range $riferimento_pag 0 0] ne "E"
			    &&  [string range $riferimento_pag 0 1] ne "F1"
			    } {
				element::set_error $form_name riferimento_pag "Num.Bollino errato: pu&ograve; iniziare solo per 'F1' o 'E' perch&egrave; la potenza termica nominale al focolare del generatore &egrave; inferiore a 350 kW"
				incr error_num
				set prosegui "f"
			    }
			} else {
			    if {[string range $riferimento_pag 0 0] ne "E"
			    &&  [string range $riferimento_pag 0 1] ne "F2"
			    } {
				element::set_error $form_name riferimento_pag "Num.Bollino errato: pu&ograve; iniziare solo per 'F2' o 'E' perch&egrave; la potenza termica nominale al focolare del generatore &egrave; &gt;= a 350 kW"
				incr error_num
				set prosegui "f"
			    }
			}
		    }
		
		    if {$prosegui eq "t"} {
			# controllo sull'esistenza o meno di quel Bollino per quella ditta di manutenzione
			
			# verifico che il numero bollino sia compreso tra le matricole
			# dei blocchetti rilasciati al manutentore indicato
			# (Savazzi dice che verra' controllato solo per una quadratura dei pagamenti).
			
			set riferimento_pag_num [string trimleft $riferimento_pag_suffix "0"]
			set flag_boll_compreso "f"
			db_foreach sel_boll_manu "" {
			    if {$matricola_da <= $riferimento_pag_num && $matricola_a >= $riferimento_pag_num} {
				ns_log Notice "coimdimp-1b-gest;$matricola_da <= $riferimento_pag_num && $matricola_a >= $riferimento_pag_num"
				set flag_boll_compreso "t"
			    }
			}
				
			#inizio boap                 
			if {$flag_boll_compreso == "f"} {
			    db_foreach sel_boll_boap "" {
				if {$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag} {
				    ns_log Notice "coimdimp-1b-gest;$matr_da <= $riferimento_pag && $matr_a >= $riferimento_pag"
				    set flag_boll_compreso "t"
				}
			    }
			}
			# fine boap

			if {$flag_boll_compreso == "f"} {
			    #append note_todo_boll "Il bollino applicato sul modello non e' stato rilasciato al manutentore che ha compilato il modulo"
			    element::set_error $form_name riferimento_pag "Num.Bollino non rilasciato al manutentore."
			    incr error_num
			}
		    }
		}
		# Fine personalizzazioni per PUD e PGO

	    } elseif {$coimtgen(ente) eq "PCE"} {

		#controllo del 28082013
		# verifico che il bollino sia compreso tra le matricole dei blocchetti
		set bol_nudo [string range $riferimento_pag 5 9]
		#set bol_nudo  "lpad(bol_nudo, 5, '0')"
		set bol_nudo [iter_check_num $bol_nudo 0]
		ns_log Notice "coimdimp-1b-gest;bol_nudo:$bol_nudo"
		set flag_boll_compreso "f"
		db_foreach sel_boll_manu "" {
		    set matricola_da [iter_check_num $matricola_da 0]
		    set matricola_a  [iter_check_num $matricola_a 0]
		    #set riferimento_pag [iter_check_num [string range $riferimento_pag 6 5] 0]
		    if {$matricola_da != 0 && $matricola_a != 0 && $bol_nudo != "Error"} {
			if {$matricola_da <= $bol_nudo
			&&  $matricola_a  >= $bol_nudo
			} {
			    set flag_boll_compreso "t"
			}
		    }
		}
		if {$flag_boll_compreso == "f"} {
		    #append note_todo_boll "Il bollino applicato sul modello  non e' stato rilasciato al manutentore che ha compilato il modulo"
		    element::set_error $form_name riferimento_pag "Il Bollino non e' stato rilasciato al manutentore che ha compilato il modulo"
		    incr error_num
		}
		
		#controllo del 28082013
		set anno_boll  [string range $riferimento_pag 0 3]
		if {$tipologia_costo != "BO"
		&&  $anno_boll == "2013"
		} {
		    element::set_error $form_name riferimento_pag "Incongruenza Bollino/Tipologia Costo"
		    incr error_num
		}
		#fine controllo del 28082013
	
		#controllo del 29082013
		if {$tipologia_costo == "BO" 
		&&  $anno_boll != "2013" 
		} {
		    element::set_error $form_name riferimento_pag "Incongruenza Bollino/Tipologia Costo Deve essere 2013/nnnnn"
		    incr error_num
		}
		#fine controllo del 29082013


		#fine caso PCE (Provincia di Caserta)

	    } elseif {$coimtgen(ente) eq "PPU"} {
		#sandro controlli prpu
		
		# verifico che il bollino sia compreso tra le matricole dei blocchetti
		set bol_nudo [string range $riferimento_pag 0 5]
		#set bol_nudo  "lpad(bol_nudo, 6, '0')"
		set bol_nudo [iter_check_num $bol_nudo 0]
		ns_log Notice "coimdimp-1b-gest;bol_nudo:$riferimento_pag - $bol_nudo"
		set flag_boll_compreso "f"
		db_foreach sel_boll_manu "" {
		    set matricola_da [iter_check_num $matricola_da 0]
		    set matricola_a  [iter_check_num $matricola_a 0]
		    if {$matricola_da != 0 && $matricola_a != 0 && $bol_nudo != "Error"} {
			if {$matricola_da <= $bol_nudo
			&&  $matricola_a  >= $bol_nudo
			} {
			    set flag_boll_compreso "t"
			}
		    }
		}
		if {$flag_boll_compreso == "f"} {
		    #append note_todo_boll "Il bollino applicato sul modello  non e' stato rilasciato al manutentore che ha compilato il modulo"
		    element::set_error $form_name riferimento_pag "Il Bollino non e' stato rilasciato al manutentore che ha compilato il modulo/Il bollino deve essere scritto nella forma XXXXXX, Inoltre piu' bollini devo essere separati da ;"
		    incr error_num
		}
		#sandro fine controlli prpu

	    } elseif {$coimtgen(ente) eq "CPESARO"} {#sim07 aggiunta if e suo contenuto

		set bol_nudo [string range $riferimento_pag 5 15]
		set bol_nudo [iter_check_num $bol_nudo 0]
		set flag_boll_compreso "f"
                db_foreach sel_boll_manu "" {
                    set matricola_da [iter_check_num $matricola_da 0]
                    set matricola_a  [iter_check_num $matricola_a 0]
                    set matricola_da [db_string query "select lpad(:matricola_da,6,0)"]
                    set matricola_a  [db_string query "select lpad(:matricola_a,6,0)"]
                    if {$matricola_da != 0 && $matricola_a != 0 && $bol_nudo != "Error"} {
                        if {$matricola_da <= $bol_nudo
                        &&  $matricola_a  >= $bol_nudo
                        } {
			    
                            set flag_boll_compreso "t"
                        }
                    }
                }
		if {$flag_boll_compreso == "f"} {
		    append note_todo_boll "Il bollino applicato sulla Dichiarazione non e' stato rilasciato al manutentore che ha compilato il modulo"
		}

	    } else {
		# Caso standard
		ns_log Notice "coimdimp-1b-gest;dentro;cod_manutentore:$cod_manutentore;flag_boll_compreso:$flag_boll_compreso"
		db_foreach sel_boll_manu "" {
		    if {$matricola_da <= $riferimento_pag
		    &&  $matricola_a  >= $riferimento_pag
		    } {
			ns_log Notice "coimdimp-1b-gest;matricola_da=$matricola_da<=riferimento_pag:$riferimento_pag;matricola_a:$matricola_a>=riferimento_pag:$riferimento_pag"
			set flag_boll_compreso "t"

			if {$pagati eq "N"} {#Aggiunta sim04 if e suo contenuto
			    set flag_boll_pagato "f"
			}		

		    }
		}

		if {$flag_boll_compreso == "f"} {
		    if {$coimtgen(ente) eq "PLI"} {
			element::set_error $form_name riferimento_pag "Il bollino non e' stato rilasciato al manutentore che ha compilato il modulo"
			incr error_num
		    } else {
			# Caso standard
			append note_todo_boll "Il bollino applicato sulla Dichiarazione non e' stato rilasciato al manutentore che ha compilato il modulo"
		    }
		}
	    }

	    if {$coimtgen(ente) eq "PLI" && $flag_boll_pagato eq "f" } {#sim04 if e suo contenuto
		element::set_error $form_name riferimento_pag "Bollino non pagato"
		incr error_num
	    }
	    
	}

    	if {![string equal $data_scad_pagamento ""]} {
	    set data_scad_pagamento [iter_check_date $data_scad_pagamento]
	    if {$data_scad_pagamento == 0} {
		element::set_error $form_name data_scad_pagamento "Data scadenza pagamento deve essere una data"
		incr error_num
	    }
	} else {
	    # se non e' stata compilata la data scadenza pagamento
	    # ed esistono gli altri estremi del pagamento
	    # devo calcolarla in automatico:
	    # se il pagamento e' effettuato,               con data controllo
	    # se il pagamento e' avvenuto tramite bollino, con data controllo
	    # negli altri casi con data controllo + gg_scad_pag_mh
	    # che e' un parametro di procedura.
	    if {![string equal $tipologia_costo ""] || $sw_costo_null == "f" || $flag_pagato   == "S"} {
		if {$tipologia_costo == "BO" || $flag_pagato == "S" || [string equal $gg_scad_pag_mh ""]} {
		    # se data_controllo non e' corretta, viene gia' segnalato
		    # l'errore sulla data_controllo.
		    if {$sw_data_controllo_ok == "t"} {
			set data_scad_pagamento $data_controllo
		    }
		} else {
		    # se data_controllo non e' corretta, viene gia' segnalato
		    # l'errore sulla data_controllo.
		    if {$sw_data_controllo_ok == "t"} {
			set data_scad_pagamento [clock format [clock scan "$gg_scad_pag_mh day" -base [clock scan $data_controllo]] -f "%Y%m%d"]
		    }
		}
	    }
	}

	if {![string equal $data_prox_manut ""]} {#san04: aggiunta if ed il suo contenuto
            set data_prox_manut [iter_check_date $data_prox_manut]
            if {$data_prox_manut == 0} {
                element::set_error $form_name data_prox_manut "Data prossima manutenzione deve essere una data"
                incr error_num
            } else {
		if {$sw_data_controllo_ok eq "t" && $data_prox_manut < $data_controllo} {
		    element::set_error $form_name data_prox_manut "Data prossima manutenzione deve essere superiore alla data controllo"
		    incr error_num
		}
	    }
        }

	if {$coimtgen(ente) ne "PFI"} {;#sim31

	    eval $controllo_tariffa;#sim08
	    set costo [iter_check_num $tariffa 2]
	    element set_properties $form_name costo -value $tariffa;#sim08

	}

	# Le seguenti istruzioni che servono per calcolare la data_scadenza_autocert devono
	# essere identiche a quelle della proc iter_cari_rcee_tipo_1 definita nel sorgente
	# tcl/batch/iter-cari-rcee-tipo-1-procs.tcl.
	# Quando si modifica un sorgente, va modificato anche l'altro.
        # SF 271114 modificato Barletta e messa come udine
        if {$coimtgen(ente) eq "CRIMINI"}  {
	    
	    if {[string equal $data_scadenza_autocert ""]} {
		set data_8 "[expr [string range $data_controllo 0 3] - 4][string range $data_controllo 4 5][string range $data_controllo 6 7]"

		if {$flag_pagato eq "N"} {
		    set data_scadenza_autocert [string range $data_controllo 0 3]
		} elseif {$pot_focolare_nom >= 35 || $combustibile eq "1" || $combustibile eq "3"} {
		    set data_scadenza_autocert [expr [string range $data_controllo 0 3] + 1]
		} elseif {$data_insta < $data_8} {
		    set data_scadenza_autocert [expr [string range $data_controllo 0 3] + 2]
		} elseif {$tipo_a_c eq "C"} {
		    set data_scadenza_autocert [expr [string range $data_controllo 0 3] + 4]
		} elseif {$locale eq "I"} {
		    set data_scadenza_autocert [expr [string range $data_controllo 0 3] + 2]
		} else {
		    set data_scadenza_autocert [expr [string range $data_controllo 0 3] + 4]
		}
		set data_scadenza_autocert "$data_scadenza_autocert[string range $data_controllo 4 7]"

		if {[string range $data_scadenza_autocert 4 7] == "0229"} {
		    set data_scadenza_autocert [string range $data_scadenza_autocert 0 3]
		    append data_scadenza_autocert "0228"
		}
	    } else {
                set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
                if {$data_scadenza_autocert == 0} {
                    element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
                    incr error_num
                }
	    }

	} elseif {$coimtgen(ente) eq "PTA"} {#sim15: aggiunta if e suo contenuto

	    if {$potenza_impianto < 35.00} {;#2 anni
		set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
	    } else {;#1 anno
		set data_scadenza_autocert [db_string query "select :data_controllo::date + 365" -default ""]
	    }
	} elseif {$coimtgen(regione) eq "MARCHE" || $coimtgen(ente) eq "PBT"} {#sim02  #sim22: Aggiunto || per BAT
	    
	    if {$potenza_impianto < 100.00 } {
		
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			
			#se combustibile gpl o metano 4 anni
			if {$combustibile eq "4" || $combustibile eq "5"} {
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 1460" -default ""]
   			} else {;#per gli altri 2
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
			}
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
		
	    }
	    
	    if {$potenza_impianto >= 100.00} {
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			
			#se combustibile gpl o metano 2 anni
			if {$combustibile eq "4" || $combustibile eq "5"} {
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
			} else {;#per gli altri 1 solo
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 365" -default ""]
			}
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
	    }
	    #fine sim02

        } elseif {$coimtgen(regione) eq "TOSCANA"} {#sim28

	    if {[string equal $data_scadenza_autocert ""]} {
		if {$sw_data_controllo_ok == "t" && $flag_errore_data_controllo eq "f" } {

		    set dt_controllo [clock format [clock scan "$data_controllo - 4 years"] -format "%Y%m%d"]

		    set data_insta_controllo $data_insta

		    #sim34 se metano o gpl e ha meno di 4 anni
		    if {$combustibile eq "4" || $combustibile eq "5"} {#sim34
			
			if {$potenza_impianto <= 100} {#se potenza minore di 100
			    
			    #primo controllo ha scadenza 4 anni
			    if {$dt_controllo <= $data_insta_controllo} {			    		    
				set anno_scad [expr [string range $data_controllo 0 3] + 4]
			    } else {#dopo il primo sempre 2 anni
				set anno_scad [expr [string range $data_controllo 0 3] + 2]
			    }
			    
			} else {#se potenza maggiore di 100
			    
			    #sempre 2 anni
			    set anno_scad [expr [string range $data_controllo 0 3] + 2]
			    
			}

		    } else {#tutti quelli tranne metano e gpl
			
			if {$potenza_impianto <= 100} {#se potenza minore di 100
			    
			    #2 anni
			    set anno_scad [expr [string range $data_controllo 0 3] + 2]
			    
			} else {#se potenza maggiore di 100
			    
			    #1 anno
			    set anno_scad [expr [string range $data_controllo 0 3] + 1]
			    
			}
		    }

		    #la scadenza va sempre al 31/12 dell'anno 
		    append anno_scad "1231"
		    set data_scadenza_autocert $anno_scad
		    
		}
	    } else {
		set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		if {$data_scadenza_autocert == 0} {
                        element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
                        incr error_num
		}
	    }
	    

	} elseif {$coimtgen(regione) eq "CALABRIA"} {#sim10

	    if {$potenza_impianto < 100.00 } {
		
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			
			#se combustibile gpl o metano 
			if {$combustibile eq "4" || $combustibile eq "5"} {

			    #se l'impianto e' "giovane", scade tra 4 anni
			    if {$flag_impianto_vecchio ne "1"} {
				set data_scadenza_autocert [db_string query "select :data_controllo::date + 1460" -default ""]
			    } else {;#altrimenti sono 2 anni
				set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
			    }

   			} else {;#per gli altri 2
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
			}
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
		
	    }
	    
	    if {$potenza_impianto >= 100.00} {
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			
			#se combustibile gpl o metano 2 anni
			if {$combustibile eq "4" || $combustibile eq "5"} {
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
			} else {;#per gli altri 1 solo
			    set data_scadenza_autocert [db_string query "select :data_controllo::date + 365" -default ""]
			}
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
	    }
	    
	    #fine sim10

	} elseif {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO" || $coimtgen(ente) eq "CBARLETTA"} {

	    if {$pot_focolare_nom < 35.00 } {
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			set data_scadenza_autocert [db_string query "select :data_controllo::date + 1460" -default ""]
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
	    }
	    
	    if {$pot_focolare_nom >= 35.00 && $pot_focolare_nom < 100.00} {
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
	    }
	    
	    if {$pot_focolare_nom >= 100.00} {
		if {[string equal $data_scadenza_autocert ""]} {
		    if {$sw_data_controllo_ok == "t"} {
			set data_scadenza_autocert [db_string query "select :data_controllo::date + 730" -default ""]
		    }
		} else {
		    set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		    if {$data_scadenza_autocert == 0} {
			element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
			incr error_num
		    }
		}
	    }
	    # Fine caso PUD e PGO e CBARLETTA

        } elseif {$coimtgen(ente) eq "PCE"} {
            # Provincia di Caserta (usa anche il flag valid_mod_h_b al 04/08/2014)

            if {[string equal $data_scadenza_autocert ""]} {
                if {$sw_data_controllo_ok   == "t"
                &&  $sw_pot_focolare_nom_ok == "t"
                } {
                    if {$pot_focolare_nom < 35.00} {
                        db_1row query "select to_char(add_months(to_date(:data_controllo,'YYYYMMDD')
                                                                ,$coimtgen(valid_mod_h))
                                                     ,'YYYYMMDD') as data_scadenza_autocert
                                         from dual"
                    } else {
                        db_1row query "select to_char(add_months(to_date(:data_controllo,'YYYYMMDD')
                                                                ,$coimtgen(valid_mod_h_b))
                                                     ,'YYYYMMDD') as data_scadenza_autocert
                                         from dual"
                    }
                }
            } else {
                set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
                if {$data_scadenza_autocert == 0} {
                    element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
                    incr error_num
                }
            }
            # Fine caso provincia di Caserta

	} elseif {$coimtgen(ente) eq "PMS" && $err_insta == 0} {#sim17 Massa

	    if {$sw_data_controllo_ok == "t"} {
		set data_insta_controllo [db_string q "select coalesce(:data_insta_contr::date,'1900-01-01')"]
		set oggi         [iter_set_sysdate]
		set dt_controllo [clock format [clock scan "$oggi - 8 years"] -format "%Y%m%d"]
		
		if {$data_insta_controllo < $dt_controllo} {
		    set flag_impianto_vecchio 1
		} else {
		    set flag_impianto_vecchio 0
		}
		
		if {$potenza_impianto < 100.00 && $flag_impianto_vecchio==0 && $locale eq "E"} {;#4 anni
		    set data_scadenza_autocert [db_string query "select :data_controllo::date + interval '4 year'" -default ""]
		} else {;#2 anno
		    set data_scadenza_autocert [db_string query "select :data_controllo::date + interval '2 year'" -default ""]
		}
	    }

	} else {
	    # Caso standard
 
	    if {[string equal $data_scadenza_autocert ""]} {
		if {$sw_data_controllo_ok == "t"} {
		    #27/06/2014 D'accordo con Sandro, usiamo il parametro gia' esistente
		    #coimtgen(valid_mod_h): Validit� allegati (mesi)
		    #27/06/2014 set data_scadenza_autocert [db_string query "select :data_controllo::date + 775" -default ""]
		    db_1row query "select to_char(add_months(to_date(:data_controllo,'YYYYMMDD')
                                                            ,$coimtgen(valid_mod_h))
                                                 ,'YYYYMMDD') as data_scadenza_autocert
                                     from dual";#27062014
		}
	    } else {
		set data_scadenza_autocert [iter_check_date $data_scadenza_autocert]
		if {$data_scadenza_autocert == 0} {
		    element::set_error $form_name data_scadenza_autocert "Inserire correttamente"
		    incr error_num
		}
	    }
	}
	# Fine istruzioni che devono essere identiche a quelli di iter_cari_rcee_tipo_1


	if {[string equal $ora_inizio ""]} {
	    element::set_error $form_name ora_inizio "Inserire ora di arrivo"
	    incr error_num
	} else {
	    set ora_inizio [iter_check_time $ora_inizio]
	    if {$ora_inizio == 0} {
		element::set_error $form_name ora_inizio "Ora non corretta, deve essere hh:mm"
		incr error_num
	    }
	}
	if {[string equal $ora_fine ""]} {
	    element::set_error $form_name ora_fine "Inserire ora di partenza"
	    incr error_num
	} else {
	    set ora_fine [iter_check_time $ora_fine]
	    if {$ora_fine == 0} {
		element::set_error $form_name ora_fine "Ora non corretta, deve essere hh:mm"
		incr error_num
	    }
	}


	if {![string equal $tiraggio_fumi ""]} {
            set tiraggio_fumi [iter_check_num $tiraggio_fumi 2]
            if {$tiraggio_fumi == "Error"} {
                element::set_error $form_name tiraggio_fumi "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $tiraggio_fumi] >=  [expr pow(10,7)]
		    ||  [iter_set_double $tiraggio_fumi] <= -[expr pow(10,7)]} {
                    element::set_error $form_name tiraggio_fumi "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }


	set sw_movi     "f"
	set data_pag    ""
	set importo_pag ""
	if {$sw_costo_null == "f" && ![string equal $tipologia_costo ""]} {
	    set sw_movi "t"
	    if {$flag_pagato == "S"} {
		set data_pag    $data_scad_pagamento
		set importo_pag $costo
	    }
	}

	set conta 0
	# controllo sui dati delle anomalie
	while {$conta < 5} {
	    incr conta
	    if {![string equal $data_ut_int($conta) ""]} {
		set data_ut_int($conta) [iter_check_date $data_ut_int($conta)]
		if {$data_ut_int($conta) == 0} {
		    element::set_error $form_name data_ut_int.$conta "Data non corretta"
		    incr error_num
		} else {
		    if {$data_controllo > $data_ut_int($conta)} {
			element::set_error $form_name data_ut_int.$conta "Data precedente al controllo"
			incr error_num
		    }
		}
		if {[string equal $cod_anom($conta) ""]} {
		    element::set_error $form_name cod_anom.$conta "Inserire anche anomalia oltre alla data utile intervento"
		    incr error_num
		}
	    }
	    
	    if {![string equal $cod_anom($conta) ""]} {
		set sw_dup "f"
		set conta2 $conta
		while {$conta2 > 1 && $sw_dup == "f"} {
		    incr conta2 -1
		    if {$cod_anom($conta) == $cod_anom($conta2)} {
			element::set_error $form_name cod_anom.$conta "Anomalia gi&agrave; presente"
			incr error_num
			set sw_dup "t"
		    }
		}

		set cod_anom_db  $cod_anom($conta)
		set prog_anom_db $prog_anom($conta)
		if {$sw_dup == "f"
		    &&  [db_string sel_anom_count ""] >= 1
		} {
		    element::set_error $form_name cod_anom.$conta "Anomalia gi&agrave; presente"
		    incr error_num
		}
	    }
	}
	
	db_1row sel_tgen_canne "select flag_obbligo_canne from coimtgen"
	if {$flag_obbligo_canne == "S"} {
	    if {$scar_ca_si == "S"
		&& $scar_parete == "S"} {
		element::set_error $form_name scar_ca_si "Solo una delle tre opzioni pu&ograve; essere Si"
		incr error_num
	    } else {
		if {$scar_ca_si == "S"
		    && $scar_can_fu == "S"} {
		    element::set_error $form_name scar_ca_si "Solo una delle tre opzioni pu&ograve; essere Si"
		    incr error_num
		} else {
		    if {$scar_parete == "S"
			&& $scar_can_fu == "S"} {
			element::set_error $form_name scar_parete "Solo una delle tre opzioni pu&ograve; essere Si"
			incr error_num
		    }
		}
	    } 
	}
    }

    #21/10/2014 Sandro
    if {$coimtgen(ente) eq "CRIMINI"}  {
	if {$funzione eq "I"} {
	    db_1row query "
            select pdr, pod, foglio, mappale, subalterno
              from coimaimp
             where cod_impianto = :cod_impianto"

	    if {[string is space $pdr]
	    ||  [string is space $pod]
	    ||  [string is space $foglio]
	    ||  [string is space $mappale]
	    ||  [string is space $subalterno]
	    } {
		#nic20141217 Nicola 17/12/2014: devo propagare su Rimini ma Sandro ha detto di
		#nic20141217 commentare la sua modifica

                #nic20141217 element::set_error $form_name num_autocert "Inserire PDR e POD in Ditte/Tecnici  e i Dati Catastali in Ubicazione"
		#nic20141217 incr error_num
	    }
	}
    }
      if {$coimtgen(ente) eq "PFI"} {#san03: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160428"} {
	    db_1row query "
             select locale
               from coimgend
              where cod_impianto = :cod_impianto
              and flag_attivo = 'S' limit 1"

	    if {[string is space $locale]
	       } {
		element::set_error $form_name num_autocert "Inserire TIPO LOCALE su GENERATORE- Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }
    #21/10/2014 Sandro-Fine modifica

    if {$coimtgen(ente) eq "PLI"} {#san03: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile == "3"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $pdr]
	    ||  [string is space $pod]
	    } {
		element::set_error $form_name num_autocert "Inserire PDR e POD in Ditte/Tecnici - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }

    if {$coimtgen(ente) eq "PLI"} {#san03: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile ne "3"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $pod]} {
		element::set_error $form_name num_autocert "Inserire POD in Ditte/Tecnici - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }

    if {$coimtgen(regione) eq "CALABRIA"} {#sim20: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile == "5"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $pdr]
	    ||  [string is space $pod]
	    } {
		element::set_error $form_name num_autocert "Inserire PDR e POD in Ditte/Tecnici - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }

    if {$coimtgen(regione) eq "CALABRIA"} {#sim20: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile ne "5"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $pod]} {
		element::set_error $form_name num_autocert "Inserire POD in Ditte/Tecnici - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }


    if {$coimtgen(ente) eq "PTA"} {#san05: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile == "3"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
          --sim16 , cod_intestatario
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $cod_int_contr]} {#sim16: aggiunta if e suo contenuto
                element::set_error $form_name cognome_contr "Inserire Intestatario Contratto"
		incr error_num
            }

	    #sim16 tolto             ||  [string is space $cod_intestatario]
	    if {[string is space $pdr]
	    ||  [string is space $pod]
	    } {
		element::set_error $form_name num_autocert "Inserire PDR e POD in Ditte/Tecnici, Intestatario in Soggetti - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }

    if {$coimtgen(ente) eq "PTA"} {#san05: aggiunta if e suo contenuto
	if {$funzione eq "I" && $data_controllo >= "20160101" && $combustibile ne "3"} {
	    db_1row query "
             select pdr, pod, foglio, mappale, subalterno
          --sim16 , cod_intestatario
               from coimaimp
              where cod_impianto = :cod_impianto"

	    if {[string is space $cod_int_contr]} {#sim16: aggiunta if e suo contenuto
		element::set_error $form_name cognome_contr "Inserire Intestatario Contratto"
		incr error_num
	    }

	    #sim16 tolto             ||  [string is space $cod_intestatario]
	    if {[string is space $pod]
               } {
		element::set_error $form_name num_autocert "Inserire POD in Ditte/Tecnici - Si puo' aprire una Nuova finestra senza uscire dal programma"
		incr error_num
	    }
	}
    }
    
    if {![db_0or1row query "
        select patentino 
          from coimmanu 
         where cod_manutentore = :cod_manutentore"]
    } {#sim09:aggiunta if e suo contenuto
	set patentino "f"
    }

    #sim33 aggiunto if su funzione
    if {$funzione eq "I" && $potenza_impianto > 232 && $patentino eq "f"} {#sim09: aggiunta if e suo contenuto
	element::set_error $form_name $error_nome_col_potenza "Manutentore non fornito di patentino. Impossibile inserire impianti con potenza maggiore di 232 kW"
	incr error_num
    }

    if {$id_tplg ne "9" && $note_tplg_altro ne ""} {
	 element::set_error $form_name note_tplg_altro "Scrivere la nota solo se � stata selezionata la tipologia altro"
         incr error_num
    }
    if {$id_tplg eq "9" && $note_tplg_altro eq ""} {
         element::set_error $form_name note_tplg_altro "E' obbligatorio specificare il campo note se � stata selezionata la tipologia altro"
         incr error_num
    }

    if {$error_num > 0} {
	if {$flag_errore_data_controllo == "f"} {
	    element::set_error $form_name data_controllo "ATTENZIONE sono presenti degli errori nella pagina"
	}
	ad_return_template
	return
    } else {
	
	if {$flag_portafoglio == "T"
	    && $funzione == "I"
	    && $data_controllo >= "20080801"
	    && $importo_tariffa >= "0.00"
	} {
	    set cod_manu [iter_check_uten_manu $id_utente]
	    if {[string range $id_utente 0 1] == "AM"} {
		set cod_manu $id_utente
	    }
	    if {![string equal $cod_manu ""]} {
		set url "lotto/balance?iter_code=$cod_manu"
	    } else {
		set url "lotto/balance?iter_code=$cod_manutentore"
	    }
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    #ns_return 200 text/html "$result(page) $cod_manu"
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    if {$risultato == "OK"} {
		set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
		set saldo [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
		set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
	    } else {
		set saldo ""
		set conto_manu ""
	    }

	    if {[string equal $saldo ""]} {

		element::set_error $form_name data_controllo "ATTENZIONE transazione non avvenuta correttamente "
		ad_return_template
		return
	    }

	    set tot_importo_wallet [expr $costo + $importo_tariffa]

	    if {[expr [iter_check_num $saldo 2] + 0] >= $tot_importo_wallet} {
		set oggi [db_string sel_date "select current_date"]
		db_1row sel_dual_cod_dimp ""
		set database [db_get_database]
		set reference "$cod_dimp+$database"

		set costo_wallet $costo
		set importo_tariffa_wallet $importo_tariffa

		if {![string equal $cod_manu ""]} {
		    set url "lotto/itermove?iter_code=$cod_manu&body_id=1&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$costo_wallet"
		    set url_regione "lotto/itermove?iter_code=$cod_manu&body_id=3&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$importo_tariffa_wallet"
		} else {
		    set url "lotto/itermove?iter_code=$cod_manutentore&body_id=1&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$costo_wallet"
		    set url_reg "lotto/itermove?iter_code=$cod_manutentore&body_id=3&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$importo_tariffa_wallet"
		}
		set data [iter_httpget_wallet $url]
		array set result $data
		#		ns_return 200 text/html "$result(page)"; return
		set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
		if {$risultato == "OK"} {
		    set transaz_eff "T"
		} else {
		    element::set_error $form_name data_controllo "ATTENZIONE transazione non avvenuta correttamente"
		    ad_return_template
		    return
		}

		#se presente tariffa regionale carico anche il suo movimento
		if {$importo_tariffa_wallet > 0} {
		    set data [iter_httpget_wallet $url_reg]
		    array set result $data
		    #		ns_return 200 text/html "$result(page)"; return
		    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
		    if {$risultato == "OK"} {
			set transaz_eff "T"
		    } else {
			element::set_error $form_name data_controllo "ATTENZIONE transazione non avvenuta correttamente"
			ad_return_template
			return
		    }
		}

	    } else {
		element::set_error $form_name data_controllo "ATTENZIONE il saldo del manutentore non &egrave; sufficente"
		ad_return_template
		return
	    }
	} else {
	    if {$funzione == "I"} {
		db_1row sel_dual_cod_dimp ""
	    }
	}
    }

    if {$funzione != "V"} {
	# leggo i soggetti, la potenza e data prima dich dell'impianto
	# che servono in preparazione inserimento, modifica e cancellazione
	if {[db_0or1row sel_aimp_old ""] == 0} {
	    iter_return_complaint "Impianto non trovato"
	}
    }

    if {$coimtgen(flag_potenza) eq "pot_utile_nom"} {#nic06
	set potenza_chk $potenza;#nic06
    } else {#nic06
	set potenza_chk $pot_focolare_nom
    };#nic06
    
    if {$funzione == "I" || $funzione == "M"} {
	# controllo se esiste un modello H con data piu' recente, in questo caso non vado ad eseguire gli aggiornamenti
	if {[db_0or1row check_modh_old ""] == 0} {
	    set data_ultimo_modh "19000101"
	}
	# Preparo i default per le note da segnalare sui todo
	set note_todo          ""
	set flag_evasione_todo "E"
	set data_controllo_db [string range $data_controllo 0 3]
	append data_controllo_db [string range $data_controllo 5 6]
	append data_controllo_db [string range $data_controllo 8 9]
	if {$data_controllo >= $data_ultimo_modh} {
	    # La potenza va confrontata con quella dell'impianto:
	    # se quella dell'impianto e' non nota, quella del modello h sovrascrive
	    # quella dell'impianto. L'aggiornamento viene registrato nel todo.
	    # se quella dell'impianto e' nota, la differenza viene segnalata todo.

	    # I soggetti del modello h vanno confrontati con quelli dell'impianto:
	    # se vi sono differenze, a seconda del parametro flag_agg_sogg,
	    # essi vanno a sovrascrivere quelli dell'impianto e l'aggiornamento
	    # viene registrato.
	    # Se il parametro flag_agg_sogg = "N" allora la differenza viene
	    # solo segnalata nel todo.

	    # preparo variabili editate e descrizione da utilizzare nei todo
	    if {[string is space $cod_manutentore]} {
		set desc_manu     "NON NOTO"
	    } else {
		set desc_manu     "$cognome_manu $nome_manu"
	    }
	    if {[string is space $cod_manutentore_old]} {
		set desc_manu_old "NON NOTO"
	    } else {
		set desc_manu_old "$cognome_manu_old $nome_manu_old"
	    }

	    if {[string is space $cod_responsabile]} {
		set desc_resp     "NON NOTO"
	    } else {
		set desc_resp     "$cognome_resp $nome_resp"
	    }
	    if {[string is space $cod_responsabile_old]} {
		set desc_resp_old "NON NOTO"
	    } else {
		set desc_resp_old "$cognome_resp_old $nome_resp_old"
	    }

	    if {[string is space $cod_occupante]} {
		set desc_occu     "NON NOTO"
	    } else {
		set desc_occu     "$cognome_occu $nome_occu"
	    }
	    if {[string is space $cod_occupante_old]} {
		set desc_occu_old "NON NOTO"
	    } else {
		set desc_occu_old "$cognome_occu_old $nome_occu_old"
	    }

	    if {[string is space $cod_proprietario]} {
		set desc_prop     "NON NOTO"
	    } else {
		set desc_prop     "$cognome_prop $nome_prop"
	    }
	    if {[string is space $cod_proprietario_old]} {
		set desc_prop_old "NON NOTO"
	    } else {
		set desc_prop_old "$cognome_prop_old $nome_prop_old"
	    }

	    if {[string is space $cod_int_contr]} {
		set desc_contr     "NON NOTO"
	    } else {
		set desc_contr     "$cognome_contr $nome_contr"
	    }
	    if {[string is space $cod_int_contr_old]} {
		set desc_contr_old "NON NOTO"
	    } else {
		set desc_contr_old "$cognome_contr_old $nome_contr_old"
	    }
	    

	    # inizio della fase di confronto dati modello h ed impianto
	    
	    set potenza_edit     [iter_edit_num $potenza_chk 2]

	    #potenza_old viene letta in modo dinamico con $nome_col_aimp_potenza
	    set potenza_old_edit [iter_edit_num $potenza_old 2]

	    #nic06 if {$potenza > 0}
	    if {$potenza_chk > 0} {#nic06
		# potenza dell'impianto non nota e del modello h valorizzata
		if {$potenza_old == 0 || [string equal $potenza_old ""]} {
		    if {[db_0or1row sel_pote_fascia ""] == 0} {
			set cod_potenza ""
		    }
		    
		    set dml_aimp_pote [db_map upd_aimp_pote]
		    append note_todo "Potenza dell'impianto aggiornata da NON NOTA a $potenza_edit kW \n"

		    db_1row sel_gend_count ""
		    if {$conta_gend == 1} {
			set dml_gend_pote [db_map upd_gend_pote]
		    }
		} else {
		    # potenza dell'impianto nota e del modello h valorizzata
		    if {$potenza != $potenza_old} {
			# segnalo solamente la differenza sul todo
			append note_todo "Potenza dell'impianto ($potenza_old_edit kW) diversa dalla potenza dell'RCEE di tipo 1 ($potenza_edit kW) \n"
		    }
		}
	    }

	    # se e' cambiato almeno un soggetto:

	    if {$cod_manutentore  != $cod_manutentore_old
		|| $cod_responsabile != $cod_responsabile_old
		|| $cod_occupante    != $cod_occupante_old
		|| $cod_proprietario != $cod_proprietario_old
		|| $cod_int_contr    != $cod_int_contr_old
	    } {
		# evito di cancellare il responsabile dell'impianto.
		if {[string equal $cod_responsabile ""]} {
		    set cod_responsabile_new $cod_responsabile_old
		} else {
		    set cod_responsabile_new $cod_responsabile
		}

		# se e' cambiato anche solo un soggetto, i soggetti del modello
		# h sovrascrivono quelli dell'impianto.
		if {$flag_agg_sogg == "T"} {
		    # valorizzo il nuovo flag_resp
		    if {      $cod_responsabile_new == $cod_occupante} {
			set flag_resp "O"
		    } elseif {$cod_responsabile_new == $cod_proprietario} {
			set flag_resp "P"
		    } elseif {$cod_responsabile_new == $cod_amministratore_old} {
			set flag_resp "A"
		    } elseif {$cod_responsabile_new == $cod_intestatario_old} {
			set flag_resp "I"
		    } else {
			set flag_resp "T"
		    }

		    set dml_upd_aimp_sogg [db_map upd_aimp_sogg]
		}

		# scrivo le note nel todo ed inserisco lo storico.
		if {$cod_manutentore != $cod_manutentore_old} {
		    if {$flag_agg_sogg == "T"} {
			append note_todo "Manutentore dell'impianto aggiornato da $desc_manu_old a $desc_manu \n"
			# memorizzo il vecchio manutentore nello storico
			set ruolo "M"
			if {![string equal $cod_manutentore_old ""]
			    &&   [db_0or1row sel_rife_check ""] == 0
			} {
			    set dml_ins_rife_manu [db_map ins_rife]
			}
		    } else {
			append note_todo "Manutentore dell'impianto ($desc_manu_old) diverso dal manutentore del modello H ($desc_manu) \n"
		    }
		}

		if {$cod_responsabile_new != $cod_responsabile_old} {
		    if {$flag_agg_sogg == "T"} {
			append note_todo "Responsabile dell'impianto aggiornato da $desc_resp_old a $desc_resp \n"
			# memorizzo il vecchio responsabile nello storico
			set ruolo "R"
			if {![string equal $cod_responsabile_old ""]
			    &&   [db_0or1row sel_rife_check ""] == 0
			} {
			    set dml_ins_rife_resp [db_map ins_rife]
			}
		    } else {
			append note_todo "Responsabile dell'impianto ($desc_resp_old) diverso dal responsabile del modello H ($desc_resp) \n"
		    }
		}

		if {$cod_occupante != $cod_occupante_old} {
		    if {$flag_agg_sogg == "T"} {
			append note_todo "Occupante dell'impianto aggiornato da $desc_occu_old a $desc_occu \n"
			# memorizzo il vecchio occupante nello storico
			set ruolo "O"
			if {![string equal $cod_occupante_old ""]
			    &&   [db_0or1row sel_rife_check ""] == 0
			} {
			    set dml_ins_rife_occu [db_map ins_rife]
			}
		    } else {
			append note_todo "Occupante dell'impianto ($desc_occu_old) diverso dall'occupante del modello H ($desc_occu) \n"
		    }
		}

		if {$cod_proprietario != $cod_proprietario_old} {
		    if {$flag_agg_sogg == "T"} {
			append note_todo "Proprietario dell'impianto aggiornato da $desc_prop_old a $desc_prop \n"
			# memorizzo il vecchio proprietario nello storico
			set ruolo "P"
			if {![string equal $cod_proprietario_old ""]
			    &&   [db_0or1row sel_rife_check ""] == 0
			} {
			    set dml_ins_rife_prop [db_map ins_rife]
			}
		    } else {
			append note_todo "Proprietario dell'impianto ($desc_prop_old) diverso dal proprietario del modello H ($desc_prop) \n"
		    }
		}

		if {$cod_int_contr != $cod_int_contr_old} {
		    if {$flag_agg_sogg == "T"} {
			append note_todo "Intestatario Contratto dell'impianto aggiornato da $desc_contr_old a $desc_contr \n"
			# memorizzo il vecchio occupante nello storico
			set ruolo "T"
			if {![string equal $cod_int_contr_old ""]
			    &&   [db_0or1row sel_rife_check ""] == 0
			} {
			    set dml_ins_rife_inte [db_map ins_rife]
			}
		    }
		}
	    }
	    if {[string equal $dt_prima_dich ""]} {
		set dml_upd_aimp_prima_dich [db_map upd_aimp_prima_dich]
	    }

	    # 18/06/2014: Richiesto da Udine ma va bene per tutti.
	    # Se non esiste il bollino, non bisogna aggiornare le date ultimo controllo e
	    # scadenza sulla coimaimp.
	    # Ignoriamo il caso del bollettino postale che ormai non e' piu' usato da nessuno
	    if {![string is space $riferimento_pag] || $flag_portafoglio eq "T"} {
		set dml_upd_aimp_ultim_dich [db_map upd_aimp_ultim_dich]
	    }
	} else {
	    # se il min di data autocertificazione dei modh di quell'impianto � piu recente della data del controllo
	    # vado a fare l'update sull'impianto
	    db_1row sel_min_data_controllo ""
	    if {[string equal $min_data_controllo ""]
		|| $min_data_controllo > [iter_check_date $data_controllo]} {
		set dml_upd_aimp_prima_dich [db_map upd_aimp_prima_dich]
	    }
	}

	if {![string equal $note_todo ""]} {
	    set dml_todo_aimp [db_map ins_todo]
	}
	
	# Preparo esito e flag_pericolosita.
	# Se c'e' almeno un'anomalia, l'esito viene forzato a negativo.
	# Se c'e' almeno un'anomalia pericolosa, flag_pericolosita diventa 'T'.

	set flag_pericolosita "F"
	set conta 0
	# ciclo sulle anomalie presenti nella form
	while {$conta < 5} {
	    incr conta
	    if {![string equal $cod_anom($conta) ""]} {
		set flag_status "N"

		set cod_anomalia $cod_anom($conta)
		if {[db_0or1row sel_tano_scatenante ""] == 0} {
		    set flag_scatenante "F"
		}
		if {$flag_scatenante == "T"} {
		    set flag_pericolosita  "T"
		}
	    }
	}

	# in modifica devo considerare anche le anomalie che non compaiono
	# nella pagina corrente (oltre a 5)
	if {$funzione == "M"} {
	    db_foreach sel_tano_anom "" {
		set flag_uguale "f"
		foreach cod_tanom_old $list_anom_old {
		    if {$cod_tanom_old == $cod_tanom_check} {
			set flag_uguale "t"
		    }
		}
		if {$flag_uguale == "f"
		    &&  $flag_scatenante_check == "T"
                } {
		    set flag_pericolosita "T"
		}
	    }
	}

	# in inserimento ed in modifica valorizzo lo stato di conformita'
        # dell'impianto in base all'esito del M.H.
	if {![string equal $flag_status ""]} {
	    # lo aggiorno solo se l'esito del M.H. non e' null
	    if {$flag_status == "P"} {
		set stato_conformita "S"
	    } else {
		set stato_conformita "N"
	    }
	    set dml_upd_aimp_stato [db_map upd_aimp_stato]
	}
    }

    set lista_pesi [list]
    switch $conformita {
	"N" {lappend lista_pesi [list "conformita" "N"]}
	"C" {lappend lista_pesi [list "conformita" "C"]}
    }
    switch $lib_impianto {
	"N" {lappend lista_pesi [list "lib_impianto" "N"]}
	"C" {lappend lista_pesi [list "lib_impianto" "C"]}
    }
    switch $lib_uso_man {
	"N" {lappend lista_pesi [list "lib_uso_man" "N"]}
	"C" {lappend lista_pesi [list "lib_uso_man" "C"]}
    }
    switch $idoneita_locale {
	"N" {lappend lista_pesi [list "idoneita_locale" "N"]}
    }
    switch $ap_ventilaz {
	"N" {lappend lista_pesi [list "ap_ventilaz" "N"]}
	"C" {lappend lista_pesi [list "ap_ventilaz" "C"]}
    }
    switch $ap_vent_ostruz {
	"N" {lappend lista_pesi [list "ap_vent_ostruz" "N"]}
	"C" {lappend lista_pesi [list "ap_vent_ostruz" "C"]}
    }
    switch $pendenza {
	"N" {lappend lista_pesi [list "pendenza" "N"]}
	"C" {lappend lista_pesi [list "pendenza" "C"]}
    }
    switch $sezioni {
	"N" {lappend lista_pesi [list "sezioni" "N"]}
	"C" {lappend lista_pesi [list "sezioni" "C"]}
    }
    switch $curve {
	"N" {lappend lista_pesi [list "curve" "N"]}
	"C" {lappend lista_pesi [list "curve" "C"]}
    }
    switch $lunghezza {
	"N" {lappend lista_pesi [list "lunghezza" "N"]}
	"C" {lappend lista_pesi [list "lunghezza" "C"]}
    }
    switch $conservazione {
	"N" {lappend lista_pesi [list "conservazione" "N"]}
	"C" {lappend lista_pesi [list "conservazione" "C"]}
    }
    switch $scar_ca_si {
	"N" {lappend lista_pesi [list "scar_ca_si" "N"]}
	"C" {lappend lista_pesi [list "scar_ca_si" "C"]}
    }
    switch $scar_parete {
	"N" {lappend lista_pesi [list "scar_parete" "N"]}
	"C" {lappend lista_pesi [list "scar_parete" "C"]}
    }
    switch $riflussi_locale {
	"N" {lappend lista_pesi [list "riflussi_locale" "N"]}
	"C" {lappend lista_pesi [list "riflussi_locale" "C"]}
    }
    switch $assenza_perdite {
	"N" {lappend lista_pesi [list "assenza_perdite" "N"]}
	"C" {lappend lista_pesi [list "assenza_perdite" "C"]}
    }
    switch $cont_rend {
	"N" {lappend lista_pesi [list "cont_rend" "N"]}
    }
    switch $pulizia_ugelli {
	"N" {lappend lista_pesi [list "pulizia_ugelli" "N"]}
	"C" {lappend lista_pesi [list "pulizia_ugelli" "C"]}
    }
    switch $antivento {
	"N" {lappend lista_pesi [list "antivento" "N"]}
	"C" {lappend lista_pesi [list "antivento" "C"]}
    }
    switch $scambiatore {
	"N" {lappend lista_pesi [list "scambiatore" "N"]}
	"C" {lappend lista_pesi [list "scambiatore" "C"]}
    }
    switch $accens_reg {
	"N" {lappend lista_pesi [list "accens_reg" "N"]}
	"C" {lappend lista_pesi [list "accens_reg" "C"]}
    }
    switch $disp_comando {
	"N" {lappend lista_pesi [list "disp_comando" "N"]}
	"C" {lappend lista_pesi [list "disp_comando" "C"]}
    }
    switch $ass_perdite {
	"N" {lappend lista_pesi [list "ass_perdite" "N"]}
	"C" {lappend lista_pesi [list "ass_perdite" "C"]}
    }
    switch $valvola_sicur {
	"N" {lappend lista_pesi [list "valvola_sicur" "N"]}
	"C" {lappend lista_pesi [list "valvola_sicur" "C"]}
    }
    switch $vaso_esp {
	"N" {lappend lista_pesi [list "vaso_esp" "N"]}
	"C" {lappend lista_pesi [list "vaso_esp" "C"]}
    }
    switch $disp_sic_manom {
	"N" {lappend lista_pesi [list "disp_sic_manom" "N"]}
	"C" {lappend lista_pesi [list "disp_sic_manom" "C"]}
    }
    switch $organi_integri {
	"N" {lappend lista_pesi [list "organi_integri" "N"]}
	"C" {lappend lista_pesi [list "organi_integri" "C"]}
    }
    switch $circ_aria {
	"N" {lappend lista_pesi [list "circ_aria" "N"]}
	"C" {lappend lista_pesi [list "circ_aria" "C"]}
    }
    switch $guarn_accop {
	"N" {lappend lista_pesi [list "guarn_accop" "N"]}
	"C" {lappend lista_pesi [list "guarn_accop" "C"]}
    }
    switch $assenza_fughe {
	"N" {lappend lista_pesi [list "assenza_fughe" "N"]}
	"A" {lappend lista_pesi [list "assenza_fughe" "A"]}
    }
    switch $coibentazione {
	"N" {lappend lista_pesi [list "coibentazione" "N"]}
	"A" {lappend lista_pesi [list "coibentazione" "A"]}
    }
    switch $eff_evac_fum {
	"N" {lappend lista_pesi [list "eff_evac_fum" "N"]}
	"A" {lappend lista_pesi [list "eff_evac_fum" "A"]}
    }

    switch $funzione {
        I { if {$flag_portafoglio == "T"
		&& $data_controllo >= "20080801"} {
	    set azione "I"
	    set dml_trans [db_map ins_trans]
	} else {
	    set tariffa_reg ""
	    set importo_tariffa ""
	}
	    #	    ns_return 200 text/html " $tabella $stn"; return
	    
	    if {[exists_and_not_null tabella]} {
		set cod_dimp $cod_dimp_ins
	    }
	    set dml_sql [db_map ins_dimp]	
	    #sim32 set dml_upd_tppt [db_map upd_tppt]	

	    # aggiorno su coimaimp il soggetto intestario del contratto
	    set dml_sql1 [db_map upd_aimp]

	    if {$sw_movi == "t"} {
		db_1row sel_dual_cod_movi ""
		set dml_movi [db_map ins_movi]
	    }

	    # in inserimento aggiorno sempre flag_dichiarato
	    set flag_dichiarato "S"

	    # in sel_aimp_old avevo letto data_prima_dich, data_installaz
	    # e note di coimaimp.

	    # se data_installaz non e' valorizzata, ci metto data_controllo
	    # e lo segnalo nelle note.
	    if {[string equal $data_installaz ""]} {
		set data_installaz  $data_controllo
		if {![string is space $note_aimp]} {
		    append note_aimp " "
		}
		append note_aimp "Data installazione presunta da data controllo del primo modello."
	    }

	    set dml_upd_aimp_flag_dich_data_inst [db_map upd_aimp_flag_dich_data_inst]

	    # gestione inserimento delle anomalie + inserimento rispettivi todo
	    set dml_ins_anom      [db_map ins_anom]
	    set dml_ins_todo_anom [db_map ins_todo]

	    # gestione inserimento dei todo relativi ai bollini
	    if {![string equal $note_todo_boll ""]} {
		set dml_ins_todo_boll [db_map ins_todo]
	    }

	    # aggiorno il controllo in agenda manutentore
	    # ad eseguito e con data_esecuzione = data_controllo
	    # se richiamato da coimgage-gest
	    if {![string is space $cod_opma]} {
		set stato           "2"
		set data_esecuzione $data_controllo
		set dml_upd_gage    [db_map upd_gage]
	    }
	    if {$flag_mod_gend == "S"} {
		set dml_upd_gend [db_map upd_gend]
                db_1row sel_gend_count "";#nic03
                if {$conta_gend == 1} {#nic03
                    set aggiorna_potenze_impianto " , potenza       = :pot_focolare_nom
                                                    , potenza_utile = :potenza ";#nic03
		    if {$potenza_chk > 0} {#nic06 Aggiunta if ed il suo contenuto (concordata con Sandro)
			if {[db_0or1row sel_pote_fascia ""]} {
			    append aggiorna_potenze_impianto " , cod_potenza = :cod_potenza"
			}
		    }
                } else {#nic03
                    set aggiorna_potenze_impianto "";#nic03
                };#nic03
		set dml_upd_aimp_mod [db_map upd_aimp_mod]
	    }
	}
        M {
	    set dml_sql [db_map upd_dimp]

	    if {$flag_portafoglio == "T"
		&& $data_controllo >= "20080801"} {
		set azione "M"
		set dml_trans [db_map ins_trans]
	    }
	    # aggiorno su coimaimp il soggetto intestario del contratto
	    set dml_sql1 [db_map upd_aimp]
	    
	    if {![exists_and_not_null tabella]} {
		if {$sw_movi == "t"} {
		    if {[db_0or1row sel_movi_check ""] == 0} {
			db_1row sel_dual_cod_movi ""
			set dml_movi  [db_map ins_movi]
		    } else {
			set dml_movi  [db_map upd_movi]
		    }
		} else {
		    set dml_movi      [db_map del_movi]
		}
	    }

	    # gestione delle anomalie: cancellazione todo ed anom
	    # e reinserimento anom e todo
	    set dml_del_todo_anom [db_map del_todo_anom]
	    set dml_del_anom      [db_map del_anom]
	    set dml_ins_anom      [db_map ins_anom]
	    set dml_ins_todo_anom [db_map ins_todo]

	    # gestione dei todo relativi ai bollini:
	    # cancellazione ed eventuale inserimento
	    set dml_del_todo_boll [db_map del_todo_boll]
	    if {![string equal $note_todo_boll ""]} {
		set dml_ins_todo_boll [db_map ins_todo]
	    }
	    if {$flag_mod_gend == "S"} {
		set dml_upd_gend [db_map upd_gend]

                db_1row sel_gend_count "";#nic03
                if {$conta_gend == 1} {#nic03
                    set aggiorna_potenze_impianto " , potenza       = :pot_focolare_nom
                                                    , potenza_utile = :potenza ";#nic03
		    if {$potenza_chk > 0} {#nic06 Aggiunta if ed il suo contenuto (concordata con Sandro)
			if {[db_0or1row sel_pote_fascia ""]} {
			    append aggiorna_potenze_impianto " , cod_potenza = :cod_potenza"
			}
		    }

                } else {#nic03
                    set aggiorna_potenze_impianto "";#nic03
                };#nic03
		set dml_upd_aimp_mod [db_map upd_aimp_mod]
	    }
	}
        D { db_1row query "select stato_dich from coimdimp where cod_dimp = :cod_dimp"
	    if {[exists_and_not_null stato_dich]} {
		iter_return_complaint "Presenti richieste di storno. Funzione di storno impossibile"
	    } else {
		set dml_sql  [db_map del_dimp]
		if {$flag_portafoglio == "T"
		    && [iter_check_date $data_controllo] >= "20080801"} {
		    set azione "D"
		    set dml_trans [db_map ins_trans]
		}
		set dml_movi [db_map del_movi]
		#	    db_1row sel_dimp_count ""
		#	    if {$conta_dimp == 0} {
		#		iter_return_complaint "Record non trovato"
		#	    }
		#	    if {$conta_dimp == 1} {
		# se il modello h che vado a cancellare e' l'unico presente 
		# per l'impianto, valorizzo la data ultima dichiarazione
		# dell'impianto con la data prima dichiarazione
		#		set data_ultim_dich   $data_prima_dich
		#	    } else {
		# se il modello h che vado a cancellare non e' l'unico 
		# presente per l'impianto, valorizzo la data ultima 
		# dichiarazione dell'impianto con la data_controllo
		# dell'ultimo modello h.
		#		db_1row sel_dimp_last ""
		#		set data_ultim_dich   $data_controllo
		#	    }
		#	    set dml_upd_aimp_ultim_dich [db_map upd_aimp_ultim_dich]
		set dml_del_todo_all    [db_map del_todo_all]
		set dml_del_anom_all    [db_map del_anom_all]
		
		# aggiorno il controllo in agenda manutentore
		# a 'da eseguire' e con data_esecuzione = null
		# se richiamato da coimgage-gest
		if {![string is space $cod_opma]} {
		    set stato           "1"
		    set data_esecuzione ""
		    set dml_upd_gage    [db_map upd_gage]
		}
	    }
	}
}
    
# Lancio la query di manipolazione dati contenute in dml_sql
if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
		db_dml dml_coimdimp $dml_sql

		if {$funzione == "I"} {
		    if {$readonly_n_prot eq "readonly"} {
			#sim32 db_dml dml_upd_tppt $dml_upd_tppt
		    }
		}
		db_1row sel_tgen ""
		if {[string equal $flag_pesi "S"]} {
		    db_dml del_dipe ""
		    if {$funzione != "D"} {
			foreach peso $lista_pesi {
			    set nome_campo [lindex $peso 0]
			    set tipo_peso  [lindex $peso 1]
			    db_dml ins_dipe ""
			}
			db_1row sel_tot_pesi ""
			db_dml upd_dipe ""
		    }
		}
		
		if {[info exists dml_trans]} {
		    db_dml dml_coimtrans $dml_trans
		}

		if {[info exists dml_sql1]} {
		    db_dml dml_coimaimp $dml_sql1
		}
		
		if {[info exists dml_movi]} {
		    db_dml dml_coimmovi $dml_movi
		}
		
		if {[info exists dml_upd_aimp_flag_dich_data_inst]} {
		    set note $note_aimp
		    db_dml dml_coimaimp_flag_dich_data_inst $dml_upd_aimp_flag_dich_data_inst
		}
		
		if {[info exists dml_upd_aimp_stato]} {
		    db_dml dml_coimaimp_stato $dml_upd_aimp_stato
		}
		
		if {[info exists dml_aimp_pote]} {
		    db_dml dml_coimaimp $dml_aimp_pote
		}
		if {[info exists dml_gend_pote]} {
		    db_dml dml_coimgend $dml_gend_pote
		}
		if {[info exists dml_upd_aimp_sogg]} {
		    db_dml dml_coimaimp $dml_upd_aimp_sogg
		}
		if {[info exists dml_ins_rife_manu]} {
		    set ruolo            "M"
		    set cod_soggetto_old $cod_manutentore_old
		    db_dml dml_coimrife  $dml_ins_rife_manu
		}
		if {[info exists dml_ins_rife_resp]} {
		    set ruolo            "R"
		    set cod_soggetto_old $cod_responsabile_old
		    db_dml dml_coimrife  $dml_ins_rife_resp
		}
		if {[info exists dml_ins_rife_occu]} {
		    set ruolo            "O"
		    set cod_soggetto_old $cod_occupante_old
		    db_dml dml_coimrife  $dml_ins_rife_occu
		}
		if {[info exists dml_ins_rife_prop]} {
		    set ruolo            "P"
		    set cod_soggetto_old $cod_proprietario_old
		    db_dml dml_coimrife  $dml_ins_rife_prop
		}
		if {[info exists dml_ins_rife_inte]} {
		    set ruolo            "T"
		    set cod_soggetto_old $cod_int_contr_old
		    db_dml dml_coimrife  $dml_ins_rife_inte
		}
		if {[info exists dml_todo_aimp]} {
		    db_1row sel_dual_cod_todo ""
		    set tipologia     "5"
		    set note          $note_todo
		    set data_evento   $data_controllo
		    set flag_evasione $flag_evasione_todo
		    if {$flag_evasione == "N"} {
			set data_evasione ""
			set data_scadenza [iter_set_sysdate]
		    } else {
			set data_evasione $data_evento
			set data_scadenza $data_evento
		    }
		    db_dml dml_coimtodo_aimp $dml_todo_aimp
		}
		
		# in caso di aggiornamento elimino le anomalie
		# con i rispettivi todo
		if {[info exists dml_del_anom]} {
		    set conta 0
		    while {$conta < 5} {
			incr conta
			set prog_anom_db $prog_anom($conta)
			
			if {[info exists dml_del_todo_anom]} {
			    db_dml dml_coimtodo $dml_del_todo_anom
			}
			db_dml dml_coimanom $dml_del_anom
		    }
		}
		
		# in inserimento/aggiornamento inserisco le anomalie con i
		# rispettivi todo
		if {[info exists dml_ins_anom]} { 
		    set conta 0
		    while {$conta < 5} {
			incr conta
			
			if {![string equal $cod_anom($conta) ""]} {
			    # inserisco l'anomalia
			    set prog_anom_db   $prog_anom($conta)
			    set cod_anom_db    $cod_anom($conta)
			    set data_ut_int_db $data_ut_int($conta)
			    
			    db_dml dml_coimanom $dml_ins_anom
			    
			    if {[info exists dml_ins_todo_anom]} {
				db_1row sel_dual_cod_todo ""
				
				set tipologia     "1"
				# estraggo la descrizione anomalia da mettere
				# nelle note del todo

				if {[db_0or1row sel_tano ""] == 0} {
				    set note ""
				}
				
				set data_evento   $data_controllo
				set flag_evasione "N"
				set data_evasione ""
				set data_scadenza $data_ut_int_db
				db_dml dml_coimtodo_anom $dml_ins_todo_anom
			    }
			}
		    }
		}

		# in caso di aggiornamento elimino i todo dei bollini
		# li individuo con like delle note sotto indicate
                if {[info exists dml_del_todo_boll]} {
		    set note "Il bollino applicato sul modello H%"
		    db_dml dml_coimtodo_boll $dml_del_todo_boll
		}

		# in inserimento/aggiornamento inserisco gli eventuali
		# todo dei bollini
                if {[info exists dml_ins_todo_boll]} {
		    db_1row sel_dual_cod_todo ""
		    set tipologia     "1"
		    set note          $note_todo_boll
		    set data_evento   $data_controllo
		    set flag_evasione "N"
		    set data_evasione ""
		    set data_scadenza [iter_set_sysdate]

		    db_dml dml_coimtodo_boll $dml_ins_todo_boll
		}

		# in cancellazione elimino tutti i todo e tutte le anom
		# relative al modello H
		if {[info exists dml_del_todo_all]} {
		    db_dml dml_coimtodo $dml_del_todo_all
		}
		if {[info exists dml_del_anom_all]} {
		    db_dml dml_coimanom $dml_del_anom_all
		}

		# in inserimento ed in cancellazione aggiorno il controllo
		# in agenda manutentore
		if {[info exists dml_upd_gage]} {
		    db_dml dml_coimgage $dml_upd_gage
		}

		if {[info exists dml_upd_aimp_prima_dich]} {
		    db_dml dml_coimaimp $dml_upd_aimp_prima_dich
		}

		if {[info exists dml_upd_aimp_ultim_dich]} {
		    db_dml dml_coimaimp $dml_upd_aimp_ultim_dich
		}
                if {[info exists dml_upd_gend]} {
		    db_dml dml_coimgend $dml_upd_gend
		}
                if {[info exists dml_upd_aimp_mod]} {
		    db_dml dml_coimaimp $dml_upd_aimp_mod
		}
	    }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione eq "I"} {
        set last_cod_dimp [list $data_controllo $cod_dimp]
    }

    set link_list [subst $link_list_script]
    set link_gest [export_url_vars flag_tracciato cod_dimp last_cod_dimp nome_funz nome_funz_caller extra_par caller cod_impianto url_list_aimp url_aimp url_gage flag_no_link cod_opma data_ins tabella]

    switch $funzione {
        M {set return_url "coimdimp-gest?funzione=V&$link_gest"}
        D {
	    if {$flag_no_link == "F"} { 
		set return_url  "$pack_dir/coimdimp-list?$link_list"
	    } else {
		set return_url  "coimdimp-gest?funzione=I&$link_gest"
	    }  
	}
        I { 
	    if {$nome_funz_caller == "insmodg"} {
		set return_url "$pack_dir/coimdimp-ins-filter?&nome_funz=insmodg&[export_url_vars flag_tracciato]&cod_impianto_old=$cod_impianto&cod_dimp_old=$cod_dimp"
	    } else {
		set return_url "coimdimp-gest?funzione=V&$link_gest&transaz_eff=$transaz_eff"
            }
	    #nic01 if {![string equal $__refreshing_p 0] && ![string equal $__refreshing_p ""]} {
	    #nic01     ad_returnredirect "coimdimp-gest?funzione=I&$link_list&__refreshing_p=$__refreshing_p"
	    #nic01 }
	}
        V {set return_url "$pack_dir/coimdimp-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
