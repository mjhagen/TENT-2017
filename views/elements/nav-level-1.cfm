<cfoutput>
  <nav class="level-1"><ul>
    <cfloop array="#rc.navigation[ 1 ]#" index="item">
      <li class="colored-bg"><a href="#rc.basePath#/#util.variableFormat( item )#">#item#</a></li>
    </cfloop>
  </ul></nav>
</cfoutput>