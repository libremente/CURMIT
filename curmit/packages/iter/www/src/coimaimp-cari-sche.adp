<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>
@link_head;noquote@

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="current_date">
<formwidget   id="current_time">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top width="50%" align=right class=form_title>Data partenza</td>
    <td valign=top width="50%"><formwidget id="dat_prev">
        <formerror  id="dat_prev"><br>
        <span class="errori">@formerror.dat_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Ora partenza</td>
    <td valign=top><formwidget id="ora_prev">
        <formerror  id="ora_prev"><br>
        <span class="errori">@formerror.ora_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr>
    <td valign=top align=right class=form_title>File da importare</td>
    <td valign=top><formwidget id="file_name">
        <formerror  id="file_name"><br>
        <span class="errori">@formerror.file_name;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>
<else>
    <tr><td colspan=2 align=center><span class="errori">@page_title;noquote@</span></td></tr>
</else>

<!-- Fine della form colorata -->

<%=[iter_form_fine]%>


<if @funzione@ eq "I">
<table>
<tr><td valign=top class=form_title>
<br>
<br>
Da questa pagina &egrave; possibile caricare nuovi impianti utilizzando un file csv.
<p>Le varie colonne del file devono essere seperate da separatore di elenco punto e virgola (;).</p>
<br>La prima riga di questo file non viene caricata perch&egrave; si prevede che contenga le  informazioni sulla testata
  </td>
</tr>
</table>
</if>

</formtemplate>
<p>
</center>

