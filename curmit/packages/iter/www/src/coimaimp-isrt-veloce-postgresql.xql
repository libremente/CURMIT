<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_aimp">
       <querytext>
                insert
                  into coimaimp 
                     ( cod_impianto
                     , cod_impianto_est
                     , cod_potenza
                     , potenza
                     , potenza_utile
                     , note
                     , stato
                     , flag_dichiarato
                     , n_generatori
                     , cod_responsabile
                     , flag_resp
                     , cod_intestatario
                     , cod_proprietario   
                     , cod_occupante      
                     , cod_amministratore 
                     , cod_manutentore    
                     , cod_installatore   
                     , localita
                     , cod_via
                     , toponimo
                     , indirizzo
                     , numero
                     , esponente
                     , scala
                     , piano 
                     , interno
                     , cod_comune
                     , cod_provincia
                     , cap
                     , data_ins           
                     , utente
                     , flag_dpr412
                     , cod_cted
                     , provenienza_dati
                     , cod_combustibile
                     , cod_tpim
		     , data_installaz
		     , anno_costruzione
                     , cod_tpdu
                     , volimetria_risc
		     , flag_targa_stampata
                   , flag_tipo_impianto
                 )             
                values
                     (:cod_impianto
                     ,:cod_impianto_est
                     ,:cod_potenza
                     ,:potenza
                     ,:potenza_utile
                     ,:note
                     ,:stato
                     ,'S'
                     ,:n_generatori
                     ,:cod_citt_resp
                     ,:flag_responsabile
                     ,:cod_citt_inte
                     ,:cod_citt_prop   
                     ,:cod_citt_occ      
                     ,:cod_citt_amm 
                     ,:cod_manu_manu    
                     ,:cod_manu_inst   
                     ,:localita
                     ,:cod_via
                     ,:descr_topo
                     ,:descr_via
                     ,:numero
                     ,:esponente
                     ,:scala
                     ,:piano 
                     ,:interno
                     ,:cod_comune
                     ,:cod_provincia
                     ,:cap
                     , current_date        
                     ,:id_utente
                     ,:flag_dpr412
                     ,:cod_cted
                     ,:provenienza_dati
                     ,:cod_combustibile
                     ,:cod_tpim
		     ,:data_installaz
		     ,:anno_costruzione
                     ,:cod_tpdu
                     ,:volimetria_risc
		     ,'N'
                   ,'R'
                   )   
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_aimp">
       <querytext>
        select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="ins_gend">
       <querytext>
                insert
                  into coimgend 
                     ( cod_impianto
                     , gen_prog
		     , data_installaz
		     , data_costruz_gen
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_attivo
                     , data_ins
                     , utente
		     , gen_prog_est
                     , matricola
                     , modello
                     , cod_cost
                     , cod_combustibile
                     , tipo_foco
                     , tiraggio
                     , cod_emissione
		     , cod_utgi
                     , cod_mode -- 2014-05-16
		     )
                values
                     (:cod_impianto
                     ,:gen_prog
		     ,:data_installaz
		     ,:anno_costruzione
                     ,:potenza
                     ,:potenza_utile
                     ,'S'
                     , current_date        
                     ,:id_utente
		     ,'1'
                     ,:matricola
                     ,:modello
                     ,:cod_cost
                     ,:cod_combustibile
                     ,:tipo_foco
                     ,:tiraggio
                     ,:cod_emissione
		     ,:cod_utgi
                     ,:cod_mode -- 2014-05-16
		     )
       </querytext>
    </partialquery>


    <fullquery name="sel_viae">
       <querytext>
             select cod_via 
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:descr_via)
                and descr_topo  = upper(:descr_topo)
                and cod_via_new is null
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
             select cod_cittadino
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_nome">
       <querytext>
             select cognome  as cognome_manu
                  , nome     as nome_manu
               from coimmanu
              where cod_manutentore = :cod_manu_manu
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore
               from coimmanu
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_prog">
       <querytext>
             select cod_progettista
               from coimprog
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="check_aimp">
       <querytext>
          select '1'
            from coimaimp 
           where cod_impianto_est = upper(:cod_impianto_est)
       </querytext>
    </fullquery>

    <fullquery name="check_fascia_pote">
       <querytext>
          select '1'
            from coimpote 
           where :potenza_tot between potenza_min and potenza_max
           and flag_tipo_impianto = :flag_tipo_impianto
       </querytext>
    </fullquery>

    <fullquery name="check_fascia_pote2">
       <querytext>
          select '1'
            from coimpote 
           where :potenza_tot between potenza_min and potenza_max
             and cod_potenza = :cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="assegna_fascia">
       <querytext>
          select cod_potenza
            from coimpote
           where :potenza_tot between potenza_min and potenza_max
            and flag_tipo_impianto = :flag_tipo_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_pote">
       <querytext>
          select potenza_min as potenza
            from coimpote
           where cod_potenza = :cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="check_aimp_prov">
       <querytext>
       select cod_impianto as cod_aimp_proven
         from coimaimp 
        where cod_impianto_est = :cod_aimp_prov
       </querytext>
    </fullquery>

    <fullquery name="get_cod_imipanto_est_old">
       <querytext>
           select coalesce('ITER25'||lpad((max(to_number(substr(cod_impianto_est, 7, 14), '99999999999999999990') ) + 1), 14, '0'), 'ITER2500000000000001') as cod_impianto_est from coimaimp
       </querytext>
    </fullquery>

    <fullquery name="get_cod_impianto_est">
       <querytext>
          select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_comu">
       <querytext>
           select coalesce(progressivo,0) + 1 as progressivo 
	       --sim01 coalesce(lpad((progressivo + 1), 7, '0'), '0000001') as progressivo
                , cod_istat
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>

   <partialquery name="upd_prog_comu">
       <querytext>
                update coimcomu
                   set progressivo = :progressivo
                 where cod_comune  = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="ins_citt">
       <querytext>
              insert
                into coimcitt 
                   ( cod_cittadino
                   , natura_giuridica
                   , cognome
                   , nome
                   , indirizzo
                   , numero
                   , cap
                   , localita
                   , comune
                   , provincia
                   , data_ins
                   , utente)
                values 
                   (:cod_cittadino
                   ,null
                   ,upper(:cognome_occ)
                   ,upper(:nome_occ)
                   ,upper(:descr_via) || ' ' || coalesce(:numero,'')
                   ,null
                   ,:cap
                   ,upper(:localita)
                   ,upper(:desc_comune)
                   ,upper(:provincia)
                   ,current_date
                   ,:id_utente)
       </querytext>
    </partialquery>


    <fullquery name="sel_cod_citt">
        <querytext>
           select nextval('coimcitt_s') as cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_desc">
        <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_legale">
       <querytext>
             select a.cod_legale_rapp as cod_citt_terzi
                  , b.cognome as cognome_terzi
                  , b.nome as nome_terzi
               from coimmanu a
                  , coimcitt b
              where a.cod_manutentore = :cod_manut
                and a.cod_legale_rapp = b.cod_cittadino
       </querytext>
    </fullquery>


    <fullquery name="sel_comu_cap">
        <querytext>
           select cap
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>

</queryset>
