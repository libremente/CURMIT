ad_page_contract {
    @author          Paolo Formizzi
    @creation-date   14/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-scfl.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 21/10/2020 Su segnalazione di Salerno modificato page_title per renderlo
    rom01            uguale al nome del menu', Sandro ha detto che va bene per tutti.

} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}

   {f_tipo_data       ""}
   {f_data            ""}
   {f_cod_impianto    ""}
   {f_tipo_estrazione ""}
   {f_anno_inst_da    ""}
   {f_anno_inst_a     ""}
   {f_cod_comb        ""}
   {f_cod_enve        ""}
   {f_cod_tecn        ""}
   {f_cod_comune      ""}
   {f_descr_topo      ""}
   {f_descr_via       ""}
   {f_cod_via         ""}
   {f_numero          ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
if {$flag_ente == "C"} {
    set f_cod_comune $coimtgen(cod_comu)
}

# Personalizzo la pagina
set button_label  "Seleziona"
set button_label2 "Scarica"
#rom01set page_title    "Scarico appuntamenti per assegnazione"
set page_title   "Scarico incontri su file esterno";#rom01
set context_bar  [iter_context_bar -nome_funz $nome_funz] 

set conta [db_string sel_cinc_count ""]
if {$conta == 0} {
    iter_return_complaint "Non ci sono campagne aperte"
}
if {$conta > 1} {
    iter_return_complaint "C'&egrave; pi&ugrave; di una campagna aperta"
}
if {$conta == 1} {
    if {[db_0or1row sel_cinc ""] == 0} {
	iter_return_complaint "Campagna non trovata"
    }
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coiminco"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_tipo_data \
-widget   select \
-options  {{Estrazione E} {Assegnazione A} {Appuntamento I}} \
-datatype text \
-html    "class form_element" \
-optional

element create $form_name f_data \
-label   "Data " \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name f_cod_impianto \
-label   "Codice impianto" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional



#set tipest_options ""
#lappend tipest_options [list "" ""]
#lappend tipest_options [list "Impianti &lt; 35kW dichiarati (5%)"          "1"]
#lappend tipest_options [list "Impianti &lt; 35kW dichiarati (mod.H scad.)" "2"]
#lappend tipest_options [list "Impianti &gt; 35kW dichiarati"               "3"]
#lappend tipest_options [list "Impianti non dichiarati"                     "4"]
#lappend tipest_options [list "Singolo impianto"                            "6"]

element create $form_name f_tipo_estrazione \
-label   "Tipo estrazione" \
-widget   select \
-options  [iter_selbox_from_table coimtpes cod_tpes descr_tpes] \
-datatype text \
-html    "class form_element" \
-optional

element create $form_name f_anno_inst_da \
-label   "Da anno installazione " \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 class form_element" \
-optional

element create $form_name f_anno_inst_a \
-label   "A anno installazione " \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 class form_element" \
-optional

element create $form_name f_cod_comb \
-label   "Combustibile" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb]

element create $form_name f_cod_enve \
-label   "Codice ente" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimenve cod_enve ragione_01]

element create $form_name f_cog_tecn \
-label   "Cognome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40 class form_element" \
-optional 

element create $form_name f_nom_tecn \
-label   "Nome tecnico" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 40 class form_element" \
-optional 

set cerca_opve [iter_search $form_name coimopve-list [list cod_enve f_cod_enve dummy f_cod_tecn dummy f_nom_tecn dummy f_cog_tecn]]

if {$flag_ente == "P"} {
    element create $form_name f_cod_comune \
	-label   "Comune" \
	-widget   select \
	-options  [iter_selbox_from_comu] \
	-datatype text \
	-html    "class form_element" \
	-optional
} else {
    element create $form_name f_cod_comune -widget hidden -datatype text -optional
}

element create $form_name f_descr_topo \
-label   "Tipo toponimo" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimtopo descr_topo descr_topo]

element create $form_name f_descr_via \
-label   "Via" \
-widget   text \
-datatype text \
-html    "size 33 maxlength 40 class form_element" \
-optional

if {$flag_viario == "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_descr_via dummy f_descr_topo cod_comune f_cod_comune]]
} else {
    set cerca_viae ""
}
element create $form_name f_cod_via   -widget hidden -datatype text -optional
element create $form_name f_cod_tecn  -widget hidden -datatype text -optional
element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name submit2     -widget submit -datatype text -label "$button_label2" -html "class form_submit"
element create $form_name dummy       -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
    element set_properties $form_name f_cod_via        -value $f_cod_via
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller

    element set_properties $form_name f_tipo_data      -value $f_tipo_data
    element set_properties $form_name f_data           -value [iter_edit_date $f_data]
    element set_properties $form_name f_cod_impianto   -value $f_cod_impianto
    element set_properties $form_name f_tipo_estrazione -value $f_tipo_estrazione

    element set_properties $form_name f_anno_inst_da   -value $f_anno_inst_da
    element set_properties $form_name f_anno_inst_a    -value $f_anno_inst_a
    element set_properties $form_name f_cod_comb       -value $f_cod_comb
    element set_properties $form_name f_cod_enve       -value $f_cod_enve
    element set_properties $form_name f_cod_tecn       -value $f_cod_tecn
    if {[db_0or1row sel_tecn ""] == 0} {
	set f_cog_tecn ""
	set f_nom_tecn ""
    }
    element set_properties $form_name f_cog_tecn       -value $f_cog_tecn
    element set_properties $form_name f_nom_tecn       -value $f_nom_tecn

    element set_properties $form_name f_cod_comune     -value $f_cod_comune
    element set_properties $form_name f_descr_topo     -value $f_descr_topo
    element set_properties $form_name f_descr_via      -value $f_descr_via
}

element create $form_name f_numero \
-label   "Numero " \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 class form_element" \
-optional

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_tipo_data       [element::get_value $form_name f_tipo_data]
    set f_data            [element::get_value $form_name f_data]
    set f_cod_impianto    [element::get_value $form_name f_cod_impianto]
    set f_tipo_estrazione [element::get_value $form_name f_tipo_estrazione]
    set f_anno_inst_da    [element::get_value $form_name f_anno_inst_da]
    set f_anno_inst_a     [element::get_value $form_name f_anno_inst_a]
    set f_cod_comb        [element::get_value $form_name f_cod_comb]
    set f_cod_enve        [element::get_value $form_name f_cod_enve]
    set f_cod_tecn        [element::get_value $form_name f_cod_tecn]
    set f_cog_tecn        [element::get_value $form_name f_cog_tecn]
    set f_nom_tecn        [element::get_value $form_name f_nom_tecn]
    set f_cod_comune      [element::get_value $form_name f_cod_comune]
    set f_descr_topo      [element::get_value $form_name f_descr_topo]
    set f_descr_via       [element::get_value $form_name f_descr_via]
    set submit            [element::get_value $form_name submit]
    set submit2           [element::get_value $form_name submit2] 
    set f_cod_via         [element::get_value $form_name f_cod_via] 
    set f_numero          [element::get_value $form_name f_numero] 
    set error_num 0

    if {![string equal $f_data ""]} {
          set f_data [iter_check_date $f_data]
          if {$f_data == 0} {
              element::set_error $form_name f_data "deve essere una data valida"
              incr error_num
          }
    }

    set flag_anno_inst_da "f"
    if {![string equal $f_anno_inst_da ""]} {
	if {![string is integer $f_anno_inst_da]} {
	    element::set_error $form_name f_anno_inst_da "Anno non valido"
	    incr error_num
	} else {
	    set flag_anno_inst_da "t"
	}
    }

    set flag_anno_inst_a "f"
    if {![string equal $f_anno_inst_a ""]} {
	if {![string is integer $f_anno_inst_a]} {
	    element::set_error $form_name f_anno_inst_a "Anno non valido"
	    incr error_num
	} else {
	    set flag_anno_inst_a "t"
	}
    }

    if {$flag_anno_inst_da  == "t"
    &&  $flag_anno_inst_a   == "t"
    &&  $f_anno_inst_da > $f_anno_inst_a
    } {
	element::set_error $form_name f_anno_inst_a "L'anno di fine deve essere maggiore dell'anno inizio"
	incr error_num
    }

 set flag_f_numero "f"
    if {![string equal $f_numero ""]} {
	if {![string is integer $f_numero]} {
	    element::set_error $form_name f_numero "Numero non valido"
	    incr error_num
	} else {
	    set flag_f_numero  "t"
	}
    }

 if {[string equal $f_numero ""]} {
	  element::set_error $form_name f_numero "Numero non valido / obbligatorio"
	    incr error_num
	    set flag_f_numero  "t"
	}
    


    #routine generica per controllo codice tecnico
    set check_cod_tecn {
	set chk_out_rc       0
	set chk_out_msg      ""
	set chk_out_cod_tecn ""
	set ctr_tecn         0
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
	db_foreach sel_tecn_nom "" {
	    incr ctr_tecn
	    if {$cod_tecn_db == $chk_inp_cod_tecn} {
		set chk_out_cod_tecn $cod_tecn_db
		set chk_out_rc       1
	    }
	}
	switch $ctr_tecn {
	    0 { set chk_out_msg "Tecnico non trovato"}
	    1 { set chk_out_cod_tecn $cod_tecn_db
		set chk_out_rc       1 }
	    default {
		if {$chk_out_rc == 0} {
		    set chk_out_msg "Trovati pi&ugrave; tecnici: usa il link cerca"
		}
	    }
	}
    }

    if {[string equal $f_cog_tecn ""]
    &&  [string equal $f_nom_tecn    ""]
    } {
	set f_cog_tecn "Operatore"
	set f_nom_tecn "Generico"
	set f_cod_tecn $f_cod_enve
	append f_cod_tecn "000"
    } else {
	set chk_inp_cod_tecn $f_cod_tecn
	set chk_inp_cognome  $f_cog_tecn
	set chk_inp_nome     $f_nom_tecn
	eval $check_cod_tecn
	set f_cod_tecn  $chk_out_cod_tecn
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_cog_tecn $chk_out_msg
	    incr error_num
	}
    }

    # si controlla la via solo se il primo test e' andato bene.
    # in questo modo si e' sicuri che f_comune e' stato valorizzato.

    if {[string equal $f_descr_via  ""]
    &&  [string equal $f_descr_topo ""]
    } {
	set f_cod_via ""
    } else {

	if {[string equal $f_cod_comune ""]} {
	    element::set_error $form_name f_cod_comune "Inserire il comune"
	    incr error_num
	} else {

	    # controllo codice via
	    set chk_out_rc      0
	    set chk_out_msg     ""
	    set chk_out_cod_via ""
	    set ctr_viae        0
	    if {[string equal $f_descr_topo ""]} {
		set eq_descr_topo  "is null"
	    } else {
		set eq_descr_topo  "= upper(:f_descr_topo)"
	    }
	    if {[string equal $f_descr_via ""]} {
		set eq_descrizione "is null"
	    } else {
		set eq_descrizione "= upper(:f_descr_via)"
	    }
	    db_foreach sel_via "" {
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
            if {$chk_out_rc == 0} {
                element::set_error $form_name f_descr_via $chk_out_msg
                incr error_num
	    }
	}
    }

    
    if {$error_num > 0} {
       ad_return_template
       return
    }
  
    set flag_scar "S"
    set link_list [export_url_vars f_data f_tipo_data f_cod_impianto f_cod_comune f_cod_via f_tipo_estrazione caller nome_funz_caller funzione cod_cinc flag_scar f_anno_inst_da f_anno_inst_a f_cod_comb]&nome_funz=incontro

    set link_scar [export_url_vars f_data f_tipo_data f_cod_impianto f_cod_tecn f_cod_comune f_cod_via f_tipo_estrazione caller funzione nome_funz nome_funz_caller cod_cinc f_cod_enve f_anno_inst_da f_anno_inst_a f_cod_comb f_numero]

    if {![string is space $submit]} {
	set return_url "coiminco-list?$link_list"
    }

    if {![string is space $submit2]} {
	set return_url "coiminco-scar?$link_scar"
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
