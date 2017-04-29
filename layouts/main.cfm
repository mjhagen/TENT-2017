<cfprocessingdirective pageEncoding="utf-8"><cfoutput><!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>#len( rc.pageTitle ) ? rc.pageTitle & ' - ' : ''#TENT</title>
    <link rel="stylesheet" type="text/css" href="/inc/css/main.css">
    <cfif util.fileExistsUsingCache( root & "/www/inc/css/" & getItem( ) & ".css" )><link rel="stylesheet" type="text/css" href="/inc/css/#getItem( )#.css"></cfif>
    <link rel="stylesheet" type="text/css" href="/inc/css/responsive.css">
  </head>
  <body class="#rc.currentBaseMenuItem#">
    <svg id="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 337.5 75">
      <title>#i18n.translate( 'tent-name' )#</title>
      <desc>TENT Logo</desc>
      <a xlink:href="/" target="_top">
        <path d="M0 25V0h25L0 25zm50 0V0H25l25 25zm25 0V0H50l25 25zM50 50V25H25l25
                 25zm0 25V50H25l25 25zm37.5-25h25v25l-25-25zm25-25h-25v25l25-25zm0-25h-25v25l25-25zm25
                 25h-25v25l25-25zm0-25h-25v25l25-25zm25 25V0h-25l25 25zm-25 25v25h-25l25-25zm25
                 0v25h-25l25-25zM250 25V0h-25l25 25zm0 25V25h-25l25 25zm0 25V50h-25l25
                 25zm-75-25v25h25l-25-25zm0-25v25h25l-25-25zm0-25v25h25L175 0zm25
                 25v25h25l-25-25zm137.5 0V0h-25l25 25zm-50 0V0h25l-25 25zm-25 0V0h25l-25
                 25zm25 25V25h25l-25 25zm0 25V50h25l-25 25z" fill="##fff" />
      </a>
    </svg>
    <div id="border" class="colored-border">
      #view( "elements/nav-level-1" )#
      #view( "elements/nav-contact" )#
      #view( "elements/nav-languages" )#
    </div>
    <div id="content">
      #view( "elements/nav-level-2" )#
      #view( "elements/content", { body = body } )#
    </div>
    <script>(function(d){var tkTimeout=3000;if(window.sessionStorage){if(sessionStorage.getItem('useTypekit')==='false'){tkTimeout=0;}}var config={kitId:'hgq8uwz',scriptTimeout: tkTimeout },h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";if(window.sessionStorage){sessionStorage.setItem("useTypekit","false")}},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)})(document);</script>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="/inc/js/main.js"></script>
    <cfif util.fileExistsUsingCache( root & "/www/inc/js/" & getItem( ) & ".js" )><script src="/inc/js/#getItem( )#.js"></script></cfif>
  </body>
</html></cfoutput>