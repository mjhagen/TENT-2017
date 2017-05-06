<cfif isNull( rc.articles ) or arrayIsEmpty( rc.articles )>
  <cfexit />
</cfif>

<cfset rc.stylesheet = "/inc/css/templates/list.css" />
<cfset local.article = rc.articles[ 1 ] />
<cfset arrayDeleteAt( rc.mediaQueries, arrayLen( rc.mediaQueries ) ) /><!--- remove high res image --->

<cfoutput>
  <div class="articles">
    <cfloop array="#rc.articles#" index="local.article">
      <div class="article">
        <cfif not arrayIsEmpty( local.article.images )>
          <div class="images">
            <cfset local.image = local.article.images[ 1 ] />
            <div class="image" id="image-#local.article.articleId#-001"></div>
            <style>
              <cfloop array="#rc.mediaQueries#" index="local.viewPort">@media only screen and (min-width: #local.viewPort.width#px) { ##image-#local.article.articleId#-001 { background-image: url( /media/#local.image.src#?s=#local.viewPort.size# ); } }
              </cfloop>
            </style>
          </div>
        </cfif>
        <div class="text">
          #local.article.body#
        </div>
      </div>
    </cfloop>
  </div>
</cfoutput>