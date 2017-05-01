<cfoutput>
  <section id="show-calendar">
    <h3>#i18n.translate( 'schedule' )#</h3>

    <cfloop query="rc.calendar">
      <div>
        <h4>#where#</h4>
        <p>
          <cfif dateDiff( 'd', start, end ) lte 1>
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

    <h3><a href="/_calendar">#i18n.translate( 'show-full-schedule' )#</a></h3>
  </section>
</cfoutput>