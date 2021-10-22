<!--
    USER  DATA       MODIFICHE
    ===== ========== =================================================================================
    rom04 12/01/2021 Le particolarita' della Provincia di Salerno ora sono sostituite dalla condizione
    rom04            su tutta la Regione Campania.

    rom03 19/02/2019 Su richiesta della regione marche ho rinominato il bottone
    rom03            "Ins. Doc." in "Storicizza stampa RCEE".

    gac01 24/01/2019 Su richiesta di Sandro del 24/01/2019 faccio vedere il campo flag_pagato
    gac01            anche in Visualizzazione.

    gac02 14/01/2019 Varie modifiche alle label e spostamento campi

    gac01M16/11/2018 Modificata parte finale del rcee tipo 2 per regione marche

    rom02 03/10/2018 La regione Marche ha richiesto che non fosse pi� possibile inserire
    rom02            Proprietario e Occupante dalla schermata degli RCEE quindi gli oscuro i link.

    rom01 26/01/2018 Aggiunto sezione multirow per prove fumi aggiuntive per dichiarazioni del freddo

    gab01 29/06/2017 Aggiunto il campo data_prox_manut

    nic02 27/05/2014 Il campo Potenza termica nominale in riscaldamento (utile) non �
    nic02            coimgend.pot_focolare_nom ma coimgend.pot_utile_lib.

    nic01 15/05/2014 Comune di Rimini: se � attivo il parametro flag_gest_coimmode, deve
    nic01            comparire un men� a tendina con l'elenco dei modelli relativi al
    nic01            costruttore selezionato (tale men� a tendina deve essere rigenerato
    nic01            quando si cambia la scelta del costruttore).
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<property name="focus_field">@focus_field;noquote@</property><!-- nic01 -->

<if @flag_no_link@ ne T>
    @link_tab;noquote@
</if>
<else>
    <if @nome_funz_caller@ ne insmodh and @nome_funz_caller@ ne insmodg and @nome_funz_caller@ ne imsmodf and @nome_funz_caller@ ne insmodhbis>
        <table width="100%" cellspacing=0 class=func-menu>
        <tr>
           <td width="25%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coimgage-gest?@url_gage;noquote@" class=func-menu>Ritorna ad Agenda</a>
           </td>
           <td width="75%" colspan=3 class=func-menu>&nbsp</td>
        </tr>
        </table>
    </if>
</else>
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if @menu@ eq 0>
       <td width="12.5%" nowrap class=func-menu>Nuovo Allegato</td>
   </if>
   <else>
   <td width="12.5%" nowrap class=@func_i;noquote@>
       <a href="coimdimp-gest?funzione=I&flag_tracciato=R2&@link_gest;noquote@" class=@func_i;noquote@>Nuovo Allegato</a>
   </td>
   </else>
   <if @funzione@ ne I and @menu@ eq 1>
       <td width="12.5%" nowrap class=@func_v;noquote@>
            <a href="coimdimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
       </td>
       <if @flag_modifica@ eq T>
           <td width="12.5%" nowrap class=@func_m;noquote@>
               <a href="coimdimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
           </td>
       </if>
       <else>
            <td width="12.5%" nowrap class=func-menu>Modifica</td>
       </else>
       <td width="12.5%" nowrap class=@func_d;noquote@>
           <a href="coimdimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
       </td>
       <if @coimtgen.regione@ ne "MARCHE"><!--gac02 if else e loro contenuto-->
	 <if @flag_modifica@ eq T>
           <td width="12.5%" nowrap class=func-menu>
               <a href="@pack_dir;noquote@/coimanom-list?@link_anom;noquote@" class=func-menu>Anomalie</a>
           </td> 
	 </if>
	 <else>
           <td width="12.5%" nowrap class=func-menu>Anomalie</td>
	 </else>
       </if>
       <td width="12.5%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coim_d_anom-list?@link_d_anom;noquote@" class=func-menu>Anomalie Dich.</a>
       </td>

       <td width="12.5%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coimdimp-fr-layout?@link_gest;noquote@&flag_ins=N" class=func-menu target="Stampa ">Stampa RCEE (Tipo 2)</a>
       </td>
       <td width="12.5%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coimdimp-fr-layout?@link_gest;noquote@&flag_ins=S" class=func-menu target="Stampa RCCEE (Tipo 2)">Storicizza stampa RCEE</a><!--rom03 rinominato bottone-->
       </td>
   </if>
   <else>
       <td width="12.5%" nowrap class=func-menu>Visualizza</td>
       <td width="12.5%" nowrap class=func-menu>Modifica</td>
       <td width="12.5%" nowrap class=func-menu>Cancella</td>
       <if @coimtgen.regione@ ne "MARCHE"><!--gac02 if e suo contenuto-->
	 <td width="12.5%" nowrap class=func-menu>Anomalie</td>
       </if>
       <td width="12.5%" nowrap class=func-menu>Anomalie Dich.</td>
       <td width="12.5%" nowrap class=func-menu>Stampa</td>
       <td width="12.5%" nowrap class=func-menu>Storicizza stampa RCEE</td><!--rom03 rinominato bottone-->
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_dimp">
<formwidget   id="cod_opma">
<formwidget   id="cod_impianto">
<formwidget   id="data_ins">
<formwidget   id="cod_manutentore">
<formwidget   id="cod_opmanu_new">
<formwidget   id="cod_dimp">
<formwidget   id="cod_responsabile">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="url_gage">
<formwidget   id="flag_no_link">
<formwidget   id="cod_occupante">
<formwidget   id="cod_proprietario">
<formwidget   id="list_anom_old">
<formwidget   id="flag_modifica">
<formwidget   id="gen_prog">
<formwidget   id="flag_ins_occu">
<formwidget   id="flag_ins_prop">
<formwidget   id="flag_modello_h">
<formwidget   id="nome_funz_new">
<formwidget   id="nome_funz_gest">
<formwidget   id="flag_tracciato">
<formwidget   id="locale">
<if @vis_desc_contr@ eq t>
    <formwidget id="flag_status"
</if>
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->
<if @coimtgen.regione@ eq "MARCHE"><!--gac02 if e suo contenuto-->
  <formwidget   id="cont_rend">
  <formwidget   id="costruttore">
  <formwidget   id="combustibile">
  <formwidget   id="data_insta">
  <formwidget   id="data_costruz_gen">
  <formwidget   id="marc_effic_energ">
  <formwidget   id="potenza">
</if>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td><table width="100%"><tr>
<td align="left" width="50%">@esito;noquote@</td>
<if @funzione@ eq "V">
<td align="right" width="50%">Inserito da: @nome_utente_ins;noquote@</td></tr>
<tr><td align="left" width="50%">&nbsp;</td>
<td align="right" width="50%">In data: @data_ins_edit;noquote@</td></tr>
</if>
<else>
<td width="50%">&nbsp;</td></tr>
</else>
<if @flag_portafoglio@ eq T>
<tr>
<td align="center" colspan=2><b><font color=red>@report;noquote@</font></b></td></tr>
<!-- <tr><td align="center" colspan=2><b><font color=red><small>@report1;noquote@</small></font></b></td></tr -->
<tr>
<td align="center" colspan=2><b><font color=red>@msg_limite;noquote@</font></b></td></tr>
<tr>
  <td align="right" colspan=2><b>Saldo attuale del portafoglio N. <formwidget id="cod_portafoglio">: &#8364;<formwidget id="saldo_manu"></b></td></tr>
<if @coimtgen.regione@ eq "MARCHE">
  <tr>
      <td colspan=2 align=center>
	<formerror  id="err_rcee"><br><!--gac01-->
	  <span class="errori">@formerror.err_rcee;noquote@</span>
      </formerror></td>
  </tr>
</if>
<tr>
  <td colspan=2>&nbsp;</td>
</tr>
</table></td></tr>
</if>
<else>
</table></td></tr>
</else>
<tr><td><table width="100%" border=0>
      <if @coimtgen.regione@ eq "MARCHE"><!--gac02 if e suo contenuto-->
	<tr>
	  <th valign=top colspan=4 align=left class=form_title>A.DATI IDENTIFICATIVI</th>
	</tr>
	<tr>
	  <td width=25% align=right>Impianto: di Potenza termica nominale totale max (kW)</td>
	  <td valign=top><formwidget id="pot_ter_nom_tot_max">
	      <formerror  id="pot_ter_nom_tot_max"><br>
		<span class="errori">@formerror.pot_ter_nom_tot_max;noquote@</span>
	      </formerror>
	  </td>
	</tr>
	<tr>
	  <td valign=top align=right class=form_title>Rapporto di controllo N&deg;</td>
	  <td valign=top><formwidget id="num_autocert">
              <formerror  id="num_autocert"><br>
		<span class="errori">@formerror.num_autocert;noquote@</span>
              </formerror>
	  </td>
        </tr>
      </if>
      <else>
	<td valign=top align=right class=form_title>Rapporto di controllo N&deg;</td>
	<td valign=top><formwidget id="num_autocert">
	    <formerror  id="num_autocert"><br>
	      <span class="errori">@formerror.num_autocert;noquote@</span>
	    </formerror>
	</td>
      </else>	
      <if @coimtgen.regione@ ne "MARCHE">
	<td valign=top align=right class=form_title nowrap>Data del controllo <font color=red>*</font></td><!--gac01-->
	<td  valign=top><formwidget id="data_controllo">
            <formerror  id="data_controllo"><br>
              <span class="errori">@formerror.data_controllo;noquote@</span>
            </formerror>
	</td>

    <td valign=top align=right class=form_title>Orario di arrivo presso l'impianto</td><!--gac01-->
    <td  valign=top><formwidget id="ora_inizio">
        <formerror  id="ora_inizio"><br>
        <span class="errori">@formerror.ora_inizio;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di partenza dall'impianto</td><!--gac01-->
    <td  valign=top><formwidget id="ora_fine">
        <formerror  id="ora_fine"><br>
        <span class="errori">@formerror.ora_fine;noquote@</span>
        </formerror>
    </td>
</if>
</tr>

<if @coimtgen.regione@ eq "MARCHE"><!--gac02 if else e loro contenuto-->
<tr>
    <td valign=top align=right class=form_title>Numero Rif. interno</td>
    <td valign=top><formwidget id="n_prot">
        <formerror  id="n_prot"><br>
        <span class="errori">@formerror.n_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data di arrivo all'ente</td>
    <td valign=top><formwidget id="data_arrivo_ente">
        <formerror  id="data_arrivo_ente"><br>
        <span class="errori">@formerror.data_arrivo_ente;noquote@</span>
        </formerror>
    </td>
  
</if>
<else>
<tr>
    <td valign=top align=right class=form_title>Num. protocollo</td>
    <td valign=top><formwidget id="n_prot">
        <formerror  id="n_prot"><br>
        <span class="errori">@formerror.n_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data protocollo</td>
    <td valign=top><formwidget id="data_prot">
        <formerror  id="data_prot"><br>
        <span class="errori">@formerror.data_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data di arrivo all'ente</td>
    <td valign=top><formwidget id="data_arrivo_ente">
        <formerror  id="data_arrivo_ente"><br>
        <span class="errori">@formerror.data_arrivo_ente;noquote@</span>
        </formerror>
    </td>
</else>
    <if @flag_cind@ eq "S">
       <td valign=top align=right class=form_title>Campagna</td>
       <td valign=top><formwidget id="cod_cind">
         <formerror  id="cod_cind"><br>
         <span class="errori">@formerror.cod_cind;noquote@</span>
         </formerror>
       </td>
    </if>

    </tr></table></td>
</tr>
<tr><td><table border=0 width="100%">
    <tr>
        <td width="17%" valign=top align=left class=form_title>Responsabile d'impianto</td>
        <td width="16%" valign=top align=left class=form_title>Impresa manutentrice<font color=red>*</font></td>
        <td width="17%" valign=top align=left class=form_title>Tecnico che ha effettuato il controllo<if @coimtgen.regione@ eq "MARCHE"><font color=red>*</font></if>
	  <!--rom04 modificata condizione su PSA con quella di regione CAMPANIA -->
	  <if @coimtgen.regione@ eq "CAMPANIA" and @id_utente_ma;noquote@ eq "MA">
            <font color=red>*</font></if>
</td>
	<if @coimtgen.regione@ ne "MARCHE"><!--gac02 if e suo contenuto-->
          <td width="17%" valign=top align=left class=form_title>Proprietario</td>
          <td width="17%" valign=top align=left class=form_title>Occupante</td>
          <td width="16%" valign=top align=left class=form_title>Intestatario Contratto</td>
	</if>
    </tr>
    <tr>
    <td valign=top><formwidget id="cognome_resp">@link_gest_resp;noquote@<br>
        <formwidget id="nome_resp">@cerca_resp;noquote@<br>
        <formwidget id="cod_fiscale_resp">(CF)<br>
        <formerror  id="cognome_resp"><br>
        <span class="errori">@formerror.cognome_resp;noquote@</span>
        </formerror>
    </td>
    <td valign=top><formwidget id="cognome_manu"><br>
        <formwidget id="nome_manu">@cerca_manu;noquote@
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
        </formerror>
    </td>
    <td valign=top><formwidget id="cognome_opma"><br>
        <formwidget id="nome_opma">@cerca_opma;noquote@
        <formerror  id="cognome_opma"><br>
        <span class="errori">@formerror.cognome_opma;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ ne "MARCHE"><!--gac02 if e suo contenuto-->
      <td valign=top><formwidget id="cognome_prop"><br>
        <formwidget id="nome_prop">@cerca_prop;noquote@
        <formerror  id="cognome_prop"><br>
        <span class="errori">@formerror.cognome_prop;noquote@</span>
        </formerror>
       <br><if @coimtgen.regione@ ne "MARCHE">@link_ins_prop;noquote@</if><!--rom02 le marche non devono poter inserire il proprietario
									      dall'rcee; quindi gli oscuro il link-->
    </td>
    <td valign=top><formwidget id="cognome_occu"><br>
        <formwidget id="nome_occu">@cerca_occu;noquote@
        <formerror  id="cognome_occu"><br>
        <span class="errori">@formerror.cognome_occu;noquote@</span>
        </formerror>
        <br><if @coimtgen.regione@ ne "MARCHE">@link_ins_occu;noquote@</if><!--rom02 le marche non devono poter inserire l'occupante
                                                                          dall'rcee; quindi gli oscuro il link-->
    </td>
    <td valign=top><formwidget id="cognome_contr"><br>
        <formwidget id="nome_contr">@cerca_contr;noquote@
        <formerror  id="cognome_contr"><br>
        <span class="errori">@formerror.cognome_contr;noquote@</span>
        </formerror>
    </td>
    </if>
    </tr></table></td>
</tr>

<tr><td><table border=0 width=100%><tr>
    <td width=50% valign=top><table border=0 width=100%><tr>
    <th valign=top colspan=4 align=left class=form_title>B.DOCUMENTAZIONE TECNICA DI CORREDO</th>
    </tr><tr>
    <td valign=top align=right class=form_title>Dichiarazione di Conformit&agrave; presente</td>
    <td valign=top><formwidget id="conformita">
        <formerror  id="conformita"><br>
        <span class="errori">@formerror.conformita;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Libretti uso/manutenzione generatore presenti</td>
    <td valign=top><formwidget id="lib_uso_man">
        <formerror  id="lib_uso_man"><br>
        <span class="errori">@formerror.lib_uso_man;noquote@</span>
        </formerror>
    </td>
  
    </tr><tr>
    <td valign=top align=right class=form_title>Libretto d'impianto presente</td>
    <td valign=top><formwidget id="lib_impianto">
        <formerror  id="lib_impianto"><br>
        <span class="errori">@formerror.lib_impianto;noquote@</span>
        </formerror>
    </td>
     <td valign=top align=right class=form_title>Libretto compilato in tutte le sue parti</td>
    <td valign=top><formwidget id="rct_lib_uso_man_comp">
        <formerror  id="lib_uso_man"><br>
        <span class="errori">@formerror.rct_lib_uso_man_comp;noquote@</span>
        </formerror>
    </td>
    </tr><tr>

    <th valign=top colspan=2 align=left class=form_title>C.TRATTAMENTO DELL'ACQUA</th>
    </tr><tr>
    <td valign=top align=right class=form_title>Durezza totale dell'acqua (�fr)</td>
    <td valign=top><formwidget id="rct_dur_acqua">
        <formerror  id="rct_dur_acqua"><br>
        <span class="errori">@formerror.rct_dur_acqua;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Trattamento in riscaldamento:</td>
    <td valign=top><formwidget id="rct_tratt_in_risc">
        <formerror  id="rct_tratt_in_risc"><br>
        <span class="errori">@formerror.rct_tratt_in_risc;noquote@</span>
        </formerror>
    </td>
	</tr>
    <tr>
     <th valign=top align=left colspan=2 class=form_title>D. CONTROLLO DELL'IMPIANTO (esami visivi)</th>
    </tr><tr> 
    <td valign=top align=right class=form_title>Locale di installazione idoneo</td>
    <td valign=top><formwidget id="idoneita_locale">
        <formerror  id="idoneita_locale"><br>
        <span class="errori">@formerror.idoneita_locale;noquote@</span>
        </formerror>
    </td>
       <td valign=top align=right class=form_title>Linee elettriche idonee</td>
    <td valign=top><formwidget id="fr_linee_ele">
        <formerror  id="fr_linee_ele"><br>
        <span class="errori">@formerror.fr_linee_ele;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
     </tr><tr> 
        <td valign=top align=right class=form_title>Dimensioni aperture di ventilazione adeguate</td>
    <td valign=top><formwidget id="ap_ventilaz">
        <formerror  id="ap_ventilaz"><br>
        <span class="errori">@formerror.ap_ventilaz;noquote@</span>
        </formerror>
    </td>
     <td valign=top align=right class=form_title>Coibentazioni idonee</td>
    <td valign=top><formwidget id="fr_coibentazione">
        <formerror  id="fr_coibentazione"><br>
        <span class="errori">@formerror.fr_coibentazione;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
          <td valign=top align=right class=form_title>Aperture di ventilazione libere da ostruzioni</td>
    <td valign=top><formwidget id="ap_vent_ostruz">
        <formerror  id="ap_vent_ostruz"><br>
        <span class="errori">@formerror.ap_vent_ostruz;noquote@</span>
        </formerror>
    </td>
     </tr> </table></td></tr>

<tr><td><table border=0 width=100%><tr><!--gac02 aggiunta sezione D.bis-->
<tr><td colspan=6><b>D.bis. CONSUMI</b></td></tr>
<tr>   
    <td valign=top align=center colspan=6 class=form_title><b>Consumi di combustibile <if @um;noquote@ ne "">(@um;noquote@)</if></b>
</tr>
<tr>
    <td width=21% valign=top align=center class=form_title>Stagione di riscaldamento attuale</td>
    <td width=15% valign=top align=center class=form_title>Acquisti</td>
    <td width=15% valign=top align=center class=form_title>Scorta o lettura iniziale</td>
    <td width=15% valign=top align=center class=form_title>Scorta o lettura finale</td>
    <td width=34% valign=top align=center class=form_title>Consumi stagione</if></td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="stagione_risc">
        <formerror  id="stagione_risc"><br>
        <span class="errori">@formerror.stagione_risc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="acquisti">
        <formerror  id="acquisti"><br>
        <span class="errori">@formerror.acquisti;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_iniz">
        <formerror id="scorta_o_lett_iniz"><br>
        <span class="errori">@formerror.scorta_o_lett_iniz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_fin">
        <formerror id="scorta_o_lett_fin"><br>
        <span class="errori">@formerror.scorta_o_lett_fin;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="consumo_annuo">
        <formerror  id="consumo_annuo"><br>
        <span class="errori">@formerror.consumo_annuo;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>@cons_annuo;noquote@</td>
</tr>
<tr>
    <td valign=top align=center class=form_title>Stagione di riscaldamento precedente</td>
    <td valign=top align=center class=form_title>Acquisti</td>
    <td valign=top align=center class=form_title>Scorta o lett. iniziale</td>
    <td valign=top align=center class=form_title>Scorta o lett. finale</td>
    <td valign=top align=center class=form_title>Consumi stagione</if></td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="stagione_risc2">
        <formerror  id="stagione_risc2"><br>
        <span class="errori">@formerror.stagione_risc2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="acquisti2">
        <formerror  id="acquisti2"><br>
        <span class="errori">@formerror.acquisti2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_iniz2">
        <formerror id="scorta_o_lett_iniz2"><br>
        <span class="errori">@formerror.scorta_o_lett_iniz2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_fin2">
        <formerror id="scorta_o_lett_fin2"><br>
        <span class="errori">@formerror.scorta_o_lett_fin2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="consumo_annuo2">
        <formerror  id="consumo_annuo2"><br>
        <span class="errori">@formerror.consumo_annuo2;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>@cons_annuo;noquote@</td>
</tr>
</table></td></tr>
<tr><td><table border=0 width=100%><!--gac02 aggiunto campi elettricit� -->
<tr>   
    <td valign=top align=center colspan=4 class=form_title><b>Consumi elettrici</b>
</tr>
<tr>
    <td valign=top align=center class=form_title>Esercizio</td>
    <td valign=top align=center class=form_title>Lettura iniziale (kWh)</td>
    <td valign=top align=center class=form_title>Lettura finale (kWh)</td>
    <td valign=top align=center class=form_title>Consumo totale (kWh)</td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="elet_esercizio_1">
        <formerror  id="elet_esercizio_1"><br>
        <span class="errori">@formerror.elet_esercizio_1;noquote@</span>
        </formerror>
    / <formwidget id="elet_esercizio_2">
        <formerror  id="elet_esercizio_2"><br>
        <span class="errori">@formerror.elet_esercizio_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_iniziale">
        <formerror  id="elet_lettura_iniziale"><br>
        <span class="errori">@formerror.elet_lettura_iniziale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_finale">
        <formerror  id="elet_lettura_finale"><br>
        <span class="errori">@formerror.elet_lettura_finale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_consumo_totale">
        <formerror  id="elet_consumo_totale"><br>
        <span class="errori">@formerror.elet_consumo_totale;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="elet_esercizio_3">
        <formerror  id="elet_esercizio_3"><br>
        <span class="errori">@formerror.elet_esercizio_3;noquote@</span>
        </formerror>
    / <formwidget id="elet_esercizio_4">
        <formerror  id="elet_esercizio_4"><br>
        <span class="errori">@formerror.elet_esercizio_4;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_iniziale_2">
        <formerror  id="elet_lettura_iniziale_2"><br>
        <span class="errori">@formerror.elet_lettura_iniziale_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_finale_2">
        <formerror  id="elet_lettura_finale_2"><br>
        <span class="errori">@formerror.elet_lettura_finale_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_consumo_totale_2">
        <formerror  id="elet_consumo_totale_2"><br>
        <span class="errori">@formerror.elet_consumo_totale_2;noquote@</span>
        </formerror>
    </td>
</tr>

</table></td></tr>

<tr><td><table border=0 width=100%>
    <tr><td colspan=6><b>E. CONTROLLO E VERIFICA ENERGETICA DEL GRUPPO FRIGO GF @gen_prog@</b></td></tr>
    <tr>
      <if @coimtgen.regione@ eq "MARCHE">
      <td valign=top align=right class=form_title>Fabbricante</td>
      <td valign=top><formwidget id="descr_cost">
          <formerror  id="descr_cost"><br>
            <span class="errori">@formerror.descr_cost;noquote@</span>
          </formerror>
      </td>
      </if>
      <else>
      <td valign=top align=right class=form_title>Costruttore</td>
      <td valign=top><formwidget id="costruttore">
          <formerror  id="costruttore"><br>
            <span class="errori">@formerror.costruttore;noquote@</span>
          </formerror>
      </td>
      </else>

    <td valign=top align=right class=form_title>Modello</td>
    <if @coimtgen.flag_gest_coimmode@ eq "F"><!-- nic01 -->
        <td valign=top><formwidget id="modello">
            <formerror  id="modello"><br>
            <span class="errori">@formerror.modello;noquote@</span>
            </formerror>
        </td>
        <formwidget id="cod_mode"><!-- nic01 -->
    </if>
    <else><!-- nic01 -->
        <td valign=top><formwidget id="cod_mode"><!-- nic01 -->
            <formerror  id="cod_mode"><br><!-- nic01 -->
            <span class="errori">@formerror.cod_mode;noquote@</span><!-- nic01 -->
            </formerror><!-- nic01 -->
        </td><!-- nic01 -->
        <formwidget id="modello"><!-- nic01 -->
    </else>

    <td valign=top align=right class=form_title>Matricola</td>
    <td valign=top><formwidget id="matricola">
        <formerror  id="matricola"><br>
        <span class="errori">@formerror.matricola;noquote@</span>
        </formerror>
    </td>
    </tr>
    <if @coimtgen.regione@ eq "MARCHE">
      <tr>
	<td valign=top align=right class=form_title>N. circuiti</td>
	<td valign=top><formwidget id="num_circuiti">
	    <formerror  id="num_circuiti"><br>
	      <span class="errori">@formerror.num_circuiti;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
    <td valign=top align=right class=form_title colspan=2>Ad assorbimento per recupero del calore</td>
    <td valign=top><formwidget id="fr_assorb_recupero">
        <formerror  id="fr_assorb_recupero"><br>
        <span class="errori">@formerror.fr_assorb_recupero;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title >Ad assorbimento a fiamma diretta</td>
    <td valign=top><formwidget id="fr_assorb_fiamma">
        <formerror  id="fr_assorb_fiamma"><br>
        <span class="errori">@formerror.fr_assorb_fiamma;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ eq "MARCHE"> 
    <td valign=top align=right class=form_title>Con combustibile</td>
    <td valign=top><formwidget id="descr_comb">
        <formerror  id="descr_comb"><br>
          <span class="errori">@formerror.descr_comb;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
    <td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top><formwidget id="combustibile">
        <formerror  id="combustibile"><br>
          <span class="errori">@formerror.combustibile;noquote@</span>
        </formerror>
    </td>
    </else>
      </tr>
    <tr>
	<td valign=top align=right class=form_title colspan=2>A ciclo di compressione con motore elettrico o endotermico</td>
	<td valign=top><formwidget id="fr_ciclo_compressione">
        <formerror  id="fr_ciclo_compressione"><br>
        <span class="errori">@formerror.fr_ciclo_compressione;noquote@</span>
        </formerror>
	</td>
      </tr>
    </if>
    <tr>
      <if @coimtgen.regione@ eq "MARCHE"><!--gac02-->
	<td valign=top align=right class=form_title>Potenza frigorifera nominale in raffrescamento (kW)</td>
	<td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
	</td>
      </if>
      <else>
	<td valign=top align=right class=form_title>Pot. term. utile raffresc. (kW)</td>
	<td valign=top><formwidget id="potenza">
        <formerror  id="potenza"><br>
        <span class="errori">@formerror.potenza;noquote@</span>
        </formerror>
	</td>
      </else>
      <if @coimtgen.regione@ eq "MARCHE"><!--gac02-->
	<td valign=top align=right class=form_title>Potenza termica nominale in riscaldamento (kW)</td>
      </if>
      <else>
	<td valign=top align=right class=form_title>Pot. term. utile riscald. (kW)</td>
      </else>
      <td valign=top><formwidget id="pot_focolare_lib">
        <formerror  id="pot_focolare_lib"><br>
        <span class="errori">@formerror.pot_focolare_lib;noquote@</span>
        </formerror>
    </td>
<if @coimtgen.regione@ ne "MARCHE">
      <td valign=top align=right class=form_title>Data costruzione</td>
    <td valign=top><formwidget id="data_costruz_gen">
        <formerror  id="data_costruz_gen"><br>
        <span class="errori">@formerror.data_costruz_gen;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Marcatura efficienza energetica (DPR 660/96)</td>
    <td valign=top><formwidget id="marc_effic_energ">
        <formerror  id="marc_effic_energ"><br>
        <span class="errori">@formerror.marc_effic_energ;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data installazione</td>
    <td valign=top><formwidget id="data_insta">
        <formerror  id="data_insta"><br>
        <span class="errori">@formerror.data_insta;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Destinazione</td>
    <td valign=top colspan=5><formwidget id="destinazione">
        <formerror  id="destinazione"><br>
        <span class="errori">@formerror.destinazione;noquote@</span>
        </formerror>
    </td>

</tr>
<tr>
    <td valign=top align=right class=form_title>Volumetria riscaldata (m<sup><small>3</small></sup>)</td>
    <td valign=top><formwidget id="volimetria_risc">
        <formerror  id="volimetria_risc"><br>
        <span class="errori">@formerror.volimetria_risc;noquote@</span>
        </formerror>
</tr>
<tr>
    <td valign=top align=right class=form_title>Stagione di riscaldamento attuale</td>
    <td valign=top><formwidget id="stagione_risc">
    	<formerror  id="stagione_risc"><br>
        	<span class="errori">@formerror.stagione_risc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Consumi stagione (m<sup><small>3</small></sup>/kg)</td>
    <td valign=top><formwidget id="consumo_annuo">
        <formerror  id="consumo_annuo"><br>
        <span class="errori">@formerror.consumo_annuo;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Stagione di riscaldamento precedente</td>
    <td valign=top><formwidget id="stagione_risc2">
    	<formerror  id="stagione_risc2"><br>
        	<span class="errori">@formerror.stagione_risc2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Consumi stagione (m<sup><small>3</small></sup>/kg)</td>
    <td valign=top><formwidget id="consumo_annuo2">
        <formerror  id="consumo_annuo2"><br>
        <span class="errori">@formerror.consumo_annuo2;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<!--
<tr>
    <td valign=top align=right class=form_title>Tipo</td>
    <td valign=top><formwidget id="tipo_a_c">
        <formerror  id="tipo_a_c"><br>
        <span class="errori">@formerror.tipo_a_c;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Tiraggio</td>
    <td valign=top><formwidget id="tiraggio">
        <formerror  id="tiraggio"><br>
        <span class="errori">@formerror.tiraggio;noquote@</span>
        </formerror>
    </td>
</tr>
-->
<if @coimtgen.regione@ ne "MARCHE">
  <tr>
    <td valign=top align=right class=form_title>Gruppo Frigo</td>
    <td valign=top><formwidget id="rct_gruppo_termico">
        <formerror  id="rct_gruppo_termico"><br>
        <span class="errori">@formerror.rct_gruppo_termico;noquote@</span>
        </formerror>
    </td>

</tr>
<tr>
    <td valign=top align=right class=form_title colspan=2>Ad assorbimento per il recupero del calore</td>
    <td valign=top><formwidget id="fr_assorb_recupero">
        <formerror  id="fr_assorb_recupero"><br>
        <span class="errori">@formerror.fr_assorb_recupero;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title colspan=2>Ad assorbimento a fiamma diretta con combustibile</td>
    <td valign=top><formwidget id="fr_assorb_fiamma">
        <formerror  id="fr_assorb_fiamma"><br>
        <span class="errori">@formerror.fr_assorb_fiamma;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ ne "MARCHE">
      <td valign=top align=right class=form_title>Combustibile</td>
      <td valign=top><formwidget id="combustibile">
        <formerror  id="combustibile"><br>
        <span class="errori">@formerror.combustibile;noquote@</span>
        </formerror>
      </td>
    </if>
</tr>
      <tr>
    <td valign=top align=right class=form_title colspan=2>A ciclo di compressione con motore elettrico o endotermico</td>
    <td valign=top><formwidget id="fr_ciclo_compressione">
        <formerror  id="fr_ciclo_compressione"><br>
        <span class="errori">@formerror.fr_ciclo_compressione;noquote@</span>
        </formerror>
    </td>
      </tr>
</if>
    <tr>
    <td valign=top align=right class=form_title colspan=2>Assenza di perdite di gas refrigerante</td>
    <td valign=top><formwidget id="fr_assenza_perdita_ref">
        <formerror  id="fr_assenza_perdita_ref"><br>
        <span class="errori">@formerror.fr_assenza_perdita_ref;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
     <td valign=top align=right class=form_title colspan=2>Presenza apparecchiatura automatica rilevazione diretta fughe refrigerante - leak detector</td>
    <td valign=top><formwidget id="fr_leak_detector">
        <formerror  id="fr_leak_detector"><br>
        <span class="errori">@formerror.fr_leak_detector;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title colspan=2>Presenza apparecchiatura automatica rilevazione indiretta fughe refrigerante (parametri termodinamici)</td>
    <td valign=top><formwidget id="fr_pres_ril_fughe">
        <formerror  id="fr_pres_ril_fughe"><br>
        <span class="errori">@formerror.fr_pres_ril_fughe;noquote@</span>
        </formerror>
    </td>
    
    </tr><tr>
    <td valign=top align=right class=form_title colspan=2>Scambiatori di calore puliti e liberi da incrostazioni</td>
    <td valign=top><formwidget id="fr_scambiatore_puliti">
        <formerror  id="fr_scambiatore_puliti"><br>
        <span class="errori">@formerror.fr_scambiatore_puliti;noquote@</span>
        </formerror>
    </td>
    </tr>
    <if @coimtgen.regione@ ne "MARCHE">
      <tr>
	<td valign=top align=right class=form_title colspan=2>Prova eseguita in modalita' raffreddamento/riscaldamento</td>
	<td valign=top><formwidget id="fr_prova_modalita">
            <formerror  id="fr_prova_modalita"><br>
              <span class="errori">@formerror.fr_prova_modalita;noquote@</span>
        </formerror>
	</td>
      </tr>
    </if>
<!--</tr>
</table>
</td>
</tr>--!>
<!--<tr>-->
<!--    <td valign=top align=left class_form_title><b>F. CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</b>-->
<!--        <formwidget id="cont_rend">-->
<!--        <formerror  id="eff_evac_fum"><br>-->
<!--        <span class="errori">@formerror.eff_evac_fum;noquote@</span>-->
<!--        </formerror>-->
<!--    </td>-->
<!--</tr>-->

<!--<tr><td colspan=2 width=100%><table border=0 cellspacing=0 cellpadding=0 width=100% border=0>-->
<if @coimtgen.regione@ eq "MARCHE">
  <tr>
    <td valign=top align=right class=form_title colspan=2>Motivo compilazione REE</td><!--sim58 aggiuno campo cod_tprc-->
    <td valign=top align=left colspan=6><formwidget id="cod_tprc">
        <formerror  id="cod_tprc"><br>
          <span class="errori">@formerror.cod_tprc;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<tr>
  <if @coimtgen.regione@ eq "MARCHE">
    <th valign=top align=left class=form_title colspan=2>Controllo del rendimento di combustione</th>
    <td valign=top><formwidget id="cont_rend_gen"><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=cont_rend_fr', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><b>Vedi nota</b></a> <!--gac02 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="cont_rend"><br>
        <span class="errori">@formerror.cont_rend;noquote@</span>
        </formerror>
    </td>   
  </if>
  <else>
    <th valign=top align=left class=form_title colspan=2>H.CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</th>
    <td valign=top><formwidget id="cont_rend">
        <formerror  id="cont_rend"><br>
        <span class="errori">@formerror.cont_rend;noquote@</span>
        </formerror>
    </td>   
  </else>
</tr>
<if @coimtgen.regione@ eq "MARCHE">
  <tr>
    <td colspan=2 color><b><font color=blue><formwidget id="warning_cont_rend"></font></b>
      <formerror  id="warning_cont_rend">
	<span class="errori">@formerror.warning_cont_rend;noquote@</span></td>
    </formerror>
  </tr>
</if>
<if @coimtgen.regione@ ne "MARCHE">
  <tr>
    <td valign=top align=right class=form_title colspan=2>Tipo controllo</td><!--sim58 aggiuno campo cod_tprc-->
    <td valign=top align=left colspan=6><formwidget id="cod_tprc">
        <formerror  id="cod_tprc"><br>
          <span class="errori">@formerror.cod_tprc;noquote@</span>
        </formerror>
    </td>
  </tr>
</if>
<if @coimtgen.regione@ eq "MARCHE">
      <tr>
	<td valign=top align=right class=form_title colspan=2>Prova eseguita in modalita' raffreddamento/riscaldamento</td>
	<td valign=top><formwidget id="fr_prova_modalita">
            <formerror  id="fr_prova_modalita"><br>
              <span class="errori">@formerror.fr_prova_modalita;noquote@</span>
        </formerror>
	</td>
      </tr>
    </if>
    </table>
    </td>
</tr>
<tr>
  <td colspan=2 width=100%><table border=0 cellspacing=0 cellpadding=0 width=100%>
    <tr>
       <td valign=top align=center class=form_title>Surrisc. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>Sottoraff. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. condens. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. evapor. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. ing. lato. est. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. usc. lato. est. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. ing. lato. utenze (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. usc. lato. utenze (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>N. Circuito<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
    </tr>
    <tr>
    <td valign=top align=center><formwidget id="fr_surrisc">
        <formerror  id="fr_surrisc"><br>
        <span class="errori">@formerror.fr_surrisc;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_sottoraff">
        <formerror  id="fr_sottoraff"><br>
        <span class="errori">@formerror.fr_sottoraff;noquote@</span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="fr_tcondens">
        <formerror  id="fr_tcondens"><br>
        <span class="errori">@formerror.fr_tcondens;noquote@</span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="fr_tevapor">
        <formerror  id="fr_tevapor"><br>
        <span class="errori">@formerror.fr_tevapor;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_ing_lato_est">
        <formerror  id="fr_t_ing_lato_est"><br>
        <span class="errori">@formerror.fr_t_ing_lato_est;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_usc_lato_est">
        <formerror  id="fr_t_usc_lato_est"><br>
        <span class="errori">@formerror.fr_t_usc_lato_est;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_ing_lato_ute">
        <formerror  id="fr_t_ing_lato_ute"><br>
        <span class="errori">@formerror.fr_t_ing_lato_ute;noquote@</span>
        </formerror>
    </td>

       <td valign=top align=center><formwidget id="fr_t_usc_lato_ute">
        <formerror  id="fr_t_usc_lato_ute"><br>
        <span class="errori">@formerror.fr_t_usc_lato_ute;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_nr_circuito">
        <formerror  id="fr_nr_circuito"><br>
        <span class="errori">@formerror.fr_nr_circuito;noquote@</span>
        </formerror>
    </td>

  
    </tr></table></td>
<!--rom01 aggiunto sezione multirow per prove fumi aggiuntive-->
<if @conta_prfumi ne 0>
<multiple name=multiple_form_prfumi>
<tr><td colspan=2 width=100%><table border=0 cellspacing=0 cellpadding=0 width=100%>
    <tr>
       <td valign=top align=center class=form_title>Surrisc. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>Sottoraff. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. condens. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. evapor. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. ing. lato. est. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. usc. lato. est. (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. ing. lato. utenze (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>T. usc. lato. utenze (&deg;C)<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
       <td valign=top align=center class=form_title>N. Circuito<if @cont_rend;noquote@ eq "S"><font color=red>*</font></if></td>
    </tr>
    <tr>
    <td valign=top align=center><formwidget id="fr_surrisc.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_surrisc.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_surrisc.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_sottoraff.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_sottoraff.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_sottoraff.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="fr_tcondens.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_tcondens.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_tcondens.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="fr_tevapor.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_tevapor.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_tevapor.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_ing_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_t_ing_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_t_ing_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_usc_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_t_usc_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_t_usc_lato_est.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_t_ing_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_t_ing_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_t_ing_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

       <td valign=top align=center><formwidget id="fr_t_usc_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_t_usc_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_t_usc_lato_ute.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="fr_nr_circuito.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="fr_nr_circuito.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(fr_nr_circuito.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

  
    </tr></table></td>

 </tr>
</multiple>
</if> <!--rom01-->

 </tr></table></td>
</tr>


 <th valign=top align=left class=form_title>F.CHECK-LIST</th>
 <tr> </tr>
  <td valign=top align=left class=form_title>Elenco dei possibili interventi, dei quali va valuta la convenienza economica, che qualora applicabili all'impianto potrebbero comportare un miglioramento della prestazione energetica</td>
 </tr>
 <tr><td colspan=2 align=left><table border=0 cellspacing=0 cellpadding=0>
    <tr>
    <td valign=top align=left class=form_title>La sostituzione di generatori a regolazione on/off, con altri di pari potenza a pi� gradini o a regolazione continua</td>
    <td valign=top><formwidget id="fr_check_list_1">
        <formerror  id="fr_check_list_1"><br>
        <span class="errori">@formerror.fr_check_list_1;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>La sostituzione dei sistemi di regolazione on/off, con sistemi programmabili su pi� livelli di temperatura</td>
    <td valign=top><formwidget id="fr_check_list_2">
        <formerror  id="fr_check_list_2"><br>
        <span class="errori">@formerror.fr_check_list_2;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>L'isolamento della rete di distribuzione acqua refrigerata/calda nei locali non climatizzati</td>
    <td valign=top><formwidget id="fr_check_list_3">
        <formerror  id="fr_check_list_3"><br>
        <span class="errori">@formerror.fr_check_list_3;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>L'isolamento dei canali di distribuzione aria fredda/calda nei locali non climatizzati</td>
    <td valign=top><formwidget id="fr_check_list_4">
        <formerror  id="fr_check_list_4"><br>
        <span class="errori">@formerror.fr_check_list_4;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
 </tr></table></td>

<tr>
  <td><table border=0><tr>
	<if @coimtgen.regione@ eq "MARCHE"><!--gac02 if else e contenuto di if-->
           <td valign=bottom align=left class=form_title><b>Osservazioni</b><br><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=osservaz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><b>Vedi nota</b></a> <!--gac02 aggiunto pop-up su richiesta delle Marche--></td>
	</if>
	<else>
	  <td valign=bottom align=left class=form_title><b>Osservazioni</b></td>
	</else>
      </tr>
         <tr>
           <td valign=top><formwidget id="osservazioni">
               <formerror  id="osservazioni"><br>
               <span class="errori">@formerror.osservazioni;noquote@</span>
               </formerror>
           </td>
         </tr>
         <tr>
	   <if @coimtgen.regione@ eq "MARCHE"><!--gac02 if else e contenuto di if-->
	     <td valign=bottom align=left class=form_title><b>Raccomandazioni</b><br><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=raccomandaz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><b>Vedi nota</b></a> <!--gac02 aggiunto pop-up su richiesta delle Marche--></td>
           </if>
	   <else>
	     <td valign=bottom align=left class=form_title><b>Raccomandazioni</b><br> (in attesa di questi interventi l'impianto pu&ograve; essere messo in funzione)</td>
	   </else>
         </tr>
         <tr>
            <td valign=top><formwidget id="raccomandazioni">
                <formerror  id="raccomandazioni"><br>
                <span class="errori">@formerror.raccomandazioni;noquote@</span>
                </formerror>
            </td>
         </tr>
        <tr>
	  <if @coimtgen.regione@ eq "MARCHE"><!--gac02 if else e contenuto di if-->
            <td valign=top align=left class=form_title><b>Prescrizioni</b><br><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=prescriz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><b>Vedi nota</b></a> <!--gac02 aggiunto pop-up su richiesta delle Marche--></td>
	  </if>
	  <else>
            <td valign=top align=left class=form_title><b>Prescrizioni</b><br> (in attesa di questi interventi l'impianto <b>non</b> pu&ograve; essere messo in funzione)</td>
	  </else>
        </tr>
         <tr>
            <td valign=top><formwidget id="prescrizioni">
               <formerror  id="prescrizioni"><br>
               <span class="errori">@formerror.prescrizioni;noquote@</span>
               </formerror>
            </td>  
         </tr>
    </tr></table></td>
</tr>
<if @coimtgen.regione@ ne "MARCHE"><!--gac02-->
<tr>
    <td><table border=0><tr>
    <td valign=top align=right class=form_title>Data limite intervento</td>
    <td valign=top><formwidget id="data_utile_inter">
        <formerror  id="data_utile_inter"><br>
        <span class="errori">@formerror.data_utile_inter;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Delega responsabile</td>
    <td valign=top><formwidget id="delega_resp">
        <formerror  id="delega_resp"><br>
        <span class="errori">@formerror.delega_resp;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Delega manutentore</td>
    <td valign=top><formwidget id="delega_manut">
        <formerror  id="delega_manut"><br>
        <span class="errori">@formerror.delega_manut;noquote@</span>
        </formerror>
    </td>
    </tr></table></td>
</tr>

<tr><td align=right><table border=0 width="100%">
    <tr>
        <td valign=top align=right class=form_title>Data utile interv.</td>
        <td valign=top class=form_title>Anomalia</td>
    </tr> 

    <formwidget id="prog_anom_max">

    <multiple name=multiple_form>
    <tr>
        <formwidget id="prog_anom.@multiple_form.conta;noquote@">
        <td valign=top align=right><formwidget id="data_ut_int.@multiple_form.conta;noquote@">
            <formerror  id="data_ut_int.@multiple_form.conta;noquote@"><br>
            <span class="errori"><%= $formerror(data_ut_int.@multiple_form.conta;noquote@) %></span>
            </formerror>
        </td>
        <td valign=top><formwidget id="cod_anom.@multiple_form.conta;noquote@">
            <formerror  id="cod_anom.@multiple_form.conta;noquote@"><br>
            <span class="errori"><%= $formerror(cod_anom.@multiple_form.conta;noquote@) %></span>
            </formerror>
        </td>
    </tr>
    </multiple>
</table></td></tr>
</if>
<tr><td><table border=0 width="100%"><tr>
<tr>
    <td width="40%" valign=top align=right class=form_title><b>L'impianto pu&ograve; funzionare
    <td width="10%" valign=top>  
        <if @vis_desc_contr@ eq f>
                <formwidget id="flag_status">
                <formerror  id="flag_status"><br>
                <span class="errori">@formerror.flag_status;noquote@</span>
                </formerror>
        </if>
        <else>
                <formwidget id="flag_stat">
                <formerror  id="flag_stat"><br>
                <span class="errori">@formerror.flag_stat;noquote@</span>
                </formerror>
        </else>
    </td>
    <td width="30%" valign=top align=right class=form_title>Data scadenza RCEE con segno identificativo</td>
    <td width="20%" valign=top><formwidget id="data_scadenza_autocert">
        <formerror  id="data_scadenza_autocert"><br>
        <span class="errori">@formerror.data_scadenza_autocert;noquote@</span>
        </formerror>
    </td>
</tr>
</table></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td><table border=0>
<if @coimtgen.regione@ ne "MARCHE"><!--gac01-->
<if @flag_portafoglio@ eq T>
<tr>
    <td valign=top align=right class=form_title width=13%>Tariffa</td>
    <td valign=top width=10%><formwidget id="tariffa_reg">
        <formerror  id="tariffa_reg"><br>
        <span class="errori">@formerror.tariffa_reg;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title width=9%>Importo</td>
    <td valign=top width=10% nowrap><formwidget id="importo_tariffa">&#8364;
        <formerror  id="importo_tariffa"><br>
        <span class="errori">@formerror.importo_tariffa;noquote@</span>
        </formerror>
    </td>
    <if @funzione@ eq V>
     @message;noquote@
    </if>
    <else>
     <td>&nbsp;</td>
    </else>
</tr>
</if>
</if>
</table></td></tr>
<tr><td><table border=0 width=100%>
<tr>
  <if @coimtgen.regione@ ne "MARCHE">
    <td valign=top align=right class=form_title>Tipologia Costo</td>
    <td valign=top><formwidget id="tipologia_costo">
        <formerror  id="tipologia_costo"><br>
        <span class="errori">@formerror.tipologia_costo;noquote@</span>
        </formerror>
    </td>
  </if>
  <else>
    <formwidget   id="tipologia_costo">
  </else>
  <if @coimtgen.regione@ ne "MARCHE"><!--gac01-->
    <td valign=top align=right class=form_title width=21%>Costo</td>
  </if>
  <else><!--gac01-->
    <td valign=top align=right class=form_title width=21%>Costo del segno identificativo</td>
  </else>
  <td valign=top><formwidget id="costo">&#8364;
        <formerror  id="costo"><br>
        <span class="errori">@formerror.costo;noquote@</span>
        </formerror>
    </td>
</tr>
<if @coimtgen.regione@ ne "MARCHE"><!--gac02-->
  <tr>
    <td valign=top align=right class=form_title>Rif./Numero bollino</td>
    <td valign=top><formwidget id="riferimento_pag">
        <formerror  id="riferimento_pag"><br>
        <span class="errori">@formerror.riferimento_pag;noquote@</span>
        </formerror>
    </td>
  </tr>
</if>
<tr>
  <if @coimtgen.regione@ ne "MARCHE">
    <td valign=top align=right class=form_title>Pagato</td>
    <td valign=top><formwidget id="flag_pagato">
	<formerror  id="flag_pagato"><br>
	  <span class="errori">@formerror.flag_pagato;noquote@</span>
	</formerror>
    </td>
  </if>
  <else>
    <td valign=top align=right class=form_title>Segno identificativo pagato <font color=red>*</font></td><!--gac01M-->
    <td valign=top colspan=3><formwidget id="flag_pagato">
	<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=flag-pag', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><b>Vedi nota</b></a> <!--gac01M aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="flag_pagato"><br>
          <span class="errori">@formerror.flag_pagato;noquote@</span>
        </formerror>
    </td>
  </else>
</tr>
<!--gac01 sandro mi ha detto di toglierlo su tutti gli enti    <tr>
        <td valign=top align=right class=form_title>Data scad. pagamento</td>
        <td valign=top><formwidget id="data_scad_pagamento">
            <formerror  id="data_scad_pagamento"><br>
            <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
            </formerror>
        </td>
</tr>-->

    <if @coimtgen.regione@ eq "MARCHE">
      <tr>
	<td valign=top align=right class=form_title nowrap>Data del controllo <font color=red>*</font></td><!--gac01-->
	<td  valign=top><formwidget id="data_controllo">
            <formerror  id="data_controllo"><br>
              <span class="errori">@formerror.data_controllo;noquote@</span>
            </formerror>
	</td>

	<td valign=top align=right class=form_title>Orario di arrivo presso l'impianto</td><!--gac01-->
	<td  valign=top><formwidget id="ora_inizio">
            <formerror  id="ora_inizio"><br>
              <span class="errori">@formerror.ora_inizio;noquote@</span>
            </formerror>
	</td>

	<td valign=top align=right class=form_title>Orario di partenza dall'impianto</td><!--gac01-->
	<td  valign=top><formwidget id="ora_fine">
            <formerror  id="ora_fine"><br>
              <span class="errori">@formerror.ora_fine;noquote@</span>
            </formerror>
	</td>
      </tr>
    </if>
<tr>
  <if @coimtgen.regione@ eq "MARCHE"><!--gac01-->
    <td valign=top align=right class=form_title nowrap>Data ultima manutenzione ordinaria effettuata @ast_CANCONA;noquote@</td>
  <td><formwidget id="data_ultima_manu"><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=data_ultima_manu', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><b>Vedi nota</b></a>
      <formerror  id="data_ultima_manu"><br>
	<span class="errori">@formerror.data_ultima_manu;noquote@</span>
      </formerror>
  </td>
</if>
  <!-- gab01 aggiunta data_prox_manut-->
  <td valign=top align=right class=form_title>Si raccomanda un intervento manutentivo entro il @ast_CANCONA;noquote@</td>
  <td valign=top><formwidget id="data_prox_manut">
      <formerror  id="data_prox_manut"><br>
        <span class="errori">@formerror.data_prox_manut;noquote@</span>
      </formerror>
  </td>
  </tr></table></td>
</tr>

<tr><td valign=top colspan=2 align=center><formwidget id="msg_rcee">
      <formerror  id="msg_rcee"><br>
	<span class="errori">@formerror.msg_rcee;noquote@</span>
</formerror></td></tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=1 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

