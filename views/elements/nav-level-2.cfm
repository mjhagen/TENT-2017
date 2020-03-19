<cfoutput>
  <cfif structKeyExists( rc, "pagination" )>
    #view( "elements/nav-pagination" )#
  <cfelseif rc.alt_navigation.isDefined( 2 ) and rc.navPath.isDefined( 2 )>
    <nav class="level-2 colored-border"><ul>
      <cfloop array="#rc.alt_navigation[ 2 ]#" index="menuItem">
        <cfif menuItem.keyExists( 'teaserImage' )>
          <cfset css = ' style="background-image:url(/media/#menuItem?.teaserImage.src#?s=s)"' />
        <cfelse>
          <cfset css = '' />
        </cfif>
        <li#css#><a
            class="colored-text#menuItem.formatted eq rc.currentMenuItem ? ' active' : ''#"
            href="#rc.basePath##rc.navPath[ 2 ]#/#menuItem.formatted#">#menuItem.name#</a></li>
      </cfloop>
    </ul></nav>
  </cfif>
</cfoutput>