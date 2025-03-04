ad_page_contract {
    Stampa modulo A e B impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimnoveb-layout.tcl

    @param cod_noveb

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    gac01 22/11/2018 Modificato modello A della stampa con aggiunta di vari campi solo per
    gac01            regione marche
    
} {
    {cod_noveb            ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {cod_impianto         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
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

set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

set link_tab      [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab      [iter_tab_form $cod_impianto]
set logo_dir      [iter_set_logo_dir]
#set logo_dir "/www/logo"

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_dimp caller nome_funz_caller nome_funz cod_impianto  url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set page_title       "Stampa Allegato art. 286"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set checked "<img src=$logo_dir/check-in.gif height=12>"
set not_checked "<img src=$logo_dir/check-out.gif height=12>"

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

if {$flag_viario == "T"} {
    set sel_aimp_2 "sel_aimp_si_viae"
} else {
    set sel_aimp_2 "sel_aimp_no_viae"
}


set stampe_logo_nome               [parameter::get_from_package_key -package_key iter -parameter stampe_logo_nome];#sim01
set stampe_logo_height             [parameter::get_from_package_key -package_key iter -parameter stampe_logo_height];#sim01

if {$stampe_logo_nome ne ""} {
    if {$stampe_logo_height ne ""} {
	if {$coimtgen(regione) eq "MARCHE"} {#parte per regione marche
	    set height_logo "height=28"
	} else {#parte standard
	    set height_logo "height=$stampe_logo_height"
	}
    } else {
	set height_logo ""
    }
    set logo "<img src=$logo_dir/$stampe_logo_nome $height_logo>"
} else {
    set logo ""
}

if {[db_0or1row $sel_aimp_2 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {
    if {[db_0or1row sel_noveb ""] == 0} {
	iter_return_complaint "Allegato non trovato"
    } else {

	if {[string range $cod_manutentore 0 1] == "MA"} {
	    db_0or1row sel_dati_manu ""
	} else {
	    db_0or1row sel_dati_citt ""
	}

	if {$flag_art_3 == "t"} {
	    set flag_art_3 $checked
	} else {
	    set flag_art_3 $not_checked
	}
	if {$flag_art_11 == "t"} {
	    set flag_art_11 $checked
	} else {
	    set flag_art_11 $not_checked
	}
        if {$flag_patente_abil == "t"} {
            set flag_patente_abil $checked
        } else {
            set flag_patente_abil $not_checked
        }
        if {$flag_art_11_comma_3 == "t"} {
            set flag_art_11_comma_3 $checked
        } else {
            set flag_art_11_comma_3 $not_checked
        }
	if {$flag_installatore == "t"} {
	    set flag_installatore $checked
	} else {
	    set flag_installatore $not_checked
	}
	if {$flag_responsabile == "t"} {
	    set flag_responsabile $checked
	} else {
	    set flag_responsabile $not_checked
	}
	if {$flag_manutentore == "t"} {
	    set flag_manutentore $checked
	} else {
	    set flag_manutentore $not_checked
	}
        if {$flag_rispetta_val_min == "t"} {
	    set flag_rispetta_val_min $checked
	} else {
	    set flag_rispetta_val_min $not_checked
	}
	if {[string equal $n_generatori ""]} {
	    set n_generatori "&nbsp;"
	}
        if {[string equal $dich_conformita_nr ""]} {
            set dich_conformita_nr "&nbsp;"
            set flag_dich_conform $not_checked
        } else {
	    set flag_dich_conform $checked
        } 	
	if {[string equal $data_dich_conform ""]} {
	    set data_dich_conform "&nbsp;"
	}
        if {$flag_libretto_centr == "t"} {
            set flag_libretto_centr $checked
        } else {
            set flag_libretto_centr $not_checked
        }
        if {[string equal $firma_dichiarante ""]} {
            set firma_dichiarante "&nbsp;"
        }
	if {[string equal $data_dichiarazione ""]} {
	    set data_dichiarazione "&nbsp;"
	}
	if {[string equal $firma_responsabile ""]} {
	    set firma_responsabile "&nbsp;"
	}
	if {[string equal $data_ricevuta ""]} {
	    set data_ricevuta "&nbsp;"
	}
	if {[string equal $regolamenti_locali ""]} {
	    set regolamenti_locali "&nbsp;"
	}
        if {$flag_verif_emis_286 == "S"} {
            set verif_emis_286_si $checked
            set verif_emis_286_no $not_checked
        } else {
            set verif_emis_286_si $not_checked
            set verif_emis_286_no $checked
        }
	if {[string equal $data_verif_emiss ""]} {
	    set data_verif_emiss "&nbsp;"
	}
	if {[string equal $risultato_mg_nmc_h ""]} {
            set risultato_mg_nmc_h "&nbsp;"
        }
	if {[string equal $data_alleg_libretto ""]} {
            set data_alleg_libretto "&nbsp;"
        }
	if {[string equal $combustibili ""]} {
            set combustibili "&nbsp;"
        }
        if {$flag_risult_conforme == "S"} {
            set risultato_conforme_si $checked
            set risultato_conforme_no $not_checked
        } else {
            set risultato_conforme_si $not_checked
            set risultato_conforme_no $checked
	}
        if {[string equal $pot_term_tot_mw ""]} {
            set pot_term_tot_mw "&nbsp;"
        }

		db_1row q "select flag_clima_invernale,flag_prod_acqua_calda from coimgend where cod_impianto = :cod_impianto and flag_attivo = 'S' limit 1";#gac01
	if {$flag_clima_invernale eq "S"} {#gac01 aggiunta if e suo contenuto
	    set riscaldamento_ambienti $checked
	} else {
	    set riscaldamento_ambienti $not_checked
	}
	if {$flag_prod_acqua_calda eq "S"} {#gac01 aggiunta if e suo contenuto
	    set produzione_acs $checked
	} else {
	    set produzione_acs $not_checked
	}

	if {$flag_dichiarante eq "L"} {#gac01 aggiunto if, elseif e else e loro contenuto
	    set legale_rapp $checked
	    set resp_tecnico $not_checked
	    set tecnico_spec $not_checked
	} elseif {$flag_dichiarante eq "R"} {
	    set legale_rapp $not_checked
	    set resp_tecnico $checked
	    set tecnico_spec $not_checked
	} elseif {$flag_dichiarante eq "T"} {
	    set legale_rapp $not_checked
	    set resp_tecnico $not_checked
	    set tecnico_spec $checked
	} else {
	    set legale_rapp $not_checked
	    set resp_tecnico $not_checked
	    set tecnico_spec $not_checked
	}

	if {$flag_a eq "t"} {
	    set flag_a_c $checked
	} else {
	    set flag_a_c $not_checked
	}
        if {$flag_c eq "t"} {
	    set flag_c_c $checked
	} else {
	    set flag_c_c $not_checked
	}
	if {$flag_e eq "t"} {
	    set flag_e_c $checked
	} else {
	    set flag_e_c $not_checked
	}

	if {$flag_uni_13284 eq "t"} {
	    set flag_uni_13284_check $checked
	} else {
	    set flag_uni_13284_check $not_checked
	}
	if {$flag_uni_14792 eq "t"} {
	    set flag_uni_14792_check $checked
	} else {
	    set flag_uni_14792_check $not_checked
	}
	if {$flag_uni_15058 eq "t"} {
	    set flag_uni_15058_check $checked
	} else {
	    set flag_uni_15058_check $not_checked
	}
	if {$flag_uni_10393 eq "t"} {
	    set flag_uni_10393_check $checked
	} else {
	    set flag_uni_10393_check $not_checked
	}
	if {$flag_uni_12619 eq "t"} {
	    set flag_uni_12619_check $checked
	} else {
	    set flag_uni_12619_check $not_checked
	}
	if {$flag_uni_1911 eq "t"} {
	    set flag_uni_1911_check $checked
	} else {
	    set flag_uni_1911_check $not_checked
	}
	if {$flag_elettrochimico eq "t"} {
	    set flag_elettrochimico_check $checked
	} else {
	    set flag_elettrochimico_check $not_checked
	}
	if {$flag_normativa_previgente eq "t"} {
	    set flag_normativa_previgente_check $checked
	} else {
	    set flag_normativa_previgente_check $not_checked
	}
	

	    #allegato IX B
	    set stampa2 "
    <font size = 2>
    <table width=100%>
        <tr><td align=center><b></b></td></tr>
        <tr><td>$logo</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=center>VERIFICA STRUMENTALE PERIODICA DELLE EMISSIONI PER IMPIANTI TERMICI CIVILI DI POTENZA TERMICA NOMINALE AL FOCOLARE > 35 kW ALIMENTATI A BIOMASSE, BIOGAS, LEGNA E CARBONE, O PER I QUALI NON SONO STATE REGOLARMENTE ESEGUITE LE OPERAZIONI DI MANUTENZIONE PERIODICA</td></tr>
        <tr><td align=center>(D.Lgs 152/06 art.286 ss.mm.ii)</td></tr>
<tr><td>&nbsp;</td></tr>
        <tr><td>Data $data_consegna &nbsp;&nbsp; Luogo $luogo_consegna</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td>Relativamente all'impianto rtermico adibito a: riscaldameto abienti $riscaldamento_ambienti &nbsp;&nbsp; produzione di acqua calda sanitaria $produzione_acs
        <tr><td align=left>Catasto impianti/codice: $cod_impianto_est sito in via $indir</td></tr>
        <tr><td align=left>di potenza termica nominale utile complessiva pari a $potenza_utile kW n� gruppi termici $n_generatori_marche Combustibile: $combustibile</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>Il sottoscritto $cognome_dichiarante $nome_dichiarante</td></tr>
        <tr><td align=left>in qualit� di: Legale rappresentante $legale_rapp &nbsp;&nbsp; Responsabile tecnico $resp_tecnico &nbsp;&nbsp; Tecnico specializzato $tecnico_spec</td></tr>
        <tr><td align=left>della ditta $cognome_manu $nome_manu</td></tr>
        <tr><td align=left>con sede in via $indirizzo_manu Comune $comune_manu</td></tr>
        <tr><td align=left>Provincia $provincia_manu</td></tr>
        <tr><td align=left>Telefono $telefono  &nbsp;&nbsp; Fax $fax  &nbsp;&nbsp; Email $email</td></tr>
        <tr><td align=left>Iscritta alla CCIAA di $localita_reg al numero $reg_imprese</td></tr>
        <tr><td align=left>abilitata ad operare per gli impianti di cui alle lettere a)$flag_a_c c)$flag_c_c e)$flag_e_c &nbsp;&nbsp; dell'articolo 1 del D.M. 37/08,</td></tr>
        <tr><td>&nbsp;</td></tr>


        <tr><td align=left>dichiara di "

	#qui simone
	if {$flag_verif_emis_286 != "S"} {

	    append stampa2 " non aver effettuato la verifica trattandosi di impianto che rientra nei casi previsti dalla parte III sez. 1 dell'allegato IX alla parte V del D.lgs. 152/2006 e ss.mm.ii)</td></tr>"

	} else {	    

	    append stampa2 "
        aver eseguito in data $data_verif_emiss la verifica del rispetto dei valori limite di emissione prevista dal D.Lgs 152/06 art.286 ss.mm.ii., con i seguenti risultati:</td></tr>
        <tr><td>&nbsp;</td></tr>
<tr>
<td>
    <table>
      <tr>
      <td>polveri totali</td>
      <td>$polveri_totali Mg/Nmc all'ora  
      </td>
    </tr>      
    <tr>
      <td>monossido di carbonio (CO)</td>
      <td>$monossido_carbonio Mg/Nmc all'ora  
      </td>
    </tr>      
    <tr>
      <td>ossidi di azoto (NO2)</td>
      <td>$ossidi_azoto Mg/Nmc all'ora  
      </td>
    </tr>      
    <tr>
      <td>ossidi di zolfo (SO2)</td>
      <td>$ossidi_zolfo Mg/Nmc all'ora  
      </td>
    </tr>      
    <tr>
      <td>carbonio organico totale (COT)</td>
      <td>$carbonio_organico_totale Mg/Nmc all'ora  
      </td>
    </tr>      
    <tr>
      <td nowrap>composti inorganici del cloro sotto forma di gas o vapori (come HCI)</td>
      <td>$composti_inorganici_cloro Mg/Nmc all'ora  
      </td>
    </tr>      
    </table>
</td>
<tr>
        <tr><td align=left>Tali risultati sono $risultato_conforme_si conformi &nbsp; &nbsp; $risultato_conforme_no non conformi ai valori-limite previsti dalla parte III, sez. 1, 2 e 3 dell'allegato IX alla parte V del D.lgs. 152/2006 e ss.mm.ii.</td></tr>

    <tr><td>&nbsp;</td></tr>
    <tr><td>Per il campionamento, l'analisi e la valutazione delle emissioni sono stati applicati i metodi contenuti nelle seguenti norme tecniche e nei relativi aggiornamenti:</td></tr>
    <tr><td>$flag_uni_13284_check UNI EN 13284-1;</td></tr>
    <tr><td>$flag_uni_14792_check UNI EN 14792:2017;</td></tr>
    <tr><td>$flag_uni_15058_check UNI EN 15058:2017;</td></tr>
    <tr><td>$flag_uni_10393_check UNI 10393;</td></tr>
    <tr><td>$flag_uni_12619_check UNI EN 12619;</td></tr>
    <tr><td>$flag_uni_1911_check UNI EN 1911-1,2,3.</td></tr>

    <tr><td>&nbsp;</td></tr>
    <tr><td>Per la determinazione delle concentrazioni di ossidi di azoto, monossido di carbonio, ossidi di zolfo e carbonio organico totale, sono stati utilizzati strumenti di misura di tipo elettrochimico. $flag_elettrochimico_check</td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td colspan=2>Per gli impianti a biomassa o a biogas, in quanto gi� esercizio alla data di entrata in vigore del D. Lsg. 152/2006, sono stati utilizzati i metodi in uso ai sensi della normativa previgente. $flag_normativa_previgente_check</td></tr>
"
	}

	append stampa2 " 
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>Il presente documento viene allegato al Libretto d'impianto</td>
        </tr>
        <tr><td colspan=2>&nbsp;</td></tr>
    </table>
    </font>
     <font size = 2>
        <table width=100%>
        <tr>
           <td align=left>Firma del Legale Rappresentante o del Tecnico e timbro della ditta</td>
           <td align=left>Firma del Responsabile dell'impianto</td>
        </tr>
        </table>
        </td>
        </tr>
       </table>
    </font>
"

	set nome_file2        "Dichiarazione art. 284 D. Lg. 152 2006"
	set nome_file2        [iter_temp_file_name $nome_file2]
	set file_html2        "$spool_dir/$nome_file2.html"
	set file_pdf2         "$spool_dir/$nome_file2.pdf"
	set file_pdf_url2     "$spool_dir_url/$nome_file2.pdf"

	set file_id2   [open $file_html2 w]
	fconfigure $file_id2 -encoding iso8859-1
	
	puts $file_id2 $stampa2
	close $file_id2
	
	# lo trasformo in PDF
	iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf2 $file_html2]
	
	ns_unlink $file_html2
	ad_returnredirect $file_pdf_url2
    
    }
}
    
ad_script_abort

