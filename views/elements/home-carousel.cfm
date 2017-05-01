<cfoutput>
  <cfif not arrayIsEmpty( rc.backGroundImages )>
    <cfset local.responsiveConfig = {
      "s" = 300,
      "m" = 480,
      "l" = 768,
      "x" = 1024
    } />

    <div id="carousel" data-length="#arrayLen( rc.backGroundImages )#">
      <div></div>
    </div>

    <style>
      <cfloop collection="#local.responsiveConfig#" item="key">
        body::after{
          position:absolute; width:0; height:0; overflow:hidden; z-index:-1;
        }

        @media only screen and (min-width: #local.responsiveConfig[ key ]#px) {
          <cfset i = 0 />
          <cfloop array="#rc.backGroundImages#" index="image">
            <cfset i++ />
            ##carousel .responsive-image-#i# { background-image: url( /media/#image.src#?s=#key# ); }
          </cfloop>
          body::after{
            content:<cfloop array="#rc.backGroundImages#" index="image"> url( /media/#image.src#?s=#key# )</cfloop>;
          }
        }
      </cfloop>
    </style>
  </cfif>
</cfoutput>