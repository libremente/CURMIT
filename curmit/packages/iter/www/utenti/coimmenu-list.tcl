ad_page_contract {
    Lista tabella "coimmenu"

    @author                  Giulio Laurenzi
    @creation-date           18/05/2004

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

    @cvs-id coimmenu-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_nome_menu ""}
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

# Richiamo la procedura iter_get_coimtgen per verificare se sono o meno in un ente regionale
iter_get_coimtgen
# Identifico settore e ruolo a cui appartiene l'utente
db_1row select_profilo_utente ""

set page_title      "Lista Men&ugrave;"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimmenu-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_nome_menu caller nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars nome_menu last_nome_menu nome_funz nome_funz_caller extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
        [list actions   "Azioni"       no_sort $actions] \
    	[list nome_menu "Men&ugrave;"  no_sort {l}] \
]

# imposto la query SQL 

# Se non ci si trova nell'ente regione non vengono estratti i menu
# relativi a profili regionali
set flag_regione ""
if {($coimtgen(flag_ente) ne "R") && ($id_settore ne "system")} {
    set flag_regione " and b.settore != 'regione' and b.settore != 'system'"
}
if {($coimtgen(flag_ente) eq "R") && ($id_settore ne "system")} {
    set flag_regione " and b.settore != 'system'"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_nome_menu]} {
    set where_last " and a.nome_menu >= :last_nome_menu"
} else {
    set where_last ""
}

set sel_menu [db_map sel_menu]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {nome_menu last_nome_menu nome_funz nome_funz_caller extra_par} go $sel_menu $table_def]

# preparo url escludendo last_nome_menu che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_nome_menu]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_nome_menu $nome_menu
    append url_vars "&[export_url_vars last_nome_menu]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
