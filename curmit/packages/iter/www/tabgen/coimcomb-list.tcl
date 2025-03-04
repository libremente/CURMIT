ad_page_contract {
    Lista tabella "coimcomb"

    @author                  Adhoc
    @creation-date           04/03/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimcomb-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {last_descr_comb ""}
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
    set id_utente [iter_get_id_utente]
}

set page_title      "Lista Combustibili"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcomb-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_descr_comb caller nome_funz extra_par]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link    "\[export_url_vars cod_combustibile last_descr_comb nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions [iter_select [list cod_combustibile descr_comb ]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_combustibile [lindex $receiving_element 1]  descr_comb  [lindex $receiving_element 2] tipo]]
}


# imposto la struttura della tabella
set table_def [list \
		   [list actions           "Azioni"          no_sort $actions] \
		   [list cod_combustibile  "Cod."            no_sort {l}] \
		   [list descr_comb        "Descrizione"     no_sort {l}] \
		   [list tipo              "Tipo"            no_sort {l}] \
		   [list um                "Unità di misura" no_sort {c}] \
		  ]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_descr_comb]} {
    set descr_comb [lindex $last_descr_comb 0]
    set cod_combustibile   [lindex $last_descr_comb 1]
    set where_last " and ((upper(descr_comb) = upper(:descr_comb)  and
                           cod_combustibile  >= :cod_combustibile) 
                      or   upper(descr_comb) > upper(:descr_comb))"
} else {
    set where_last ""
}

set sel_comb [db_map sel_comb]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_combustibile descr_comb last_descr_comb nome_funz extra_par} go $sel_comb $table_def]

# preparo url escludendo last_descr_comb che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_descr_comb]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_descr_comb [list $descr_comb $cod_combustibile]
    append url_vars "&[export_url_vars last_descr_comb]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

