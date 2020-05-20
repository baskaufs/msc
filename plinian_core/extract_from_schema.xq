xquery version "3.1";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
let $url := 'https://github.com/tdwg/PlinianCore/raw/master/xsd/abstract%20models/stable%20version/PlinianCore_AbstractModel_v3.2.2.xsd'
let $pcam_xsd := fn:doc($url)
let $elements := $pcam_xsd/xs:schema/xs:element
return(file:write("Documents/GitHub/msc/plinian_core/output.csv", 

  for $element in $elements
  return string($element/@name)||",&quot;"||$element/xs:annotation/xs:documentation/text()||"&quot;&#10;"
))