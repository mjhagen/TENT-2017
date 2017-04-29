<cfoutput>
  <cfif structKeyExists( rc, "pagination" )>
    #view( "elements/nav-pagination" )#
  <cfelseif arrayIsDefined( rc.navigation, 2 )>
    <nav class="level-2 colored-border">
      <cfloop array="#rc.navigation[ 2 ]#" index="item">
        <cfset menuItem = util.variableFormat( item ) />
        <a class="colored-text#menuItem eq rc.currentMenuItem ? ' active' : ''#" href="#rc.basePath##rc.navPath#/#menuItem#">#item#</a>
      </cfloop>
      <div class="clearfix"></div>
    </nav>
  </cfif>
</cfoutput>