<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic03 24/05/2014 Devo esporre ed aggiornare le potenze del generatore e non dell'impianto
    nic03            (o meglio, quelle dell'impianto solo se c'e' solo un generatore)
    nic03            Il campo Potenza termica nominale in riscaldamento (utile) non è
    nic03            coimgend.pot_focolare_nom ma coimgend.pot_utile_lib (per ora, non è
    nic03            visualizzato nella gestione del generatore)

    nic02 23/05/2014 Ora il generatore viene scelto dall'utente in fase di inserimento

    nic01 15/05/2014 Gestito il nuovo campo coimgend.cod_mode
-->

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_dimp">
       <querytext>
                insert
                  into coimdimp 
                     ( cod_dimp
                     , cod_impianto
                     , data_controllo
                     , gen_prog
                     , cod_manutentore
                     , cod_responsabile
                     , cod_proprietario
                     , cod_occupante
                     , flag_status
                     , garanzia
                     , conformita
                     , lib_impianto
                     , lib_uso_man
                     , inst_in_out
                     , idoneita_locale
                     , ap_ventilaz
                     , ap_vent_ostruz
                     , pendenza
                     , sezioni
                     , curve
                     , lunghezza
                     , conservazione
                     , scar_ca_si
                     , scar_parete
                     , riflussi_locale
                     , assenza_perdite
                     , pulizia_ugelli
                     , antivento
                     , scambiatore
                     , accens_reg
                     , disp_comando
                     , ass_perdite
                     , valvola_sicur
                     , vaso_esp
                     , disp_sic_manom
                     , organi_integri
                     , circ_aria
                     , guarn_accop
                     , assenza_fughe
                     , coibentazione
                     , eff_evac_fum
                     , cont_rend
                     , pot_focolare_mis
                     , portata_comb_mis
                     , temp_fumi
                     , temp_ambi
                     , o2
                     , co2
                     , bacharach
                     , co
                     , rend_combust
                     , osservazioni
                     , raccomandazioni
                     , prescrizioni
                     , data_utile_inter
                     , n_prot
                     , data_prot
                     , delega_resp
                     , delega_manut
                     , utente
                     , data_ins
                     , num_bollo
                     , costo
                     , tipologia_costo
                     , riferimento_pag
                     , potenza
                     , flag_co_perc
                     , flag_tracciato
                     , scar_can_fu
                     , tiraggio
                     , ora_inizio
                     , ora_fine
                     , data_scadenza
                     , num_autocert
                     , volimetria_risc
                     , consumo_annuo
                     )
                values 
                     (:cod_dimp
                     ,:cod_impianto
                     ,:data_controllo
                     ,:gen_prog
                     ,:cod_manutentore
                     ,:cod_responsabile
                     ,:cod_proprietario
                     ,:cod_occupante
                     ,:flag_status
                     ,:garanzia
                     ,:conformita
                     ,:lib_impianto
                     ,:lib_uso_man
                     ,:inst_in_out
                     ,:idoneita_locale
                     ,:ap_ventilaz
                     ,:ap_vent_ostruz
                     ,:pendenza
                     ,:sezioni
                     ,:curve
                     ,:lunghezza
                     ,:conservazione
                     ,:scar_ca_si
                     ,:scar_parete
                     ,:riflussi_locale
                     ,:assenza_perdite
                     ,:pulizia_ugelli
                     ,:antivento
                     ,:scambiatore
                     ,:accens_reg
                     ,:disp_comando
                     ,:ass_perdite
                     ,:valvola_sicur
                     ,:vaso_esp
                     ,:disp_sic_manom
                     ,:organi_integri
                     ,:circ_aria
                     ,:guarn_accop
                     ,:assenza_fughe
                     ,:coibentazione
                     ,:eff_evac_fum
                     ,:cont_rend
                     ,:pot_focolare_mis
                     ,:portata_comb_mis
                     ,:temp_fumi
                     ,:temp_ambi
                     ,:o2
                     ,:co2
                     ,:bacharach
                     ,:co
                     ,:rend_combust
                     ,:osservazioni
                     ,:raccomandazioni
                     ,:prescrizioni
                     ,:data_utile_inter
                     ,:n_prot
                     ,:data_prot
                     ,:delega_resp
                     ,:delega_manut
                     ,:id_utente
                     ,sysdate
                     ,:num_bollo
                     ,:costo
                     ,:tipologia_costo
                     ,:riferimento_pag
		     ,:potenza
                     ,:flag_co_perc
                     ,'G'
                     ,:scar_can_fu
                     ,:tiraggio_fumi
                     ,:ora_inizio
                     ,:ora_fine
                     ,:data_scadenza_autocert
                     ,:num_autocert
                     ,:volimetria_risc
                     ,:consumo_annuo
                     )
       </querytext>
    </partialquery>

    <partialquery name="upd_dimp">
       <querytext>
                update coimdimp
                   set cod_impianto       = :cod_impianto
                     , data_controllo     = :data_controllo
                     , gen_prog           = :gen_prog
                     , cod_manutentore    = :cod_manutentore
                     , cod_responsabile   = :cod_responsabile
                     , cod_proprietario   = :cod_proprietario
                     , cod_occupante      = :cod_occupante
                     , flag_status        = :flag_status
                     , garanzia           = :garanzia
                     , conformita         = :conformita
                     , lib_impianto       = :lib_impianto
                     , lib_uso_man        = :lib_uso_man
                     , inst_in_out        = :inst_in_out
                     , idoneita_locale    = :idoneita_locale
                     , ap_ventilaz        = :ap_ventilaz
                     , ap_vent_ostruz     = :ap_vent_ostruz
                     , pendenza           = :pendenza
                     , sezioni            = :sezioni
                     , curve              = :curve
                     , lunghezza          = :lunghezza
                     , conservazione      = :conservazione
                     , scar_ca_si         = :scar_ca_si
                     , scar_parete        = :scar_parete
                     , riflussi_locale    = :riflussi_locale
                     , assenza_perdite    = :assenza_perdite
                     , pulizia_ugelli     = :pulizia_ugelli
                     , antivento          = :antivento
                     , scambiatore        = :scambiatore
                     , accens_reg         = :accens_reg
                     , disp_comando       = :disp_comando
                     , ass_perdite        = :ass_perdite
                     , valvola_sicur      = :valvola_sicur
                     , vaso_esp           = :vaso_esp
                     , disp_sic_manom     = :disp_sic_manom
                     , organi_integri     = :organi_integri
                     , circ_aria          = :circ_aria
                     , guarn_accop        = :guarn_accop
                     , assenza_fughe      = :assenza_fughe
                     , coibentazione      = :coibentazione
                     , eff_evac_fum       = :eff_evac_fum
                     , cont_rend          = :cont_rend
                     , pot_focolare_mis   = :pot_focolare_mis
                     , portata_comb_mis   = :portata_comb_mis
                     , temp_fumi          = :temp_fumi
                     , temp_ambi          = :temp_ambi
                     , o2                 = :o2
                     , co2                = :co2
                     , bacharach          = :bacharach
                     , co                 = :co
                     , rend_combust       = :rend_combust
                     , osservazioni       = :osservazioni
                     , raccomandazioni    = :raccomandazioni
                     , prescrizioni       = :prescrizioni
                     , data_utile_inter   = :data_utile_inter
                     , n_prot             = :n_prot
                     , data_prot          = :data_prot
                     , delega_resp        = :delega_resp
                     , delega_manut       = :delega_manut
                     , utente             = :id_utente
                     , data_mod           = sysdate
                     , num_bollo          = :num_bollo
                     , costo              = :costo
                     , tipologia_costo    = :tipologia_costo
                     , riferimento_pag    = :riferimento_pag
		     , potenza            = :potenza
                     , flag_co_perc       = :flag_co_perc
                     , scar_can_fu        = :scar_can_fu
                     , tiraggio           = :tiraggio_fumi
                     , ora_inizio         = :ora_inizio
                     , ora_fine           = :ora_fine
                     , data_scadenza      = :data_scadenza_autocert
                     , num_autocert       = :num_autocert
                     , volimetria_risc    = :volimetria_risc
                     , consumo_annuo      = :consumo_annuo
                 where cod_dimp           = :cod_dimp
       </querytext>
    </partialquery>

    <partialquery name="del_dimp">
       <querytext>
                delete
                  from coimdimp
                 where cod_dimp = :cod_dimp
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp">
       <querytext>
             select a.cod_dimp
                  , a.cod_impianto
                  , iter_edit.data(a.data_controllo) as data_controllo
                  , iter_edit.num(a.gen_prog, 0) as gen_prog
                  , a.cod_manutentore
                  , a.cod_responsabile
                  , a.cod_proprietario
                  , a.cod_occupante
                  , a.flag_status
                  , a.garanzia
                  , a.conformita
                  , a.lib_impianto
                  , a.lib_uso_man
                  , a.inst_in_out
                  , a.idoneita_locale
                  , a.ap_ventilaz
                  , a.ap_vent_ostruz
                  , a.pendenza
                  , a.sezioni
                  , a.curve
                  , a.lunghezza
                  , a.conservazione
                  , a.scar_ca_si
                  , a.scar_parete
                  , a.riflussi_locale
                  , a.assenza_perdite
                  , a.pulizia_ugelli
                  , a.antivento
                  , a.scambiatore
                  , a.accens_reg
                  , a.disp_comando
                  , a.ass_perdite
                  , a.valvola_sicur
                  , a.vaso_esp
                  , a.disp_sic_manom
                  , a.organi_integri
                  , a.circ_aria
                  , a.guarn_accop
                  , a.assenza_fughe
                  , a.coibentazione
                  , a.eff_evac_fum
                  , a.cont_rend
                  , iter_edit_num(a.volimetria_risc, 2) as volimetria_risc
                  , iter_edit_num(a.consumo_annuo, 2) as consumo_annuo
                  , iter_edit.num(a.pot_focolare_mis, 2) as pot_focolare_mis
                  , iter_edit.num(a.portata_comb_mis, 2) as portata_comb_mis
                  , iter_edit.num(a.temp_fumi, 2) as temp_fumi
                  , iter_edit.num(a.temp_ambi, 2) as temp_ambi
                  , iter_edit.num(a.o2, 2) as o2
                  , iter_edit.num(a.co2, 2) as co2
                  , iter_edit.num(a.bacharach, 2) as bacharach
                  , a.co
                  , iter_edit.num(a.rend_combust, 2) as rend_combust
                  , a.osservazioni
                  , a.raccomandazioni
                  , a.prescrizioni
                  , iter_edit.data(a.data_utile_inter) as data_utile_inter
                  , a.n_prot
                  , iter_edit.data(a.data_prot) as data_prot
                  , a.delega_resp
                  , a.delega_manut
                  , a.num_bollo
                  , b.cognome   as cognome_manu
                  , b.nome      as nome_manu
                  , c.cognome   as cognome_resp
                  , c.nome      as nome_resp
                  , d.cognome   as cognome_prop
                  , d.nome      as nome_prop
                  , e.cognome   as cognome_occu
                  , e.nome      as nome_occu
                  , g.cod_intestatario   as cod_int_contr	
                  , h.cognome            as cognome_contr
                  , h.nome               as nome_contr
                  , iter_edit.num(a.costo, 2) as costo
                  , tipologia_costo
                  , riferimento_pag
                  , iter_edit.data(f.data_scad) as data_scad
		  , case
                      when importo_pag is null
                       and data_pag    is null
                      then 'N'
                      else 'S'
                    end         as flag_pagato
		  , iter_edit.num(a.potenza, 2) as potenza
                  , a.data_ins
                  , a.flag_co_perc
                  , scar_can_fu
                  , iter_edit.num(a.tiraggio,2) as tiraggio_fumi
                  , iter_edit_time(a.ora_inizio) as ora_inizio
                  , iter_edit_time(a.ora_fine) as ora_fine
                  , iter_edit_date(a.data_scadenza) as data_scadenza_autocert
                  , a.num_autocert
               from coimdimp a
                  , coimmanu b  
                  , coimcitt c  
	          , coimcitt d  
                  , coimcitt e  
                  , coimmovi f  
                  , coimaimp g
                  , coimcitt h
              where cod_dimp              = :cod_dimp
		and b.cod_manutentore (+) = a.cod_manutentore
                and c.cod_cittadino   (+) = a.cod_responsabile
                and d.cod_cittadino   (+) = a.cod_proprietario
                and e.cod_cittadino   (+) = a.cod_occupante
                and f.riferimento     (+) = a.cod_dimp
	        and f.cod_impianto    (+) = a.cod_impianto
                and f.tipo_movi       (+) = 'MH'
                and g.cod_impianto        = a.cod_impianto
                and h.cod_cittadino   (+) = g.cod_intestatario
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_dimp">
       <querytext>
        select coimdimp_s.nextval as cod_dimp
          from dual
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

    <fullquery name="sel_citt">
       <querytext>
             select cod_cittadino
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_old">
       <querytext>
       select a.cod_manutentore    as cod_manutentore_old
            , a.cod_responsabile   as cod_responsabile_old
            , a.cod_occupante      as cod_occupante_old
            , a.cod_proprietario   as cod_proprietario_old
            , a.cod_intestatario   as cod_int_contr_old
            , a.cod_intestatario   as cod_intestatario_old
            , a.cod_amministratore as cod_amministratore_old
	    , a.flag_resp          as flag_resp_old
	    , a.cod_potenza        as cod_potenza_old
            , a.potenza            as potenza_old
            , a.flag_dichiarato
            , a.data_prima_dich
            , a.data_installaz
            , a.note               as note_aimp
            , b.cognome            as cognome_manu_old
            , b.nome               as nome_manu_old
            , c.cognome            as cognome_resp_old
            , c.nome               as nome_resp_old
            , d.cognome            as cognome_occu_old
            , d.nome               as nome_occu_old
            , e.cognome            as cognome_prop_old
            , e.nome               as nome_prop_old
            , f.cognome            as cognome_contr_old
            , f.nome               as nome_contr_old
         from coimaimp a
	    , coimmanu b 
	    , coimcitt c
	    , coimcitt d
	    , coimcitt e
	    , coimcitt f
        where a.cod_impianto = :cod_impianto
	  and b.cod_manutentore    (+) = a.cod_manutentore
	  and c.cod_cittadino      (+) = a.cod_responsabile
	  and d.cod_cittadino      (+) = a.cod_occupante
	  and e.cod_cittadino      (+) = a.cod_proprietario
	  and f.cod_cittadino      (+) = a.cod_intestatario
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check_data_controllo">
       <querytext>
       select '1' 
         from coimdimp
        where cod_impianto   = :cod_impianto
          and data_controllo = :data_controllo
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_flag_convenzionato">
       <querytext>
        select flag_convenzionato
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check_riferimento_pag">
       <querytext>
        select count(*) as count_riferimento_pag
          from coimdimp
         where riferimento_pag = :riferimento_pag
           and tipologia_costo = :tipologia_costo
        $where_codice
       </querytext>
    </fullquery>

    <fullquery name="sel_boll_manu">
       <querytext>
         select matricola_da
              , matricola_a 
              , cod_tpbo
           from coimboll 
          where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_movi">
       <querytext>
           select coimmovi_s.nextval as cod_movi
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_movi">
       <querytext>
                insert
                  into coimmovi 
                     ( cod_movi
                     , tipo_movi
                     , cod_impianto
                     , data_scad
                     , data_compet
                     , importo
                     , importo_pag
                     , riferimento
                     , data_pag
                     , tipo_pag
                     , data_ins
                     , utente)
                values 
                     (:cod_movi
                     ,'MH'
                     ,:cod_impianto
                     ,:data_scad_pagamento
                     ,:data_controllo
                     ,:costo
                     ,:importo_pag
                     ,:cod_dimp
                     ,:data_pag
                     ,:tipologia_costo
                     , sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_movi">
       <querytext>
                update coimmovi
                   set data_scad    = :data_scad_pagamento
                     , data_compet  = :data_controllo
                     , importo      = :costo
                     , importo_pag  = :importo_pag
                     , data_pag     = :data_pag
                     , tipo_pag     = :tipologia_costo
                     , data_mod     =  sysdate
                     , utente       = :id_utente
                 where cod_movi     = :cod_movi                 
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_sogg">
       <querytext>
          update coimaimp
             set cod_manutentore  = :cod_manutentore
               , cod_responsabile = :cod_responsabile_new
               , cod_occupante    = :cod_occupante
               , cod_proprietario = :cod_proprietario
	       , flag_resp        = :flag_resp
               , data_mod         =  sysdate
               , utente           = :id_utente
           where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_rife_check">
       <querytext>
	 select '1'
           from coimrife
          where cod_impianto   = :cod_impianto
            and ruolo          = :ruolo
            and to_char(data_fin_valid,'yyyymmdd') = to_char((sysdate - 1),'yyyymmdd')
       </querytext>
    </fullquery>

    <partialquery name="ins_rife">
       <querytext>
         insert
           into coimrife
              ( cod_impianto
              , ruolo
              , data_fin_valid 
              , cod_soggetto
              , data_ins
              , utente
     ) values (
               :cod_impianto
              ,:ruolo
              ,(sysdate - 1)
              ,:cod_soggetto_old
              , sysdate
              ,:id_utente
              )
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_stato">
       <querytext>
          update coimaimp
             set stato_conformita = :stato_conformita
           where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_movi_check">
       <querytext>
       select cod_movi 
         from coimmovi
        where riferimento  = :cod_dimp
          and cod_impianto = :cod_impianto
          and tipo_movi    = 'MH'
       </querytext>
    </fullquery>

    <partialquery name="del_movi">
       <querytext>
          delete from coimmovi
           where tipo_movi   = 'MH'
             and riferimento = :cod_dimp
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_last">
        <querytext>
	select max(data_controllo) as data_controllo
          from coimdimp
         where cod_impianto  = :cod_impianto
           and cod_dimp     <> :cod_dimp
        </querytext>
    </fullquery>    

    <fullquery name="sel_dimp_count">
        <querytext>
        select count(*) as conta_dimp
          from coimdimp
         where cod_impianto = :cod_impianto 
       </querytext>
    </fullquery>

    <fullquery name="sel_tari">
        <querytext>
	select iter_edit.num(a.importo,2) as tariffa
          from coimtari a
         where a.cod_potenza = :cod_potenza_old
           and a.tipo_costo  = '1' 
           and a.cod_listino = :cod_listino 
           and a.data_inizio = (select max(d.data_inizio) 
                                  from coimtari d 
                                 where d.cod_potenza = :cod_potenza_old
                                   and d.cod_listino  = :cod_listino
                                   and d.tipo_costo  = '1'
                                   and d.data_inizio <= sysdate)  

       </querytext>
    </fullquery>

    <fullquery name="sel_gend_count">
       <querytext>
        select count(*) as conta_gend
          from coimgend
         where cod_impianto = :cod_impianto
           and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <partialquery name="upd_gend_pote">
       <querytext>
           update coimgend
	      set pot_focolare_lib = :potenza 
	        , pot_utile_lib    = :potenza
                , pot_focolare_nom = :potenza
                , pot_utile_nom    = :potenza
		, data_mod         =  sysdate
		, utente           = :id_utente
            where cod_impianto     = :cod_impianto
              and flag_attivo      = 'S'
              and gen_prog         = :gen_prog -- nic02
       </querytext>
    </partialquery>

    <fullquery name="sel_pote_fascia">
       <querytext>
          select cod_potenza
            from coimpote 
           where potenza_min <= :potenza
             and potenza_max >= :potenza 
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp_pote">
       <querytext>
           update coimaimp
	      set cod_potenza    = :cod_potenza
                , potenza        = :potenza
                , potenza_utile  = :potenza
		, data_mod       =  sysdate
		, utente         = :id_utente
            where cod_impianto   = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="ins_anom">
       <querytext>
                insert
                  into coimanom 
                     ( cod_cimp_dimp
                     , prog_anom
                     , tipo_anom
                     , cod_tanom
                     , dat_utile_inter
		     , flag_origine)
                values 
                     (:cod_dimp
                     ,:prog_anom_db
                     ,'1'
                     ,:cod_anom_db
                     ,:data_ut_int_db
		     ,'MH')
       </querytext>
    </partialquery>

    <fullquery name="sel_tano">
       <querytext>
             select cod_tano||' '||nvl(descr_tano, '') as note
               from coimtano
              where cod_tano = :cod_anom_db
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_todo">
       <querytext>
        select coimtodo_s.nextval as cod_todo
          from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_todo">
        <querytext>
	    insert into 
            coimtodo ( cod_todo
                     , cod_impianto
                     , tipologia
                     , note
                     , cod_cimp_dimp
                     , flag_evasione
		     , data_evasione
                     , data_evento
                     , data_scadenza
                     , data_ins
                     , utente
                     ) values (
		      :cod_todo
		     ,:cod_impianto
		     ,:tipologia
		     ,:note
		     ,:cod_dimp
                     ,:flag_evasione
		     ,:data_evasione
                     ,:data_evento
                     ,:data_scadenza
                     , sysdate
                     ,:id_utente
		     )
        </querytext>
    </partialquery>

    <fullquery name="sel_anom">
       <querytext>
           select * 
             from (
                   select prog_anom
                        , cod_tanom 
                        , iter_edit.data(dat_utile_inter) as dat_utile_inter
                     from coimanom 
                    where cod_cimp_dimp = :cod_dimp
                      and flag_origine  = 'MH'
	         order by to_number(prog_anom,'99999999')
                  ) 
            where rownum <= 5              
       </querytext>
    </fullquery>

    <fullquery name="sel_anom_count">
       <querytext>
        select count(*) as conta_anom
          from coimanom
         where cod_cimp_dimp = :cod_dimp
           and cod_tanom     = :cod_anom_db
	   and flag_origine  = 'MH'
	   and prog_anom     > :prog_anom_max
	   and prog_anom    <> :prog_anom_db
       </querytext>
    </fullquery>

    <partialquery name="del_todo_anom">
       <querytext>
           delete 
             from coimtodo
            where cod_impianto     = :cod_impianto
              and tipologia        = '1'
              and cod_cimp_dimp    = :cod_dimp
	      and substr(note,1,3) = (select cod_tanom
                                        from coimanom a
                                       where cod_cimp_dimp =  :cod_dimp
                                         and flag_origine  =  'MH'
                                         and prog_anom     =  :prog_anom_db)
       </querytext>
    </partialquery>

    <partialquery name="del_anom">
       <querytext>
           delete
             from coimanom
            where cod_cimp_dimp = :cod_dimp
	      and flag_origine  = 'MH'
              and prog_anom     = :prog_anom_db
       </querytext>
    </partialquery>

    <partialquery name="del_todo_boll">
       <querytext>
           delete 
             from coimtodo
            where cod_impianto     = :cod_impianto
              and tipologia        = '1'
              and cod_cimp_dimp    = :cod_dimp
	      and note          like :note
       </querytext>
    </partialquery>

    <partialquery name="del_todo_all">
       <querytext>
           delete
             from coimtodo
            where cod_impianto  = :cod_impianto
              and tipologia    in ('1', '5')
              and cod_cimp_dimp = :cod_dimp
       </querytext>
    </partialquery>

    <partialquery name="del_anom_all">
       <querytext>
           delete
             from coimanom
            where cod_cimp_dimp = :cod_dimp
              and flag_origine  = 'MH'
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_esito">
       <querytext>
           select flag_status
                , flag_pericolosita 
             from coimdimp
            where cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
           select * 
             from (
                   select b.descr_cost as costruttore
	   	        , a.modello
                        , a.cod_mode   -- nic01
		        , a.matricola
		        , c.descr_comb as combustibile
		        , iter_edit.data(e.data_installaz) as data_insta
		        , a.tiraggio
		        , d.descr_utgi as destinazione
		        , a.tipo_foco as tipo_a_c
  -- nic02              , a.gen_prog
                        , a.locale
                        , iter_edit.data(a.data_costruz_gen) as data_costruz_gen
                        , a.marc_effic_energ  
                        , iter_edit.num(e.volimetria_risc,2) as volimetria_risc
                        , iter_edit.num(e.consumo_annuo,2) as consumo_annuo
    -- nic03            , iter_edit.num(a.pot_focolare_nom,2) as pot_focolare_nom
                        , iter_edit.num(a.pot_utile_nom,2)    as pot_utile_nom -- nic03 (utile raffr.)
                        , iter_edit.num(a.pot_utile_lib,2)    as pot_utile_lib -- nic03 (utile risc.)
                     from coimgend a
	                , coimcost b
                        , coimcomb c
                        , coimutgi d
                        , coimaimp e
                    where e.cod_impianto = :cod_impianto
                      and a.cod_impianto = e.cod_impianto
                      and a.gen_prog     = :gen_prog -- nic02
                      and a.flag_attivo  = 'S'
                      and b.cod_cost         (+) = a.cod_cost
                      and c.cod_combustibile (+) = e.cod_combustibile
                      and d.cod_utgi         (+) = a.cod_utgi
                  ) 
            where rownum <= 1    
      </querytext>
    </fullquery>

    <fullquery name="sel_tano_scatenante">
       <querytext>
           select flag_scatenante
             from coimtano 
            where cod_tano = :cod_anomalia
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_anom">
        <querytext>
           select a.cod_tanom       as cod_tanom_check 
                , b.flag_scatenante as flag_scatenante_check
             from coimanom a
                , coimtano b
            where a.cod_cimp_dimp = :cod_dimp
	      and a.flag_origine  = 'MH'
	      and b.cod_tano      = a.cod_tanom
        </querytext>
    </fullquery>

    <fullquery name="sel_anom_count2">
       <querytext>
        select count(*) as conta_anom_2
          from coimanom
         where cod_cimp_dimp = :cod_dimp
	   and flag_origine  = 'MH'
       </querytext>
    </fullquery>

    <partialquery name="sel_gage">
        <querytext>
            select iter_edit.data(data_prevista)   as data_prevista
              from coimgage
             where cod_opma     = :cod_opma
               and cod_impianto = :cod_impianto
               and data_ins     = :data_ins
        </querytext>
    </partialquery>

    <partialquery name="upd_gage">
        <querytext>
            update coimgage
               set data_esecuzione = :data_esecuzione
                 , stato           = :stato
             where cod_opma     = :cod_opma
               and cod_impianto = :cod_impianto
               and data_ins     = :data_ins
        </querytext>
    </partialquery>

    <fullquery name="sel_tano_gg_adattamento">
        <querytext>
              select gg_adattamento
                from coimtano
	       where cod_tano = :cod_anomalia
        </querytext>
    </fullquery>

    <fullquery name="upd_aimp">
       <querytext>
            update coimaimp
               set cod_intestatario = :cod_int_contr
             where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="check_modh_old">
       <querytext>
           select to_char(max(data_controllo), 'yyyymmdd') as data_ultimo_modh
             from coimdimp
            where cod_impianto = :cod_impianto              
       </querytext>
    </fullquery>

    <fullquery name="add_months">
       <querytext>
	   select to_char(add_months(:data_controllo, :valid_mod_h_b),'yyyy-mm-dd') as data_scadenza_autocert
       </querytext>
    </fullquery>

    <fullquery name="sel_tgen">
       <querytext>
	   select *
             from coimtgen
       </querytext>
    </fullquery>

    <fullquery name="sel_min_data_controllo">
       <querytext>
	   select min(data_controllo) as min_data_controllo
             from coimdimp
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_max_data_controllo">
       <querytext>
	   select max(data_controllo) as max_data_controllo
             from coimdimp
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp_prima_dich">
       <querytext>
        update coimaimp
           set data_prima_dich  = :data_controllo
             , data_mod        =  current_date
             , utente          = :id_utente 
         where cod_impianto    = :cod_impianto        
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_ultim_dich">
       <querytext>
        update coimaimp
           set data_ultim_dich = :data_controllo
             , data_scad_dich  = :data_scadenza_autocert
             , data_mod        =  current_date
             , utente          = :id_utente 
         where cod_impianto    = :cod_impianto        
       </querytext>
    </partialquery>

    <fullquery name="sel_gend_list"><!-- nic02 -->
       <querytext>
           select gen_prog
             from coimgend
            where cod_impianto = :cod_impianto
              and flag_attivo  = 'S'
       </querytext>
    </fullquery>

</queryset>
