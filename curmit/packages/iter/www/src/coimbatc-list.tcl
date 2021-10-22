ad_page_contract {
    Lista tabella "coimbatc"

    @author                  Adhoc
    @creation-date           11/08/2004

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

    @cvs-id coimbatc-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_key          ""}
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
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$nome_funz == $nome_funz_caller} {
    set link_head ""
} else {
    # preparo i link di testata della pagina per consultazione coda lavori
    set link_head [iter_links_batc $nome_funz $nome_funz_caller $search_word]
}

set page_title      "Consultazione lavori in esecuzione"

#if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar [iter_context_bar \
#                    [list "javascript:window.close()" "Torna alla Gestione"] \
#                    "$page_title"]
#}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog        [file tail [ns_conn url]]
set gest_prog        "coimbatc-gest"
set form_di_ricerca  [iter_search_form $curr_prog $search_word]
set col_di_ricerca   "Lavoro"
set extra_par        [list rows_per_page     $rows_per_page \
                           search_word       $search_word \
                           receiving_element $receiving_element]
set current_datetime "[iter_edit_date [iter_set_sysdate]] [iter_set_systime -second]"
set link_aggiorna    "$current_datetime <a href=\"$curr_prog?[export_ns_set_vars url]\">Aggiorna pagina</a>"
set rows_per_page    [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe       [iter_rows_per_page     $rows_per_page]

#if {$caller == "index"} {
    set link    "\[export_url_vars cod_batc last_key nome_funz nome_funz_caller extra_par\]"
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
        [list actions       "Azioni"   no_sort $actions] \
	[list nom           "Lavoro"   no_sort {l}] \
	[list flg_stat_edit "Stato"    no_sort {l}] \
	[list tim_batc_edit "Data/Ora" no_sort {c}] \
    	[list cod_batc      "Codice"   no_sort {r}] \
	[list cod_uten_sch  "Utente"   no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(nom) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_key]} {
    set flg_stat [lindex $last_key 0]
    set dat_prev [lindex $last_key 1]
    set ora_prev [lindex $last_key 2]
    set cod_batc [lindex $last_key 3]

    set where_last " and (
                             (    flg_stat  = :flg_stat
                              and dat_prev  = :dat_prev
                              and ora_prev  = :ora_prev
                              and cod_batc >= :cod_batc
                             )
                          or (    flg_stat  = :flg_stat
                              and dat_prev  = :dat_prev
                              and ora_prev  > :ora_prev
                             )
                          or (    flg_stat  = :flg_stat
                              and dat_prev  > :dat_prev
                             )
                          or      flg_stat  < :flg_stat
                         )"
} else {
    set where_last ""
}

set sel_batc     [db_map sel_batc]
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun lavoro in coda." -Textra_vars {cod_batc flg_stat dat_prev ora_prev last_key nome_funz nome_funz_caller extra_par} go $sel_batc $table_def]

# preparo url escludendo last_key che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_key]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_key [list $flg_stat $dat_prev $ora_prev $cod_batc]
    append url_vars "&[export_url_vars last_key]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca \
              $link_aggiorna  $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
