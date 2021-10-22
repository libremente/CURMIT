ad_page_contract {
    Lista tabella "coim_d_anom"

    @author                  Giulio Laurenzi
    @creation-date           16/04/2004

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

    @cvs-id coim_d_anom-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_data_controllo ""}
   {cod_impianto ""}
   {url_aimp     ""}
   {url_list_aimp ""}
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

iter_get_coimtgen
set flag_ente  $coimtgen(flag_ente)
set sigla_prov $coimtgen(sigla_prov)

set page_title      "Lista anomalie dichiarazioni"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coim_d_anom-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars cod_d_tano url_aimp url_list_aimp cod_impianto last_data_controllo nome_funz nome_funz_caller  extra_par\]"
 set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""


# imposto la struttura della tabella
set table_def [list \
	      [list cod_d_tano          "Codice anomalia"    no_sort {c}] \
	      [list data_controllo_edit "Data controllo"     no_sort {l}] \
	      [list data_invio_lettera  "Data invio lettera" no_sort {l}] \
	      [list descr_breve         "Descrizione"        no_sort {l}] \
		  ]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_data_controllo]} {
    set where_last " and a.data_controllo >= :last_data_controllo"
} else {
    set where_last ""
}

if {![string is space $cod_impianto]} {
    set where_aimp "and a.cod_impianto = :cod_impianto"
} else {
    set where_aimp ""
}

set sel_anom [db_map sel_d_anom]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_d_tano cod_impianto url_aimp url_list_aimp last_data_controllo nome_funz nome_funz_caller extra_par} go $sel_anom $table_def]

set url_vars [export_ns_set_vars "url" last_data_controllo]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
#    set last_data_controllo [iter_check_date $data_controllo_edit]
    append url_vars "&[export_url_vars last_data_controllo]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
