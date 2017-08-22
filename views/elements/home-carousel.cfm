<cfoutput>
  <cfif not arrayIsEmpty( rc.backGroundImages )>
    <cfset local.responsiveConfigs = [ { size = "s", width = 300 },
                                       { size = "m", width = 480 },
                                       { size = "l", width = 768 },
                                       { size = "x", width = 1024 } ] />

    <div id="carousel" data-length="#arrayLen( rc.backGroundImages )#">
      <div class="image"></div>
      <cfset i = 0 />
      <cfloop array="#rc.backGroundImages#" index="image">
        <div class="quotes colored-text quote-#++i#">
          <q>#image.alt#</q><br />
          <small class="author">#image.byline#</small>
        </div>
      </cfloop>
    </div>

    <style>
      body::after{ position:absolute; width:0; height:0; overflow:hidden; z-index:-1; }
      <cfloop array="#local.responsiveConfigs#" index="local.responsiveConfig">
        @media only screen and (min-width: #local.responsiveConfig.width#px) {
          <cfset i = 0 />
          <cfloop array="#rc.backGroundImages#" index="image">
            ##carousel .responsive-image-#++i# { background-image: url( /media/#image.src#?s=#local.responsiveConfig.size# ); }
          </cfloop>
          body::after{ content:<cfloop array="#rc.backGroundImages#" index="image"> url( /media/#image.src#?s=#local.responsiveConfig.size# )</cfloop>; }
        }
      </cfloop>
    </style>
  </cfif>
</cfoutput>