<cfoutput>
  <cfif not arrayIsDefined( rc.navigation, 2 )>
    <nav class="languages">
      <a href="/uk"#rc.basePath eq "/uk" ? ' class="active"' : ''#>ENG</a>
      <a href="/"#rc.basePath eq "" ? ' class="active"' : ''#>NL</a>
    </nav>
  </cfif>
</cfoutput>