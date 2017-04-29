<cfoutput>
  <nav class="level-1">
    <cfloop array="#rc.navigation[ 1 ]#" index="item">
      <a class="colored-bg" href="#rc.basePath#/#util.variableFormat( item )#">#item#</a>
    </cfloop>
  </nav>
</cfoutput>