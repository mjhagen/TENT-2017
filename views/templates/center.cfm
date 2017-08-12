<cfif isNull( rc.articles ) or arrayIsEmpty( rc.articles )>
  <cfexit />
</cfif>

<cfset rc.stylesheet = "/inc/css/templates/center.css" />
<cfset local.article = rc.articles[ 1 ] />

<cfoutput>
  <div class="article">
    #local.article.body#
    <cfif not arrayIsEmpty( local.article.images )>
      <cfset local.image = local.article.images[ 1 ] />
      <picture>
        <source srcset="/media/#local.image.src#?s=s" media="(max-width: 500px)">
        <source srcset="/media/#local.image.src#?s=m" media="(max-width: 1000px)">
        <source srcset="/media/#local.image.src#?s=l" media="(max-width: 1500px)">
        <source srcset="/media/#local.image.src#?s=x" media="(min-width: 1501px)">
        <img srcset="/media/#local.image.src#?s=m" alt="#local.image.alt#">
      </picture>
    </cfif>
  </div>
</cfoutput>