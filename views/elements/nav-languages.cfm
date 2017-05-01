<cfoutput>
  <cfif not arrayIsDefined( rc.navigation, 2 )>
    <nav class="languages"><ul>
      <li><a href="/uk"#rc.basePath eq "/uk" ? ' class="active"' : ''#>ENG</a></li>
      <li><a href="/"#rc.basePath eq "" ? ' class="active"' : ''#>NL</a></li>
    </ul></nav>
  </cfif>
</cfoutput>