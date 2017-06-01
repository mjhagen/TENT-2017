<cfoutput>
  <div id="calendar">
    <cfif structKeyExists( rc, "years" )>
      <nav>
        <ul>
          <li><a href="?year=0"#rc.year eq 0?' class="active"':''#>#i18n.translate( 'upcoming' )#</a></li>
          <cfloop from="#rc.years[ 1 ]#" to="#rc.years[ 2 ]#" index="yr" step="-1">
            <li> | <a#rc.year eq yr?' class="active"':''# href="?year=#yr#">#yr#</a></li>
          </cfloop>
        </ul>
      </nav>
    </cfif>

    <table cellpadding="0" cellspacing="0">
      <thead>
        <tr>
          <th width="20%">#i18n.translate( 'title' )#</th>
          <th width="40%">#i18n.translate( 'where' )#</th>
          <th width="15%">#i18n.translate( 'when' )#</th>
          <th width="15%">#i18n.translate( 'time' )#</th>
          <th width="10%">#i18n.translate( 'info' )#</th>
        </tr>
      </thead>
      <tbody>
        <cfloop query="rc.calendar">
          <tr>
            <td nowrap="nowrap">#title#</td>
            <td nowrap="nowrap">#where#</td>
            <td>#lsDateFormat( start, i18n.translate( 'date-format' ) )#</td>
            <cfif timeFormat( start, i18n.translate( 'time-format' ) ) eq "00:00" and timeFormat( end, i18n.translate( 'time-format' ) ) eq "00:00">
              <td></td>
            <cfelse>
              <td nowrap="nowrap">#timeFormat( start, i18n.translate( 'time-format' ) )# - #timeFormat( end, i18n.translate( 'time-format' ) )#</td>
            </cfif>
            <td>#util.activateURL( input = link, replaceWith = i18n.translate( 'info' ), target = "_blank" )#</td>
          </tr>
          <cfif dateDiff( 'd', start, end ) gt 0>
            <cfset index = 0 />
            <cfloop from="#dateFormat( start, 'yyyymmdd' )+1#" to="#dateFormat( end, 'yyyymmdd' )#" index="i">
              <cfset localData = {
                title = title,
                where = where,
                start = dateAdd( 'd', ++index, start ),
                end = end,
                link = link
              } />
              <tr>
                <td>#localData.title#</td>
                <td>#localData.where#</td>
                <td>#lsDateFormat( localData.start, i18n.translate( 'date-format' ) )#</td>
                <cfif timeFormat( localData.start, i18n.translate( 'time-format' ) ) eq "00:00" and timeFormat( localData.end, i18n.translate( 'time-format' ) ) eq "00:00">
                  <td></td>
                <cfelse>
                  <td nowrap="nowrap">#timeFormat( localData.start, i18n.translate( 'time-format' ) )# - #timeFormat( localData.end, i18n.translate( 'time-format' ) )#</td>
                </cfif>
                <td>#util.activateURL( input = localData.link, replaceWith = i18n.translate( 'info' ), target = "_blank" )#</td>
              </tr>
            </cfloop>
          </cfif>
        </cfloop>
      </tbody>
    </table>
  </div>
</cfoutput>