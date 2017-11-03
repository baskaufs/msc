(: this module needs to be put in the webapp folder of your BaseX installation.  On my computer it's at c:\Program Files (x86)\BaseX\webapp\ :)

(: to test, send an HTTP GET to localhost:8984/Longxingsi using cURL, Postman, etc. :)

xquery version "3.1";

module namespace page = 'http://basex.org/modules/web-page';
import module namespace html = 'http://example.org/html' at 'https://raw.githubusercontent.com/baskaufs/msc/master/basexhttp/html.xqm';
(: import module namespace html = 'http://example.org/html' at './html.xqm'; :)

declare
  %rest:path("/{$string}")
  function page:home($string)
  {
  html:generate-webpage($string)
  };
