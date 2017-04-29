<cfoutput>
  <cfif not isNull( rc.articles )>
    <div class="articles">
      <cfloop array="#rc.articles#" index="article">
        #article.body#
      </cfloop>
    </div>
  </cfif>
</cfoutput>