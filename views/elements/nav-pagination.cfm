<cfprocessingdirective pageEncoding="utf-8" /><cfoutput>
  <cfif not arrayLen( rc.pagination )>
    <cfexit />
  </cfif>
  <nav class="pagination colored-border"><ul>
    <li><a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 1 ] )#" title="#i18n.translate( 'prev-page' )#">«</a></li>
    <li><a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 2 ] )#">#rc.pagination[ 2 ]#</a></li>
    <li><a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 3 ] )#" title="#i18n.translate( 'next-page' )#">»</a></li>
  </ul></nav>
</cfoutput>