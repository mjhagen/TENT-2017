<cfif isNull( rc.articles ) or arrayIsEmpty( rc.articles )>
  <cfexit />
</cfif>

<cfset rc.stylesheet = "/inc/css/templates/article.css" />

<cfoutput>
  <div class="grip">
    <cfloop array="#rc.articles#" index="article">
      <div class="article">
        <cfif not arrayIsEmpty( article.images )>
          <cfset image = article.images[ 1 ] />
          <picture>
            <source srcset="/media/#image.src#?s=s" media="(max-width: 500px)">
            <source srcset="/media/#image.src#?s=m" media="(max-width: 1000px)">
            <source srcset="/media/#image.src#?s=l" media="(max-width: 1500px)">
            <source srcset="/media/#image.src#?s=x" media="(min-width: 1501px)">
            <img srcset="/media/#image.src#?s=m" alt="#image.alt#">
          </picture>
        </cfif>
        <div>#article.body#</div>
      </div>
    </cfloop>
  </div>
</cfoutput>