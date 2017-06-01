<cfoutput>
  <cfif structKeyExists( rc, "pagination" )>
    #view( "elements/nav-pagination" )#
  <cfelseif arrayIsDefined( rc.navigation, 2 )>
    <nav class="level-2 colored-border"><ul>
      <cfloop array="#rc.navigation[ 2 ]#" index="item">
        <cfset menuItem = util.variableFormat( item ) />
        <li><a class="colored-text#menuItem eq rc.currentMenuItem ? ' active' : ''#" href="#rc.basePath##rc.navPath[ 2 ]#/#menuItem#">#item#</a></li>
      </cfloop>
      <div class="clearfix"></div>
    </ul></nav>
  </cfif>
</cfoutput>