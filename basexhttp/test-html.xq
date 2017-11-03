xquery version "3.1";

import module namespace html = 'http://example.org/html' at './html.xqm';
(: import module namespace html = 'http://example.org/html' at 'https://raw.githubusercontent.com/baskaufs/msc/master/basexhttp/html.xqm';
 :)

let $topic := "nothing"
return html:generate-webpage($topic)


