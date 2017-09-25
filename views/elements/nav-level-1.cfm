<cfif arrayIsEmpty( rc.navigation )>
  <cfexit />
</cfif>

<cfoutput>
  <nav class="level-1"><ul>
    <cfloop array="#rc.navigation[ 1 ]#" index="item">
      <li class="colored-bg"><a href="#rc.basePath#/#util.variableFormat( item )#">#trim( replace( item, '_', ' ', 'all' ) )#</a></li>
    </cfloop>
  </ul></nav>
</cfoutput>