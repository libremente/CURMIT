ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimrgen"
    @author          Giulio Laurenzi
    @creation-date   01/08/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimrgen-gest.tcl
} {

   {cod_rgen ""}
   {last_cod_rgen ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_list_rgen ""}
   {url_rgen ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}
#ns_return 200 text/html "cod_rgen-$cod_rgen  last_cod_rgen-$last_cod_rgen  url_list_rgen-$url_list_rgen  url_rgen-$url_rgen"; return
# Controlla lo user

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_rgen last_cod_rgen nome_funz nome_funz_caller url_list_rgen url_rgen extra_par]

if {[string equal $url_rgen ""]} {
    set url_rgen  [list [ad_conn url]?[export_ns_set_vars url "url_list_rgen url_rgen"]]
}

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$funzione != "I"} {
   set link_tab [iter_links_rgen $cod_rgen $nome_funz_caller $url_list_rgen $url_rgen]
   set dett_tab [iter_tab_rgen $cod_rgen]
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_rgen caller nome_funz_caller nome_funz url_list_rgen url_rgen]&[iter_set_url_vars $extra_par]}

set link_list        [subst $link_list_script]
set titolo           "Raggruppamento enti competenti per anomalie"
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
set form_name    "coimrgen"
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

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_rgen \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 80 maxlength 100 $readonly_fld {} class form_element" \
-optional


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_rgen -widget hidden -datatype text -optional
element create $form_name url_rgen      -widget hidden -datatype text -optional
element create $form_name url_list_rgen -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_rgen    -value $last_cod_rgen
    element set_properties $form_name url_list_rgen    -value $url_list_rgen
    element set_properties $form_name url_rgen         -value $url_rgen
    
    if {$funzione == "I"} {

        
    } else {
      # leggo riga
        if {[db_0or1row sel_rgen {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_rgen     -value $cod_rgen
        element set_properties $form_name descrizione  -value $descrizione

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_rgen      [element::get_value $form_name cod_rgen]
    set descrizione   [element::get_value $form_name descrizione]
    set url_list_rgen [element::get_value $form_name url_list_rgen]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	if {[string equal $cod_rgen ""]} {
	    element::set_error $form_name cod_rgen "Inserire il codice"
	    incr error_num
	}
	if {[string equal $descrizione ""]} {
	    element::set_error $form_name descrizione "Inserire la descrizione"
	    incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_rgen_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_rgen "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }


    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_rgen]}
        M {set dml_sql [db_map upd_rgen]}
        D {set dml_sql [db_map del_rgen]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimrgen $dml_sql
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
        set last_cod_rgen $cod_rgen
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_rgen last_cod_rgen nome_funz nome_funz_caller url_list_rgen url_rgen extra_par caller]

    switch $funzione {
        M {set return_url   "coimrgen-gest?funzione=V&$link_gest"}
        D {set return_url   "coimrgen-list?$link_list"}
        I {set return_url   "coimrgen-gest?funzione=V&$link_gest"}
        V {set return_url   "coimrgen-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
