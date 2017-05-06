<cfoutput>
  <section id="home-calendar">
    <h3>#i18n.translate( 'coming-soon' )#</h3>

    <cfloop query="rc.calendar">
      <div>
        <cfif len( attachments )>
          <cfloop list="#attachments#" index="attachment">
            <cfif util.fileExistsUsingCache( "#root#/www/inc/img/resized/m-#attachment#" )>
              <img src="/inc/img/resized/m-#attachment#" />
            <cfelse>
              <!-- MISSING: #root#/www/inc/img/resized/#attachment# -->
            </cfif>
          </cfloop>
        </cfif>

        <cfif len( link ) and isValid( "url", link )>
          <h4><a href="#left( link, 4 ) eq 'http' ? '' : 'http://'##link#" target="_blank">#title#</a></h4>
        <cfelse>
          <h4>#title#</h4>
        </cfif>

        <p>#where#</p>

        <p>
          <cfif dateDiff( 'd', start, end ) lt 1>
            <time>#lsDateFormat( start, 'd/m/yyyy' )#</time>
          <cfelse>
            <time>#lsDateFormat( start, 'd/m' )#</time> t/m <time>#lsDateFormat( end, 'd/m' )#</time>
          </cfif>
          <cfif timeFormat( start, 'HHmm' ) neq timeFormat( end, 'HHmm' )>
            | <time>#lsTimeFormat( start, 'HH:mm' )# - #lsTimeFormat( end, 'HH:mm' )# U</time>
          </cfif>
        </p>
      </div>
    </cfloop>

    <h3><a href="/calendar">#i18n.translate( 'show-more' )#</a></h3>
  </section>
</cfoutput>