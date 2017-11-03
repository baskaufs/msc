xquery version "3.1";

module namespace html = 'http://example.org/html';

declare function html:generate-webpage($topic as xs:string) as element()
{
<html>
  <head>{
    <meta charset="utf-8"/>,
    <title>{"Webpage about "||$topic}</title>
   }</head>
  <body>
    <p>{
    "This is the web page that I made about "||$topic
    }</p>
  </body>
</html>
};

