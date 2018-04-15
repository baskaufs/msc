xquery version "3.1";

declare namespace rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace rdfs = "http://www.w3.org/2000/01/rdf-schema#";
declare namespace foaf = "http://xmlns.com/foaf/0.1/";
declare namespace schema = "http://schema.org/";
declare namespace dc = "http://purl.org/dc/elements/1.1/";
declare namespace dcterms = "http://purl.org/dc/terms/";
declare namespace xmp = "http://ns.adobe.com/xap/1.0/";
declare namespace ac = "http://rs.tdwg.org/ac/terms/";
declare namespace xmpRights = "http://ns.adobe.com/xap/1.0/rights/";
declare namespace cc = "http://creativecommons.org/ns#";
declare namespace xhv = "http://www.w3.org/1999/xhtml/vocab#";
declare namespace blocal = "http://bioimages.vanderbilt.edu/rdf/local#";
declare namespace geo = "http://www.w3.org/2003/01/geo/wgs84_pos#";
declare namespace dwc = "http://rs.tdwg.org/dwc/terms/";
declare namespace dsw = "http://purl.org/dsw/";
declare namespace dwciri = "http://rs.tdwg.org/dwc/iri/";
declare namespace exif = "http://ns.adobe.com/exif/1.0/";

declare function local:calculate-shrink($height as xs:integer, $width as xs:integer, $size as xs:integer) as xs:decimal
{
let $whRatio := $width div $height
let $imageMax := if ($whRatio > 1)then ($width) else ($height)
return if ($imageMax < $size)
      then 1
      else $size div $imageMax
};

declare function local:clean-meters($input)
{
(: for whatever reason, there are sometimes multiple elements :)
let $string := $input[1]/text()
(: only want integer part :)
return tokenize($string,"[A-z,\.]")[1] (: got this idea from functx:substring-before-match :)
};

declare function local:get-country-code($input)
{
let $string := $input[1]/text()
return switch($string)
case "andorra" return "AD"
case "argentina" return "AR"
case "armenia" return "AM"
case "australia" return "AU"
case "australiaacanthorhynchustenuirostris" return "AU"
case "australiaartamussuperciliosus" return "AU"
case "australiacollectingeventvaliddistributionflagfalse" return "AU"
case "australiageoalt104" return "AU"
case "australis" return "AU"
case "austria" return "AT"
case "austrla" return "AT"
case "belgium" return "BE"
case "belize" return "BZ"
case "bolivia" return "BO"
case "botswana" return "BW"
case "brazil" return "BR"
case "brazilgeoregionsouth" return "BR"
case "canada" return "CA"
case "chile" return "CL"
case "china" return "CN"
case "costa" return "CR"
case "costarica" return "CR"
case "cuba" return "CU"
case "czechoslovakia" return "CSK"
case "czechrepublic" return "CZ"
case "denmark" return "DK"
case "ecuador" return "EC"
case "england" return "GB"
case "fiji" return "FJ"
case "finland" return "FI"
case "france" return "FR"
case "francen" return "FR"
case "frenchpolynesia" return "PF"
case "georgia" return "GE"
case "germany" return "DE"
case "guatemala" return "GT"
case "honduras" return "HN"
case "india" return "IN"
case "indonesia" return "ID"
case "italy" return "IT"
case "jamaica" return "JM"
case "lichtenstein" return "LI"
case "madagascar" return "MG"
case "malaysia" return "MY"
case "mexico" return "MX"
case "mexicoprickly" return "MX"
case "monaco" return "MC"
case "morocco" return "MA"
case "newguinea" return "PG"
case "newzealand" return "NZ"
case "norway" return "NO"
case "panama" return "PA"
case "papuanewguinea" return "PG"
case "peru" return "PE"
case "portugal" return "PT"
case "republicofgeorgia" return "GE"
case "republicofsanmarino" return "SM"
case "russia" return "RU"
case "scotland" return "GB"
case "singapore" return "SG"
case "somalia" return "SO"
case "southafrica" return "ZA"
case "spain" return "ES"
case "srilanka" return "LK"
case "sweden" return "SE"
case "switzerland" return "CH"
case "taiwan" return "TW"
case "thailand" return "TH"
case "thenetherlands" return "NL"
case "uk" return "GB"
case "unitedstatesamerica" return "US"
case "unitedstatesofamercial" return "US"
case "unitedstatesofamerica" return "US"
case "uzbekistan" return "UZ"
case "vanuatu" return "VU"
case "vaticancity" return "VA"
default return ""
};

let $photos := fn:collection('chapman')/photos/photo
return 

(file:write("c:\test\flickr\images.rdf",

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"  xmlns:rdfs = "http://www.w3.org/2000/01/rdf-schema#" xmlns:foaf = "http://xmlns.com/foaf/0.1/" xmlns:schema = "http://schema.org/" xmlns:dc = "http://purl.org/dc/elements/1.1/" xmlns:dcterms = "http://purl.org/dc/terms/" xmlns:xmp = "http://ns.adobe.com/xap/1.0/" xmlns:ac = "http://rs.tdwg.org/ac/terms/" xmlns:xmpRights = "http://ns.adobe.com/xap/1.0/rights/" xmlns:cc = "http://creativecommons.org/ns#" xmlns:xhv = "http://www.w3.org/1999/xhtml/vocab#" xmlns:blocal = "http://bioimages.vanderbilt.edu/rdf/local#" xmlns:geo = "http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:dwc = "http://rs.tdwg.org/dwc/terms/" xmlns:dsw = "http://purl.org/dsw/" xmlns:dwciri = "http://rs.tdwg.org/dwc/iri/" xmlns:exif = "http://ns.adobe.com/exif/1.0/">{
    for $photo in $photos
    where $photo/taxonomy/node() (: include only photos with non-empty taxonomy nodes, i.e. photos of identified organisms :)
    (:let $photo := $photos[6]  :)
    let $photoUri := 'https://www.flickr.com/photos/arthur_chapman/'||$photo/id/text()
    let $licenseUri := 
        if ($photo/license/text()="1")
        then "http://creativecommons.org/licenses/by-nc-sa/2.0/"
        else if ($photo/license/text()="2")
        then "http://creativecommons.org/licenses/by-nc/2.0/"
        else "none"
    let $licenseStatement := 
        if ($photo/license/text()="1")
        then "Available under a Creative Commons Attribution-NonCommercial-ShareAlike 2.0 Generic license."
        else if ($photo/license/text()="2")
        then "Available under a Creative Commons Attribution-NonCommercial 2.0 Generic license"
        else ()
    let $licenseButton := 
        if ($photo/license/text()="1")
        then "https://licensebuttons.net/l/by-nc-sa/2.0/88x31.png"
        else if ($photo/license/text()="2")
        then "https://licensebuttons.net/l/by-nc/2.0/88x31.png"
        else ()
    let $georeferenceRemarks :=
        if ($photo/method/text()="gps")
        then "Location determined by GPS."
        else if ($photo/method/text()="googleearth")
        then "Location determined from Google Earth."
        else ()
    let $baseAccessUri := substring($photo/thumbUrl/text(),1,string-length($photo/thumbUrl/text())-6)
    let $format :=
        if ($photo/format/text()="jpg")
        then "image/jpeg"
        else if ($photo/format/text()="png")
        then "image/png"
        else ()
    let $uuid := "U"||random:uuid()
    let $occurrenceUuid := "U"||random:uuid()
    let $eventUuid := "U"||random:uuid()
    let $countryCode := local:get-country-code($photo/country)
    let $x := $photo/originalWidth/text()
    let $y := $photo/originalHeight/text()
    (: dc:rights should have a year :)
    return (

       <rdf:Description rdf:about="{$photoUri}">
           {if ($photo/media/text()="video")
           then (
             <rdf:type rdf:resource="http://purl.org/dc/dcmitype/MovingImage" />,
             <dc:type>MovingImage</dc:type>             
           ) else (
             <rdf:type rdf:resource="http://purl.org/dc/dcmitype/StillImage" />,
             <dc:type>StillImage</dc:type>
           )          
           }
           <dcterms:identifier>{$photo/id/text()}</dcterms:identifier>
           <xmp:metadatadate rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">2018-04-12T21:17:00-05:00</xmp:metadatadate>
           <dc:creator>Arthur Chapman</dc:creator>
           <dcterms:creator rdf:resource="http://viaf.org/viaf/93519663" />
           <dcterms:created>{$photo/dateTaken/text()}</dcterms:created>
           <ac:providerLiteral>Flickr</ac:providerLiteral>
           <dc:rights xml:lang="en">(c) Arthur D. Chapman</dc:rights>
           <xmpRights:owner>Arthur D. Chapman</xmpRights:owner>
           {
           if ($licenseUri!="none")
           then (
           <cc:license rdf:resource="{$licenseUri}"/>,
           <xhv:license rdf:resource="{$licenseUri}"/>,
           <dcterms:license rdf:resource="{$licenseUri}"/>,
           <xmpRights:UsageTerms>{$licenseStatement}</xmpRights:UsageTerms>,
           <xmpRights:WebStatement>{$licenseUri}</xmpRights:WebStatement>,
           <ac:licenseLogoURL>{$licenseButton}</ac:licenseLogoURL>
           )
           else ()
           }
           <dcterms:title>{$photo/title/text()}</dcterms:title>
           <dcterms:description>{$photo/description/text()}</dcterms:description>
          {
          for $tag in $photo/tags/tag
          return <ac:tag>{$tag/text()}</ac:tag>
          }
           <blocal:contactURL>http://www.anbg.gov.au/biography/chapman-arthur-david.html</blocal:contactURL>
           <geo:lat>{$photo/latitude/text()}</geo:lat>
           <geo:long>{$photo/longitude/text()}</geo:long>
           <dwc:coordinateUncertaintyInMeters>{substring-before($photo/accuracy[1]/text(),"meters")}</dwc:coordinateUncertaintyInMeters>
           <dwc:georeferenceRemarks>{$georeferenceRemarks}</dwc:georeferenceRemarks>
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#bq"/>
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#tn"/>
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#lq"/>
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#gq"/>
           {
           if ($photo/media/text()="video")
           then <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#video"/>
           else ()
           }
           <foaf:depicts rdf:nodeID="{$uuid}"/>
           <dsw:derivedFrom rdf:nodeID="{$uuid}"/>
       </rdf:Description>,

       <rdf:Description rdf:nodeID="{$uuid}">
          <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Organism"/>
          <rdf:type rdf:resource="http://purl.org/dc/terms/PhysicalResource"/>
          <foaf:depiction rdf:resource="{$photoUri}"/>
          {
           if (exists($photo/validDistribution))
           then if ($photo/validDistribution[1]/text()="false")
                 then <dwc:establishmentMeans>managed</dwc:establishmentMeans>
                 else ()
           else ()
         }
         {
           if (exists($photo/conservationStatus))
           then if ($photo/conservationStatus[1]/text()="extinct")
                 then <dwc:occurrenceStatus>extinct</dwc:occurrenceStatus>
                 else()
           else ()
         }
          <dsw:hasDerivative rdf:resource="{$photoUri}"/>
          <dsw:hasOccurrence>
            <rdf:Description rdf:nodeID="{$occurrenceUuid}">
              <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Occurrence"/>
              <dsw:occurrenceOf rdf:nodeID="{$uuid}"/>
              <dwciri:recordedBy rdf:resource="http://viaf.org/viaf/93519663"/>
              <dwc:recordedBy>Arthur Chapman</dwc:recordedBy>
              <dsw:hasEvidence rdf:resource="{$photoUri}"/>
              <dsw:atEvent>
                <rdf:Description rdf:nodeID="{$eventUuid}">
                  <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Event"/>
                  <dwc:eventDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">{substring($photo/dateTaken/text(),1,10)}</dwc:eventDate>
                  <dsw:eventOf rdf:nodeID="{$occurrenceUuid}"/>
                  <dsw:locatedAt>
                    <rdf:Description>
                       <rdf:type rdf:resource="http://purl.org/dc/terms/Location"/>
                       <dsw:locates rdf:nodeID="{$eventUuid}"/>
                       <dwc:countryCode>{$countryCode}</dwc:countryCode>
                       <geo:lat>{$photo/latitude/text()}</geo:lat>
                       <dwc:decimalLatitude rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">{$photo/latitude/text()}</dwc:decimalLatitude>
                       <geo:long>{$photo/longitude/text()}</geo:long>
                       <dwc:decimalLongitude rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">{$photo/longitude/text()}</dwc:decimalLongitude>
                       <dwc:coordinateUncertaintyInMeters>{local:clean-meters($photo/accuracy)}</dwc:coordinateUncertaintyInMeters>
                       <dwc:geodeticDatum>EPSG:4326</dwc:geodeticDatum>
                       <geo:alt>{local:clean-meters($photo/alt)}</geo:alt>
                       <dwc:minimumElevationInMeters rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{local:clean-meters($photo/alt)}</dwc:minimumElevationInMeters>
                       <dwc:maximumElevationInMeters rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{local:clean-meters($photo/alt)}</dwc:maximumElevationInMeters>
                       <dwc:georeferenceRemarks>{$georeferenceRemarks}</dwc:georeferenceRemarks>
                     </rdf:Description>
                  </dsw:locatedAt>
                </rdf:Description>
                </dsw:atEvent>
            </rdf:Description>
          </dsw:hasOccurrence>
          <dsw:hasIdentification>
            <rdf:Description>
              <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Identification"/>
              <dsw:identifies  rdf:nodeID="{$uuid}"/>
              <dwc:kingdom>{$photo/taxonomy/kingdom/text()}</dwc:kingdom>
              <dwc:phylum>{$photo/taxonomy/phylum/text()}</dwc:phylum>
              <dwc:class>{$photo/taxonomy/class/text()}</dwc:class>
              <dwc:order>{$photo/taxonomy/order/text()}</dwc:order>
              <dwc:family>{$photo/taxonomy/family/text()}</dwc:family>
              <dwc:genus>{$photo/taxonomy/genus/text()}</dwc:genus>
              <dwc:specificEpithet>{$photo/taxonomy/specificEpithet/text()}</dwc:specificEpithet>
              <dwc:infraspecificEpithet>{$photo/taxonomy/infraspecificEpithet/text()}</dwc:infraspecificEpithet>
              {
              for $common in $photo/taxonomy/common
              return <dwc:vernacularName>{$common/text()}</dwc:vernacularName>
              }
            </rdf:Description>
          </dsw:hasIdentification>
       </rdf:Description>,

       <rdf:Description rdf:about="{$photoUri}#tn">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Thumbnail</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/Thumbnail"/>
         <ac:accessURI rdf:resource="{$baseAccessUri||"_t.jpg"}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/thumbWidth/text()}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/thumbHeight/text()}</exif:PixelYDimension>
         <dc:format>image/jpeg</dc:format>
       </rdf:Description>,

       <rdf:Description rdf:about="{$photoUri}#lq">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Lower Quality</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/LowerQuality"/>
         <ac:accessURI rdf:resource="{$baseAccessUri||".jpg"}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{round($x*local:calculate-shrink($x, $y, 500))}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{round($y*local:calculate-shrink($x, $y, 500))}</exif:PixelYDimension>
         <dc:format>image/jpeg</dc:format>
       </rdf:Description>,

       <rdf:Description rdf:about="{$photoUri}#gq">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Good Quality</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/GoodQuality"/>
         <ac:accessURI rdf:resource="{$baseAccessUri||"_b.jpg"}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{round($x*local:calculate-shrink($x, $y, 1024))}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{round($y*local:calculate-shrink($x, $y, 1024))}</exif:PixelYDimension>
         <dc:format>image/jpeg</dc:format>
       </rdf:Description>,

       <rdf:Description rdf:about="{$photoUri}#bq">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Best Quality</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/BestQuality"/>
         <ac:accessURI rdf:resource="{$photo/originalUrl/text()}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$x}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$y}</exif:PixelYDimension>
         <dc:format>{$format}</dc:format>
       </rdf:Description>,

if ($photo/media/text()="video")
then
       <rdf:Description rdf:about="{$photoUri}#video">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Good Quality</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/GoodQuality"/>
         <ac:accessURI rdf:resource="https://www.flickr.com/video_download.gne?id={$photo/id/text()}"/>
         <dc:format>video/mp4</dc:format>
       </rdf:Description>
else ()

    )
}</rdf:RDF>

))
