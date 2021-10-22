<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp_si_vie">
       <querytext>
                select a.cod_impianto
                     , a.cod_documento
                     , a.verb_n
                     , a.gen_prog
                     , iter_edit_data(a.data_controllo) as data_controllo
                     , a.data_controllo as data_controllo_db
                     , case presenza_libretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as pres_libr
                     , case libretto_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_corr
                     , case a.libretto_manutenz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           when 'I' then 'Incompleta'
                           else 'Non noto'
                       end as libr_manut
                     , coalesce(iter_edit_num(a.mis_port_combust, 2),'&nbsp;') as mis_port_combust
                     , coalesce(iter_edit_num(a.mis_pot_focolare, 2),'&nbsp;') as mis_pot_focolare
                     , case a.stato_coiben
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as stato_coiben
                     , case a.stato_canna_fum
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as stato_canna_fum
                     , case a.verifica_areaz
                           when 'P' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'A' then 'Assente'
                           else 'Non nota'
                       end as verifica_areaz
                     , coalesce(iter_edit_num(a.temp_fumi_md, 2),'&nbsp;') as temp_fumi_md
                     , coalesce(iter_edit_num(a.t_aria_comb_md, 2),'&nbsp;') as t_aria_comb_md
                     , coalesce(iter_edit_num(a.temp_mant_md, 2),'&nbsp;') as temp_mant_md
                     , coalesce(iter_edit_num(a.temp_h2o_out_md, 2),'&nbsp;') as temp_h2o_out_md
                     , coalesce(iter_edit_num(a.co2_md, 2),'&nbsp;') as co2_md
                     , coalesce(iter_edit_num(a.o2_md, 2),'&nbsp;') as o2_md
                     , coalesce(iter_edit_num(a.co_md, 2),'&nbsp;') as co_md
                     , coalesce(iter_edit_num(a.indic_fumosita_1a, 2),'&nbsp;') as indic_fumosita_1a
                     , coalesce(iter_edit_num(a.indic_fumosita_2a, 2),'&nbsp;') as indic_fumosita_2a
                     , coalesce(iter_edit_num(a.indic_fumosita_3a, 2),'&nbsp;') as indic_fumosita_3a
                     , coalesce(iter_edit_num(a.indic_fumosita_md, 2),'&nbsp;') as indic_fumosita_md
                     , coalesce(iter_edit_num(a.co_fumi_secchi, 2),'&nbsp;') as co_fumi_secchi
                     , coalesce(iter_edit_num(a.rend_comb_conv, 2),'Non noto;') as rend_comb_conv
                     , coalesce(a.rend_comb_conv,'0') as rend_comb_convc
                     , coalesce(iter_edit_num(a.rend_comb_min, 2),'Non noto;') as rend_comb_min
                     , case a.manutenzione_8a
                       when 'S' then 'Effettuata'
                       when 'N' then 'Non effettuata'
                       else 'Non noto'
                       end as manutenzione_8a
                     , case a.co_fumi_secchi_8b
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as co_fumi_secchi_8b
                     , case a.indic_fumosita_8c
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as indic_fumosita_8c
                     , case a.rend_comb_8d
                       when 'S' then 'Sufficiente'
                       when 'N' then 'Insufficiente'
                       else 'Non noto'
                       end as rend_comb_8d
                     , case a.esito_verifica
                       when 'S' then 'Rientra'
                       when 'N' then 'Non rientra'
                       else 'Non noto'
                       end as esito_verifica
                     , a.note_verificatore
                     , iter_edit_data(b.data_installaz) as data_installaz
                     , coalesce(c.descr_topo,'')||' '||coalesce(c.descr_estesa,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente, '')||' '||coalesce(m.denominazione,'') as ubicazione
                     , d.cognome as cogn_responsabile
                     , d.nome as nome_responsabile
                     , coalesce(d.indirizzo,'')||'&nbsp;'||coalesce(d.numero,'') as indi_resp
                     , d.comune as comu_resp
                     , coalesce(d.telefono,'')||'&nbsp;'||coalesce(d.cellulare,'') as telef_resp
                     , n.cognome as cogn_amministratore
                     , n.nome as nome_amministratore
                     , coalesce(n.indirizzo,'')||'&nbsp;'||coalesce(n.numero,'') as indi_ammin
                     , n.comune as comu_ammin
                     , coalesce(n.telefono,'')||'&nbsp;'||coalesce(n.cellulare,'') as telef_ammin
                     , o.cognome as cogn_occu
                     , o.nome as nome_occu
                     , coalesce(o.indirizzo,'')||'&nbsp;'||coalesce(o.numero,'') as indi_occu
                     , o.comune as comu_occu
                     , coalesce(o.telefono,'')||'&nbsp;'||coalesce(o.cellulare,'') as telef_occu
                     , p.cognome as cogn_prop
                     , p.nome as nome_prop
                     , coalesce(p.indirizzo,'')||'&nbsp;'||coalesce(p.numero,'') as indi_prop
                     , p.comune as comu_prop
                     , coalesce(p.telefono,'')||'&nbsp;'||coalesce(p.cellulare,'') as telef_prop
                     , b.flag_resp
                     , e.cognome||' '||coalesce(e.nome,'') as opve
                     , h.descr_utgi as dest
                     , case f.mod_funz
                       when '1' then 'Aria'
                       when '2' then 'Acqua'
                       else 'Non noto'
                       end as mod_funz
                     , coalesce(f.matricola,'Non nota') as matricola
                     , coalesce(f.modello,'Non noto') as modello
                     , coalesce(f.matricola_bruc,'Non nota') as matricola_bruc
                     , coalesce(f.modello_bruc,'Non noto') as modello_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_nom, 2),'&nbsp;') as pot_focolare_nom
                     , coalesce(iter_edit_num(f.pot_utile_nom, 2),'&nbsp;') as pot_utile_nom
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
                     , g.descr_comb
                     , case a.flag_ispes
                       when 'T' then 'S&igrave;'
                       when 'F' then 'NO'
		       when 'V' then 'NV'
                       else 'Non noto'
                       end as flag_ispes
                     , case b.flag_resp
                           when 'P' then 'Proprietario'
                           when 'O' then 'Occupante'
                           when 'A' then 'Amministratore'
                           when 'I' then 'Intestatario'
                           when 'T' then 'Terzo responsabile (manutentore)'
                           else 'Non noto'
                       end                  as aimp_flag_resp_desc
                     , case b.cod_tpim
                           when 'A' then 'Singola unit&agrave; immobiliare'
                           when 'C' then 'Pi&ugrave; unit&agrave; immobiliari'
                           when '0' then 'Non noto'
                           else 'Non Noto;'
                       end                  as aimp_tipologia
                     , i.descr_cted         as aimp_categoria_edificio
                     , coalesce(k.descr_cost,'&nbsp;')   as gend_descr_cost
                     , iter_edit_data(f.data_installaz) as gend_data_installaz
                     , case f.tipo_foco
                           when 'A' then 'Aperto'
                           when 'C' then 'Chiuso'
                           else 'Non Noto'
                       end                  as gend_tipo_focolare
                     , case f.tiraggio
                           when 'F' then 'Forzato'
                           when 'N' then 'Naturale'
                           else 'Non Noto'
                       end                  as gend_tiraggio
                     , coalesce(f.modello,'&nbsp')    as gend_modello
                     , coalesce(f.matricola,'&nbsp;') as gend_matricola
                     , case f.tipo_bruciatore
                           when 'A' then 'Atmosferico'
                           when 'P' then 'Soffiato'
                           when 'M' then 'Premiscelato'
                           else 'Non Noto'
                       end                  as gend_tipo_bruciatore
                     , coalesce(l.descr_cost,'&nbsp;')  as gend_descr_cost_bruc
                     , coalesce(f.modello_bruc,'&nbsp;') as gend_modello_bruc
                     , coalesce(f.matricola_bruc,'&nbsp;') as gend_matricola_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as gend_pot_focolare_lib_edit
                     , coalesce(iter_edit_num(f.pot_utile_lib, 2),'&nbsp;')    as gend_pot_utile_lib_edit
                     , coalesce(h.descr_utgi,'&nbsp;') as gend_destinazione_uso
                     , case f.locale 
                           when 'T' then 'Tecnico'
                           when 'E' then 'Esterno'
                           when 'I' then 'Interno'
                           else 'Non Noto'
                       end                  as gend_tipologia_locale
                     , coalesce(j.descr_fuge,'&nbsp;') as gend_fluido_termovettore
                     , f.cod_emissione 
                     , iter_edit_data(a.new1_data_dimp) as new1_data_dimp
                     , iter_edit_data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                     , case a.new1_conf_locale
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_locale
                     , case a.new1_conf_accesso
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_accesso
                     , case a.new1_pres_intercet
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_intercet
                     , case a.new1_pres_interrut
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_interrut
                     , case a.new1_asse_mate_estr
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_asse_mate_estr
                     , case a.new1_pres_mezzi
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_mezzi
                     , case a.new1_pres_cartell
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_cartell
                     , case a.new1_disp_regolaz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'                         
                       end as new1_disp_regolaz
                     , case a.new1_foro_presente
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_presente
                     , case a.new1_foro_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_corretto
                     , case a.new1_foro_accessibile
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_accessibile
                     , case a.new1_canali_a_norma
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_canali_a_norma
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_iniz ,2),'0') as new1_lavoro_nom_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_fine ,2),'0') as new1_lavoro_nom_fine
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_iniz ,2),'0') as new1_lavoro_lib_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_fine ,2),'0') as new1_lavoro_lib_fine
                     , a.new1_note_manu
                     , case a.new1_dimp_pres
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_pres
                     , case a.new1_dimp_prescriz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_prescriz
                     , iter_edit_data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                     , iter_edit_data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                     , case a.new1_manu_prec_8a
                           when 'S' then 'Effettuata'
                           when 'N' then 'Non effettuata'
                           else 'Non noto'
                       end as new1_manu_prec_8a
                     , coalesce(iter_edit_num(a.new1_co_rilevato, 2),'&nbsp;') as new1_co_rilevato
                     , case a.new1_flag_peri_8p 
                           when 'I' then 'Immediatamente'
                           when 'P' then 'Potenzialmente'
                           else 'Non noto'
                       end as new1_flag_peri_8p
                     , coalesce(a.note_conf,'&nbsp;') as note_conf
                     , coalesce(a.note_resp,'&nbsp;') as note_resp
                     , coalesce(a.nominativo_pres,'&nbsp') as nominativo_pres
                     , f.gen_prog_est       as gend_gen_prog_est
                     , b.cod_impianto_est
                     , coalesce(iter_edit_num(a.costo,2),'&nbsp') as costo
                     , q.descr_tpdu as aimp_dest_uso
                     , a.n_prot
                     , a.data_prot
                     , b.cod_responsabile
                     , a.pendenza
                     , a.ventilaz_lib_ostruz
                     , case a.disp_reg_cont_pre
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_pre
                     , case a.disp_reg_cont_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_funz
                     , case a.disp_reg_clim_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_clim_funz
                     , iter_edit_num(a.volumetria,2) as volumetria
                     , iter_edit_num(a.comsumi_ultima_stag,2) as comsumi_ultima_stag
                     , iter_edit_num(a.temp_h2o_out_1a, 2) as temp_h2o_out_1a
                     , iter_edit_num(a.temp_h2o_out_2a, 2) as temp_h2o_out_2a
                     , iter_edit_num(a.temp_h2o_out_3a, 2) as temp_h2o_out_3a
                     , iter_edit_num(a.t_aria_comb_1a, 2) as t_aria_comb_1a
                     , iter_edit_num(a.t_aria_comb_2a, 2) as t_aria_comb_2a
                     , iter_edit_num(a.t_aria_comb_3a, 2) as t_aria_comb_3a
                     , iter_edit_num(a.temp_fumi_1a, 2) as temp_fumi_1a
                     , iter_edit_num(a.temp_fumi_2a, 2) as temp_fumi_2a
                     , iter_edit_num(a.temp_fumi_3a, 2) as temp_fumi_3a
                     , iter_edit_num(a.co_1a, 2) as co_1a
                     , iter_edit_num(a.co_2a, 2) as co_2a
                     , iter_edit_num(a.co_3a, 2) as co_3a
                     , iter_edit_num(a.co2_1a, 2) as co2_1a
                     , iter_edit_num(a.co2_2a, 2) as co2_2a
                     , iter_edit_num(a.co2_3a, 2) as co2_3a
                     , iter_edit_num(a.o2_1a, 2) as o2_1a
                     , iter_edit_num(a.o2_2a, 2) as o2_2a
                     , iter_edit_num(a.o2_3a, 2) as o2_3a
                     , a.strumento
                     , a.marca_strum
                     , a.modello_strum
                     , a.matr_strum
                     , iter_edit_num(b.volimetria_risc,2) as aimp_volumetria_risc
                     , iter_edit_num(b.consumo_annuo,2) as aimp_consumo_annuo
                     , case f.dpr_660_96
                          when 'S' then 'Standard'
                          when 'B' then 'A bassa temperatura'
                          when 'G' then 'A gas a condensazione'
                           else 'Non Noto'
                       end as gend_dpr_660_96
                     , iter_edit_data(f.data_installaz) as gend_data_installazione 
                     , case a.dich_conformita 
                          when 'S' then 'S&igrave;'
                          when 'N' then 'No'
                          else '&nbsp;'
                       end as dich_conformita
                     , iter_edit_data(r.data_inizio) as data_inizio_campagna
                     , iter_edit_data(r.data_fine) as data_fine_campagna
                     , case a.ubic_locale_norma
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as ubic_locale_norma
                     , case a.doc_ispesl
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_ispesl
                     , case a.libr_manut_bruc
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as libr_manut_bruc
                     , case a.conf_imp_elettrico
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as conf_imp_elettrico
                     , case a.doc_prev_incendi	        
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_prev_incendi
                     , iter_edit_num(f.campo_funzion_min, 2) as campo_funzion_min
                     , iter_edit_num(f.campo_funzion_max, 2) as campo_funzion_max
                     , case t.tipo_strum
                            when 'A' then 'Analizzatore'
                            else 'Deprimometro'
                       end as strumento_01
                     , t.marca_strum as marca_01
                     , t.modello_strum as modello_01
                     , t.matr_strum as matricola_01
                     , case s.tipo_strum
                            when 'A' then 'Analizzatore'
                            else 'Deprimometro'
                       end as strumento_02
                     , s.marca_strum as marca_02
                     , s.modello_strum as modello_02
                     , s.matr_strum as matricola_02
                      , case a.scarico_dir_esterno
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as scarico_dir_esterno
                      , case a.rend_suff_insuff
                           when 'S' then 'Sufficiente'
                           when 'N' then 'Insufficiente'
                           else 'Non noto'
                       end as rend_suff_insuff
                       , case a.dichiarato
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as dichiarato
                      , a.riferimento_pag_bollini as riferimento_pag_bollini
                      , iter_edit_num(a.et, 2) as et
                  from coimcimp a
                  left outer join coimopve e on e.cod_opve = a.cod_opve
                  left outer join coimstru t on t.cod_strumento = a.cod_strumento_01
                  left outer join coimstru s on s.cod_strumento = a.cod_strumento_02
                       inner join coimaimp b on b.cod_impianto = a.cod_impianto
                  left outer join coimviae c on c.cod_comune = b.cod_comune
                                            and c.cod_via    = b.cod_via
                  left outer join coimcitt d on d.cod_cittadino = b.cod_responsabile
                       inner join coimgend f on f.cod_impianto = a.cod_impianto
		                            and f.gen_prog     = a.gen_prog
                  left outer join coimcomb g on g.cod_combustibile = f.cod_combustibile
                  left outer join coimcted i on i.cod_cted     = b.cod_cted
		  left outer join coimutgi h on h.cod_utgi     = f.cod_utgi
                  left outer join coimfuge j on j.cod_fuge     = f.mod_funz
                  left outer join coimcost k on k.cod_cost     = f.cod_cost
                  left outer join coimcost l on l.cod_cost     = f.cod_cost_bruc
                  left outer join coimcomu m on m.cod_comune   = b.cod_comune
		  left outer join coimcitt n on n.cod_cittadino = b.cod_amministratore
                  left outer join coimcitt o on o.cod_cittadino = b.cod_occupante
                  left outer join coimcitt p on p.cod_cittadino = b.cod_proprietario
                  left outer join coimtpdu q on q.cod_tpdu     = b.cod_tpdu
                  left outer join coimcinc r on r.data_inizio     <= a.data_controllo
                                            and r.data_fine       >= a.data_controllo
					    and r.stato            = '1'
        where a.cod_cimp     = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_no_vie">
       <querytext>
                select coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente,'')||' '||coalesce(m.denominazione,'') as ubicazione
                     , a.cod_impianto
                     , a.cod_documento
                     , a.verb_n
                     , a.gen_prog
                     , iter_edit_data(a.data_controllo) as data_controllo
                     , a.data_controllo as data_controllo_db
                     , a.data_controllo as data_controllo_db
                     , case presenza_libretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as pres_libr
                     , case libretto_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_corr
                     , case a.libretto_manutenz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_manut
                     , coalesce(iter_edit_num(a.mis_port_combust, 2),'&nbsp;') as mis_port_combust
                     , coalesce(iter_edit_num(a.mis_pot_focolare, 2),'&nbsp;') as mis_pot_focolare
                     , case a.stato_coiben
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_coiben
                     , case a.stato_canna_fum
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_canna_fum
                     , case a.verifica_areaz
                           when 'P' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as verifica_areaz
                     , coalesce(iter_edit_num(a.temp_fumi_md, 2),'&nbsp;') as temp_fumi_md
                     , coalesce(iter_edit_num(a.t_aria_comb_md, 2),'&nbsp;') as t_aria_comb_md
                     , coalesce(iter_edit_num(a.temp_mant_md, 2),'&nbsp;') as temp_mant_md
                     , coalesce(iter_edit_num(a.temp_h2o_out_md, 2),'&nbsp;') as temp_h2o_out_md
                     , coalesce(iter_edit_num(a.co2_md, 2),'&nbsp;') as co2_md
                     , coalesce(iter_edit_num(a.o2_md, 2),'&nbsp;') as o2_md
                     , coalesce(iter_edit_num(a.co_md, 2),'&nbsp;') as co_md
                     , coalesce(iter_edit_num(a.indic_fumosita_1a, 2),'&nbsp;') as indic_fumosita_1a
                     , coalesce(iter_edit_num(a.indic_fumosita_2a, 2),'&nbsp;') as indic_fumosita_2a
                     , coalesce(iter_edit_num(a.indic_fumosita_3a, 2),'&nbsp;') as indic_fumosita_3a
                     , coalesce(iter_edit_num(a.indic_fumosita_md, 2),'&nbsp;') as indic_fumosita_md
                     , coalesce(iter_edit_num(a.co_fumi_secchi, 2),'&nbsp;') as co_fumi_secchi
                     , coalesce(iter_edit_num(a.rend_comb_conv, 2),'Non noto;') as rend_comb_conv
                     , coalesce(a.rend_comb_conv,'0') as rend_comb_convc
                     , coalesce(iter_edit_num(a.rend_comb_min, 2),'Non noto;') as rend_comb_min
                     , case a.manutenzione_8a
                       when 'S' then 'Effettuata'
                       when 'N' then 'Non effettuata'
                       else 'Non noto'
                       end as manutenzione_8a
                     , case a.co_fumi_secchi_8b
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as co_fumi_secchi_8b
                     , case a.indic_fumosita_8c
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as indic_fumosita_8c
                     , case a.rend_comb_8d
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as rend_comb_8d
                     , case a.esito_verifica
                       when 'S' then 'Rientra'
                       when 'N' then 'Non rientra'
                       else 'Non noto'
                       end as esito_verifica
                     , a.note_verificatore
                     , iter_edit_data(b.data_installaz) as data_installaz
                     , d.cognome as cogn_responsabile
                     , d.nome as nome_responsabile
                     , coalesce(d.indirizzo,'')||'&nbsp;'||coalesce(d.numero,'') as indi_resp
                     , d.comune as comu_resp
                     , coalesce(d.telefono,'')||'&nbsp;'||coalesce(d.cellulare,'') as telef_resp

                     , n.cognome as cogn_amministratore
                     , n.nome as nome_amministratore
                     , coalesce(n.indirizzo,'')||'&nbsp;'||coalesce(n.numero,'') as indi_ammin
                     , n.comune as comu_ammin
                     , coalesce(n.telefono,'')||'&nbsp;'||coalesce(n.cellulare,'') as telef_ammin
                     , o.cognome as cogn_occu
                     , o.nome as nome_occu
                     , coalesce(o.indirizzo,'')||'&nbsp;'||coalesce(o.numero,'') as indi_occu
                     , o.comune as comu_occu
                     , coalesce(o.telefono,'')||'&nbsp;'||coalesce(o.cellulare,'') as telef_occu
                     , p.cognome as cogn_prop
                     , p.nome as nome_prop
                     , coalesce(p.indirizzo,'')||'&nbsp;'||coalesce(p.numero,'') as indi_prop
                     , p.comune as comu_prop
                     , coalesce(p.telefono,'')||'&nbsp;'||coalesce(p.cellulare,'') as telef_prop
                     , b.flag_resp
                     , e.cognome||' '||coalesce(e.nome,'') as opve
                     , h.descr_utgi as dest
                     , case f.mod_funz
                       when '1' then 'Aria'
                       when '2' then 'Acqua'
                       else 'Non noto'
                       end as mod_funz
                     , coalesce(f.matricola,'Non nota') as matricola
                     , coalesce(f.modello,'Non noto') as modello
                     , coalesce(f.matricola_bruc,'Non nota') as matricola_bruc
                     , coalesce(f.modello_bruc,'Non noto') as modello_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_nom, 2),'&nbsp;') as pot_focolare_nom
                     , coalesce(iter_edit_num(f.pot_utile_nom, 2),'&nbsp;') as pot_utile_nom
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
                     , g.descr_comb
                     , case a.flag_ispes
                       when 'T' then 'S&igrave;'
                       when 'F' then 'NO'
		       when 'S' then 'Scaduto'
                       else 'Non noto'
                       end as flag_ispes
                     , case b.flag_resp
                           when 'P' then 'Proprietario'
                           when 'O' then 'Occupante'
                           when 'A' then 'Amministratore'
                           when 'I' then 'Intestatario'
                           when 'T' then 'Terzo responsabile(manutentore)'
                           else 'Non noto'
                       end                  as aimp_flag_resp_desc
                     , case b.cod_tpim
                           when 'A' then 'Singola unit&agrave; immobiliare'
                           when 'C' then 'Pi&ugrave; unit&agrave; immobiliari'
                           when '0' then 'Non noto'
                           else 'Non Noto;'
                       end                  as aimp_tipologia
                     , i.descr_cted         as aimp_categoria_edificio
                     , coalesce(k.descr_cost,'&nbsp;')   as gend_descr_cost
                     , iter_edit_data(f.data_installaz) as gend_data_installaz
                     , case f.tipo_foco
                           when 'A' then 'Aperto'
                           when 'C' then 'Chiuso'
                           else 'Non Noto'
                       end                  as gend_tipo_focolare
                     , case f.tiraggio
                           when 'F' then 'Forzato'
                           when 'N' then 'Naturale'
                           else 'Non Noto'
                       end                  as gend_tiraggio
                     , coalesce(f.modello,'&nbsp')    as gend_modello
                     , coalesce(f.matricola,'&nbsp;') as gend_matricola
                     , case f.tipo_bruciatore
                           when 'A' then 'Atmosferico'
                           when 'P' then 'Soffiato'
                           else 'Non Noto'
                       end                  as gend_tipo_bruciatore
                     , coalesce(l.descr_cost,'&nbsp;')  as gend_descr_cost_bruc
                     , coalesce(f.modello_bruc,'&nbsp;') as gend_modello_bruc
                     , coalesce(f.matricola_bruc,'&nbsp;') as gend_matricola_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as gend_pot_focolare_lib_edit
                     , coalesce(iter_edit_num(f.pot_utile_lib, 2),'&nbsp;')    as gend_pot_utile_lib_edit
                     , coalesce(h.descr_utgi,'&nbsp;') as gend_destinazione_uso
                     , case f.locale 
                           when 'T' then 'Tecnico'
                           when 'E' then 'Esterno'
                           when 'I' then 'Interno'
                           else 'Non Noto'
                       end                  as gend_tipologia_locale
                     , coalesce(j.descr_fuge,'&nbsp;') as gend_fluido_termovettore
                     , f.cod_emissione 
                     , iter_edit_data(a.new1_data_dimp) as new1_data_dimp
                     , iter_edit_data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                     , case a.new1_conf_locale
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_locale
                     , case a.new1_conf_accesso
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_accesso
                     , case a.new1_pres_intercet
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_intercet
                     , case a.new1_pres_interrut
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_interrut
                     , case a.new1_asse_mate_estr
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_asse_mate_estr
                     , case a.new1_pres_mezzi
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_mezzi
                     , case a.new1_pres_cartell
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_cartell
                     , case a.new1_disp_regolaz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'                         
                       end as new1_disp_regolaz
                     , case a.new1_foro_presente
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_presente
                     , case a.new1_foro_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_corretto
                     , case a.new1_foro_accessibile
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_accessibile
                     , case a.new1_canali_a_norma
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_canali_a_norma
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_iniz ,2),'0') as new1_lavoro_nom_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_fine ,2),'0') as new1_lavoro_nom_fine
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_iniz ,2),'0') as new1_lavoro_lib_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_fine ,2),'0') as new1_lavoro_lib_fine
                     , a.new1_note_manu
                     , case a.new1_dimp_pres
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_pres
                     , case a.new1_dimp_prescriz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_prescriz
                     , iter_edit_data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                     , iter_edit_data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                     , case a.new1_manu_prec_8a
                           when 'S' then 'Effettuata'
                           when 'N' then 'Non effettuata'
                           else 'Non noto'
                       end as new1_manu_prec_8a
                     , coalesce(iter_edit_num(a.new1_co_rilevato, 2),'&nbsp;') as new1_co_rilevato
                     , case a.new1_flag_peri_8p 
                           when 'I' then 'Immediatamente'
                           when 'P' then 'Potenzialmente'
                           else 'Non noto'
                       end as new1_flag_peri_8p
                     , coalesce(a.note_conf,'&nbsp;') as note_conf
                     , coalesce(a.note_resp,'&nbsp;') as note_resp
                     , coalesce(a.nominativo_pres,'&nbsp') as nominativo_pres
                     , f.gen_prog_est       as gend_gen_prog_est
                     , b.cod_impianto_est
                     , coalesce(iter_edit_num(a.costo,2),'&nbsp') as costo
                     , q.descr_tpdu as aimp_dest_uso
                     , a.n_prot
                     , a.data_prot
                     , b.cod_responsabile
                     , a.pendenza
                     , case a.ventilaz_lib_ostruz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as ventilaz_lib_ostruz
                     , case a.disp_reg_cont_pre
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_pre
                     , case a.disp_reg_cont_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_funz
                     , case a.disp_reg_clim_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_clim_funz
                     , iter_edit_num(a.volumetria,2) as volumetria
                     , iter_edit_num(a.comsumi_ultima_stag,2) as comsumi_ultima_stag
                     , iter_edit_num(a.temp_h2o_out_1a, 2) as temp_h2o_out_1a
                     , iter_edit_num(a.temp_h2o_out_2a, 2) as temp_h2o_out_2a
                     , iter_edit_num(a.temp_h2o_out_3a, 2) as temp_h2o_out_3a
                     , iter_edit_num(a.t_aria_comb_1a, 2) as t_aria_comb_1a
                     , iter_edit_num(a.t_aria_comb_2a, 2) as t_aria_comb_2a
                     , iter_edit_num(a.t_aria_comb_3a, 2) as t_aria_comb_3a
                     , iter_edit_num(a.temp_fumi_1a, 2) as temp_fumi_1a
                     , iter_edit_num(a.temp_fumi_2a, 2) as temp_fumi_2a
                     , iter_edit_num(a.temp_fumi_3a, 2) as temp_fumi_3a
                     , iter_edit_num(a.co_1a, 2) as co_1a
                     , iter_edit_num(a.co_2a, 2) as co_2a
                     , iter_edit_num(a.co_3a, 2) as co_3a
                     , iter_edit_num(a.co2_1a, 2) as co2_1a
                     , iter_edit_num(a.co2_2a, 2) as co2_2a
                     , iter_edit_num(a.co2_3a, 2) as co2_3a
                     , iter_edit_num(a.o2_1a, 2) as o2_1a
                     , iter_edit_num(a.o2_2a, 2) as o2_2a
                     , iter_edit_num(a.o2_3a, 2) as o2_3a
                     , a.strumento
                     , a.marca_strum
                     , a.modello_strum
                     , a.matr_strum
                     , iter_edit_num(b.volimetria_risc,2) as aimp_volumetria_risc
                     , iter_edit_num(b.consumo_annuo,2) as aimp_consumo_annuo
                     , case f.dpr_660_96
                          when 'S' then 'Standard'
                          when 'B' then 'A bassa temperatura'
                          when 'G' then 'A gas a condensazione'
                           else 'Non Noto'
                       end as gend_dpr_660_96
                     , iter_edit_data(f.data_installaz) as gend_data_installazione
                     , case a.dich_conformita 
                          when 'S' then 'S&igrave;'
                          when 'N' then 'No'
                          else '&nbsp;'
                       end as dich_conformita
                     , iter_edit_data(r.data_inizio) as data_inizio_campagna
                     , iter_edit_data(r.data_fine) as data_fine_campagna
                     , case a.ubic_locale_norma
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as ubic_locale_norma
                     , case a.doc_ispesl
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_ispesl
                     , case a.libr_manut_bruc
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as libr_manut_bruc
                     , case a.conf_imp_elettrico
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as conf_imp_elettrico
                     , case a.doc_prev_incendi	        
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_prev_incendi
                     , iter_edit_num(f.campo_funzion_min, 2) as campo_funzion_min
                     , iter_edit_num(f.campo_funzion_max, 2) as campo_funzion_max
                     , case t.tipo_strum
                            when 'A' then 'Analizzatore'
                            else 'Deprimometro'
                       end as strumento_01
                     , t.marca_strum as marca_01
                     , t.modello_strum as modello_01
                     , t.matr_strum as matricola_01
                     , case s.tipo_strum
                            when 'A' then 'Analizzatore'
                            else 'Deprimometro'
                       end as strumento_02
                     , s.marca_strum as marca_02
                     , s.modello_strum as modello_02
                     , s.matr_strum as matricola_02
                        , case a.scarico_dir_esterno
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as scarico_dir_esterno
                      , case a.rend_suff_insuff
                           when 'S' then 'Sufficiente'
                           when 'N' then 'Insufficiente'
                           else 'Non noto'
                       end as rend_suff_insuff
                       , case a.dichiarato
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as dichiarato
                      , a.riferimento_pag_bollini as riferimento_pag_bollini
                      , iter_edit_num(a.et, 2) as et
                  from coimcimp a                
                  left outer join coimopve e on e.cod_opve = a.cod_opve
                  left outer join coimstru t on t.cod_strumento = a.cod_strumento_01
                  left outer join coimstru s on s.cod_strumento = a.cod_strumento_02
                       inner join coimaimp b on b.cod_impianto = a.cod_impianto
                  left outer join coimcitt d on d.cod_cittadino = b.cod_responsabile
                       inner join coimgend f on f.cod_impianto = a.cod_impianto
		                            and f.gen_prog     = a.gen_prog
                  left outer join coimcomb g on g.cod_combustibile = f.cod_combustibile
                  left outer join coimcted i on i.cod_cted     = b.cod_cted
		  left outer join coimutgi h on h.cod_utgi     = f.cod_utgi
                  left outer join coimfuge j on j.cod_fuge     = f.mod_funz
                  left outer join coimcost k on k.cod_cost     = f.cod_cost
                  left outer join coimcost l on l.cod_cost     = f.cod_cost_bruc
                  left outer join coimcomu m on m.cod_comune   = b.cod_comune
		  left outer join coimcitt n on n.cod_cittadino = b.cod_amministratore
                  left outer join coimcitt o on o.cod_cittadino = b.cod_occupante
                  left outer join coimcitt p on p.cod_cittadino = b.cod_proprietario
                  left outer join coimtpdu q on q.cod_tpdu     = b.cod_tpdu
                  left outer join coimcinc r on r.data_inizio     <= a.data_controllo
                                            and r.data_fine       >= a.data_controllo
					    and r.stato            = '1'
                 where a.cod_cimp     = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
                     , tipo_soggetto
                     , cod_soggetto
                     , protocollo_02
                     , data_prot_02
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,:data_controllo_db
                     ,current_date
                     ,'C'
                     ,:cod_responsabile
                     ,:n_prot
                     ,:data_prot
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
       <querytext>
                   update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = lo_import(:contenuto_tmpfile)
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_cimp">
       <querytext>
                   update coimcimp
                      set cod_documento = :cod_documento
                    where cod_cimp      = :cod_cimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_cimp
              and tipo_anom     = '2'
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_prog">
       <querytext>
            select gen_prog as gen_prog_n
              from coimgend
             where cod_impianto = :cod_impianto
               and gen_prog    <> :gen_prog
               and flag_attivo  = 'S' 
          order by gen_prog_est
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_n">
       <querytext>
                select a.cod_documento
                     , case presenza_libretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as pres_libr
                     , case libretto_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_corr
                     , case a.libretto_manutenz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'NO'
                           else 'Non noto'
                       end as libr_manut
                     , coalesce(iter_edit_num(a.mis_port_combust, 2),'&nbsp;') as mis_port_combust
                     , coalesce(iter_edit_num(a.mis_pot_focolare, 2),'&nbsp;') as mis_pot_focolare
                     , case a.stato_coiben
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_coiben
                     , case a.stato_canna_fum
                           when 'B' then 'Buono'
                           when 'M' then 'Mediocre'
                           when 'S' then 'Scarso'
                           else 'Non noto'
                       end as stato_canna_fum
                     , case a.verifica_areaz
                           when 'P' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as verifica_areaz
                     , coalesce(iter_edit_num(a.temp_fumi_md, 2),'&nbsp;') as temp_fumi_md
                     , coalesce(iter_edit_num(a.t_aria_comb_md, 2),'&nbsp;') as t_aria_comb_md
                     , coalesce(iter_edit_num(a.temp_mant_md, 2),'&nbsp;') as temp_mant_md
                     , coalesce(iter_edit_num(a.temp_h2o_out_md, 2),'&nbsp;') as temp_h2o_out_md
                     , coalesce(iter_edit_num(a.co2_md, 2),'&nbsp;') as co2_md
                     , coalesce(iter_edit_num(a.o2_md, 2),'&nbsp;') as o2_md
                     , coalesce(iter_edit_num(a.co_md, 2),'&nbsp;') as co_md
                     , coalesce(iter_edit_num(a.indic_fumosita_1a, 2),'&nbsp;') as indic_fumosita_1a
                     , coalesce(iter_edit_num(a.indic_fumosita_2a, 2),'&nbsp;') as indic_fumosita_2a
                     , coalesce(iter_edit_num(a.indic_fumosita_3a, 2),'&nbsp;') as indic_fumosita_3a
                     , coalesce(iter_edit_num(a.indic_fumosita_md, 2),'&nbsp;') as indic_fumosita_md
                     , coalesce(iter_edit_num(a.co_fumi_secchi, 2),'&nbsp;') as co_fumi_secchi
                     , coalesce(iter_edit_num(a.rend_comb_conv, 2),'Non noto;') as rend_comb_conv
                     , coalesce(iter_edit_num(a.rend_comb_min, 2),'Non noto;') as rend_comb_min
                     , case a.manutenzione_8a
                       when 'S' then 'Effettuata'
                       when 'N' then 'Non effettuata'
                       else 'Non noto'
                       end as manutenzione_8a
                     , case a.co_fumi_secchi_8b
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as co_fumi_secchi_8b
                     , case a.indic_fumosita_8c
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as indic_fumosita_8c
                     , case a.rend_comb_8d
                       when 'S' then 'Regolare'
                       when 'N' then 'Irregolare'
                       else 'Non noto'
                       end as rend_comb_8d
                     , case a.esito_verifica
                       when 'S' then 'Rientra'
                       when 'N' then 'Non rientra'
                       else 'Non noto'
                       end as esito_verifica
                     , a.note_verificatore
                     , iter_edit_data(b.data_installaz) as data_installaz
                     , h.descr_utgi as dest
                     , case f.mod_funz
                       when '1' then 'Aria'
                       when '2' then 'Acqua'
                       else 'Non noto'
                       end as mod_funz
                     , coalesce(f.matricola,'Non nota') as matricola
                     , coalesce(f.modello,'Non noto') as modello
                     , coalesce(f.matricola_bruc,'Non nota') as matricola_bruc
                     , coalesce(f.modello_bruc,'Non noto') as modello_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_nom, 2),'&nbsp;') as pot_focolare_nom
                     , coalesce(iter_edit_num(f.pot_utile_nom, 2),'&nbsp;') as pot_utile_nom
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
                     , g.descr_comb
                     , case a.flag_ispes
                       when 'T' then 'S&igrave;'
                       when 'F' then 'NO'
		       when 'S' then 'Scaduto'
                       else 'Non noto'
                       end as flag_ispes
                     , i.descr_cted         as aimp_categoria_edificio
                     , iter_edit_data(f.data_installaz) as gend_data_installaz
                     , case f.tipo_foco
                           when 'A' then 'Aperto'
                           when 'C' then 'Chiuso'
                           else 'Non Noto'
                       end                  as gend_tipo_focolare
                     , case f.tiraggio
                           when 'F' then 'Forzato'
                           when 'N' then 'Naturale'
                           else 'Non Noto'
                       end                  as gend_tiraggio
                     , coalesce(f.modello,'&nbsp')    as gend_modello
                     , coalesce(f.matricola,'&nbsp;') as gend_matricola
                     , case f.tipo_bruciatore
                           when 'A' then 'Atmosferico'
                           when 'P' then 'Soffiato'
                           else 'Non Noto'
                       end                  as gend_tipo_bruciatore
                     , coalesce(l.descr_cost,'&nbsp;')  as gend_descr_cost_bruc
                     , coalesce(f.modello_bruc,'&nbsp;') as gend_modello_bruc
                     , coalesce(f.matricola_bruc,'&nbsp;') as gend_matricola_bruc
                     , coalesce(iter_edit_num(f.pot_focolare_lib, 2),'&nbsp;') as gend_pot_focolare_lib_edit
                     , coalesce(iter_edit_num(f.pot_utile_lib, 2),'&nbsp;')    as gend_pot_utile_lib_edit
                     , coalesce(h.descr_utgi,'&nbsp;') as gend_destinazione_uso
                     , case f.locale 
                           when 'T' then 'Tecnico'
                           when 'E' then 'Esterno'
                           when 'I' then 'Interno'
                           else 'Non Noto'
                       end                  as gend_tipologia_locale
                     , coalesce(j.descr_fuge,'&nbsp;') as gend_fluido_termovettore
                     , f.cod_emissione 
                     , iter_edit_data(a.new1_data_dimp) as new1_data_dimp
                     , iter_edit_data(a.new1_data_paga_dimp) as new1_data_paga_dimp
                     , case a.new1_conf_locale
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_locale
                     , case a.new1_conf_accesso
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_conf_accesso
                     , case a.new1_pres_intercet
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_intercet
                     , case a.new1_pres_interrut
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_interrut
                     , case a.new1_asse_mate_estr
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_asse_mate_estr
                     , case a.new1_pres_mezzi
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_mezzi
                     , case a.new1_pres_cartell
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           when 'V' then 'NV'
                           else 'Non noto'
                       end as new1_pres_cartell
                     , case a.new1_disp_regolaz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'                         
                       end as new1_disp_regolaz
                     , case a.new1_foro_presente
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_presente
                     , case a.new1_foro_corretto
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_corretto
                     , case a.new1_foro_accessibile
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_foro_accessibile
                     , case a.new1_canali_a_norma
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_canali_a_norma
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_iniz ,2),'0') as new1_lavoro_nom_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_nom_fine ,2),'0') as new1_lavoro_nom_fine
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_iniz ,2),'0') as new1_lavoro_lib_iniz
                     , coalesce(iter_edit_num(a.new1_lavoro_lib_fine ,2),'0') as new1_lavoro_lib_fine
                     , a.new1_note_manu
                     , case a.new1_dimp_pres
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_pres
                     , case a.new1_dimp_prescriz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as new1_dimp_prescriz
                     , iter_edit_data(a.new1_data_ultima_manu) as new1_data_ultima_manu
                     , iter_edit_data(a.new1_data_ultima_anal) as new1_data_ultima_anal
                     , case a.new1_manu_prec_8a
                           when 'S' then 'Effettuata'
                           when 'N' then 'Non effettuata'
                           else 'Non noto'
                       end as new1_manu_prec_8a
                     , coalesce(iter_edit_num(a.new1_co_rilevato, 2),'&nbsp;') as new1_co_rilevato
                     , case a.new1_flag_peri_8p 
                           when 'I' then 'Immediatamente'
                           when 'P' then 'Potenzialmente'
                           else 'Non noto'
                       end as new1_flag_peri_8p
                     , coalesce(a.note_conf,'&nbsp;') as note_conf
                     , coalesce(a.note_resp,'&nbsp;') as note_resp
                     , coalesce(a.nominativo_pres,'&nbsp') as nominativo_pres
                     , f.gen_prog_est       as gend_gen_prog_est
                     , coalesce(iter_edit_num(a.costo,2),'&nbsp') as costo
                     , q.descr_tpdu as aimp_dest_uso
                     , a.n_prot
                     , a.data_prot
                     , a.pendenza
                     , case a.ventilaz_lib_ostruz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as ventilaz_lib_ostruz
                     , case a.disp_reg_cont_pre
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_pre
                     , case a.disp_reg_cont_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_cont_funz
                     , case a.disp_reg_clim_funz
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else '&nbsp;'
                       end as disp_reg_clim_funz
                     , iter_edit_num(a.volumetria,2) as volumetria
                     , iter_edit_num(a.comsumi_ultima_stag,2) as comsumi_ultima_stag
                     , iter_edit_num(a.temp_h2o_out_1a, 2) as temp_h2o_out_1a
                     , iter_edit_num(a.temp_h2o_out_2a, 2) as temp_h2o_out_2a
                     , iter_edit_num(a.temp_h2o_out_3a, 2) as temp_h2o_out_3a
                     , iter_edit_num(a.t_aria_comb_1a, 2) as t_aria_comb_1a
                     , iter_edit_num(a.t_aria_comb_2a, 2) as t_aria_comb_2a
                     , iter_edit_num(a.t_aria_comb_3a, 2) as t_aria_comb_3a
                     , iter_edit_num(a.temp_fumi_1a, 2) as temp_fumi_1a
                     , iter_edit_num(a.temp_fumi_2a, 2) as temp_fumi_2a
                     , iter_edit_num(a.temp_fumi_3a, 2) as temp_fumi_3a
                     , iter_edit_num(a.co_1a, 2) as co_1a
                     , iter_edit_num(a.co_2a, 2) as co_2a
                     , iter_edit_num(a.co_3a, 2) as co_3a
                     , iter_edit_num(a.co2_1a, 2) as co2_1a
                     , iter_edit_num(a.co2_2a, 2) as co2_2a
                     , iter_edit_num(a.co2_3a, 2) as co2_3a
                     , iter_edit_num(a.o2_1a, 2) as o2_1a
                     , iter_edit_num(a.o2_2a, 2) as o2_2a
                     , iter_edit_num(a.o2_3a, 2) as o2_3a
                     , a.strumento
                     , a.marca_strum
                     , a.modello_strum
                     , a.matr_strum
                     , iter_edit_num(b.volimetria_risc,2) as aimp_volumetria_risc
                     , iter_edit_num(b.consumo_annuo,2) as aimp_consumo_annuo
                     , case f.dpr_660_96
                          when 'S' then 'Standard'
                          when 'B' then 'A bassa temperatura'
                          when 'G' then 'A gas a condensazione'
                           else 'Non Noto'
                       end as gend_dpr_660_96
                     , iter_edit_data(f.data_installaz) as gend_data_installazione
                     , case a.dich_conformita 
                          when 'S' then 'S&igrave;'
                          when 'N' then 'No'
                          else '&nbsp;'
                       end as dich_conformita
                     , iter_edit_data(r.data_inizio) as data_inizio_campagna
                     , iter_edit_data(r.data_fine) as data_fine_campagna
                     , case a.ubic_locale_norma
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as ubic_locale_norma
                     , case a.doc_ispesl
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_ispesl
                     , case a.libr_manut_bruc
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as libr_manut_bruc
                     , case a.conf_imp_elettrico
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as conf_imp_elettrico
                     , case a.doc_prev_incendi	        
                           when 'N' then 'No'
                           when 'S' then 'S&igrave;'
                           else '&nbsp;'
                       end as doc_prev_incendi
                     , iter_edit_num(f.campo_funzion_min, 2) as campo_funzion_min
                     , iter_edit_num(f.campo_funzion_max, 2) as campo_funzion_max
                      , case a.scarico_dir_esterno
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as scarico_dir_esterno
                      , case a.rend_suff_insuff
                           when 'S' then 'Sufficiente'
                           when 'N' then 'Insufficiente'
                           else 'Non noto'
                       end as rend_suff_insuff
                       , case a.dichiarato
                           when 'S' then 'S&igrave;'
                           when 'N' then 'No'
                           else 'Non noto'
                       end as dichiarato
                      , a.riferimento_pag_bollini as riferimento_pag_bollini
                      , iter_edit_num(a.et, 2) as et

                  from coimcimp a                
                  left outer join coimopve e on e.cod_opve = a.cod_opve
                       inner join coimaimp b on b.cod_impianto = a.cod_impianto
                       inner join coimgend f on f.cod_impianto = a.cod_impianto
		                            and f.gen_prog     = a.gen_prog
                  left outer join coimcomb g on g.cod_combustibile = f.cod_combustibile
                  left outer join coimcted i on i.cod_cted     = b.cod_cted
		  left outer join coimutgi h on h.cod_utgi     = f.cod_utgi
                  left outer join coimfuge j on j.cod_fuge     = f.mod_funz
                  left outer join coimcost k on k.cod_cost     = f.cod_cost
                  left outer join coimcost l on l.cod_cost     = f.cod_cost_bruc
                  left outer join coimtpdu q on q.cod_tpdu     = b.cod_tpdu
                  left outer join coimcinc r on r.data_inizio     <= a.data_controllo
                                            and r.data_fine       >= a.data_controllo
					    and r.stato           = '1'
                 where a.cod_cimp      <> :cod_cimp
                   and a.cod_impianto   = :cod_impianto
                   and a.data_controllo = :data_controllo_db
                   and a.gen_prog       = :gen_prog_n
       </querytext>
    </fullquery>


</queryset>
