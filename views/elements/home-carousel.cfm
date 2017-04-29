<cfoutput>
  <cfif not arrayIsEmpty( rc.backGroundImages )>
    <div id="carousel" data-length="#arrayLen( rc.backGroundImages )#">
      <div></div>
    </div>

    <style>
      @media only screen and (min-width: 300px) {
        <cfset i = 0 />
        <cfloop array="#rc.backGroundImages#" index="image">
          <cfset i++ />
          ##carousel .responsive-image-#i# { background-image: url( /media/#listLast( image.src, '/' )#?s=s ); }
        </cfloop>
      }
      @media only screen and (min-width: 480px) {
        <cfset i = 0 />
        <cfloop array="#rc.backGroundImages#" index="image">
          <cfset i++ />
          ##carousel .responsive-image-#i# { background-image: url( /media/#listLast( image.src, '/' )#?s=m ); }
        </cfloop>
      }
      @media only screen and (min-width: 768px) {
        <cfset i = 0 />
        <cfloop array="#rc.backGroundImages#" index="image">
          <cfset i++ />
          ##carousel .responsive-image-#i# { background-image: url( /media/#listLast( image.src, '/' )#?s=l ); }
        </cfloop>
      }
      @media only screen and (min-width: 1024px) {
        <cfset i = 0 />
        <cfloop array="#rc.backGroundImages#" index="image">
          <cfset i++ />
          ##carousel .responsive-image-#i# { background-image: url( /media/#listLast( image.src, '/' )#?s=x ); }
        </cfloop>
      }
    </style>
  </cfif>
</cfoutput>