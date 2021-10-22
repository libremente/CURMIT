ad_page_contract {
    Add/Edit/Delete  form per la tabella "Rapporti di verifica" (coimcimp)
    @author          Giulio Laurenzi
    @creation-date   08/2006

    @param cod_cimp         E' la chiave della tabella
    @last_cod_cimp          E' l'ultima chiave della lista rapporti di verifica
    @param funzione         I=insert M=edit D=delete V=view
    @param caller           caller della lista da restituire alla lista:
                            serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz        identifica l'entrata di menu,
                            serve per le autorizzazioni
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                            navigazione con navigation bar
    @param extra_par        Variabili extra da restituire alla lista
    @param cod_impianto     Codice impianto cui si riferisce il rapporto di v
                           (E' indispensabile per l'inserimento).
    @param gen_prog         Numero del generatore cui si riferice.
                           (E' indispensabile per l'inserimento).
    @param url_aimp         Url da restituire a coimaimp-gest
    @param url_list_aimp    Url da restituire a coimaimp-list
    @param flag_cimp        Se vale "S" significa che il programma e' stato
                            richiamato dalla gestione impianti.
    @param flag_inco        Se vale "S" significa che il programma e' stato
                            richiamato dalla gestione appuntamenti.
    @param extra_par_inco   Parametri da restituire alla gestione appuntamenti.
    @param cod_inco         Codice appuntamento (tabella coiminco).
    @param flag_modifica    Parametro che viene valorizzato da questo programma
                            ed utilizzato dall'adp per vietare la modifica
                            se e' gia' stato inserito da piu' di un certo
                            numero di giorni specificati nella tabella coimtgen

    @cvs-id                 coimcimp-gest.tcl
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 25/01/2019 Corretto errore sulla query sel_pote_cod_potenza, ora tengo conto del 
    rom01            flag_tipo_impianto per scelgiere la potenza.
} {
    
   {cod_cimp         ""}
   {last_cod_cimp    ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_impianto     ""}
   {gen_prog         ""}
   {url_aimp         ""}
   {url_list_aimp    ""}
   {flag_cimp        ""}
   {flag_inco        ""}
   {extra_par_inco   ""}
   {cod_inco         ""}
   {flag_modifica    ""}
   {flag_tracciato   ""}
   {cod_opve         ""}
   {__refreshing_p   1}
   {flag_tipo_impianto "R"}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# bisogna reperire id_utente dai cookie perche' il controllo di autorizzazione
# e' gia' stato effettuato dal programma che si trova sotto src
# e che indirizza la richiesta alle sottodirectory di srcpers.

#switch $funzione {
#    "V" {set lvl 1}
#    "I" {set lvl 2}
#    "M" {set lvl 3}
#    "D" {set lvl 4}
#}
#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]
set id_utente_ve [string range $id_utente 0 1]

# valorizzo pack_dir che sara' utilizzata sull'adp per fare i link.
set pack_key  [iter_package_key]
set pack_dir  [apm_package_url_from_key $pack_key]
append pack_dir "src"

# verifico se sono un tecnico o un operatore
set cod_enve   [iter_check_uten_enve $id_utente]
set cod_tecn   [iter_check_uten_opve $id_utente]

if {![string equal $cod_enve ""]} {
    set flag_cod_enve "t"
} else {
    set flag_cod_enve "f"
}

if {![string equal $cod_tecn ""]} {
    set flag_cod_tecn "t"  
} else {
    set flag_cod_tecn "f"
}

# imposto una variabile che utilizzo nel caso siano presenti degli errori
# nell'inserimento dati, in modo da avvisare l'utente, quando un errore 
# non e' visibile perche' posizionato in una parte bassa della maschera e
# non visibile subito
set errore ""

# preparo alcune variabili utilizzate nel programma
iter_get_coimtgen
set flag_agg_da_verif $coimtgen(flag_agg_da_verif)
set flag_dt_scad      $coimtgen(flag_dt_scad)
set flag_gg_modif_rv  $coimtgen(flag_gg_modif_rv)
set gg_scad_pag_rv    $coimtgen(gg_scad_pag_rv)
set flag_ente         $coimtgen(flag_ente)
set sigla_prov        $coimtgen(sigla_prov)
set current_date      [iter_set_sysdate]

db_1row sel_tgen_sanz ""

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# preparo il link da usare per richiamare questo programma con tutti i
# i parametri ricevuti e cambiando solo la funzione
set link_gest [export_url_vars cod_cimp last_cod_cimp nome_funz nome_funz_caller extra_par cod_impianto url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]

# preparo il link da usare per tornare alla lista rapporti di verifica;
# e' diverso a seconda se il programma e' stato richiamato o meno
# dalla gestione impianti
if {$flag_cimp == "S"} {
    set link_list_script {[export_url_vars cod_impianto last_cod_cimp nome_funz_caller nome_funz url_aimp url_list_aimp flag_cimp]&[iter_set_url_vars $extra_par]}
} else {
    set link_list_script {[export_url_vars cod_impianto last_cod_cimp nome_funz_caller nome_funz flag_cimp flag_inco cod_inco extra_par_inco]&[iter_set_url_vars $extra_par]}
}
set link_list        [subst $link_list_script]

# preparo il link per richiamare la gestione anomalie
set link_anom "[export_url_vars cod_impianto gen_prog last_cod_cimp nome_funz_caller extra_par caller url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]&nome_funz=[iter_get_nomefunz coimanom-list]&cod_cimp_dimp=$cod_cimp&flag_origine=RV"

# preparo i link per richiamare la stampa e l'inserimento del doc<umento.
set link_prnt [export_url_vars cod_cimp nome_funz nome_funz_caller caller]
set link_prn2 [export_url_vars cod_cimp nome_funz nome_funz_caller caller]

# imposto la proc per i link e per il dettaglio impianto
if {$flag_cimp == "S"} {
    set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
} else {
    set link_tab ""
    if {$funzione != "I"
	&&  [db_0or1row sel_cimp_cod_impianto ""] == 0
    } {
	iter_return_complaint "Rapporto di verifica non trovato"
    }
}

# se il programma e' stato richiamato dalla gestione appuntamenti,
# preparo l'html di testata degli appuntamenti da usare nell'adp.
if {$flag_inco == "S"} {
    set link_inc [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz "" $extra_par_inco]
    set link_manc_ver "<a href=\"$pack_dir/coimcimp-manc-gest?funzione=I&flag_tracciato=MA&$link_gest\" class=func-menu>Manc. Verifica</a>"
} else {
    set link_inc ""
    set link_manc_ver "&nbsp;"
}

# preparo l'html con i dati identificativi dell'impianto.
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set titolo           "Rapporto di verifica"
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

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcimp"
set readonly_key "readonly"
set disabled_key "disabled"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set disabled_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

set disabled_opve $disabled_fld
if {$flag_cod_tecn == "t"} {
  # disabilito tecnico verificatore se utente e' tecnico verificatore
    set disabled_opve "disabled"
}

form create $form_name \
-html    $onsubmit_cmd

if {$flag_inco   != "S"
    && (   $funzione == "I"
	   || $funzione == "M")} {
    set readonly_inco \{\}
    set link_inco     [iter_search $form_name [ad_conn package_url]/src/coiminco-list [list dummy_1 cod_inco cod_impianto cod_impianto]]
} else {
    set readonly_inco "readonly"
    set link_inco     ""
}

element create $form_name cod_inco \
-label   "Cod.inc." \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_inco {} class form_element" \
-optional

element create $form_name data_controllo \
-label   "Data controllo" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

if {$disabled_opve != "disabled"} {

    # se il verificatore e' valorizzabile, uso un selection box
    # che propone ente verificatore - tecnico verificatore.
    # nel caso in cui l'utente e' un ente-verificatore
    # allora vengono proposti solamente i suoi tecnici.
    if {$flag_cod_enve == "t"} {
	set where_enve_opve " and o.cod_enve = :cod_enve"
    } else {
	set where_enve_opve ""
    }
    set lista_opve [db_list_of_lists sel_enve_opve ""]
    set lista_opve [linsert $lista_opve 0 [list "" ""]]

    element create $form_name cod_opve \
    -label   "Verificatore" \
    -widget   select \
    -datatype text \
    -html    {onChange "document.coimcimp.__refreshing_p.value='1';document.coimcimp.submit()"} \
    -optional \
    -options  $lista_opve
} else {
    # se il verificatore e' protetto,
    # metto il cod_opve in un campo hidden
    # e visualizzo ente - tecnico verificatore.

    element create $form_name cod_opve -widget hidden -datatype text -optional

    element create $form_name des_opve \
    -label   "Verificatore" \
    -widget   text \
    -datatype text \
    -html    "size 47 maxlegth 100 readonly {} class form_element" \
    -optional
}

element create $form_name costo \
-label   "Costo verifica" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name nominativo_pres \
-label   "Presenziante" \
-widget   textarea \
-datatype text \
-html    "cols 80 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name presenza_libretto \
-label   "Presenza libretto" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name libretto_corretto \
-label   "Libretto corretto" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name dich_conformita \
-label   "Dichiarazione di conformit&agrave;" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name libretto_manutenz \
-label   "Libretto di manutenzione" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave; S} {No N} {Incompleta I}}

element create $form_name mis_port_combust \
-label   "Potenza combustibile" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name mis_pot_focolare \
-label   "Potenza termica al focolare" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name verifica_areaz \
-label   "Verifica aerazione" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave P} {No N} {Assente A}}

element create $form_name rend_comb_conv \
-label   "Rendimento convenzionale(%)" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name rend_comb_min \
-label   "Rendimento minimo richiesto" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_fumi_md \
-label   "Temperatura fumi(�C) media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name t_aria_comb_md \
-label   "Temperatura aria comburente(�C) media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_mant_md \
-label   "Temperatura mantello(�C) media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_h2o_out_md \
-label   "Temperaura fluido in mandata(�C) media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co2_md \
-label   "CO2 media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 6 $readonly_fld {} class form_element" \
-optional

element create $form_name o2_md \
-label   "O2 media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 6 $readonly_fld {} class form_element" \
-optional

element create $form_name co_md \
-label   "CO (ppm) media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name indic_fumosita_1a \
-label   "Indice di fumosit&agrave; Bacharach 1" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name indic_fumosita_2a \
-label   "Indice di fumosit&agrave; Bacharach 2" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name indic_fumosita_3a \
-label   "Indice di fumosit&agrave; Bacharach 3" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name indic_fumosita_md \
-label   "Indice di fumosit&agrave; Bacharach media" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name manutenzione_8a \
-label   "Menutenzione 8a" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
    -options  {{{} {}} {Effettuata S} {{Non Effettuata} N}}

element create $form_name co_fumi_secchi_8b \
-label   "CO riferita a fumi secchi 8b" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
    -options  {{{} {}} {Regolare S} {Irregolare N}}

element create $form_name indic_fumosita_8c \
-label   "Indice di fumosit&agrave; 8c" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {Regolare S} {Irregolare N}}

element create $form_name rend_comb_8d \
-label   "Rendimento convenzionale 8d" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {Sufficiente S} {Insufficiente N}}


# esito_verifica e' un selection box.
# solo nella funzione di modifica e se sono presenti delle anomalie
# l'esito non e' modificabile.
if {$funzione != "M"
|| ($funzione == "M"
&&  [db_0or1row sel_cimp_esito_negativo ""] == 0)
} {
    element create $form_name esito_verifica \
    -label   "Esito verifica" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{{} {}} {Positivo P} {Negativo N}}
    set vis_desc_ver "f"
} else {
    element create $form_name esito_verifica -widget hidden -datatype text -optional
    set vis_desc_ver "t"

    element create $form_name text_esito_verifica \
    -label   "Esito verifica" \
    -widget   text \
    -datatype text \
    -html    "size 10 readonly {} class form_element" \
    -optional \
    -value   "Negativo"
}

element create $form_name note_verificatore \
-label   "Osservazioni/raccomandazioni" \
-widget   textarea \
-datatype text \
-html    "cols 40 rows 8 $readonly_fld {} class form_element" \
-optional

element create $form_name note_resp \
-label   "Note responsabile" \
-widget   textarea \
-datatype text \
-html    "cols 87 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name note_conf \
-label   "Note non conformit&agrave;" \
-widget   textarea \
-datatype text \
-html    "cols 87 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name tipologia_costo \
-label   "Tipo pagamento" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {{Bollettino postale} BP}}

element create $form_name flag_pagato \
-label   "Pagato" \
-widget   select \
-options  {{{} {}} {No N} {S&igrave; S}} \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional

element create $form_name data_scad_pagamento \
-label   "Data scadenza pagamento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name riferimento_pag \
-label   "Riferimento_pag" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_utile_nom \
-label   "Potenza utile nominale" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_focolare_nom \
-label   "Potenza termica al focolare" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_combustibile \
-label   "Combustibile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb]

element create $form_name nome_responsabile \
-label   "Nome responsabile" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name cogn_responsabile \
-label   "cognome responsabile" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name prog_anom_max \
-widget   hidden \
-datatype text \
-optional

element create $form_name new1_data_dimp \
-label   "Data allegato H" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_data_paga_dimp \
-label   "Data versamento allegato H" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_conf_accesso \
-label   "Conformita accesso" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_pres_intercet \
-label   "intercettazione manuale esterna" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_pres_interrut \
-label   "Interruttore generale esterno" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_asse_mate_estr \
-label   "Assenza materiali estranei" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_pres_mezzi \
-label   "Mezzi estinzione incendi" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_pres_cartell \
-label   "Presenza cartellonistica" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {NV V}}

element create $form_name new1_lavoro_nom_iniz \
-label   "Lavoro bruc. nominale inizio" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_lavoro_nom_fine \
-label   "Lavoro bruc. nominale fine" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_lavoro_lib_iniz \
-label   "Lavoro bruc libretto inizio" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_lavoro_lib_fine \
-label   "Lavoro bruc libretto fine" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_note_manu \
-label   "Note manutentore" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_data_ultima_manu \
-label   "Data ultima manutenzione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_data_ultima_anal \
-label   "Data ultima analis di combustione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_manu_prec_8a \
-label   "Data ultima manutenzione" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options { {{} {}} {Effettuata S} {{Non Effettuata} N}}

element create $form_name new1_co_rilevato \
-label   "Co rilevato" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name new1_dimp_pres \
-label   "rapporto di conrollo presente" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options { {{} {}} {S&igrave; S} {No N}}

element create $form_name new1_dimp_prescriz \
-label   "rapporto di conrollo presente con prescrizioni" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options { {{} {}} {S&igrave; S} {No N}}

element create $form_name new1_flag_peri_8p \
-label   "flag_pericolosita" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options { {{} {}} {Immediatamente I} {Potenzialmente P}}

element create $form_name n_prot \
-label   "Num. protocollo" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name data_prot \
-label   "Data protocollo" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name verb_n \
-label   "Num. verbale" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name data_verb \
-label   "Data verbale" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional
########
element create $form_name volumetria \
-label   "Volumetria" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name comsumi_ultima_stag \
-label   "Consumi ultima stagione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_h2o_out_1a \
-label   "Temperaura fluido in mandata(�C) " \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_h2o_out_2a \
-label   "Temperaura fluido in mandata(�C)" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_h2o_out_3a \
-label   "Temperaura fluido in mandata(�C)" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name t_aria_comb_1a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name t_aria_comb_3a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name t_aria_comb_2a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_fumi_1a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_fumi_2a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name temp_fumi_3a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co_1a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co_2a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co_3a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co2_1a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co2_2a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name co2_3a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name o2_1a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name o2_2a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name o2_3a \
-label   "Temperaura aria comburente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name ubic_locale_norma \
-label   "matricola strumento" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name doc_ispesl \
-label   "Denuncia ispsel" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name libr_manut_bruc \
-label   "libreto bruciatore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N} {Incompleta I}}

element create $form_name conf_imp_elettrico \
-label   "conformita impianto elettrico" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name doc_prev_incendi \
-label   "Certificato prevenzione incendi" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name campo_funzion_max \
-label   "campo di funzionamento" \
-widget   text \
-datatype text \
-html    "size 10 readonly {} class form_element" \
-optional 

element create $form_name campo_funzion_min \
-label   "campo di funzionamento" \
-widget   text \
-datatype text \
-html    "size 10 readonly {} class form_element" \
-optional 

element create $form_name cod_sanzione_1 \
-label   "cod. sanzione 1" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimsanz cod_sanzione "cod_sanzione||' - '||descr_breve"]

element create $form_name cod_sanzione_2 \
-label   "cod. sanzione 2" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimsanz cod_sanzione "cod_sanzione||' - '||descr_breve"]

element create $form_name tiraggio \
-label   "Tiraggio" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 13 $readonly_fld {} class form_element" \
-optional

#--------------------------------
element create $form_name scarico_dir_esterno \
    -label   "Scarica direttamente all'esterno" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {S&igrave; S} {No N}}

element create $form_name riferimento_pag_bollini \
    -label   "Bollini" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name dichiarato \
    -label   "Dichiarato" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {S&igrave; S} {No N}}

element create $form_name rend_suff_insuff \
    -label   "Rendimento sufficiente" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Sufficiente S} {Insufficiente N}}

element create $form_name et \
    -label   "E.T." \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 8 $readonly_fld {} class form_element" \
    -optional
#---------------------------------------------------------------------------
element create $form_name flag_pres_284 \
    -label   "Presente" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {S&igrave; S} {No N}}

element create $form_name data_284 \
-label   "Data documento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional


element create $form_name flag_comp_284 \
    -label   "Completo" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Completo C} {Incompleto I}}


if {![string equal $cod_opve ""]} {
    set where_opve "and cod_opve = '$cod_opve'"
} else {
    if  {$funzione == "I"} {
	set where_opve "and cod_opve is null"
    } else {
	db_1row sel_op_ini "select cod_opve from coimcimp where cod_cimp = :cod_cimp"
	set where_opve "and cod_opve = '$cod_opve'"
    }
}

element create $form_name cod_strumento_01 \
    -label   "cod. strumento 1" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimstru cod_strumento "marca_strum||' - '||modello_strum||' - '||matr_strum" "tipo_strum" "where 1 = 1 $where_opve and (dt_fine_att is null or dt_fine_att > current_date) and tipo_strum = 'A'"]

element create $form_name cod_strumento_02 \
    -label   "cod. strumento 2" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimstru cod_strumento "marca_strum||' - '||modello_strum||' - '||matr_strum" "tipo_strum" "where 1 = 1 $where_opve and (dt_fine_att is null or dt_fine_att > current_date) and tipo_strum = 'D'"]


if {($funzione == "I"
     || $funzione == "M")
    && $__refreshing_p == "1"
    && ![string equal $cod_opve ""]} {
    if {[db_0or1row sel_def_strum_a "select cod_strumento as def_ana from coimstru where cod_opve = :cod_opve and (dt_fine_att is null or dt_fine_att < current_date) and strum_default = 'S' and tipo_strum = 'A'"] == 1} {
	element set_properties $form_name cod_strumento_01    -value $def_ana
	}
    if {[db_0or1row sel_def_strum_d "select cod_strumento as def_dep from coimstru where cod_opve = :cod_opve and (dt_fine_att is null or dt_fine_att < current_date) and strum_default = 'S' and tipo_strum = 'D'"] == 1} {
	element set_properties $form_name cod_strumento_02    -value $def_dep
    }
}

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
    -options [iter_selbox_from_table_wherec coimtano cod_tano "cod_tano||' - '||descr_breve" "" "where (flag_modello = 'R'
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

if {$funzione == "I"
||  $funzione == "M"
} {
    set cerca_resp [iter_search $form_name [ad_conn package_url]/src/coimcitt-filter [list dummy cod_responsabile f_cognome cogn_responsabile f_nome nome_responsabile]]
} else {
    set cerca_resp ""
}

if {$funzione == "I" 
||  $funzione == "M"
} {
	#link inserimento responsabile
	set link_ins_resp [iter_link_ins $form_name ../../src/coimcitt-isrt [list cognome cogn_responsabile nome nome_responsabile nome_funz nome_funz_new flag_ins_prop flag_ins_prop cod_responsabile] "Inserisci Sogg."]
	
} else {
	set link_ins_resp ""
}

element create $form_name __refreshing_p -widget hidden -datatype text -optional
element create $form_name cod_cimp      -widget hidden -datatype text -optional
element create $form_name last_cod_cimp -widget hidden -datatype text -optional
element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name gen_prog      -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp      -widget hidden -datatype text -optional
element create $form_name nome_funz_new -widget hidden -datatype text -optional

element create $form_name flag_ins_prop -widget hidden -datatype text -optional
element create $form_name flag_cimp     -widget hidden -datatype text -optional
element create $form_name flag_inco     -widget hidden -datatype text -optional
element create $form_name extra_par_inco -widget hidden -datatype text -optional
element create $form_name cod_inco_old  -widget hidden -datatype text -optional
element create $form_name flag_modifica -widget hidden -datatype text -optional
element create $form_name cod_responsabile -widget hidden -datatype text -optional
element create $form_name list_anom_old -widget hidden -datatype text -optional
element create $form_name submitbut     -widget submit -datatype text -label "$button_label" -html {onClick "document.coimcimp.__refreshing_p.value='0'"}

#elemento rendimento_min_notice indica il tipo di calcolo automatico per il rendimento minimo
element create $form_name rendimento_min_notice      -widget hidden -datatype text -optional

# definisco la routine che legge i dati dell'impianto e del generatore
# che in parte devono essere visualizzati come campi di testata
# ed in parte devono essere a disposizione nel programma
# tale routine deve essere quindi eseguita sia nella form is_request
# che nella form is_valid (dopo aver reperito cod_impianto e gen_prog)

set prep_aimp_e_gend {
    
    # reperisco i dati dell'impianto
    if {[db_0or1row sel_aimp ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }

    # reperisco i dati del generatore
    if {[db_0or1row sel_gend ""] == 0} {
	iter_return_complaint "Generatore non trovato"
    }

    if {[string equal $gend_descr_fuge ""]} {
	set gend_descr_fuge     "Non noto"
    }
    if {[string equal $gend_matricola ""]} {
	set gend_matricola      "Non nota"
    }
    if {[string equal $gend_modello ""]} {
	set gend_modello        "Non noto"
    }
    if {[string equal $gend_matricola_bruc ""]} {
	set gend_matricola_bruc "Non nota"
    }
    if {[string equal $gend_modello_bruc ""]} {
	set gend_modello_bruc   "Non noto"
    }
    if {[string equal $gend_data_installazione ""]} {
	set gend_data_installazione   "Non noto"
	set gend_eta_gend ""
    } else {
	set gend_data_installazione [iter_check_date $gend_data_installazione]
	if {$gend_data_installazione <= "19010101"} {
	    set gend_eta_gend ">= 15 anni"
	} else {
	    if {[clock format [clock scan "$gend_data_installazione 15 year"] -format %Y%m%d] > [clock format [clock second] -format %Y%m%d]} {
		set gend_eta_gend "< 15 anni"
	    } else {
		set gend_eta_gend ">= 15 anni"
	    }
	}
    }

    if {$funzione != "I"} {
	if {[db_0or1row sel_cimp_esito ""] == 0} {
	    iter_return_complaint "Rapporto di Verifica non trovato"
	}
	switch $cimp_esito_verifica {
	    "P" {set des_esito_verifica "Positivo"}
	    "N" {set des_esito_verifica "<font color=red><b>Negativo</b></font>"}
        default {set des_esito_verifica ""}
	}
	if {$cimp_flag_pericolosita == "T"} {
	    if {![string is space $des_esito_verifica]} {
		append des_esito_verifica ", "
	    }
	    append des_esito_verifica   "<font color=red><b>impianto pericoloso</b></font>"
	} 
    }
}

set verifiche_aimp_gend {
    if {![info exists error_num]} {
	set error_num 0
    }
    if {[string equal $aimp_dest_uso ""]} {
	set aimp_dest_uso_error "<br><span class=errori>Inserire in ubicazione </span>"
	incr error_num
    } else {
	set aimp_dest_uso_error ""
    }

    if {[string equal $aimp_tipologia ""]} {
	set aimp_tipologia_error "<br><span class=errori>Inserire in dati tecnici </span>"
	incr error_num
    } else {
	set aimp_tipologia_error ""
    }
    
    if {[string equal $gend_destinazione_uso ""]} {
	set gend_destinazione_uso_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_destinazione_uso_error ""
    }

    if {[string equal $gend_tipologia_locale ""]} {
	set gend_tipologia_locale_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_tipologia_locale_error ""
    }


    if {[string equal $gend_fluido_termovettore ""]} {
	set gend_fluido_termovettore_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_fluido_termovettore_error ""
    }

    if {[string equal $gend_tipologia_emissione ""]} {
	set gend_tipologia_emissione_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_tipologia_emissione_error ""
    }

    if {[string equal $gend_tipo_focolare ""]} {
	set gend_tipo_focolare_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_tipo_focolare_error ""
    }

    if {[string equal $gend_descr_cost ""]} {
	set gend_descr_cost_error "<br><span class=errori>Inserire sul generatore</span> "
	incr error_num
    } else {
	set gend_descr_cost_error ""
    }

#    if {[string equal $gend_pot_utile_lib_edit ""]} {
#	set gend_pot_utile_lib_edit_error "<br><span class=errori>Inserire sul generatore</span> "
#	incr error_num
#    } else {
	set gend_pot_utile_lib_edit_error ""
#    }

#    if {[string equal $gend_pot_focolare_lib_edit ""]} {
#	set gend_pot_focolare_lib_edit_error "<br><span class=errori>Inserire sul generatore</span> "
#	incr error_num
#    } else {
	set gend_pot_focolare_lib_edit_error ""
#    }
}

# preparo l'eventuale link alle note riguardanti l'ultimo modello H 
set link_note_view ""

# imposto la where condition della query, in modo che se non sono in 
# inserimento, visualizzo i dati del mod.h precedenti alla data_controllo
# del rapporto di veirifica
set where_data_controllo ""
if {$funzione != "I"} {
    if {[db_0or1row sel_cimp_data ""] == 1} {
	set where_data_controllo "and b.data_controllo <= :data_controllo"
    }
}

if {[db_0or1row check_dimp ""] == 1} {
    set link_note_view    "&nbsp;&nbsp;<a name=\"note_manu\" href=\"#note_manu\" onclick=\"javascript:window.open('coimdimp-note-view?[export_url_vars cod_dimp]', 'help', 'scrollbars=yes, resizable=yes, width=790, height=450').moveTo(1,80)\"><b>Note manutentore</b></a>"
}

set flag_ins_prop "S"
element set_properties $form_name flag_ins_prop  -value $flag_ins_prop

set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
element set_properties $form_name nome_funz_new   -value $nome_funz_new

if {[form is_request $form_name]} {

    element set_properties $form_name last_cod_cimp  -value $last_cod_cimp
    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par      -value $extra_par
    element set_properties $form_name cod_impianto   -value $cod_impianto
    element set_properties $form_name gen_prog       -value $gen_prog
    element set_properties $form_name url_list_aimp  -value $url_list_aimp
    element set_properties $form_name url_aimp       -value $url_aimp
    element set_properties $form_name flag_cimp      -value $flag_cimp   
    element set_properties $form_name flag_inco      -value $flag_inco
#   cod_inco viene valorizzato col default in inserimento oppure con
#   quello letto dalla coimcimp.
#   element set_properties $form_name cod_inco       -value $cod_inco
    element set_properties $form_name extra_par_inco -value $extra_par_inco

    if {$funzione != "V"} {
	set mess_err_sanz1 ""
	set mess_err_sanz2 ""
	set mess_err_sanz ""
    }

    if {$funzione == "I"} {
	# gen_prog non e' mai valorizzato ad eccezione del caso in cui
	# non sia stata effettuata la scelta del generatore tramite
	# il programma coimcimp-gend-list qui sotto richiamato.
	if {[string equal $gen_prog ""]} {
	    # se esiste un solo generatore attivo, predispongo l'inserimento
	    # del rapporto di verifica relativo a tale generatore
	    set ctr_gend 0
	    db_foreach sel_gend_list "" {
		incr ctr_gend
	    }
	    # se ho un solo generatore ho gia' reperito gen_prog con la query
	    # se ne ho piu' di uno, invece richiamo coimcimp-gend-list
	    # per scegliere su quale generatore si vuole inserire il R.V.
	    # se non ho nessun generatore non posso inserire il R.V.
	    if {$ctr_gend == 1} {
		# gen_prog e' gia' stato valorizzato con sel_gend_list
	    } else {
		if {$ctr_gend > 1} {
		    # richiamo il programma che permette di scegliere gen_prog
		    set link_gend "flag_tracciato=N1&[export_url_vars cod_impianto last_cod_cimp nome_funz nome_funz_caller extra_par caller url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]"
		    ad_returnredirect [ad_conn package_url]src/coimcimp-gend-list?$link_gend
		    ad_script_abort
		} else {
		    iter_return_complaint "Non trovato nessun generatore attivo: inserirlo"
		}
	    }
	}
    
    
	# leggo i dati dell'impianto e del generatore
	eval $prep_aimp_e_gend
	if {$funzione == "I"} {
	    eval $verifiche_aimp_gend
	    if {$error_num > 0} {
		# segnalo la presenza di errori nella pagina
		set errore "<td valign=top align=center><font color=red><b>ATTENZIONE sono presenti degli errori nella pagina</b></font></td>"
	    }
	}
	set gen_prog_est         $gend_gen_prog_est

	# valorizzo cod_combustibile con quello del generatore
	# (se e' valorizzato) altrimenti con quello dell'impianto
	if {![string equal $gend_cod_combustibile ""]} {
	    set cod_combustibile $gend_cod_combustibile
	} else {
	    set cod_combustibile $aimp_cod_combustibile
	}	
	
	# valorizzo pot_utile_nom con quella del generatore
	# (se e' valorizzata) altrimenti con quella dell'impianto
	if {![string equal $gend_pot_utile_nom ""]
	&&   $gend_pot_utile_nom != 0
	} {
	    set pot_utile_nom $gend_pot_utile_nom
	} else {
	    set pot_utile_nom $aimp_pot_utile_nom
	}
	set pot_utile_nom_edit [iter_edit_num $pot_utile_nom 2]

	# valorizzo pot_focolare_nom con quella del generatore
	# (se e' valorizzata) altrimenti con quella dell'impianto
	if {![string equal $gend_pot_focolare_nom ""]
	&&   $gend_pot_focolare_nom != 0
	} {
	    set pot_focolare_nom $gend_pot_focolare_nom
	} else {
	    set pot_focolare_nom $aimp_pot_focolare_nom
	}
	set pot_focolare_nom_edit [iter_edit_num $pot_focolare_nom 2]

	# estraggo cod_potenza della pot_focolare_nom
	# che serve per ricavare la tariffa da applicare alla verifica
	set h_potenza $pot_focolare_nom
        if {[db_0or1row sel_pote_cod_potenza ""] == 0} {
	    set cod_potenza ""
	}

	# per determinare la tariffa devo sapere se si tratta del
	# generatore principale.

	# imposto il codice listino a 0 perche' per ora il listino destinato ai costi 
        # e' il listino con codice 0 (zero) se in futuro ci sara' una diversificazione
        # sara' da creare una function o una procedura che renda dinamico il codice_listino
	set cod_listino 0

	set gen_prog_est_min [db_string sel_gend_min ""]
        if {$flag_sanzioni == "N"} {
	    if {$gen_prog_est == $gen_prog_est_min} {
		# costo generatore principale
		set tipo_costo "2"
	    } else {
		# costo generatore supplementare
		set tipo_costo "3"
	    }
	    if {[db_0or1row sel_tari ""] == 1} {
		set costo [iter_edit_num $importo 2]
	    } else {
		set costo ""
	    }
	}

	# nel caso provenga dagli incontri, cod_inco e' gia' valorizzato
	# correttamente.
	# nel caso provenga dalla gestione impianto, valorizzo cod_inco
	# con l'eventuale incontro dell'impianto e campagna correnti.
	if {$flag_inco != "S"} {
	    db_foreach sel_inco_default "" {
		# se ho piu' di una campagna aperta (evento funzionalmente
		# impossibile, seleziono l'appuntamento piu' recente)
		break
	    }
	    # se l'appuntamento e' gia' stato associato ad un rapporto
	    # di verifica, evito di usarlo come default
	    set ctr_cimp_inco [db_string sel_cimp_inco_count ""]
	    if {$ctr_cimp_inco > 0} {
		set cod_inco ""
	    }
	}

	# estraggo i dati dell'appuntamento da usare come default
	set inco_cod_opve      ""
	set inco_data_verifica ""
	if {![string equal $cod_inco ""]} {
	    if {[db_0or1row sel_inco ""] == 0} {
		iter_return_complaint "Appuntamento non trovato"
	    }
	}

	# se cod_opve non e' stato valorizzato con quello dell'appuntamento
	# e se l'utente e' un tecnico, lo valorizzo col codice del tecnico.
        set cod_opve $inco_cod_opve
	if {[string equal $cod_opve ""]} {
	    set cod_opve $cod_tecn
	}

	# di default esito_verifica Positivo
	set esito_verifica "P"

	# reperisco la data dell'ultimo modello h con la quale valorizzo
	# la new1_data_dimp e new1_data_paga_dimp
	if {[db_0or1row sel_dimp_data_controllo_max ""] == 0} {
	    set dimp_data_controllo_max
	}
	set new1_data_dimp      $dimp_data_controllo_max
	set new1_data_paga_dimp $dimp_data_controllo_max

	# se la data dell'ultimo allegato H e' uguale o maggiore alla data
        # odierna meno 2 anni e l'impianto ha una potenza <= a 35 Kw
        # valorizzo di default costo a 0 e tipologia pagamento null

	set dimp_data_controllo_max_db [iter_check_date $dimp_data_controllo_max]
	set data_dimp_valido           [clock format [clock scan "-2 years"] -f "%Y%m%d"]

        if {$flag_sanzioni == "N"} {
	    if {$dimp_data_controllo_max_db >= $data_dimp_valido
		&&  $pot_focolare_nom <= 35
	    } {
		set tipologia_costo ""
		set costo           ""
	    } else {
		set tipologia_costo "BP"
	    }
	} else {
	    set tipologia_costo ""
	    set costo           ""
	}

	# Calcolo, se possibile, il valore del rendimento minimo per il generatore in questione
	set rendimento_minimo ""
	set rendimento_min_notice ""
	if {$funzione == "I"} {
	    set rendimento_min_notice "Rendimento minimo calcolato automaticamente"
	    with_catch msg_errore { 
		set rendimento_minimo [iter_calc_rend $cod_impianto $gen_prog]
	    } {
		set rendimento_min_notice $msg_errore
	    }
	    element set_properties $form_name rend_comb_min       -value $rendimento_minimo
	    element set_properties $form_name rendimento_min_notice -value $rendimento_min_notice
	}

	# valorizzo i default per l'inserimento
	element set_properties $form_name new1_data_dimp        -value $new1_data_dimp
	element set_properties $form_name new1_data_paga_dimp   -value $new1_data_paga_dimp
	element set_properties $form_name gen_prog              -value $gen_prog
	element set_properties $form_name pot_utile_nom         -value $pot_utile_nom_edit
	element set_properties $form_name pot_focolare_nom      -value $pot_focolare_nom_edit
	element set_properties $form_name cod_combustibile      -value $cod_combustibile

	# se ho l'incontro, valorizzo i default di data controllo e tecnico.
	element set_properties $form_name cod_inco              -value $cod_inco
	element set_properties $form_name data_controllo        -value $inco_data_verifica
	element set_properties $form_name cod_opve              -value $cod_opve

        element set_properties $form_name tipologia_costo       -value $tipologia_costo
        element set_properties $form_name costo                 -value $costo
	element set_properties $form_name cod_responsabile      -value $aimp_cod_responsabile
	element set_properties $form_name nome_responsabile     -value $aimp_nome_resp
	element set_properties $form_name cogn_responsabile     -value $aimp_cogn_resp
	element set_properties $form_name volumetria            -value $aimp_volumetria_risc
	element set_properties $form_name comsumi_ultima_stag   -value $aimp_consumo_annuo
	element set_properties $form_name esito_verifica        -value $esito_verifica

	element set_properties $form_name new1_dimp_pres        -value ""
	element set_properties $form_name new1_dimp_prescriz    -value ""

	if {![string equal $cod_opve ""]} {
	    if {[db_0or1row sel_def_strum_a "select cod_strumento as def_ana from coimstru where cod_opve = :cod_opve and (dt_fine_att is null or dt_fine_att < current_date) and strum_default = 'S' and tipo_strum = 'A'"] == 1} {
		element set_properties $form_name cod_strumento_01    -value $def_ana
	    }
	    if {[db_0or1row sel_def_strum_d "select cod_strumento as def_dep from coimstru where cod_opve = :cod_opve and (dt_fine_att is null or dt_fine_att < current_date) and strum_default = 'S' and tipo_strum = 'D'"] == 1} {
		element set_properties $form_name cod_strumento_02    -value $def_dep
	    }
	}

	# definisco un campo hidden per ognuna delle 5 righe
	# predisposte per le anomalie
	set conta 0
	while {$conta < 5} {
	    incr conta
	    element set_properties $form_name prog_anom.$conta -value $conta
	}

	# se esiste un rapporto di verifica sullo stesso impianto e stessa data recupero i dati comuni e li
        # imposto come default
	db_0or1row sel_cimp_check_multiple ""
	if {$conta_cimp_multiple > 0} {
	    if {[db_0or1row sel_cimp_pag1 ""] == 0} {
		element set_properties $form_name dich_conformita       -value ""
                element set_properties $form_name new1_conf_accesso     -value ""
                element set_properties $form_name new1_pres_intercet    -value ""
                element set_properties $form_name new1_pres_interrut    -value ""
                element set_properties $form_name new1_asse_mate_estr   -value ""
                element set_properties $form_name new1_pres_mezzi       -value ""
                element set_properties $form_name new1_pres_cartell     -value ""
                element set_properties $form_name verifica_areaz        -value ""  
                element set_properties $form_name presenza_libretto     -value ""
                element set_properties $form_name libretto_corretto     -value ""
                element set_properties $form_name libretto_manutenz     -value ""
                element set_properties $form_name ubic_locale_norma     -value ""
                element set_properties $form_name doc_ispesl            -value ""
                element set_properties $form_name libr_manut_bruc       -value ""
                element set_properties $form_name conf_imp_elettrico    -value ""
                element set_properties $form_name doc_prev_incendi	-value ""        
	    } else {
		element set_properties $form_name dich_conformita       -value $dich_conformita
                element set_properties $form_name new1_conf_accesso     -value $new1_conf_accesso
                element set_properties $form_name new1_pres_intercet    -value $new1_pres_intercet
                element set_properties $form_name new1_pres_interrut    -value $new1_pres_interrut
                element set_properties $form_name new1_asse_mate_estr   -value $new1_asse_mate_estr
                element set_properties $form_name new1_pres_mezzi       -value $new1_pres_mezzi
                element set_properties $form_name new1_pres_cartell     -value $new1_pres_cartell
                element set_properties $form_name verifica_areaz        -value $verifica_areaz
                element set_properties $form_name presenza_libretto     -value $presenza_libretto
                element set_properties $form_name libretto_corretto     -value $libretto_corretto
                element set_properties $form_name libretto_manutenz     -value $libretto_manutenz
                element set_properties $form_name ubic_locale_norma     -value $ubic_locale_norma
                element set_properties $form_name doc_ispesl            -value $doc_ispesl
                element set_properties $form_name libr_manut_bruc       -value $libr_manut_bruc
                element set_properties $form_name conf_imp_elettrico    -value $conf_imp_elettrico
                element set_properties $form_name doc_prev_incendi	-value $doc_prev_incendi
	    }
	}
    } else {
	if {$flag_sanzioni == "N"} {
	    set join_movi "left outer join coimmovi b  on b.riferimento   = a.cod_cimp
                             and b.cod_impianto  = a.cod_impianto
                             and b.tipo_movi     = 'VC'"
	} else {
	    set join_movi "left outer join coimmovi b  on b.riferimento   = a.cod_cimp
                             and b.cod_impianto  = a.cod_impianto
                             and b.tipo_movi     = 'SA'"
	}

      # leggo riga
        if {[db_0or1row sel_cimp ""] == 0} {
            iter_return_complaint "Rapporto di verifica non trovato"
	}

        set data_scad_mod [clock format [clock scan "$data_ins $flag_gg_modif_rv day"] -f %Y%m%d]
        if {$id_utente_ve == "VE"} {
          if {$data_scad_mod >= $current_date} {
	     set flag_modifica "T" 
          } else {
	     set flag_modifica "F"
          }
        } else {
         set flag_modifica "T"
      }    

	set mess_err_sanz1 ""
	set mess_err_sanz2 ""
	set mess_err_sanz ""

	if {![string equal $cod_sanzione_1 ""]} {
	    if {[db_0or1row sel_sanz_check1 ""] == 0} {
		 set mess_err_sanz1 "<font color=red><b>Sanzione non presente sui pagamenti.</b></font>"
	    }
	}
	if {![string equal $cod_sanzione_2 ""]} {
	    if {[db_0or1row sel_sanz_check2 ""] == 0} {
		set mess_err_sanz2 "<font color=red><b>Sanzione non presente sui pagamenti.</b></font>"
	    }
	}

	set count_mancanti 0
	db_foreach sel_sanz_check "" {
	    if {$cod_sanz_movi1 == $cod_sanzione_1
		|| $cod_sanz_movi2 == $cod_sanzione_1
		|| $cod_sanz_movi1 == $cod_sanzione_2
		|| $cod_sanz_movi2 == $cod_sanzione_2} {
		
	    } else {
		incr count_mancanti
	    }
	    

	}
	if {$count_mancanti > 0} {
	    set mess_err_sanz "<font color=red><b>Sui pagamenti sono presenti sanzioni riferite a questo R.V. differenti da queste.</b></font>"
	}

	# leggo i dati dell'impianto e del generatore
	# in questo caso servono solo per visualizzare correttamente
	# i dati di testata del generatore e dell'impianto
	eval $prep_aimp_e_gend
	if {$funzione == "M"} {
	    eval $verifiche_aimp_gend
	    if {$error_num > 0} {
		# segnalo la presenza di errori nella pagina
		set errore "<td valign=top align=center><font color=red><b>ATTENZIONE sono presenti degli errori nella pagina</b></font></td>"
	    } 
	} else {
	    set aimp_dest_uso_error ""
	    set aimp_tipologia_error ""
	    set gend_destinazione_uso_error ""
	    set gend_fluido_termovettore_error ""
	    set gend_tipologia_emissione_error ""
	    set gend_tipo_focolare_error ""
	    set gend_descr_cost_error ""
	    set gend_pot_utile_lib_edit_error ""
	    set gend_pot_focolare_lib_edit_error ""
	    set gend_tipologia_locale_error ""
            set aimp_volumetria_risc ""
            set aimp_consumo_annuo ""
	}
	set gen_prog_est       $gend_gen_prog_est

	element set_properties $form_name flag_modifica       -value $flag_modifica
        element set_properties $form_name cod_cimp            -value $cod_cimp
        element set_properties $form_name gen_prog            -value $gen_prog
        element set_properties $form_name cod_inco            -value $cod_inco
        element set_properties $form_name cod_inco_old        -value $cod_inco
        element set_properties $form_name data_controllo      -value $data_controllo
        element set_properties $form_name cod_opve            -value $cod_opve
        element set_properties $form_name costo               -value $costo
        element set_properties $form_name nominativo_pres     -value $nominativo_pres
        element set_properties $form_name presenza_libretto   -value $presenza_libretto
        element set_properties $form_name libretto_corretto   -value $libretto_corretto
        element set_properties $form_name dich_conformita     -value $dich_conformita
        element set_properties $form_name libretto_manutenz   -value $libretto_manutenz
        element set_properties $form_name mis_port_combust    -value $mis_port_combust
        element set_properties $form_name mis_pot_focolare    -value $mis_pot_focolare
        element set_properties $form_name verifica_areaz      -value $verifica_areaz
        element set_properties $form_name rend_comb_conv      -value $rend_comb_conv
        element set_properties $form_name rend_comb_min       -value $rend_comb_min
        element set_properties $form_name temp_fumi_md        -value $temp_fumi_md
        element set_properties $form_name t_aria_comb_md      -value $t_aria_comb_md
        element set_properties $form_name temp_mant_md        -value $temp_mant_md
        element set_properties $form_name temp_h2o_out_md     -value $temp_h2o_out_md
        element set_properties $form_name co2_md              -value $co2_md
        element set_properties $form_name o2_md               -value $o2_md
        element set_properties $form_name co_md               -value $co_md
        element set_properties $form_name indic_fumosita_1a   -value $indic_fumosita_1a
        element set_properties $form_name indic_fumosita_2a   -value $indic_fumosita_2a
        element set_properties $form_name indic_fumosita_3a   -value $indic_fumosita_3a
        element set_properties $form_name indic_fumosita_md   -value $indic_fumosita_md
        element set_properties $form_name manutenzione_8a     -value $manutenzione_8a
        element set_properties $form_name co_fumi_secchi_8b   -value $co_fumi_secchi_8b
        element set_properties $form_name indic_fumosita_8c   -value $indic_fumosita_8c
        element set_properties $form_name rend_comb_8d        -value $rend_comb_8d
        element set_properties $form_name esito_verifica      -value $esito_verifica
        element set_properties $form_name note_verificatore   -value $note_verificatore
        element set_properties $form_name note_resp           -value $note_resp
        element set_properties $form_name note_conf           -value $note_conf

        element set_properties $form_name tipologia_costo     -value $tipologia_costo
	element set_properties $form_name data_scad_pagamento -value $data_scad
        element set_properties $form_name riferimento_pag     -value $riferimento_pag
	element set_properties $form_name flag_pagato         -value $flag_pagato
	element set_properties $form_name pot_utile_nom       -value $pot_utile_nom
	element set_properties $form_name pot_focolare_nom    -value $pot_focolare_nom
	element set_properties $form_name cod_combustibile    -value $cod_combustibile
	element set_properties $form_name cod_responsabile    -value $cod_responsabile
	element set_properties $form_name nome_responsabile   -value $nome_responsabile
	element set_properties $form_name cogn_responsabile   -value $cogn_responsabile

	element set_properties $form_name new1_data_dimp      -value $new1_data_dimp
	element set_properties $form_name new1_data_paga_dimp -value $new1_data_paga_dimp
	element set_properties $form_name new1_conf_accesso   -value $new1_conf_accesso
	element set_properties $form_name new1_pres_intercet  -value $new1_pres_intercet
	element set_properties $form_name new1_pres_interrut  -value $new1_pres_interrut
	element set_properties $form_name new1_asse_mate_estr -value $new1_asse_mate_estr
	element set_properties $form_name new1_pres_mezzi     -value $new1_pres_mezzi
	element set_properties $form_name new1_pres_cartell   -value $new1_pres_cartell
	element set_properties $form_name new1_lavoro_nom_iniz -value $new1_lavoro_nom_iniz
	element set_properties $form_name new1_lavoro_nom_fine -value $new1_lavoro_nom_fine
	element set_properties $form_name new1_lavoro_lib_iniz -value $new1_lavoro_lib_iniz
	element set_properties $form_name new1_lavoro_lib_fine -value $new1_lavoro_lib_fine
	element set_properties $form_name new1_note_manu      -value $new1_note_manu
	element set_properties $form_name new1_data_ultima_manu -value $new1_data_ultima_manu
	element set_properties $form_name new1_data_ultima_anal -value $new1_data_ultima_anal
	element set_properties $form_name new1_manu_prec_8a   -value $new1_manu_prec_8a
	element set_properties $form_name new1_co_rilevato    -value $new1_co_rilevato
	element set_properties $form_name new1_dimp_pres      -value $new1_dimp_pres  
	element set_properties $form_name new1_dimp_prescriz  -value $new1_dimp_prescriz
	element set_properties $form_name new1_flag_peri_8p   -value $new1_flag_peri_8p
	element set_properties $form_name n_prot              -value $n_prot
	element set_properties $form_name data_prot           -value $data_prot
	element set_properties $form_name verb_n              -value $verb_n
	element set_properties $form_name data_verb           -value $data_verb
	element set_properties $form_name volumetria          -value $volumetria
	element set_properties $form_name comsumi_ultima_stag -value $comsumi_ultima_stag
	element set_properties $form_name temp_h2o_out_1a     -value $temp_h2o_out_1a
	element set_properties $form_name temp_h2o_out_2a     -value $temp_h2o_out_2a
	element set_properties $form_name temp_h2o_out_3a     -value $temp_h2o_out_3a
	element set_properties $form_name t_aria_comb_1a      -value $t_aria_comb_1a
	element set_properties $form_name t_aria_comb_2a      -value $t_aria_comb_2a
	element set_properties $form_name t_aria_comb_3a      -value $t_aria_comb_3a
	element set_properties $form_name temp_fumi_1a        -value $temp_fumi_1a
	element set_properties $form_name temp_fumi_2a        -value $temp_fumi_2a
	element set_properties $form_name temp_fumi_3a        -value $temp_fumi_3a
	element set_properties $form_name co_1a               -value $co_1a
	element set_properties $form_name co_2a               -value $co_2a
	element set_properties $form_name co_3a               -value $co_3a
	element set_properties $form_name co2_1a              -value $co2_1a
	element set_properties $form_name co2_2a              -value $co2_2a
	element set_properties $form_name co2_3a              -value $co2_3a
	element set_properties $form_name o2_1a               -value $o2_1a
	element set_properties $form_name o2_2a               -value $o2_2a
	element set_properties $form_name o2_3a               -value $o2_3a
	element set_properties $form_name ubic_locale_norma   -value $ubic_locale_norma
	element set_properties $form_name doc_ispesl          -value $doc_ispesl
	element set_properties $form_name libr_manut_bruc     -value $libr_manut_bruc
	element set_properties $form_name conf_imp_elettrico  -value $conf_imp_elettrico
	element set_properties $form_name doc_prev_incendi    -value $doc_prev_incendi
        element set_properties $form_name campo_funzion_max -value $campo_funzion_max
        element set_properties $form_name campo_funzion_min -value $campo_funzion_min
	element set_properties $form_name cod_sanzione_1      -value $cod_sanzione_1
	element set_properties $form_name cod_sanzione_2      -value $cod_sanzione_2
	element set_properties $form_name tiraggio            -value $tiraggio

	element set_properties $form_name cod_strumento_01    -value $cod_strumento_01
	element set_properties $form_name cod_strumento_02    -value $cod_strumento_02

       element set_properties $form_name riferimento_pag_bollini    -value $riferimento_pag_bollini
       element set_properties $form_name scarico_dir_esterno    -value $scarico_dir_esterno
       element set_properties $form_name rend_suff_insuff    -value $rend_suff_insuff
       element set_properties $form_name dichiarato    -value $dichiarato
       element set_properties $form_name et   -value $et
       element set_properties $form_name data_284   -value $data_284
       element set_properties $form_name flag_pres_284   -value $flag_pres_284
       element set_properties $form_name flag_comp_284   -value $flag_comp_284

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

	# valorizzo comunque prog_anom delle righe di anom eventualmente
	# non ancora inserite

	while {$conta < 5} {
	    incr conta
	    incr prog_anom
	    element set_properties $form_name prog_anom.$conta -value $prog_anom
	}
    }

    # sia in inserimento che in modifica:
    # se opve e' disabled di conseguenza cod_opve e' hidden
    # e bisogna visualizzare des_opve
    if {$disabled_opve == "disabled"
    && ![string equal $cod_opve ""]
    } {
	set where_enve_opve " and o.cod_opve = :cod_opve"
	if {[db_0or1row sel_enve_opve ""] == 0} {
	    set des_opve ""
	}
	element set_properties $form_name des_opve     -value $des_opve
    }
   
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_cimp                [element::get_value $form_name cod_cimp]
    set gen_prog                [element::get_value $form_name gen_prog]
    set cod_inco                [element::get_value $form_name cod_inco]
    set cod_inco_old            [element::get_value $form_name cod_inco_old]
    set data_controllo          [element::get_value $form_name data_controllo]
    set cod_opve                [element::get_value $form_name cod_opve]
    set costo                   [element::get_value $form_name costo]
    set nominativo_pres         [element::get_value $form_name nominativo_pres]
    set presenza_libretto       [element::get_value $form_name presenza_libretto]
    set libretto_corretto       [element::get_value $form_name libretto_corretto]
    set dich_conformita         [element::get_value $form_name dich_conformita]
    set libretto_manutenz       [element::get_value $form_name libretto_manutenz]
    set mis_port_combust        [element::get_value $form_name mis_port_combust]
    set mis_pot_focolare        [element::get_value $form_name mis_pot_focolare]
    set verifica_areaz          [element::get_value $form_name verifica_areaz]
    set rend_comb_conv          [element::get_value $form_name rend_comb_conv]
    set rend_comb_min           [element::get_value $form_name rend_comb_min]
    set temp_fumi_md            [element::get_value $form_name temp_fumi_md]
    set t_aria_comb_md          [element::get_value $form_name t_aria_comb_md]
    set temp_mant_md            [element::get_value $form_name temp_mant_md]
    set temp_h2o_out_md         [element::get_value $form_name temp_h2o_out_md]
    set co2_md                  [element::get_value $form_name co2_md]
    set o2_md                   [element::get_value $form_name o2_md]
    set co_md                   [element::get_value $form_name co_md]
    set indic_fumosita_1a       [element::get_value $form_name indic_fumosita_1a]
    set indic_fumosita_2a       [element::get_value $form_name indic_fumosita_2a]
    set indic_fumosita_3a       [element::get_value $form_name indic_fumosita_3a]
    set indic_fumosita_md       [element::get_value $form_name indic_fumosita_md]
    set manutenzione_8a         [element::get_value $form_name manutenzione_8a]
    set co_fumi_secchi_8b       [element::get_value $form_name co_fumi_secchi_8b]
    set indic_fumosita_8c       [element::get_value $form_name indic_fumosita_8c]
    set rend_comb_8d            [element::get_value $form_name rend_comb_8d]
    set esito_verifica          [element::get_value $form_name esito_verifica]
    set note_verificatore       [element::get_value $form_name note_verificatore]
    set note_resp               [element::get_value $form_name note_resp]
    set note_conf               [element::get_value $form_name note_conf]
    set tipologia_costo         [element::get_value $form_name tipologia_costo]
    set flag_pagato             [element::get_value $form_name flag_pagato]
    set data_scad_pagamento     [element::get_value $form_name data_scad_pagamento]
    set riferimento_pag         [element::get_value $form_name riferimento_pag]
    set pot_utile_nom           [element::get_value $form_name pot_utile_nom]
    set pot_focolare_nom        [element::get_value $form_name pot_focolare_nom]
    set cod_combustibile        [element::get_value $form_name cod_combustibile]
    set cod_responsabile        [element::get_value $form_name cod_responsabile]
    set cogn_responsabile       [element::get_value $form_name cogn_responsabile]
    set nome_responsabile       [element::get_value $form_name nome_responsabile]
    set prog_anom_max           [element::get_value $form_name prog_anom_max]
    set list_anom_old           [element::get_value $form_name list_anom_old]

    set new1_data_dimp          [element::get_value $form_name new1_data_dimp]
    set new1_data_paga_dimp     [element::get_value $form_name new1_data_paga_dimp]
    set new1_conf_accesso       [element::get_value $form_name new1_conf_accesso]
    set new1_pres_intercet      [element::get_value $form_name new1_pres_intercet]
    set new1_pres_interrut      [element::get_value $form_name new1_pres_interrut]
    set new1_asse_mate_estr     [element::get_value $form_name new1_asse_mate_estr]
    set new1_pres_mezzi         [element::get_value $form_name new1_pres_mezzi]
    set new1_pres_cartell       [element::get_value $form_name new1_pres_cartell]
    set new1_lavoro_nom_iniz    [element::get_value $form_name new1_lavoro_nom_iniz]
    set new1_lavoro_nom_fine    [element::get_value $form_name new1_lavoro_nom_fine]
    set new1_lavoro_lib_iniz    [element::get_value $form_name new1_lavoro_lib_iniz]
    set new1_lavoro_lib_fine    [element::get_value $form_name new1_lavoro_lib_fine]
    set new1_note_manu          [element::get_value $form_name new1_note_manu]
    set new1_data_ultima_manu   [element::get_value $form_name new1_data_ultima_manu]
    set new1_data_ultima_anal   [element::get_value $form_name new1_data_ultima_anal]
    set new1_manu_prec_8a       [element::get_value $form_name new1_manu_prec_8a]
    set new1_co_rilevato        [element::get_value $form_name new1_co_rilevato]
    set new1_dimp_pres          [element::get_value $form_name new1_dimp_pres]
    set new1_dimp_prescriz      [element::get_value $form_name new1_dimp_prescriz]
    set new1_flag_peri_8p       [element::get_value $form_name new1_flag_peri_8p]
    set n_prot                  [element::get_value $form_name n_prot]
    set data_prot               [element::get_value $form_name data_prot]
    set verb_n                  [element::get_value $form_name verb_n]
    set data_verb               [element::get_value $form_name data_verb]

    set volumetria              [element::get_value $form_name volumetria]
    set comsumi_ultima_stag     [element::get_value $form_name comsumi_ultima_stag]
    set temp_h2o_out_1a         [element::get_value $form_name temp_h2o_out_1a]
    set temp_h2o_out_2a         [element::get_value $form_name temp_h2o_out_2a]
    set temp_h2o_out_3a         [element::get_value $form_name temp_h2o_out_3a]
    set t_aria_comb_1a          [element::get_value $form_name t_aria_comb_1a]
    set t_aria_comb_2a          [element::get_value $form_name t_aria_comb_2a]
    set t_aria_comb_3a          [element::get_value $form_name t_aria_comb_3a]
    set temp_fumi_1a            [element::get_value $form_name temp_fumi_1a]
    set temp_fumi_2a            [element::get_value $form_name temp_fumi_2a]
    set temp_fumi_3a            [element::get_value $form_name temp_fumi_3a]
    set co_1a                   [element::get_value $form_name co_1a]
    set co_2a                   [element::get_value $form_name co_2a]
    set co_3a                   [element::get_value $form_name co_3a]
    set co2_1a                  [element::get_value $form_name co2_1a]
    set co2_2a                  [element::get_value $form_name co2_2a]
    set co2_3a                  [element::get_value $form_name co2_3a]
    set o2_1a                   [element::get_value $form_name o2_1a]
    set o2_2a                   [element::get_value $form_name o2_2a]
    set o2_3a                   [element::get_value $form_name o2_3a]
    set ubic_locale_norma       [element::get_value $form_name ubic_locale_norma]
    set doc_ispesl              [element::get_value $form_name doc_ispesl]
    set libr_manut_bruc         [element::get_value $form_name libr_manut_bruc]
    set conf_imp_elettrico      [element::get_value $form_name conf_imp_elettrico]
    set doc_prev_incendi        [element::get_value $form_name doc_prev_incendi]
    set cod_sanzione_1          [element::get_value $form_name cod_sanzione_1]
    set cod_sanzione_2          [element::get_value $form_name cod_sanzione_2]
    set tiraggio                [element::get_value $form_name tiraggio]
    set rendimento_min_notice   [element::get_value $form_name rendimento_min_notice]
    set cod_strumento_01        [element::get_value $form_name cod_strumento_01]
    set cod_strumento_02        [element::get_value $form_name cod_strumento_02]


    set riferimento_pag_bollini     [element::get_value $form_name riferimento_pag_bollini]
    set scarico_dir_esterno    [element::get_value $form_name scarico_dir_esterno]
    set rend_suff_insuff       [element::get_value $form_name rend_suff_insuff]
    set dichiarato             [element::get_value $form_name dichiarato]
    set et                     [element::get_value $form_name et]
    set data_284               [element::get_value $form_name data_284]
    set flag_pres_284          [element::get_value $form_name flag_pres_284]
    set flag_comp_284          [element::get_value $form_name flag_comp_284]


    set conta 0
    while {$conta < 5} {
	incr conta
	set prog_anom($conta)   [element::get_value $form_name prog_anom.$conta]
	set cod_anom($conta)    [element::get_value $form_name cod_anom.$conta]
	set data_ut_int($conta) [element::get_value $form_name data_ut_int.$conta]
    }

    # leggo i dati dell'impianto e del generatore
    eval $prep_aimp_e_gend
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    set flag_errore_pot_focolare_nom_ok "f"

    if {$funzione == "I"
    ||  $funzione == "M"
    } {

       # controlli sui campi obbligatori e non modificabile da questa maschera
	eval $verifiche_aimp_gend

	set mess_err_sanz1 ""
	set mess_err_sanz2 ""
	set mess_err_sanz ""

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

	#verifico responsabile

        if {[string equal $cogn_responsabile ""]
	&&  [string equal $nome_responsabile ""]
	} {
            set cod_responsabile ""
	} else {
	    set chk_inp_cod_citt $cod_responsabile
	    set chk_inp_cognome  $cogn_responsabile
	    set chk_inp_nome     $nome_responsabile
	    eval $check_cod_citt
            set cod_responsabile $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cogn_responsabile $chk_out_msg
                incr error_num
	    }
	}


	set cinc_data_inizio ""
	set cinc_data_fine   ""
	set data_assegn      ""
	if {![string equal $cod_inco ""]} {
	    if {[db_0or1row sel_inco ""] == 0} {
		element::set_error $form_name cod_inco "Appuntamento non esistente"
		incr error_num
	    } else {
		if {$inco_cod_impianto != $cod_impianto} {
		    element::set_error $form_name cod_inco "Appuntamento relativo ad un altro impianto"
		    incr error_num
		}

		if {![string equal $cod_cinc  ""]} {
		    # estraggo, cinc_data_inizio e cinc_data_fine, default ""
		    db_0or1row sel_cinc ""
		}
	    }
	}

	set sw_data_controllo_ok "f"
        if {[string equal $data_controllo ""]} {
            element::set_error $form_name data_controllo "Inserire Data verifica"
            incr error_num
        } else {
            set data_controllo [iter_check_date $data_controllo]
            if {$data_controllo == 0} {
                element::set_error $form_name data_controllo "Data non corretta"
                incr error_num
            } else {
		if {$data_controllo > $current_date} {
		    set flag_errore_data_controllo "t"
		    element::set_error $form_name data_controllo "Data controllo deve essere inferiore alla data odierna"
		    incr error_num
		} else {

		    if {![string is space $cinc_data_inizio]
		    &&  ![string is space $cinc_data_fine]
		    &&  (   $data_controllo < $cinc_data_inizio
			 || $data_controllo > $cinc_data_fine)
		    } {
			element::set_error $form_name data_controllo "Data non compresa nella campagna dell'appuntamento (fra il [iter_edit_date $cinc_data_inizio] ed il [iter_edit_date $cinc_data_fine]"
			incr error_num
		    } else {
			if {$funzione == "M"} {
			    set where_cod_cimp "and cod_cimp <> :cod_cimp"
			} else {
			    set where_cod_cimp ""
			}
			
			if {[db_string sel_cimp_count_dup ""] > 0} {
			    element::set_error $form_name data_controllo "Esiste gi&agrave; un rapporto di verifica su questo generatore in questa data"
			    incr error_num
			} else {
			    set sw_data_controllo_ok "t"
			    if {[string equal $data_assegn ""]} {
				set data_assegn $data_controllo
			    }
			}
		    }
		}
	    }
	}

	if {[string equal $cod_opve ""]} {
	    element::set_error $form_name cod_opve "Inserire il verificatore"
	    incr error_num
	}
    
        if {![string equal $mis_port_combust ""]} {
            set mis_port_combust [iter_check_num $mis_port_combust 2]
            if {$mis_port_combust == "Error"} {
                element::set_error $form_name mis_port_combust "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $mis_port_combust] >=  [expr pow(10,7)]
		||  [iter_set_double $mis_port_combust] <= -[expr pow(10,7)]} {
                    element::set_error $form_name mis_port_combust "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $tiraggio ""]} {
            set tiraggio [iter_check_num $tiraggio 4]
            if {$tiraggio == "Error"} {
                element::set_error $form_name tiraggio "Deve essere numerico, max 4 dec"
                incr error_num
            } else {
                if {[iter_set_double $tiraggio] >=  [expr pow(10,7)]
		||  [iter_set_double $tiraggio] <= -[expr pow(10,7)]} {
                    element::set_error $form_name tiraggio "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }
	
        if {![string equal $mis_pot_focolare ""]} {
            set mis_pot_focolare [iter_check_num $mis_pot_focolare 2]
            if {$mis_pot_focolare == "Error"} {
                element::set_error $form_name mis_pot_focolare "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $mis_pot_focolare] >=  [expr pow(10,7)]
                ||  [iter_set_double $mis_pot_focolare] <= -[expr pow(10,7)]} {
                    element::set_error $form_name mis_pot_focolare "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }
    
	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
        if {[string equal $rend_comb_conv ""]} {
	    if {$indic_fumosita_md <= 3
		&& $cod_combustibile == $cod_check_comb} {
		element::set_error $form_name rend_comb_conv "Inserire"
		incr error_num
	    }		
	} else {
            set rend_comb_conv [iter_check_num $rend_comb_conv 2]
            if {$rend_comb_conv == "Error"} {
                element::set_error $form_name rend_comb_conv "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $rend_comb_conv] >=  [expr pow(10,7)]
                ||  [iter_set_double $rend_comb_conv] <= -[expr pow(10,7)]} {
                    element::set_error $form_name rend_comb_conv "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $volumetria ""]} {
            set volumetria [iter_check_num $volumetria 2]
            if {$volumetria == "Error"} {
                element::set_error $form_name volumetria "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $volumetria] >=  [expr pow(10,7)]
		||  [iter_set_double $volumetria] <= -[expr pow(10,7)]} {
                    element::set_error $form_name volumetria "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $comsumi_ultima_stag ""]} {
            set comsumi_ultima_stag [iter_check_num $comsumi_ultima_stag 2]
            if {$comsumi_ultima_stag == "Error"} {
                element::set_error $form_name comsumi_ultima_stag "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $comsumi_ultima_stag] >=  [expr pow(10,7)]
		||  [iter_set_double $comsumi_ultima_stag] <= -[expr pow(10,7)]} {
                    element::set_error $form_name comsumi_ultima_stag "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

    
        if {![string equal $rend_comb_min ""]} {
            set rend_comb_min [iter_check_num $rend_comb_min 2]
            if {$rend_comb_min == "Error"} {
                element::set_error $form_name rend_comb_min "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $rend_comb_min] >=  [expr pow(10,7)]
                ||  [iter_set_double $rend_comb_min] <= -[expr pow(10,7)]} {
                    element::set_error $form_name rend_comb_min "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }
    

	if {![string equal $temp_fumi_1a ""]} {
            set temp_fumi_1a [iter_check_num $temp_fumi_1a 2]
            if {$temp_fumi_1a == "Error"} {
                element::set_error $form_name temp_fumi_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_fumi_1a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_fumi_1a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_fumi_1a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }        
	if {![string equal $temp_fumi_2a ""]} {
            set temp_fumi_2a [iter_check_num $temp_fumi_2a 2]
            if {$temp_fumi_2a == "Error"} {
                element::set_error $form_name temp_fumi_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_fumi_2a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_fumi_2a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_fumi_2a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }      
	if {![string equal $temp_fumi_3a ""]} {
            set temp_fumi_3a [iter_check_num $temp_fumi_3a 2]
            if {$temp_fumi_3a == "Error"} {
                element::set_error $form_name temp_fumi_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_fumi_3a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_fumi_3a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_fumi_3a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

	# Temperatura Fumi
	if {[string equal $temp_fumi_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $temp_fumi_1a ""] && ![string equal $temp_fumi_2a ""] && ![string equal $temp_fumi_3a ""]} {
		set temp_fumi_md [expr ($temp_fumi_1a + $temp_fumi_2a + $temp_fumi_3a) / 3.00]
		set temp_fumi_md [db_string query "select iter_edit_num(:temp_fumi_md, 2)"]
		set temp_fumi_md [iter_check_num $temp_fumi_md 2]
		if {$temp_fumi_md == "Error"} {
		    element::set_error $form_name temp_fumi_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $temp_fumi_md] >=  [expr pow(10,4)]
			||  [iter_set_double $temp_fumi_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name temp_fumi_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set temp_fumi_md [iter_check_num $temp_fumi_md 2]
	    if {$temp_fumi_md == "Error"} {
		element::set_error $form_name temp_fumi_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $temp_fumi_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_fumi_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name temp_fumi_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}
    
	# Temperatura aria comburente
        if {![string equal $t_aria_comb_1a ""]} {
            set t_aria_comb_1a [iter_check_num $t_aria_comb_1a 2]
            if {$t_aria_comb_1a == "Error"} {
                element::set_error $form_name t_aria_comb_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $t_aria_comb_1a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $t_aria_comb_1a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name t_aria_comb_1a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
        if {![string equal $t_aria_comb_2a ""]} {
            set t_aria_comb_2a [iter_check_num $t_aria_comb_2a 2]
            if {$t_aria_comb_2a == "Error"} {
                element::set_error $form_name t_aria_comb_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $t_aria_comb_2a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $t_aria_comb_2a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name t_aria_comb_2a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
        if {![string equal $t_aria_comb_3a ""]} {
            set t_aria_comb_3a [iter_check_num $t_aria_comb_3a 2]
            if {$t_aria_comb_3a == "Error"} {
                element::set_error $form_name t_aria_comb_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $t_aria_comb_3a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $t_aria_comb_3a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name t_aria_comb_3a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
	if {[string equal $t_aria_comb_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $t_aria_comb_1a ""] && ![string equal $t_aria_comb_2a ""] && ![string equal $t_aria_comb_3a ""]} {
		set t_aria_comb_md [expr ($t_aria_comb_1a + $t_aria_comb_2a + $t_aria_comb_3a) / 3.00]
		set t_aria_comb_md [db_string query "select iter_edit_num(:t_aria_comb_md, 2)"]
		set t_aria_comb_md [iter_check_num $t_aria_comb_md 2]
		if {$t_aria_comb_md == "Error"} {
		    element::set_error $form_name t_aria_comb_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $t_aria_comb_md] >=  [expr pow(10,4)]
			||  [iter_set_double $t_aria_comb_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name t_aria_comb_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set t_aria_comb_md [iter_check_num $t_aria_comb_md 2]
	    if {$t_aria_comb_md == "Error"} {
		element::set_error $form_name t_aria_comb_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $t_aria_comb_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $t_aria_comb_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name t_aria_comb_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}


	# Temperatura mantello
        if {![string equal $temp_mant_md ""]} {
            set temp_mant_md [iter_check_num $temp_mant_md 2]
            if {$temp_mant_md == "Error"} {
                element::set_error $form_name temp_mant_1a "Valore medio deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_mant_md] >=  [expr pow(10,4)]
                ||  [iter_set_double $temp_mant_md] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_mant_1a "Valore medio deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }


	# Temperaura fluido in mandata
	if {![string equal $temp_h2o_out_1a ""]} {
            set temp_h2o_out_1a [iter_check_num $temp_h2o_out_1a 2]
            if {$temp_h2o_out_1a == "Error"} {
                element::set_error $form_name temp_h2o_out_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_h2o_out_1a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_h2o_out_1a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_h2o_out_1a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
        if {![string equal $temp_h2o_out_2a ""]} {
            set temp_h2o_out_2a [iter_check_num $temp_h2o_out_2a 2]
            if {$temp_h2o_out_2a == "Error"} {
                element::set_error $form_name temp_h2o_out_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_h2o_out_2a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_h2o_out_2a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_h2o_out_2a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
        if {![string equal $temp_h2o_out_3a ""]} {
            set temp_h2o_out_3a [iter_check_num $temp_h2o_out_3a 2]
            if {$temp_h2o_out_3a == "Error"} {
                element::set_error $form_name temp_h2o_out_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $temp_h2o_out_3a] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_h2o_out_3a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name temp_h2o_out_3a "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }
	if {[string equal $temp_h2o_out_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $temp_h2o_out_1a ""] && ![string equal $temp_h2o_out_2a ""] && ![string equal $temp_h2o_out_3a ""]} {
		set temp_h2o_out_md [expr ($temp_h2o_out_1a + $temp_h2o_out_2a + $temp_h2o_out_3a) / 3.00]
		set temp_h2o_out_md [db_string query "select iter_edit_num(:temp_h2o_out_md, 2)"]
		set temp_h2o_out_md [iter_check_num $temp_h2o_out_md 2]
	if {$temp_h2o_out_md == "Error"} {
		    element::set_error $form_name temp_h2o_out_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $temp_h2o_out_md] >=  [expr pow(10,4)]
			||  [iter_set_double $temp_h2o_out_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name temp_h2o_out_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set temp_h2o_out_md [iter_check_num $temp_h2o_out_md 2]
	    if {$temp_h2o_out_md == "Error"} {
		element::set_error $form_name temp_h2o_out_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $temp_h2o_out_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $temp_h2o_out_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name temp_h2o_out_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}


	# CO2
        if {![string equal $co2_1a ""]} {
            set co2_1a [iter_check_num $co2_1a 2]
            if {$co2_1a == "Error"} {
                element::set_error $form_name co2_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co2_1a] >  [expr pow(10,2)]
		    ||  [iter_set_double $co2_1a] < -[expr pow(10,2)]} {
                    element::set_error $form_name co2_1a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
        if {![string equal $co2_2a ""]} {
            set co2_2a [iter_check_num $co2_2a 2]
            if {$co2_2a == "Error"} {
                element::set_error $form_name co2_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co2_2a] >  [expr pow(10,2)]
		    ||  [iter_set_double $co2_2a] < -[expr pow(10,2)]} {
                    element::set_error $form_name co2_2a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
        if {![string equal $co2_3a ""]} {
            set co2_3a [iter_check_num $co2_3a 2]
            if {$co2_3a == "Error"} {
                element::set_error $form_name co2_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co2_3a] >  [expr pow(10,2)]
		    ||  [iter_set_double $co2_3a] < -[expr pow(10,2)]} {
                    element::set_error $form_name co2_3a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
	if {[string equal $co2_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $co2_1a ""] && ![string equal $co2_2a ""] && ![string equal $co2_3a ""]} {
		set co2_md [expr ($co2_1a + $co2_2a + $co2_3a) / 3.00]
		set co2_md [db_string query "select iter_edit_num(:co2_md, 2)"]
		set co2_md [iter_check_num $co2_md 2]
		if {$co2_md == "Error"} {
		    element::set_error $form_name co2_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $co2_md] >=  [expr pow(10,4)]
			||  [iter_set_double $co2_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name co2_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set co2_md [iter_check_num $co2_md 2]
	    if {$co2_md == "Error"} {
		element::set_error $form_name co2_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $co2_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $co2_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name co2_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}


	# O2
        if {![string equal $o2_1a ""]} {
            set o2_1a [iter_check_num $o2_1a 2]
            if {$o2_1a == "Error"} {
                element::set_error $form_name o2_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $o2_1a] >  [expr pow(10,2)]
		    ||  [iter_set_double $o2_1a] < -[expr pow(10,2)]} {
                    element::set_error $form_name o2_1a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
        if {![string equal $o2_2a ""]} {
            set o2_2a [iter_check_num $o2_2a 2]
            if {$o2_2a == "Error"} {
                element::set_error $form_name o2_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $o2_2a] >  [expr pow(10,2)]
		    ||  [iter_set_double $o2_2a] < -[expr pow(10,2)]} {
                    element::set_error $form_name o2_2a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
        if {![string equal $o2_3a ""]} {
            set o2_3a [iter_check_num $o2_3a 2]
            if {$o2_3a == "Error"} {
                element::set_error $form_name o2_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $o2_3a] >  [expr pow(10,2)]
		    ||  [iter_set_double $o2_3a] < -[expr pow(10,2)]} {
                    element::set_error $form_name o2_3a "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }
	if {[string equal $o2_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $o2_1a ""] && ![string equal $o2_2a ""] && ![string equal $o2_3a ""]} {
		set o2_md [expr ($o2_1a + $o2_2a + $o2_3a) / 3.00]
		set o2_md [db_string query "select iter_edit_num(:o2_md, 2)"]
		set o2_md [iter_check_num $o2_md 2]
		if {$o2_md == "Error"} {
		    element::set_error $form_name o2_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $o2_md] >=  [expr pow(10,4)]
			||  [iter_set_double $o2_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name o2_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set o2_md [iter_check_num $o2_md 2]
	    if {$o2_md == "Error"} {
		element::set_error $form_name o2_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $o2_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $o2_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name o2_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}
	

	# CO
        if {![string equal $co_1a ""]} {
            set co_1a [iter_check_num $co_1a 2]
            if {$co_1a == "Error"} {
                element::set_error $form_name co_1a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co_1a] >=  [expr pow(10,5)]
		    ||  [iter_set_double $co_1a] <= -[expr pow(10,5)]} {
                    element::set_error $form_name co_1a "Deve essere inferiore di 100.000"
                    incr error_num
                }
            }
        }
        if {![string equal $co_2a ""]} {
            set co_2a [iter_check_num $co_2a 2]
            if {$co_2a == "Error"} {
                element::set_error $form_name co_2a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co_2a] >=  [expr pow(10,5)]
		    ||  [iter_set_double $co_2a] <= -[expr pow(10,5)]} {
                    element::set_error $form_name co_2a "Deve essere inferiore di 100.000"
                    incr error_num
                }
            }
        }
        if {![string equal $co_3a ""]} {
            set co_3a [iter_check_num $co_3a 2]
            if {$co_3a == "Error"} {
                element::set_error $form_name co_3a "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $co_3a] >=  [expr pow(10,5)]
		    ||  [iter_set_double $co_3a] <= -[expr pow(10,5)]} {
                    element::set_error $form_name co_3a "Deve essere inferiore di 100.000"
                    incr error_num
                }
            }
        }
	if {[string equal $co_md ""]} {
	    # se non è valorizzato, calcolo la media dei 3 valori inseriti
	    if {![string equal $co_1a ""] && ![string equal $co_2a ""] && ![string equal $co_3a ""]} {
		set co_md [expr ($co_1a + $co_2a + $co_3a) / 3.00]
		set co_md [db_string query "select iter_edit_num(:co_md, 2)"]
		set co_md [iter_check_num $co_md 2]
		if {$co_md == "Error"} {
		    element::set_error $form_name co_md "Deve essere numerico, max 2 dec"
		    incr error_num
		} else {
		    if {[iter_set_double $co_md] >=  [expr pow(10,4)]
			||  [iter_set_double $co_md] <= -[expr pow(10,4)]} {
			element::set_error $form_name co_md "Deve essere inferiore di 10.000"
			incr error_num
		    }
		}
	    }
        } else {
	    # se è valorizzato, controllo il valore che deve essere numerico
	    set co_md [iter_check_num $co_md 2]
	    if {$co_md == "Error"} {
		element::set_error $form_name co_md "Deve essere numerico, max 2 dec"
		incr error_num
	    } else {
		if {[iter_set_double $co_md] >=  [expr pow(10,4)]
		    ||  [iter_set_double $co_md] <= -[expr pow(10,4)]} {
		    element::set_error $form_name co_md "Deve essere inferiore di 10.000"
		    incr error_num
		}
	    }
	}


        if {![string equal $indic_fumosita_md ""]} {
            set indic_fumosita_md [iter_check_num $indic_fumosita_md 2]
            if {$indic_fumosita_md == "Error"} {
                element::set_error $form_name indic_fumosita_md "Valore medio deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $indic_fumosita_md] >=  [expr pow(10,4)]
                ||  [iter_set_double $indic_fumosita_md] <= -[expr pow(10,4)]} {
                    element::set_error $form_name indic_fumosita_md "Valore medio deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
        if {[string equal $indic_fumosita_3a ""]} {
	    if {$cod_combustibile == $cod_check_comb} {
		element::set_error $form_name indic_fumosita_3a "Inserire"
                incr error_num
	    }
	} else {
            set indic_fumosita_3a [iter_check_num $indic_fumosita_3a 2]
            if {$indic_fumosita_3a == "Error"} {
                element::set_error $form_name indic_fumosita_3a "3&deg; lettura deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $indic_fumosita_3a] >=  [expr pow(10,4)]
                ||  [iter_set_double $indic_fumosita_3a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name indic_fumosita_3a "3&deg; lettura deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
        if {[string equal $indic_fumosita_2a ""]} {
	    if {$cod_combustibile == $cod_check_comb} {
		element::set_error $form_name indic_fumosita_2a "Inserire"
                incr error_num
	    }
	} else {
            set indic_fumosita_2a [iter_check_num $indic_fumosita_2a 2]
            if {$indic_fumosita_2a == "Error"} {
                element::set_error $form_name indic_fumosita_2a "2&deg; lettura deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $indic_fumosita_2a] >=  [expr pow(10,4)]
                ||  [iter_set_double $indic_fumosita_2a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name indic_fumosita_2a "2&deg; lettura deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
        if {[string equal $indic_fumosita_1a ""]} {
	    if {$cod_combustibile == $cod_check_comb} {
		element::set_error $form_name indic_fumosita_1a "Inserire"
                incr error_num
	    }
	} else {
            set indic_fumosita_1a [iter_check_num $indic_fumosita_1a 2]
            if {$indic_fumosita_1a == "Error"} {
                element::set_error $form_name indic_fumosita_1a "1&deg; lettura deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $indic_fumosita_1a] >=  [expr pow(10,4)]
                ||  [iter_set_double $indic_fumosita_1a] <= -[expr pow(10,4)]} {
                    element::set_error $form_name indic_fumosita_1a "1&deg; lettura deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $data_prot ""]} {
            set data_prot [iter_check_date $data_prot]
            if {$data_prot == 0} {
                element::set_error $form_name data_prot "Data non corretta"
                incr error_num
            } else {
		if {$data_prot > $current_date} {
		    element::set_error $form_name data_prot "Data protocollo deve essere inferiore alla data odierna"
		    incr error_num
		}
	    }
	}

        if {![string equal $data_verb ""]} {
            set data_verb [iter_check_date $data_verb]
            if {$data_verb == 0} {
                element::set_error $form_name data_verb "Data non corretta"
                incr error_num
            } else {
		if {$data_verb > $current_date} {
		    element::set_error $form_name data_verb "Data verbale deve essere inferiore alla data odierna"
		    incr error_num
		}
	    }
        }

      if {![string equal $et ""]} {
            set et [iter_check_num $et 2]
            if {$et == "Error"} {
                element::set_error $form_name et "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $et] >=  [expr pow(10,4)]
		    ||  [iter_set_double $et] <= -[expr pow(10,4)]} {
                    element::set_error $form_name et "Deve essere inferiore di 100"
                    incr error_num
                }
            }
        }


	set sw_new1_data_dimp_ok "f"
        if {![string equal $new1_data_dimp ""]} {
            set new1_data_dimp [iter_check_date $new1_data_dimp]
            if {$new1_data_dimp == 0} {
                element::set_error $form_name new1_data_dimp "Data non corretta"
                incr error_num
            } else {
		set sw_new1_data_dimp_ok "t"
	    }
        }

        if {![string equal $new1_data_paga_dimp ""]} {
            set new1_data_paga_dimp [iter_check_date $new1_data_paga_dimp]
            if {$new1_data_paga_dimp == 0} {
                element::set_error $form_name new1_data_paga_dimp "Data non corretta"
                incr error_num
            }
        }

     if {![string equal $data_284 ""]} {
            set data_284 [iter_check_date $data_284]
            if {$data_284== 0} {
                element::set_error $form_name data_284 "Data non corretta"
                incr error_num
            }
        }


	set sw_costo_null "f"
        if {![string equal $costo ""]} {
            set costo [iter_check_num $costo 2]
            if {$costo == "Error"} {
                element::set_error $form_name costo "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $costo] >=  [expr pow(10,7)]
		||  [iter_set_double $costo] <= -[expr pow(10,7)]} {
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

	# costo e' obbligatorio se sono stati indicati gli altri estremi
	# del pagamento
        if {$flag_sanzioni == "N"} {
	    if {$sw_costo_null == "t"} {
		if {![string equal $tipologia_costo ""]
		    ||   $flag_pagato == "S"
		} {
		    element::set_error $form_name costo "Inserire il costo"
		    incr error_num
		}
	    }
	}

	# se l'impianto e' <= 35kW, la data dell'ultimo modello h e' >= alla 
	# data controllo meno 2 anni e il costo > 0
	# segnalo che in questo caso il controllo � gratuido
        if {$flag_sanzioni == "N"} {
	    if {$pot_focolare_nom     <= 35
		&&  $sw_costo_null        == "f"
		&&  $sw_data_controllo_ok == "t"
		&&  $sw_new1_data_dimp_ok == "t"
		&&  $new1_data_dimp       >= [clock format [clock scan "$data_controllo -2 years"] -f "%Y%m%d"]
	    } {
		element::set_error $form_name costo "Gratuito per impianti inferiori a 35 kW e con modello H compilato negli ultimi due anni"
		incr error_num
	    }
	}

	# tipologia costo e' obbligatoria se sono stati indicati
	# gli altri estremi del pagamento
        if {$flag_sanzioni == "N"} {
	    if {[string equal $tipologia_costo ""]} {
		if {$sw_costo_null == "f"
		    ||  $flag_pagato   == "S"
		} {
		    element::set_error $form_name tipologia_costo "Inserire la tipologia del costo"
		    incr error_num
		}
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
	    # devo calcolarla in automatico:            # se il pagamento e' effettua
	    # se il pagamento e' effettuato,               con data controllo
	    # se il pagamento e' avvenuto tramite bollino, con data controllo
	    # negli altri casi con data controllo + gg_scad_pag_rv
	    # che e' un parametro di procedura.
            if {$flag_sanzioni == "N"} {
		if {![string equal $tipologia_costo ""]
		    ||  $sw_costo_null == "f"
		    ||  $flag_pagato   == "S"
		} {
		    if {$tipologia_costo == "BO"
			||  $flag_pagato     == "S"
			||  [string equal $gg_scad_pag_rv ""]
		    } {
			# se data_controllo non e' corretta, viene gia' segnalato
			# l'errore sulla data_controllo.
			if {$sw_data_controllo_ok == "t"} {
			    set data_scad_pagamento $data_controllo
			}
		    } else {
			# se data_controllo non e' corretta, viene gia' segnalato
			# l'errore sulla data_controllo.
			if {$sw_data_controllo_ok == "t"} {
			    set data_scad_pagamento [clock format [clock scan "$gg_scad_pag_rv day" -base [clock scan $data_controllo]] -f "%Y%m%d"]
			}
		    }
		}
	    } else {
		if {$sw_data_controllo_ok == "t"} {
		    set data_scad_pagamento [clock format [clock scan "$gg_scad_pag_rv day" -base [clock scan $data_controllo]] -f "%Y%m%d"]
		}
	    }
	}

	if {$flag_sanzioni == "N"} {
	    set sw_movi     "f"
	    set data_pag    ""
	    set importo_pag ""
	    if {$sw_costo_null == "f"
		&& ![string equal $tipologia_costo ""]
	    } {
		set sw_movi "t"
		if {$flag_pagato == "S"} {
		    set data_pag    $data_scad_pagamento
		    set importo_pag $costo
		}
	    }
	} else {
	    if {![string equal $cod_sanzione_1 ""]
	     || ![string equal $cod_sanzione_2 ""]} {
		set importo_min1 0
		set importo_min2 0
		set tipo_soggetto_1 ""
		set tipo_soggetto_2 ""
		if {![string equal $cod_sanzione_1 ""]} {
		    db_0or1row sel_imp_1 ""
		}
		if {![string equal $cod_sanzione_2 ""]} {
		    db_0or1row sel_imp_2 ""
		}
		if {[string equal $costo ""]} {
		    set costo [expr $importo_min1 + $importo_min2]
		}
		if {$tipo_soggetto_1 == "M"
		    && [string equal $cod_manutentore ""]} {
		    element::set_error $form_name cod_sanzione_1 "Soggetto della sanzione mancante (aggiornare manutentore)."
		    incr error_num
		}
		
		if {$tipo_soggetto_2 == "M"
		    && [string equal $cod_manutentore ""]} {
		    element::set_error $form_name cod_sanzione_2 "Soggetto della sanzione mancante (aggiornare manutentore)."
		    incr error_num
		}
	    }
	}


        if {[string equal $pot_utile_nom ""]} {
	    element::set_error $form_name pot_utile_nom "Inserire"
	    incr error_num
	} else {
            set pot_utile_nom [iter_check_num $pot_utile_nom 2]
            if {$pot_utile_nom == "Error"} {
                element::set_error $form_name pot_utile_nom "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $pot_utile_nom] >=  [expr pow(10,7)]
                ||  [iter_set_double $pot_utile_nom] <= -[expr pow(10,7)]} {
                    element::set_error $form_name pot_utile_nom "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {[string equal $pot_focolare_nom ""]} {
	    element::set_error $form_name pot_focolare_nom "Inserire"
	    incr error_num
	} else {
            set pot_focolare_nom [iter_check_num $pot_focolare_nom 2]
            if {$pot_focolare_nom == "Error"} {
		set flag_errore_pot_focolare_nom_ok "t"
                element::set_error $form_name pot_focolare_nom "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $pot_focolare_nom] >=  [expr pow(10,7)]
                ||  [iter_set_double $pot_focolare_nom] <= -[expr pow(10,7)]} {
                    element::set_error $form_name pot_focolare_nom "Deve essere inferiore di 10.000.000"
                    incr error_num
		    set flag_errore_pot_focolare_nom_ok "t"
                }
            }
        }
	if {![string equal $new1_lavoro_nom_iniz ""]} {
            set new1_lavoro_nom_iniz [iter_check_num $new1_lavoro_nom_iniz 2]
            if {$new1_lavoro_nom_iniz == "Error"} {
               element::set_error $form_name new1_lavoro_nom_fine "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $new1_lavoro_nom_iniz] >=  [expr pow(10,7)]
                ||  [iter_set_double $new1_lavoro_nom_iniz] <= -[expr pow(10,7)]} {
                    element::set_error $form_name new1_lavoro_nom_fine "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $new1_lavoro_nom_fine ""]} {
            set new1_lavoro_nom_fine [iter_check_num $new1_lavoro_nom_fine 2]
            if {$new1_lavoro_nom_fine == "Error"} {
                element::set_error $form_name new1_lavoro_nom_fine "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $new1_lavoro_nom_fine] >=  [expr pow(10,7)]
                ||  [iter_set_double $new1_lavoro_nom_fine] <= -[expr pow(10,7)]} {
                    element::set_error $form_name new1_lavoro_nom_fine "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $new1_lavoro_lib_iniz ""]} {
            set new1_lavoro_lib_iniz [iter_check_num $new1_lavoro_lib_iniz 2]
            if {$new1_lavoro_lib_iniz == "Error"} {
                element::set_error $form_name new1_lavoro_lib_fine "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $new1_lavoro_lib_iniz] >=  [expr pow(10,7)]
                ||  [iter_set_double $new1_lavoro_lib_iniz] <= -[expr pow(10,7)]} {
                    element::set_error $form_name new1_lavoro_lib_fine "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $new1_lavoro_lib_fine ""]} {
            set new1_lavoro_lib_fine [iter_check_num $new1_lavoro_lib_fine 2]
            if {$new1_lavoro_lib_fine == "Error"} {
                element::set_error $form_name new1_lavoro_lib_fine "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $new1_lavoro_lib_fine] >=  [expr pow(10,7)]
                ||  [iter_set_double $new1_lavoro_lib_fine] <= -[expr pow(10,7)]} {
                    element::set_error $form_name new1_lavoro_lib_fine "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }


	if {![string equal $new1_co_rilevato ""]} {
            set new1_co_rilevato [iter_check_num $new1_co_rilevato 2]
            if {$new1_co_rilevato == "Error"} {
                element::set_error $form_name new1_co_rilevato "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $new1_co_rilevato] >=  [expr pow(10,4)]
                ||  [iter_set_double $new1_co_rilevato] <= -[expr pow(10,4)]} {
                    element::set_error $form_name new1_co_rilevato "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $new1_data_ultima_manu ""]} {
            set new1_data_ultima_manu [iter_check_date $new1_data_ultima_manu]
            if {$new1_data_ultima_manu == 0} {
                element::set_error $form_name new1_data_ultima_manu "Data non corretta"
                incr error_num
            } else {
		if {$new1_data_ultima_manu > $current_date} {
		    element::set_error $form_name new1_data_ultima_manu  "Deve essere inferiore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $new1_data_ultima_anal ""]} {
            set new1_data_ultima_anal [iter_check_date $new1_data_ultima_anal]
            if {$new1_data_ultima_anal == 0} {
                element::set_error $form_name new1_data_ultima_anal "Data non corretta"
                incr error_num
            } else {
		if {$new1_data_ultima_anal > $current_date} {
		    element::set_error $form_name new1_data_ultima_anal  "Deve essere inferiore alla data odierna"
		    incr error_num
		}
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
		&&  [db_string sel_anom_count_dup ""] >= 1
		} {
		    element::set_error $form_name cod_anom.$conta "Anomalia gi&agrave; presente"
		    incr error_num
		}
	    }
	}

	if {[string equal $cod_combustibile ""]} {
	    element::set_error $form_name cod_combustibile "Inserire il combustibile"
	    incr error_num
	}

	if {[string equal $presenza_libretto ""]} {
	    element::set_error $form_name presenza_libretto "Inserire la presenza libretto"
	    incr error_num
	}
	

	if {[string equal $new1_pres_interrut ""]} {
	    element::set_error $form_name new1_pres_interrut "Inserire"
	    incr error_num
	}
	
	if {[string equal $new1_asse_mate_estr ""]} {
	    element::set_error $form_name new1_asse_mate_estr "Inserire"
	    incr error_num		
	}
	
	if {[string equal $new1_conf_accesso ""]} {
	    element::set_error $form_name new1_conf_accesso "Inserire"
	    incr error_num		
	}
	
	if {[string equal $new1_pres_mezzi ""]} {
	    element::set_error $form_name new1_pres_mezzi "Inserire"
	    incr error_num		
	}
	
	if {[string equal $new1_pres_intercet ""]} {
	    element::set_error $form_name new1_pres_intercet "Inserire"
	    incr error_num		
	}
	if {[string equal $new1_pres_cartell ""]} {
	    element::set_error $form_name new1_pres_cartell "Inserire"
	    incr error_num		
	}  

	if {[string equal $verifica_areaz ""]} {
	    element::set_error $form_name verifica_areaz "Inserire"
	    incr error_num		
	}

	if {[string equal $manutenzione_8a ""]} {
	    element::set_error $form_name manutenzione_8a "Inserire"
	    incr error_num		
	}

	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
	if {[string equal $new1_co_rilevato ""]} {
	    if {$indic_fumosita_md <= 3
		&& $cod_combustibile == $cod_check_comb} {
		element::set_error $form_name new1_co_rilevato "Inserire"
		incr error_num		
	    }
	}
    
	db_1row sel_cod_comb "select cod_combustibile as cod_check_comb from coimcomb where descr_comb = 'GASOLIO'"
	if {[string equal $rend_comb_min ""]} {
	    if {$indic_fumosita_md <= 3 
		&& $cod_combustibile == $cod_check_comb} {
		element::set_error $form_name rend_comb_min "Inserire"
		incr error_num		
	    }
	}
    }

    if {$error_num > 0} {
	# segnalo la presenza di errori nella pagina
	set errore "<td valign=top align=center><font color=red><b>ATTENZIONE sono presenti degli errori nella pagina</b></font></td>"
        ad_return_template
        return
    } else {
#	ns_return 200 text/html $__refreshing_p; return
	if {[string equal $__refreshing_p "1"]} {
	    ad_return_template
	    return
	}
    }
    
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

	# controllo se esiste un modello H con data pi� recente, in questo caso non vado 
        # ad eseguire gli aggiornamenti
	if {[db_0or1row check_modh_old ""] == 0} {
	    set data_ultimo_modh "19000101"
	}

	set note_todo ""
	set flag_evasione_todo "E"

	set data_controllo_db    [string range $data_controllo 0 3]
	append data_controllo_db [string range $data_controllo 5 6]
	append data_controllo_db [string range $data_controllo 8 9]
	if {$data_controllo > $data_ultimo_modh} {

	    # edito potenza utile nominale
	    set pot_utile_nom_edit [iter_edit_num $pot_utile_nom 2]
	    if {[string equal $gend_pot_utile_nom ""]
	    ||  $gend_pot_utile_nom <= 0
	    } {
		set gend_pot_utile_nom_edit "NON NOTA"
	    } else {
		set gend_pot_utile_nom_edit [iter_edit_num $gend_pot_utile_nom 2]
		append gend_pot_utile_nom_edit " kW"
	    }

	    # dato che non bisogna cancellare i dati esistenti sul generatore, se
	    # il dato del rapporto di verifica e' null, allora evito di aggiornare
	    if {[string equal $pot_utile_nom ""]
	    ||  $pot_utile_nom <= 0
	    } {
		set pot_utile_nom_upd $gend_pot_utile_nom
	    } else {
		set pot_utile_nom_upd $pot_utile_nom
	    }
	    
	    # preparo le note da scrivere sui todo
	    if {$pot_utile_nom_upd != $gend_pot_utile_nom} {
		if {$flag_agg_da_verif == "T"} {
		    append note_todo "Potenza nominale utile del generatore aggiornata da $gend_pot_utile_nom_edit a $pot_utile_nom_edit kW\n"
		} else {
		    append note_todo "Potenza nominale utile del generatore ($gend_pot_utile_nom_edit) diversa da quella del rapporto di verifica ($pot_utile_nom_edit kW)\n"
		}
	    }
	    
	    # edito potenza focolare nominale
	    set pot_focolare_nom_edit [iter_edit_num $pot_focolare_nom     2]
	    if {[string equal $gend_pot_focolare_nom ""]
	    ||  $gend_pot_focolare_nom <= 0
	    } {
		set gend_pot_focolare_nom_edit "NON NOTA"
	    } else {
		set gend_pot_focolare_nom_edit [iter_edit_num $gend_pot_focolare_nom 2]
		append gend_pot_focolare_nom_edit " kW"
	    }

	    # dato che non bisogna cancellare i dati esistenti sul generatore, se
	    # il dato del rapporto di verifica e' null, allora evito di aggiornare
	    if {[string equal $pot_focolare_nom ""]
	    ||  $pot_focolare_nom <= 0
	    } {
		set pot_focolare_nom_upd $gend_pot_focolare_nom
	    } else {
		set pot_focolare_nom_upd $pot_focolare_nom
	    }

	    # preparo le note da scrivere sui todo
	    if {$pot_focolare_nom_upd != $gend_pot_focolare_nom} {
		if {$flag_agg_da_verif == "T"} {
		    append note_todo "Potenza nominale focolare del generatore aggiornata da $gend_pot_focolare_nom_edit a $pot_focolare_nom_edit kW\n"
		} else {
		    append note_todo "Potenza nominale focolare del generatore ($gend_pot_focolare_nom_edit) diversa da quella del rapporto di verifica ($pot_focolare_nom_edit kW)\n"
		}
	    }
	    
	    # leggo la descrizione del combustibile attualmente presente sul gend
	    set save_cod_combustibile $cod_combustibile
	    set cod_combustibile      $gend_cod_combustibile
	    if {[string equal $cod_combustibile ""]
	    ||  [db_0or1row sel_comb ""] == 0
	    ||  [string is space $descr_comb]
	    } {
		set descr_comb "NON NOTO"
	    }
	    set gend_descr_comb       $descr_comb
	    set cod_combustibile      $save_cod_combustibile
	    unset save_cod_combustibile
	    unset descr_comb
	    
	    # trovo la descrizione del combustibile
	    if {[string equal $cod_combustibile ""]
	    ||  [db_0or1row sel_comb ""] == 0
	    } {
		set descr_comb ""
	    }

	    # dato che non bisogna cancellare i dati esistenti sul generatore, se
	    # il dato del rapporto di verifica e' null, allora evito di aggiornare
	    if {[string equal $cod_combustibile ""]} {
		set cod_combustibile_upd $gend_cod_combustibile
	    } else {
		set cod_combustibile_upd $cod_combustibile
	    }
	    
	    # preparo le note da scrivere sui todo
	    if {$cod_combustibile_upd != $gend_cod_combustibile} {
		if {$flag_agg_da_verif == "T"} {
		    append note_todo "Combustibile del generatore aggiornato da $gend_descr_comb a $descr_comb\n"
		} else {
		    append note_todo "Combustibile del generatore ($gend_descr_comb) diverso da quello del rapporto di verifica ($descr_comb)\n"
		}
	    }
	
	    
	    # ho gia' cognome e nome del responsabile attualmente esistente su aimp
	    if {[string equal $aimp_cod_responsabile ""]} {
		set aimp_cogn_resp "NON"
		set aimp_nome_resp "NOTO"
	    }
	    
	    # dato che non bisogna cancellare i dati esistenti sul generatore, se
	    # il dato del rapporto di verifica e' null, allora evito di aggiornare
	    if {[string equal $cod_responsabile ""]} {
		set cod_responsabile_upd $aimp_cod_responsabile
	    } else {
		set cod_responsabile_upd $cod_responsabile
	    }
	    
	    # preparo le note da scrivere sui todo
	    if {$cod_responsabile_upd != $aimp_cod_responsabile} {
		if {$flag_agg_da_verif == "T"} {
		    if {$cod_responsabile_upd == $aimp_cod_occupante} {
			set flag_resp "O"
		    } elseif {$cod_responsabile_upd == $aimp_cod_proprietario} {
			set flag_resp "P"
		    } elseif {$cod_responsabile_upd == $aimp_cod_amministratore} {
			set flag_resp "A"
		    } elseif {$cod_responsabile_upd == $aimp_cod_intestatario} {
			set flag_resp "I"
		    } else {
			set flag_resp "T"
		    } 
		    switch $flag_resp {
			"O" {set desc_flag_resp "occupante" }
			"P" {set desc_flag_resp "proprietario"}
			"A" {set desc_flag_resp "amministratore"}
			"I" {set desc_flag_resp "intestatario"}
			"T" {set desc_flag_resp "terzo responsabile"}
		    }
		    
		    # preparo l'aggiornamento del responsabile dell'impianto
		    set dml_upd_aimp_resp [db_map upd_aimp_resp]
		    # memorizzo il vecchio responsabile nello storico
		    set ruolo             "R"
		    if {![string equal $aimp_cod_responsabile ""]
			&&   [db_0or1row sel_rife_check ""] == 0
		    } {
			set dml_ins_rife_resp [db_map ins_rife]
		    }
		    
		    append note_todo "Responsabile dell'impianto aggiornato da $aimp_cogn_resp $aimp_nome_resp a $cogn_responsabile $nome_responsabile in qualita' di $desc_flag_resp\n"
		} else {
		    append note_todo "Responsabile dell'impianto ($aimp_cogn_resp $aimp_nome_resp) diverso da quello del rapporto di verifica ($cogn_responsabile $nome_responsabile)\n"
		}
	    }
	    
	    if {$flag_agg_da_verif == "T"} {
		# se e' stato modificato il combustibile con un valore diverso da 
		# null e non noto, aggiorno solo l'impianto e non il/i generatore/i
		if {$cod_combustibile != $aimp_cod_combustibile
		    &&  $cod_combustibile != ""
		    &&  $cod_combustibile != "1"
		} {
		    set dml_upd_aimp_comb [db_map upd_aimp_comb]
		}
		
		# se viene modificata la volumetria con valore diverso da null, aggiorno
                # anche al volumetria sull'impianto
		if {![string equal $volumetria ""]
                &&  $volumetria != $aimp_volumetria_risc
		} {
		    set dml_upd_aimp_volumetria [db_map upd_aimp_volumetria]
		}

		# se viene modificato il consumo  con un valore diverso da null,
                # aggiorno anche il consumo annuo sull'impianto.
		if {![string equal $comsumi_ultima_stag ""]
                &&  $comsumi_ultima_stag != $aimp_consumo_annuo
		} {
		    set dml_upd_aimp_consumi [db_map upd_aimp_consumi]
		}


		# se l'impianto ha un solo generatore, aggiorno la potenza 
		# anche sull'impianto
		set ctr_gend [db_string sel_gend_count ""]
		if {$ctr_gend <= 1} {
		    set h_potenza $pot_focolare_nom_upd
		    if {[db_0or1row sel_pote_cod_potenza ""] == 0} {
			set cod_potenza ""
		    }
		    set dml_upd_aimp_pote [db_map upd_aimp_pote]
		} else {
		    # altrimenti verifico se la somma delle potenze al focolare
		    # nominali di tutti i generatori e' = alla potenza al
		    # focolare nominale dell'impianto
		    set gend_sum_pot_focolare_nom [db_string sel_gend_sum_pot_focolare_nom ""]
		    if {[string is space $gend_sum_pot_focolare_nom]} {
			set gend_sum_pot_focolare_nom 0
		    }
		    
		    set pot_focolare_nom_expr $pot_focolare_nom_upd
		    if {[string is space $pot_focolare_nom_expr]} {
			set pot_focolare_nom_expr 0
		    }
		    
		    set gend_sum_pot_focolare_nom [expr $gend_sum_pot_focolare_nom + $pot_focolare_nom_expr]
		    
		    if {$aimp_pot_focolare_nom != $gend_sum_pot_focolare_nom} {
			set aimp_pot_focolare_nom_edit [iter_edit_num $aimp_pot_focolare_nom 2]
			set gend_sum_pot_focolare_nom_edit [iter_edit_num $gend_sum_pot_focolare_nom 2]
			append note_todo "Verificare la potenza dell'impianto che attualmente vale $aimp_pot_focolare_nom_edit kW mentre la somma della potenza nominale al focolare dei generatori e' di $gend_sum_pot_focolare_nom_edit kW \n"
		    }
		}
		set dml_gend [db_map upd_gend]
	    }
	    
	    if {![string equal $note_todo ""]} {
		set dml_todo_aimp [db_map ins_todo]
	    }
	}

	# Se 8b e' null, lo valorizzo con S o N a seconda 
	# se il co rilevato e' a norma o meno
	if {[string equal $co_fumi_secchi_8b ""]
	&& ![string equal $new1_co_rilevato ""]
	} {
	    if {$new1_co_rilevato <= 1000} {
		set co_fumi_secchi_8b "S"
	    } else {
		set co_fumi_secchi_8b "N"
	    }
	}

	# Se 8c e' null, lo valorizzo con S o N a seconda
	# se l'indice fumosita' e' conforme o meno.
	if {[string equal $indic_fumosita_8c  ""]
	&& ![string equal $indic_fumosita_md ""]
	} {
	    # cablatura solo per Provincia di Mantova
	    if {$flag_ente        == "P"
	    &&  $sigla_prov       == "MN"
	    &&  $cod_combustibile == "4"
	    } {
		set cod_combustibile "O"
	    }

	    if {$cod_combustibile == "O"} {
		# per gasolio <= 2
		if {$indic_fumosita_md <= 2} {
		    set indic_fumosita_8c "S"
		} else {
		    set indic_fumosita_8c "N"
		}
	    } else {
		if {$indic_fumosita_md <= 6} {
		    set indic_fumosita_8c "S"
		} else {
		    set indic_fumosita_8c "N"
		}
	    }
	}

	# Se 8d e' null, lo valorizzo con S o N a seconda
	# che il rendimento di combustione sia conforme o meno.
	if { [string equal $rend_comb_8d   ""]
	&&  ![string equal $rend_comb_min  ""]
        &&  ![string equal $rend_comb_conv ""]
	} {
	    # algoritmo accordato con Villagrossi.
	    if {$rend_comb_conv >= [expr $rend_comb_min * 0.98]} {
		set rend_comb_8d "S"
	    } else {
		set rend_comb_8d "N"
	    }
	}

	# Preparo esito e flag_pericolosita.
	# Se c'e' una non conformita' di tipo 8a, 8b, 8c, 8d, 8p allora l'esito
	# e' negativo.
	if {$manutenzione_8a   == "N"
        ||  $co_fumi_secchi_8b == "N"
        ||  $indic_fumosita_8c == "N"
        ||  $rend_comb_8d      == "N"
        ||  $new1_flag_peri_8p == "I"
        ||  $new1_flag_peri_8p == "P"
	} {
	    set esito_verifica "N"
	}
        # se il flag pericolosita_8p e' impostato come pericoloso o potenziale
        # attivo il flag_pericolosit�
        if {$new1_flag_peri_8p == "I"
        ||  $new1_flag_peri_8p == "P"
	} {
	    set flag_pericolosita "T"
	}
	# Se c'e' almeno un'anomalia pericolosa, flag_pericolosita diventa 'T'.
	set flag_pericolosita "F"
	set sw_anom_exists    "f"
	set conta 0
	# ciclo sulle anomalie presenti nella form
	while {$conta < 5} {
	    incr conta
	    if {![string equal $cod_anom($conta) ""]} {
		set sw_anom_exists "t"

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
        # dell'impianto in base alla presenza di non conformita' di tipo
	# 8a, 8b, 8c, 8d oppure della presenza di anomalie sul R.V.
	if {$sw_anom_exists == "t"} {
	    # esistono anomalie sul R.V.
	    set stato_conformita "N"
	} else {
	    # se l'esito del R.V. e' null evito di aggiornare lo stato di conf.
	    if {[string equal $esito_verifica ""]} {
		set stato_conformita ""
	    } else {
		# lo aggiorno solo se l'esito del R.V. non e' null
		if {$esito_verifica == "P"} {
		    set stato_conformita "S"
		} else {
		    # se l'esito e' 'N' significa che e' presente
		    # una non conformita' di tipo 8a,b,c,d oppure
		    # l'esito e' comunque negativo 
		    set stato_conformita "N"
		}
	    }
	}
	# se lo stato_conformita e' null evito di aggiornarlo.
	if {![string equal $stato_conformita ""]} {
	    set dml_upd_aimp_stato [db_map upd_aimp_stato]
	}
    }

    switch $funzione {
        I {
	    db_1row sel_dual_cod_cimp ""
	    set dml_sql [db_map ins_cimp]

	    if {$flag_sanzioni == "N"} {
		if {$sw_movi == "t"} {
		    db_1row sel_dual_cod_movi ""
		    set dml_movi [db_map ins_movi]
		}
	    } else {
		if {![string equal $cod_sanzione_1 ""]} {
		    if {$tipo_soggetto_1 == "M"} {
			set cod_soggetto_1 $cod_manutentore
		    } else {
			set cod_soggetto_1 $cod_responsabile
		    }
		    db_1row sel_dual_cod_movi ""
		    set cod_movi1 $cod_movi
		    set dml_movi [db_map ins_movi_sanz1]
		}
		if {![string equal $cod_sanzione_2 ""]} {
		    if {$tipo_soggetto_2 == "M"} {
			set cod_soggetto_2 $cod_manutentore
		    } else {
			set cod_soggetto_2 $cod_responsabile
		    }
		    db_1row sel_dual_cod_movi ""
		    set cod_movi2 $cod_movi
		    set dml_movi2 [db_map ins_movi_sanz2]
		}
	    }

	    if {![string equal $cod_inco ""]} {
		set dml_inco [db_map upd_inco]
	    }

	    # aggiorno utente e data di ultima modifica
	    set dml_aimp_utente   [db_map upd_aimp_utente]

	    # gestione inserimento delle anomalie + inserimento rispettivi
            # todo 
	    set dml_ins_anom      [db_map ins_anom]
	    set dml_ins_todo_anom [db_map ins_todo]

	}
        M {
	    set dml_sql [db_map upd_cimp]

	    if {$flag_sanzioni == "N"} {
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

	    if {![string equal $cod_inco_old ""]
	    &&  $cod_inco_old != $cod_inco
	    &&  [db_string sel_cimp_inco_count ""] <= 1
	    } {
		# annullo l'esito di cod_inco_old (esito diventa null)
		set dml_inco_old [db_map upd_inco_old]
	    }

	    if {![string equal $cod_inco ""]} {
		set dml_inco [db_map upd_inco]
	    }

	    # gestione delle anomalie: cancellazione todo ed anom
	    # e reinserimento anom e todo
	    set dml_del_todo_anom [db_map del_todo_anom]
	    set dml_del_anom      [db_map del_anom]
	    set dml_ins_anom      [db_map ins_anom]
	    set dml_ins_todo_anom [db_map ins_todo]
	}
        D { set dml_sql           [db_map del_cimp]
            if {$flag_sanzioni == "N"} {
		set dml_movi          [db_map del_movi]
	    }
	    set dml_del_todo_all  [db_map del_todo_all]
	    set dml_del_anom_all  [db_map del_anom_all]

	    if {![string equal $cod_inco_old ""]} {
		# uso la query sel_cimp_inco_count
		set save_cod_inco     $cod_inco
		set cod_inco          $cod_inco_old
		if {[db_string sel_cimp_inco_count ""] <= 1} {
		    # annullo l'esito di cod_inco_old (esito diventa null)
		    set dml_inco_old [db_map upd_inco_old]
		}
		set cod_inco          $save_cod_inco
	    }
	}
    }
  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimcimp $dml_sql
		if {[info exists dml_movi]} {
		    db_dml dml_coimmovi $dml_movi
		}

		if {[info exists dml_inco_old]} {
		    db_dml dml_coiminco_old $dml_inco_old
		}

		if {[info exists dml_inco]} {
		    db_dml dml_coiminco $dml_inco
		}

                if {[info exists dml_upd_aimp_stato]} {
		    db_dml dml_coimaimp_stato $dml_upd_aimp_stato
		}

		if {[info exists dml_upd_aimp_utente]} {
		    db_dml dml_coimaimp_utente $dml_upd_aimp_utente
		
		}
		if {[info exists dml_upd_aimp_resp]} {
		    db_dml dml_coimaimp_resp $dml_upd_aimp_resp
		}
		if {[info exists dml_upd_aimp_comb]} {
		    db_dml dml_coimaimp_comb $dml_upd_aimp_comb
		}

		if {[info exists dml_upd_aimp_volumetria]} {
		    db_dml dml_coimaimp_volumetria $dml_upd_aimp_volumetria
		}
		if {[info exists dml_upd_aimp_consumi]} {
		    db_dml dml_coimaimp_consumi $dml_upd_aimp_consumi
		}

                if {[info exists dml_ins_rife_resp]} {
		    set ruolo            "R"
		    set cod_soggetto_old $aimp_cod_responsabile
		    db_dml dml_coimrife  $dml_ins_rife_resp
		}

		if {[info exists dml_upd_aimp_pote]} {
		    db_dml dml_coimaimp_pote $dml_upd_aimp_pote
		}

		if {[info exists dml_gend]} {
		    db_dml dml_coimgend $dml_gend
		}

		if {[info exists dml_todo_aimp]} {
		    db_1row sel_dual_cod_todo ""
		    set tipologia     "6"
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

				set tipologia     "2"
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

		# in cancellazione elimino tutti i todo e tutte le anom
		# relative al rapporto di verifica
		if {[info exists dml_del_todo_all]} {
		    db_dml dml_coimtodo $dml_del_todo_all
		}
		if {[info exists dml_del_anom_all]} {
		    db_dml dml_coimanom $dml_del_anom_all
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
    if {$funzione == "I"} {
        set last_cod_cimp $cod_cimp
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto gen_prog cod_cimp last_cod_cimp nome_funz nome_funz_caller extra_par url_aimp url_list_aimp flag_cimp flag_inco extra_par_inco cod_inco]
    switch $funzione {
        M {set return_url   "[ad_conn package_url]src/coimcimp-gest?funzione=V&$link_gest"}
        D {set return_url   "[ad_conn package_url]src/coimcimp-list?$link_list"}
        I  {set return_url "[ad_conn package_url]src/coimcimp-gest?funzione=V&$link_gest"
	}

        V {set return_url   "[ad_conn package_url]src/coimcimp-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}
ad_return_template
