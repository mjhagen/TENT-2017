<cfoutput>
  <section id="home-calendar">
    <h3>#i18n.translate( 'coming-soon' )#</h3>

    <cfloop query="rc.calendar">
      <div>
        <cfif len( attachments )>
          <cfloop list="#attachments#" index="attachment">
            <cfif util.fileExistsUsingCache( "#root#/www/inc/img/resized/medium-#attachment#" )>
              <img src="/inc/img/resized/medium-#attachment#" />
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
          <cfif dateDiff( 'd', start, end ) lte 1>
            <time>#lsDateFormat( start, 'd/m/yyyy' )#</time>
          <cfelse>
            <time>#lsDateFormat( start, 'd/m' )#</time> t/m <time>#lsDateFormat( end, 'd/m' )#</time>
          </cfif>
          | <time>#lsTimeFormat( start, 'HH:mm' )# - #lsTimeFormat( end, 'HH:mm' )# U</time>
        </p>
      </div>
    </cfloop>

    <a href="/_calendar">#i18n.translate( 'show-more' )#</a>
  </section>
</cfoutput>