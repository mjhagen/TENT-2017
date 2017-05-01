<cfif isNull( rc.articles ) or arrayIsEmpty( rc.articles )>
  <cfexit />
</cfif>

<cfset rc.stylesheet = "/inc/css/templates/article.css" />
<cfset local.article = rc.articles[ 1 ] />

<cfoutput>
  <div class="articles">
    <cfloop array="#rc.articles#" index="local.article">
      <cfloop array="#local.article.images#" index="local.image">
        <picture>
          <source srcset="/media/#local.image.src#?s=s" media="(max-width: 500px)">
          <source srcset="/media/#local.image.src#?s=m" media="(max-width: 1000px)">
          <source srcset="/media/#local.image.src#?s=l" media="(max-width: 1500px)">
          <source srcset="/media/#local.image.src#?s=x" media="(min-width: 1501px)">
          <img srcset="/media/#local.image.src#?s=m" alt="#local.image.alt#">
        </picture>
      </cfloop>
      #local.article.body#
    </cfloop>
  </div>
</cfoutput>