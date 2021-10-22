ad_page_contract {
    Lista tabella "coimacts"

    @author                  Katia Coazzoli Adhoc
    @creation-date           07/05/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimacts-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_cod_acts ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}


# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista dichiarazioni del fornitore di energia"

#if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar [iter_context_bar \
#                    [list "javascript:window.close()" "Torna alla Gestione"] \
#                    "$page_title"]
#}


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimacts-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Fornitore di energia"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
#set link_aggiungi   "<a href=\"coimacts-isrt?funzione=I&[export_url_vars last_cod_acts caller nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"
set link_aggiungi ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


#if {$caller == "index"} {
    set link    "\[export_url_vars cod_acts last_cod_acts nome_funz nome_funz_caller extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
#} else { 
#    set actions [iter_select [list column_name .... ]]
#    set receiving_element [split $receiving_element |]
#    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  column_name1 [lindex $receiving_element 1]  column_name2 .... .... ]]
#}


# imposto la struttura della tabella
set table_def [list \
        [list actions             "Azioni"               no_sort $actions] \
    	[list cod_acts            "Codice"               no_sort {l}] \
	[list distributore        "Fornitore di energia" no_sort {l}] \
	[list data_caric_edit     "Dt caric."            no_sort {c}] \
	[list cod_documento       "Docum"                no_sort {c}] \
	[list caricati_edit       "Caricati"             no_sort {c}] \
	[list invariati_edit      "Invariati"            no_sort {c}] \
	[list da_analizzare_edit  "Da analizz."          no_sort {c}] \
	[list importati_aimp_edit "Esportati"            no_sort {c}] \
	[list chiusi_forzat_edit  "Chiusi"               no_sort {c}] \
	[list stato               "Stato"                no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(b.ragione_01) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_acts]} {
    set distributore   [lindex $last_cod_acts 0]
    set data_caric     [lindex $last_cod_acts 1]
    set where_last " and ((upper(b.ragione_01) = upper(:distributore) and
                                 data_caric   <= :data_caric)   or
                           upper(b.ragione_01) > upper(:distributore))"
} else {
    set where_last ""
}


set sel_acts [db_map sel_acts]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_acts last_cod_acts nome_funz distributore data_caric nome_funz_caller extra_par} go $sel_acts $table_def]

# preparo url escludendo last_cod_acts che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_acts]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_acts [list  $distributore $data_caric]
    append url_vars "&[export_url_vars last_cod_acts]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
