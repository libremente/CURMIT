<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="current_date">
<formwidget   id="current_time">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr>
    <td valign=top align=right class=form_title>Tipo modello</td>
    <td valign=top><formwidget id="tipo_modello">
        <formerror  id="tipo_modello"><br>
        <span class="errori">@formerror.tipo_modello;noquote@</span>
        </formerror>
    </td>
</tr>


<tr>
    <td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top><formwidget id="cod_manutentore">
        <formerror  id="cod_manutentore"><br>
        <span class="errori">@formerror.cod_manutentore;noquote@</span>
        </formerror>
    </td>
</tr>




<tr><td colspan=2>&nbsp;</td></tr>

    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->

<%=[iter_form_fine]%>


</table>
</if>

</formtemplate>
<p>
</center>

