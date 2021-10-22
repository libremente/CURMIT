<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom06 25/02/2019 Messi asterischi sui campi obbligatori su richiesta della Regione Marche

    rom05 11/02/2019 Modificate le potenze per la Regione Marche.

    rom04 31/07/2018 Su richiesta della Regione Marche modificata dicitura iniziale.

    gac01 29/06/2018 Modificate label

    rom03 28/06/2018 Cambiata l'impaginazione per la Regione Marche.

    rom02 11/05/2018 Aggiunto il campo targa, lo faccio vedere solo per le Marche.

    rom01 18/04/2018 Aggiunta la sezione 'Scheda 4.1: Dati Relativi all'utenza' per 
    rom01 	     i campi POD e PDR su richiesta di Sandro.

    sim04 01/08/2017 Aggiunto la potenza utile del freddo che in un primo momento non era stata
    sim04            prevista.
    sim04            Dato che si era deciso di riusare il campo pot_utile_nom per la potenza di
    sim04            assorbimento ho dovuto usare il nuovo campo pot_utile_nom_freddo

    nic01 16/05/2014 Comune di Rimini: se è attivo il parametro flag_gest_coimmode, deve
    nic01            comparire un menù a tendina con l'elenco dei modelli relativi al
    nic01            costruttore selezionato (tale menù a tendina deve essere rigenerato
    nic01            quando si cambia la scelta del costruttore).
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<property name="focus_field">@focus_field;noquote@</property><!-- nic01 -->

<center>

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_provincia">
<if @coimtgen.flag_ente@ eq "C">
   <formwidget   id="cod_comune">
</if>
<formwidget   id="cod_impianto">
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_citt_terzi">
<formwidget   id="cod_citt_inte">
<formwidget   id="cod_citt_prop">
<formwidget   id="cod_citt_occ">
<formwidget   id="cod_citt_amm">
<formwidget   id="cod_manu_manu">
<formwidget   id="cod_manu_inst">
<formwidget   id="cod_impianto_est_new">
<formwidget   id="f_resp_cogn"> 
<formwidget   id="f_resp_nome"> 
<formwidget   id="f_comune">
<formwidget   id="f_cod_via">
<formwidget   id="f_desc_via">
<formwidget   id="f_desc_topo">
<formwidget   id="flag_ins_occu">
<formwidget   id="flag_ins_prop">
<formwidget   id="flag_ins_terzi">
<formwidget   id="cod_manut">
<formwidget   id="soloatt">
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->

<!-- Inizio della form colorata -->

   <table border="0" width="100%">
      <tr>
         <td width="85%">&nbsp;</td>
         <td align="center">
            <a href="#" onclick="javascript:window.open('coimaimp-isrt2-help', 'help', 'scrollbars=yes, resizable=yes, width=580, height=320').moveTo(110,140)"><b>Help</b></a> 
         </td>
      </tr>
   </table>
    <table border="0" width="96%" align="center">
      <tr>
         <if @coimtgen.regione@ ne "MARCHE">
         <td class="func-menu-yellow2"><b>Vengono richiesti l'inserimento di questi dati per controllo su eventuali impianti già esistenti<br>o per permettere la validazione all'ente dell'impianto stesso</b></td>
	 </if>
         <else>
<td class="func-menu-yellow2"><b>In questa scheda vengono richiesti i dati necessari per controllare<br>se l’impianto &egrave; gi&agrave; nel catasto e, nel caso non ci sia, per inserirlo in CURMIT</b></td>
         </else><!--rom04 cambiata label -->
      </tr>
   </table>
   <table border="0" width="96%" align="center">
      <tr>
         <td colspan="6" class="func-menu-yellow2"><b>Dati Generali dell'Impianto di condizionamento</b></td>
      </tr>
   </table>

   <table width="100%" border="0" allign="center" cellpadding="0" cellspacing="2">
      <tr>
         <td valign="top" align="right" nowrap class="form_title">Cod. impianto</td>
         <td valign="top">
            <formwidget id="cod_impianto_est">
            <formerror  id="cod_impianto_est">
               <br>
               <span class="errori">@formerror.cod_impianto_est;noquote@</span>
            </formerror>
         </td>
    <if @coimtgen.regione@ ne "MARCHE"><!-- rom03  aggiunta if, aggiunta else e contenuto-->
         <td valign="top" align="right" nowrap class="form_title">Stato</td>
         <td valign="top" width="15%">
	    <formwidget id="stato">
            <formerror  id="stato">
               <br>
               <span class="errori">@formerror.stato;noquote@</span>
            </formerror>
         </td> 
         <td width="30%" valign="top" align="right" class="form_title">
	    <b>Sottoponibile D.P.R. 74</b>
	 </td>
         <td valign="top" align="left" width="20%">
	    <formwidget id="flag_dpr412">
            <formerror  id="flag_dpr412">
	       <br>
               <span class="errori">@formerror.flag_dpr412;noquote@</span>
            </formerror>
         </td>
    </if>
    <else>
        <td colspan=4>&nbsp;</td>
   </else><!--rom03-->
      </tr>
      <tr>
      <if @coimtgen.regione@ eq "MARCHE"> <!-- rom02 aggiunta if e suo contenuto-->
         <td valign="top" align="right" nowrap class="form_title">Codice catasto(targa)</td>
         <td valign="top"><formwidget id="targa">
         <formerror  id="targa"><br>
         <span class="errori">@formerror.targa;noquote@</span>
         </formerror>
     </td>
     </if>
  <if @coimtgen.regione@ ne "MARCHE"> <!-- rom03aggiunta if, aggiunta else e contenuto-->
         <td valign="top" align="right" nowrap class="form_title">Data install.</td>
         <td valign="top" nowrap width="8%">
	    <formwidget id="data_installaz">
            <formerror id="data_installaz">
	       <br>
               <span class="errori">@formerror.data_installaz;noquote@</span>
            </formerror>
         </td>
         <td valign="top" align="right" class="form_title">Data Costr.</td>
         <td valign="top" width="8%" colspan="3">
	    <formwidget id="anno_costruzione">
            <formerror id="anno_costruzione">
	       <br>
               <span class="errori">@formerror.anno_costruzione;noquote@</span>
            </formerror>
         </td>
  </if>
  <else>
        <td colspan=4>&nbsp;</td>
  </else><!--rom03-->
      </tr>
      <tr>
	<if @coimtgen.regione@ ne "MARCHE"><!--rom100 oscuro il campo per le marche-->
          <td valign="top" align="right" class="form_title">Tipologia</td>
          <td valign="top">
	    <formwidget id="cod_tpim">
              <formerror  id="cod_tpim">
		<br>
		<span class="errori">@formerror.cod_tpim;noquote@</span>
              </formerror>
          </td>
	</if>
        <td valign="top" align="right"  nowrap class="form_title">Alimentazione<font color=red>*</font></td><!--rom06 aggiunto *-->
         <td valign="top" colspan="3">
            <formwidget id="cod_combustibile">
            <formerror  id="cod_combustibile">
	       <br>
               <span class="errori">@formerror.cod_combustibile;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Localit&agrave;</td>
         <td colspan="5">
         
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
	       <tr>
		  <td valign="top" width="185">
		     <formwidget id="localita">
		     <formerror  id="localita">
		        <br>
			<span class="errori">@formerror.localita;noquote@</span>
                     </formerror>
                  </td>
		  <if @coimtgen.flag_ente@ eq "P">
		  <td valign="top" align="right" class="form_title" width="14%">Comune&nbsp;</td>
		  <td valign="top" width="214">
		     <formwidget id="cod_comune">
		     <formerror id="cod_comune">
		        <span class="errori">@formerror.cod_comune;noquote@</span>
		     </formerror>
                  </td>
                  </if>

		  <if @coimtgen.flag_ente@ eq "C">
		  <td valign="top" align="right" class="form_title" width="14%">Comune&nbsp</td>
		  <td valign="top" width="214">
		     <formwidget id="descr_comu">
		     <formerror id="descr_comu">
		        <span class="errori">@formerror.descr_comu;noquote@</span>
		     </formerror>
                  </td>
                  </if>

		  <td valign="top">(<formwidget id="provincia">)</td>
		  <td valign="top" align="right" class="form_title" width="35">CAP&nbsp;</td>
		  <td valign="top">
		     <formwidget id="cap">
		     <formerror  id="cap">
			<br>
			<span class="errori">@formerror.cap;noquote@</span>
		     </formerror>
		     <a target="cap" href="http://www.poste.it/online/cercacap/">Ricerca CAP</a>
                  </td>
               </tr>
	    </table>
	 </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Indirizzo<font color=red>*</font></td><!--rom06 aggiunto *-->     
         <td valign="top" colspan="5">
        
	   <table border="0" cellpadding="0" cellaspacing="0">
              <tr>
	         <td valign="top" width="380">
	            <formwidget id="descr_topo">
                    <formerror  id="descr_topo">
	               <br>
                       <span class="errori">@formerror.descr_topo;noquote@</span>
                    </formerror>
                    <formwidget id="descr_via">@cerca_viae;noquote@
                    <formerror  id="descr_via">
	               <br>
                       <span class="errori">@formerror.descr_via;noquote@</span>
                    </formerror>
                 </td>
                 <td valign="top" align="right" class="form_title" width="18">N&deg;</td>
                 <td valign="top" width="125">
		    <formwidget id="numero">/<formwidget id="esponente">
                    <formerror  id="numero">
		       <br>
		       <span class="errori">@formerror.numero;noquote@</span>
                    </formerror>
                 </td>
		 <td valign="top" align="right" class="form_title" width="25">Scala</td>
		 <td valign="top" width="60"><formwidget id="scala"></td>
		 <td valign="top" align="right" class="form_title" width="25">Piano</td>
		 <td valign="top" width="45"><formwidget id="piano"></td>
		 <td valign="top" align="right" class="form_title" width="25">Int.</td>    
		 <td valign="top" width="40"><formwidget id="interno"></td>
	      </tr>
           </table>
         
	 </td>
      </tr>

      <tr>
       <if @coimtgen.regione@ ne "MARCHE"> <!-- rom03  aggiunta if-->
	 <td valign="top" align="right" class="form_title" nowrap>Destinazione d'uso</td>
	 <td valign="top">
	    <formwidget id="cod_tpdu"> 
            <formerror id="cod_tpdu">
	        <br>
		<span class="errori">@formerror.cod_tpdu;noquote@</span>
            </formerror>
         </td>	 
	 <td valign="top" align="right" class="form_title" nowrap>Volumetria riscaldata m<sup><small>3</small></sup></td>
	 <td valign="top">
	    <formwidget id="volimetria_risc"> 
	    <formerror id="volimetria_risc">
	      <br>
	      <span class="errori">@formerror.volimetria_risc;noquote@</span>
            </formerror>
         </td>
         </if><!--rom03-->
	 <td valign="top" align="right" nowrap class="form_title">N&deg; generatori</td>
	 <td valign="top">
	    <formwidget id="n_generatori">
	    <formerror  id="n_generatori">
	       <br>
	       <span class="errori">@formerror.n_generatori;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title" nowrap>Categoria di edificio<font color=red>*</font></td><!--rom06 agg. *-->
	 <td valign="top" colspan="5">
	    <formwidget id="cod_cted"> 
            <formerror id="cod_cted">
	        <br>
		<span class="errori">@formerror.cod_cted;noquote@</span>
            </formerror>
	 </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Note</td>
         <td valign="top" colspan="5">
	    <formwidget id="note">
            <formerror  id="note">
	       <br>
               <span class="errori">@formerror.note;noquote@</span>
            </formerror>
         </td>
      </tr>
   </table>

   <table border="0" width="96%" align="center">
      <tr>
         <td colspan="4" class="func-menu-yellow2"><b>Dati Relativi ai Soggetti operanti sull'impianto</b> (deducibili dall'RCEE cartaceo)</td><!--gac01-->
      </tr>
   </table>

   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="2">
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Responsabile<font color=red>*</font></b></td><!--rom06 agg. *-->
	 <td valign="top" colspan="6">
	    <formwidget id="flag_responsabile"> 
	    <formerror id="flag_responsabile">
	       <br>
	       	<span class="errori">@formerror.flag_responsabile;noquote@</span>
            </formerror>
         </td>
      </tr>
 
      <tr>
	 <td>&nbsp;</td>
	 <td valign="bottom" width="14%"><b>Cognome</b></td>
	 <td valign="bottom" colspan=2><b>Nome</b></td>
	 <td>&nbsp;</td>
	 <td valign="bottom" width="135"><b>Cognome</b></td>
	 <td valign="bottom"><b>Nome</b></td>
      </tr>

      <tr>
	<td valign="top" align="right" class="form_title"><b>Proprietario</b>@ast_prop;noquote@</td><!--rom06 aggiunta ast_prop-->
	 <td valign="top" nowrap colspan="3" width="40%">
	    <formwidget id="cognome_prop"><formwidget id="nome_prop">@cerca_prop;noquote@|@link_ins_prop;noquote@
	    <formerror id="cognome_prop">
	       <br>
	       <span class="errori">@formerror.cognome_prop;noquote@</span>
            </formerror>
         </td>
         <td valign="top" align="right" class="form_title"><b>Intestatario di fornitura energetica</b></td> <!--gac01 -->
	 <td valign="top" nowrap colspan="2">
	    <formwidget id="cognome_inte"><formwidget id="nome_inte">@cerca_inte;noquote@
	    <formerror id="cognome_inte">
	       <br>
	       <span class="errori">@formerror.cognome_inte;noquote@</span>
            </formerror>
         </td>
      </tr>
 
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Occupante</b></td>
         <td valign="top" nowrap colspan="3" width="40%">
	     <formwidget id="cognome_occ"><formwidget id="nome_occ">@cerca_occ;noquote@|@link_ins_occu;noquote@
	     <formerror  id="cognome_occ">
	        <br>
                <span class="errori">@formerror.cognome_occ;noquote@</span>
             </formerror>
         </td>
	 <td valign="top" align="right" class="form_title"><b>Amministratore</b></td>
	 <td valign="top" nowrap colspan="2">
	    <formwidget id="cognome_amm"><formwidget id="nome_amm">@cerca_amm;noquote@
	    <formerror  id="cognome_amm">
	       <br>
	       <span class="errori">@formerror.cognome_amm;noquote@</span>
            </formerror>
         </td>
      </tr>
            
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Terzo responsabile</b></td>
	 <td valign="top" nowrap colspan="3" width="40%">
	    <formwidget id="cognome_terzi"><formwidget id="nome_terzi">@cerca_terzi;noquote@
	    <formerror  id="cognome_terzi">
	       <br>
	       <span class="errori">@formerror.cognome_terzi;noquote@</span>
            </formerror>
         </td>
	 <td valign="top" align="right" class="form_title"><b>Progettista</b></td>
	 <td valign="top" nowrap colspan="2">
	     <formwidget id="cognome_prog"><formwidget id="nome_prog">@cerca_prog;noquote@
	     <formerror  id="cognome_prog">
	        <br>
		<span class="errori">@formerror.cognome_prog;noquote@</span>
	     </formerror>
         </td>
      </tr>

      <tr>
	 <td valign="top" align="right" class="form_title"><b>Manutentore</b></td>
	 <td valign="top" nowrap colspan="3" width="40%">
	    <formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@
	    <formerror  id="cognome_manu">
	       <br>
	       <span class="errori">@formerror.cognome_manu;noquote@</span>
            </formerror>
	 </td>
	 <td valign="top" align="right" class="form_title"><b>Installatore</b></td>
	 <td valign="top" nowrap colspan="2">
	     <formwidget id="cognome_inst"><valign="top"><formwidget id="nome_inst">@cerca_inst;noquote@
	     <formerror  id="cognome_inst">
		<br>
		<span class="errori">@formerror.cognome_inst;noquote@</span>
             </formerror>
	 </td>
      </tr>
   </table>

   <table border="0" width="96%" align="center">
      <tr>
         <td width="100%" class="func-menu-yellow2"><b>Dati Relativi al Gruppo Frigo/Pompa di calore</b> (con potenza nominale più elevata), Attenzione ad eventuali warning che appariranno </td> <!--gac01-->
      </tr>
   </table>

   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="2">
  <if @coimtgen.regione@ eq "MARCHE"> <!-- rom03aggiunta if-->
    <tr>
      <td valign="top" align="right" nowrap class="form_title">Data installazione<font color=red>*</font></td><!--rom06 aggiunto *-->
         <td valign="top" nowrap width="8%">
	    <formwidget id="data_installaz">
            <formerror id="data_installaz">
	       <br>
               <span class="errori">@formerror.data_installaz;noquote@</span>
            </formerror>
         </td>
         <td valign="top" align="right" class="form_title">Data Costruzione</td>
         <td valign="top" width="8%" >
	    <formwidget id="anno_costruzione">
            <formerror id="anno_costruzione">
	       <br>
               <span class="errori">@formerror.anno_costruzione;noquote@</span>
            </formerror>
         </td>
      </tr>
  </if><!--rom03-->
      <tr>
	<td valign="top" align="right" nowrap class="form_title">Costruttore<font color=red>*</font></td><!--rom06 aggiunto *-->
	 <td valign="top">
	    <formwidget id="cod_cost">
	    <formerror  id="cod_cost">
	       <br>
	       <span class="errori">@formerror.cod_cost;noquote@</span>
            </formerror>
         </td>

	 <td valign="top" align="right" nowrap class="form_title">Modello<font color=red>*</font></td><!--rom06 aggiunto *-->
         <if @coimtgen.flag_gest_coimmode@ eq "F"><!-- nic01 -->
             <td valign="top">
	         <formwidget id="modello">
	         <formerror  id="modello">
	            <br>
	            <span class="errori">@formerror.modello;noquote@</span>
                 </formerror>
	     </td>
             <formwidget id="cod_mode"><!-- nic01 -->
         </if>
         <else><!-- nic01 -->
             <td valign=top>
                 <formwidget id="cod_mode"><!-- nic01 -->
                 <formerror  id="cod_mode">
                    <br><!-- nic01 -->
                    <span class="errori">@formerror.cod_mode;noquote@</span><!-- nic01 -->
                 </formerror><!-- nic01 -->
             </td><!-- nic01 -->
             <formwidget id="modello"><!-- nic01 -->
         </else>

         <td valign="top" align="right" nowrap class="form_title">Matricola<font color=red>*</font></td><!--rom06 aggiunto *-->
	 <td valign="top">
	    <formwidget id="matricola">
	    <formerror  id="matricola">
	       <br>
	       <span class="errori">@formerror.matricola;noquote@</span>
            </formerror>
         </td>

      </tr>
<!--
      <tr>

         <td valign="top" align="right" nowrap class="form_title">Tiraggio</td>
	 <td valign="top">
	    <formwidget id="tiraggio">
	    <formerror  id="tiraggio">
	       <br>
	       <span class="errori">@formerror.tiraggio;noquote@</span>
            </formerror>
         </td>
	 <td valign="top" align="right" nowrap class="form_title">Tipo</td>
	 <td valign="top">
	    <formwidget id="tipo_foco">
	    <formerror  id="tipo_foco">
	       <br>
	       <span class="errori">@formerror.tipo_foco;noquote@</span>
            </formerror>
         </td>
	 <td valign="top" align="right" nowrap class="form_title">Scarico fumi</td>
	 <td valign="top">
	    <formwidget id="cod_emissione">
	    <formerror  id="cod_emissione">
	       <br>
	       <span class="errori">@formerror.cod_emissione;noquote@</span>
            </formerror>
         </td>
      </tr>
-->
      <tr>
	<if @coimtgen.regione@ ne "MARCHE"> <!-- rom03 aggiunta if-->
          <td valign="top" align="right" class="form_title">Dest. d'uso generatore</td>
	  <td colspan=5 valign="top">
	    <formwidget id="cod_utgi">
	      <formerror  id="cod_utgi">
		<br>
		<span class="errori">@formerror.cod_utgi;noquote@</span>
              </formerror>
          </td>
	</if><!--rom03-->
	<!-- sim04 spostato sulla riga sopra per motivi di spazio -->
	<!-- gac01	 <td valign="top" align="right" nowrap class="form_title">Fascia</td>
	     <td valign="top" colspan="3"><formwidget id="cod_potenza">
		 <formerror  id="cod_potenza">
		   <br>
		   <span class="errori">@formerror.cod_potenza;noquote@</span>
		 </formerror>
             </td> -->
	
	
      </tr>
      <if @coimtgen.regione@ ne "MARCHE"><!--rom05 aggiunta if ma non il suo contenuto-->
	<tr>
          <td valign="top" align="right" nowrap class="form_title">Potenza frigorifera nominale(kW)</td>
	  <td valign="top">
	    <formwidget id="potenza">
	      <formerror  id="potenza">
		<br>
		<span class="errori">@formerror.potenza;noquote@</span>
              </formerror>
          </td>
	  <td valign="top" align="right" nowrap class="form_title">Potenza frigorifera assorbita nominale(kW)</td>
	  <td valign="top">
	    <formwidget id="potenza_utile">
	      <formerror  id="potenza_utile">
		<br>
		<span class="errori">@formerror.potenza_utile;noquote@</span>
	      </formerror>
          </td>
	  
	  <td valign="top" align="right" nowrap class="form_title">Potenza frigorifera utile(kW)</td><!--sim04-->
	  <td valign="top"><!--sim04-->
	    <formwidget id="potenza_utile_freddo"><!--sim04-->
	      <formerror  id="potenza_utile_freddo"><!--sim04-->
		<br><!--sim04-->
		<span class="errori">@formerror.potenza_utile_freddo;noquote@</span><!--sim04-->
	      </formerror><!--sim04-->
          </td><!--sim04-->
	  
	</tr>
      </if><!--rom05-->
      <if @coimtgen.regione@ eq "MARCHE"><!--rom05 aggiunta if e suo contenuto-->
	<tr>
          <td valign="top" align="right" nowrap class="form_title">Potenza frigorifera nominale(kW)<font color=red>*</font></td>
	  <td valign="top">
	    <formwidget id="potenza">
	      <formerror  id="potenza">
		<br>
		<span class="errori">@formerror.potenza;noquote@</span>
	      </formerror>
	  </td>
	<td valign="top" align="right" nowrap class="form_title">Potenza assorbita nominale(kW)<font color=red>*</font></td>
	<td valign="top">
	  <formwidget id="potenza_utile">
	    <formerror  id="potenza_utile">
	      <br>
	      <span class="errori">@formerror.potenza_utile;noquote@</span>
	    </formerror>
	</td>
	</tr>
	<tr>
	  <td valign="top" align="right" nowrap class="form_title">Potenza termica nominale(KW)<font color=red>*</font></td>
	  <td valign="top">
	    <formwidget id="potenza_termica_nominale">
	      <formerror  id="potenza_termica_nominale"><br>
		<span class="errori">@formerror.potenza_termica_nominale@</span>
	      </formerror>
	  </td>
	  <td valign="top" align="right" nowrap class="form_title">Potenza assorbita nominale(KW)<font color=red>*</font></td>
	  <td valign="top">
	    <formwidget id="potenza_termica_assorbita_nominale">
	      <formerror  id="potenza_termica_assorbita_nominale"><br>
		<span class="errori">@formerror.potenza_termica_assorbita_nominale@</span>
	      </formerror>
	  </td>
	  </tr>
      </if>
  <tr>
    <td valign="top" align="right" class="form_title">Sistema di azionamento</td>
    <td valign="top" colspan="1">
      <formwidget id="cod_tpco">
	    <formerror  id="cod_tpco">
	       <br>
	       <span class="errori">@formerror.cod_tpco;noquote@</span>
            </formerror>
         </td>

         <td valign="top" align="right" class="form_title">Fluido frigorigeno</td>
	 <td valign="top" colspan="3">
	    <formwidget id="cod_flre">
	    <formerror  id="cod_flre">
	       <br>
	       <span class="errori">@formerror.cod_flre;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Carica refrigerante(Kg)</td>
	 <td valign="top" colspan="1">
	    <formwidget id="carica_refrigerante">
	    <formerror  id="carica_refrigerante">
	       <br>
	       <span class="errori">@formerror.carica_refrigerante;noquote@</span>
            </formerror>
         </td>

         <td valign="top" colspan="1" align="right" class="form_title">Carica ermeticamente sigillata</td>
	 <td valign="top" colspan="3">
	    <formwidget id="sigillatura_carica">
	    <formerror  id="sigillatura_carica">
	       <br>
	       <span class="errori">@formerror.sigillatura_carica;noquote@</span>
            </formerror>
         </td>
      </tr>

     <tr>
     <td colspan=6>
           <table border="0" width="96%" align="center">
         <tr>
         <td colspan=6 width="100%" class="func-menu-yellow2"><b>Dati Relativi all'utenza</b></td>
         </tr>
         </table>
     </td> 
     </tr>  

   <tr>
      <td valign=top align=right colspan="1" class=form_title>POD</td>
      <td valign=top align=left nowrap><formwidget id="pod">
        <formerror id="pod"><br>
        <span class="errori">@formerror.pod;noquote@</span>
        </formerror>
      </td>
      <td valign=top align=right class=form_title>PDR</td>
        <td valign=top colspan="1" nowrap><formwidget id="pdr">
        <formerror id="pdr"><br>
        <span class="errori">@formerror.pdr;noquote@</span>
        </formerror>
      </td>
      <td colspan=2></td>
    </tr>
</table>


 <table border="0" width="100%" align="center">
<tr>
<td colspan=2>&nbsp;</td>
</tr>
       <tr>
          <td align="center">
	     <formwidget id="submit">
	  </td>
       </tr>
    </table>

</formtemplate>
<p>


