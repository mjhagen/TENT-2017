<cfif isNull( rc.articles ) or arrayLen( rc.articles ) lt 2>
  <cfexit />
</cfif>

<cfset rc.stylesheet = "/inc/css/templates/show.css" />

<cfoutput>
  <div class="article">
    <div class="images">
      <cfloop array="#rc.articles[ 1 ].images#" index="local.image">
        <cfif listFindNoCase( "jpg,gif,png,jpeg", listLast( local.image.src, "." ) )>
          <picture>
            <source srcset="/media/#local.image.src#?s=s" media="(max-width: 500px)">
            <source srcset="/media/#local.image.src#?s=m" media="(min-width: 501px)">
            <img srcset="/media/#local.image.src#?s=m" alt="#local.image.alt#">
          </picture>
        <cfelseif local.image.alt eq "video">
          <div class="videoWrapper">#local.image.other#</div>
        </cfif>
      </cfloop>
    </div>
    <div class="show">
      #rc.articles[ 1 ].body#
    </div>
    <div class="crew-calendar colored-text">
      <div class="crew">
        <h3>#i18n.translate( 'credit' )#</h3>
        #rc.articles[ 2 ].body#
      </div>
      <div class="calendar">
        #view( 'elements/show-calendar' )#
      </div>
    </div>
  </div>
</cfoutput>