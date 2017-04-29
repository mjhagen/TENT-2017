<cfoutput>
  <cfif not arrayLen( rc.pagination )>
    <cfexit />
  </cfif>
  <nav class="pagination colored-border">
    <a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 1 ] )#">&laquo;</a>
    <a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 2 ] )#">#rc.pagination[ 2 ]#</a>
    <a class="colored-text" href="#rc.basePath##rc.navPath#/#util.variableFormat( rc.pagination[ 3 ] )#">&raquo;</a>
  </nav>
</cfoutput>