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


let $photos := fn:collection('chapman')/photos/photo
return 

(file:write("c:\test\flickr\images.rdf",

<rdf:RDF>{
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
    let $format :=
        if ($photo/format/text()="jpg")
        then "image/jpeg"
        else ()
    let $uuid := "U"||random:uuid()
    return (
       element rdf:Description { 
           attribute rdf:about {$photoUri},
           <rdf:type rdf:resource="http://purl.org/dc/dcmitype/StillImage" />,
           <dc:type>StillImage</dc:type>,
           <dcterms:identifier>{$photo/id/text()}</dcterms:identifier>, 
           <xmp:metadatadate rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">2018-04-12T21:17:00-05:00</xmp:metadatadate>,
           <dc:creator>Arthur Chapman</dc:creator>,
           <dcterms:creator rdf:resource="http://viaf.org/viaf/93519663" />,
           <dcterms:created>{$photo/dateTaken/text()}</dcterms:created>,
           <ac:providerLiteral>Flickr</ac:providerLiteral>,
           <dc:rights xml:lang="en">(c) Arthur D. Chapman</dc:rights>, (: should have a year here :)
           <xmpRights:owner>Arthur D. Chapman</xmpRights:owner>,
           
           if ($licenseUri!="none")
           then (
           <cc:license rdf:resource="{$licenseUri}"/>,
           <xhv:license rdf:resource="{$licenseUri}"/>,
           <dcterms:license rdf:resource="{$licenseUri}"/>,
           <xmpRights:UsageTerms>{$licenseStatement}</xmpRights:UsageTerms>,
           <xmpRights:WebStatement>{$licenseUri}</xmpRights:WebStatement>,
           <ac:licenseLogoURL>{$licenseButton}</ac:licenseLogoURL>
           )
           else (),
           
           <dcterms:title>{$photo/title/text()}</dcterms:title>,
           <dcterms:description>{$photo/description/text()}</dcterms:description>,
           <blocal:contactURL>http://www.anbg.gov.au/biography/chapman-arthur-david.html</blocal:contactURL>,
           <geo:lat>{$photo/latitude/text()}</geo:lat>,
           <geo:long>{$photo/longitude/text()}</geo:long>,
           <dwc:coordinateUncertaintyInMeters>{substring-before($photo/accuracy[1]/text(),"meters")}</dwc:coordinateUncertaintyInMeters>,
           <dwc:georeferenceRemarks>{$georeferenceRemarks}</dwc:georeferenceRemarks>,
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#bq"/>,
           <ac:hasServiceAccessPoint rdf:resource="{$photoUri}#tn"/>,
           <foaf:depicts rdf:nodeID="{$uuid}"/>,
           <dsw:derivedFrom rdf:nodeID="{$uuid}"/>
           },
       <rdf:Description rdf:nodeID="{$uuid}">
          <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Organism"/>
          <rdf:type rdf:resource="http://purl.org/dc/terms/PhysicalResource"/>
          <foaf:depiction rdf:resource="{$photoUri}"/>
          <dsw:hasDerivative rdf:resource="{$photoUri}"/>
          <dsw:hasOccurrence>
            <rdf:Description>
              <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Occurrence"/>
              <dsw:occurrenceOf rdf:nodeID="{$uuid}"/>
              <dwciri:recordedBy rdf:resource="http://viaf.org/viaf/93519663"/>
              <dwc:recordedBy>Arthur Chapman</dwc:recordedBy>
              <dsw:hasEvidence rdf:resource="{$photoUri}"/>
              <dsw:atEvent>
                <rdf:Description>
                  <rdf:type rdf:resource="http://rs.tdwg.org/dwc/terms/Event"/>
                  <dwc:eventDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">{substring($photo/dateTaken/text(),1,10)}</dwc:eventDate>
                  <dsw:locatedAt>
                    <rdf:Description>
                       <rdf:type rdf:resource="http://purl.org/dc/terms/Location"/>
                       <geo:lat>{$photo/latitude/text()}</geo:lat>
                       <dwc:decimalLatitude rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">{$photo/latitude/text()}</dwc:decimalLatitude>
                       <geo:long>{$photo/longitude/text()}</geo:long>
                       <dwc:decimalLongitude rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">{$photo/longitude/text()}</dwc:decimalLongitude>
                       <dwc:coordinateUncertaintyInMeters>{substring-before($photo/accuracy[1]/text(),"meters")}</dwc:coordinateUncertaintyInMeters>
                       <dwc:geodeticDatum>EPSG:4326</dwc:geodeticDatum>
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
         <ac:accessURI rdf:resource="{$photo/thumbUrl/text()}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/thumbWidth/text()}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/thumbHeight/text()}</exif:PixelYDimension>
         <dc:format>{$format}</dc:format>
       </rdf:Description>,
       <rdf:Description rdf:about="{$photoUri}#bq">
         <rdf:type rdf:resource="http://rs.tdwg.org/ac/terms/ServiceAccessPoint"/>
         <ac:variantLiteral>Best Quality</ac:variantLiteral>
         <ac:variant rdf:resource="http://rs.tdwg.org/ac/terms/BestQuality"/>
         <ac:accessURI rdf:resource="{$photo/originalUrl/text()}"/>
         <exif:PixelXDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/originalWidth/text()}</exif:PixelXDimension>
         <exif:PixelYDimension rdf:datatype="http://www.w3.org/2001/XMLSchema#int">{$photo/originalHeight/text()}</exif:PixelYDimension>
         <dc:format>{$format}</dc:format>
       </rdf:Description>

    )
}</rdf:RDF>

))
