| property | value |
|----------|-------|
| **Term Name:** | **ac:term_localName** |
| Normative URI: | http://rs.tdwg.org/ac/terms/term_localName |
| Label: | label |
| | **Layer:** tdwgutility_layer -- **Required:** tdwgutility_required -- **Repeatable:** tdwgutility_repeatable |
| Definition: | rdfs_comment |
| Notes: | dcterms_description |
| | |
| **Term Name:** | **ac:accessURI** |
| Normative URI: | http://rs.tdwg.org/ac/terms/accessURI |
| Label: | Access URI |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | A URI that uniquely identifies a service that provides a representation of the underlying resource. If this resource can be acquired by an http request, its http URL should be given. If not, but it has some URI in another URI scheme, that may be given here. |
| Notes: | Value might point to something offline, such as a published CD, etc. For example, the doi of an published CD would be a suitable value. |
| | |
| **Term Name:** | **ac:associatedObservationReference** |
| Normative URI: | http://rs.tdwg.org/ac/terms/associatedObservationReference |
| Label: | Associated Observation Reference |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | A reference to an observation associated with this resource. |
| Notes: |  |
| | |
| **Term Name:** | **ac:associatedSpecimenReference** |
| Normative URI: | http://rs.tdwg.org/ac/terms/associatedSpecimenReference |
| Label: | Associated Specimen Reference |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | A reference to a specimen associated with this resource. |
| Notes: | Supports finding a specimen resource, where additional information is available. If several resources relate to the same specimen, these are implicitly related. Examples: for NHM "BM 23974324" for a barcoded or "BM Smith 32" for a non-barcoded specimen; for UNITS: "TSB 28637"; for PMSL: "PMSL-Lepidoptera-2534781". Ideally this may be a URI identifying a specimen record that is available online. |
| | |
| **Term Name:** | **ac:attributionLinkURL** |
| Normative URI: | http://rs.tdwg.org/ac/terms/attributionLinkURL |
| Label: | Attribution Link URL |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | The URL where information about ownership, attribution, etc. of the resource may be found. |
| Notes: | This URL may be used in creating a clickable logo. Providers should consider making this link as specific and useful to consumers as possible, e. g., linking to a metadata page of the specific image resource rather than to a generic page describing the owner or provider of a resource. |
| | |
| **Term Name:** | **ac:attributionLogoURL** |
| Normative URI: | http://rs.tdwg.org/ac/terms/attributionLogoURL |
| Label: | Attribution URL |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | The URL of the icon or logo image to appear in source attribution. |
| Notes: | Entering this URL into a browser should only result in the icon (not in a webpage including the icon). |
| | |
| **Term Name:** | **ac:caption** |
| Normative URI: | http://rs.tdwg.org/ac/terms/caption |
| Label: | Caption |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | As alternative or in addition to description, a caption is free-form text to be displayed together with (rather than instead of) a resource that is suitable for captions (especially images). |
| Notes: | If both description and caption are present in the metadata, a description is typically displayed instead of the resource, a caption together with the resource. Often only one of description or caption is present; choose the term most appropriate for your metadata. |
| | |
| **Term Name:** | **ac:captureDevice** |
| Normative URI: | http://rs.tdwg.org/ac/terms/captureDevice |
| Label: | Capture Device |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | Free form text describing the device or devices used to create the resource. |
| Notes: | It is best practice to record the device; this may include a combination such as camera plus lens, or camera plus microscope. Examples: "Canon Supershot 2000", "Makroscan Scanner 2000", "Zeiss Axioscope with Camera IIIu", "SEM (Scanning Electron Microscope)". |
| | |
| **Term Name:** | **ac:commenter** |
| Normative URI: | http://rs.tdwg.org/ac/terms/commenter |
| Label: | Commenter |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | A URI denoting a person, using some controlled vocabulary such as FOAF. Implementers and communities of practice may produce restrictions or recommendations on the choice of vocabularies. |
| Notes: | See also Reviewer Comments for the distinction between Comments and Reviewer Comments. |
| | |
| **Term Name:** | **ac:commenterLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/commenterLiteral |
| Label: | Commenter |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | A name or the literal "anonymous" (= anonymously commented). |
| Notes: | See also Reviewer Comments for the distinction between Comments and Reviewer Comments. See also See also the entry for ac:commenter in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:comments** |
| Normative URI: | http://rs.tdwg.org/ac/terms/comments |
| Label: | Comments |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Any comment provided on the media resource, as free-form text. Best practice would also identify the commenter. |
| Notes: | Comments may refer to the resource itself (e. g., asserting a taxon name or location of a biological subject in an image), or to the relation between resource and associated metadata (e. g., asserting that the taxon name given in the metadata is wrong, without asserting a positive identification). There is a separate item for Reviewer Comments, which is defined more as an expert-level review.Implementers or communities of practice might establish conventions about the meaning of the absence of a commenter, but this specification is silent on that matter. |
| | |
| **Term Name:** | **ac:derivedFrom** |
| Normative URI: | http://rs.tdwg.org/ac/terms/derivedFrom |
| Label: | Derived From |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | A reference to an original resource from which the current one is derived. |
| Notes: | Derivation of one resource from another is of special interest for identification tools (e. g. a key from an unpublished data set, as in FRIDA, or a PDA key from a PC or web key) or web services (e. g. a name synonymization service being derived from a specific data set). It may very rarely also be known where one image or sound recording is derived from another (but compare the separate mechanism to be used for quality/resolution levels). – Human readable, or doi number, or URL. Simple name of parent for human readable. Can be repeated if a montage of images. |
| | |
| **Term Name:** | **ac:digitizationDate** |
| Normative URI: | http://rs.tdwg.org/ac/terms/digitizationDate |
| Label: | Date and Time Digitized |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | Date the first digital version was created, if different from Original Date and Time found in the Temporal Coverage Vocabulary. The date and time must comply with the World Wide Web Consortium (W3C) datetime practice, which requires that date and time representation correspond to ISO 8601:1998, but with year fields always comprising 4 digits. This makes datetime records compliant with 8601:2004. AC datetime values may also follow 8601:2004 for ranges by separating two IS0 8601 datetime fields by a solidus ("forward slash", '/'). See also the wikipedia IS0 8601 entry for further explanation and examples. |
| Notes: | This is often not the media creation or modification date. For example, if photographic prints have been scanned, the date of that scanning is what this term carries, but Original Date and Time is that depicted in the print. Use the international (ISO/xml) format yyyy-mm-ddThh:mm (e. g. "2007-12-31" or "2007-12-31T14:59"). Where available, timezone information should be added. In the case of digital images containing EXIF, whereas the EXIF capture date does not contain time zone information, but EXIF GPSDateStamp and GPSTimeStamp may be relevant as these include time-zone information. Compare also MWG (2010)[9], which has best practice advice on handling time-zone-less EXIF date/time data. See also the wikipedia IS0 8601 entry for further explanation and examples. |
| | |
| **Term Name:** | **ac:fundingAttribution** |
| Normative URI: | http://rs.tdwg.org/ac/terms/fundingAttribution |
| Label: | Funding |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Organizations or individuals who funded the creation of the resource. |
| Notes: |  |
| | |
| **Term Name:** | **ac:furtherInformationURL** |
| Normative URI: | http://rs.tdwg.org/ac/terms/furtherInformationURL |
| Label: | Further Information URL |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | The URL of a Web site that provides additional information about the version of the media resource that is provided by the Service Access Point. |
| Notes: |  |
| | |
| **Term Name:** | **ac:hashFunction** |
| Normative URI: | http://rs.tdwg.org/ac/terms/hashFunction |
| Label: | Hash Function |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | The cryptographic hash function used to compute the value given in the Hash Value. |
| Notes: | Recommended values include MD5, SHA-1, SHA-224,SHA-256, SHA-384, SHA-512, SHA-512/224 and SHA-512/256 |
| | |
| **Term Name:** | **ac:hashValue** |
| Normative URI: | http://rs.tdwg.org/ac/terms/hashValue |
| Label: | Hash |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | The value computed by a hash function applied to the media that will be delivered at the access point. |
| Notes: | Best practice is to also specify the hash function by supplying a value of the Hash Function term, using one of the standard literals from the Notes there. |
| | |
| **Term Name:** | **ac:hasServiceAccessPoint** |
| Normative URI: | http://rs.tdwg.org/ac/terms/hasServiceAccessPoint |
| Label: | Service Access Point |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | In a chosen serialization (RDF, XML Schema, etc.) the potentially multiple service access points (e.g., for different resolutions of an image) might be provided in a referenced or in a nested object. This property identifies one such access point. That is, each of potentially multiple values of hasServiceAccessPoint identifies a set of representation-dependent metadata using the properties defined under the section Service Access Point Vocabulary. |
| Notes: | Some serializations may flatten the model of service-access points by (a) dropping ac:hasServiceAccessPoint, ac:variant and ac:variantLiteral, (b) repeating properties from the Service Access Point Vocabulary and prefixing them with values of ac:variantLiteral. If such a flat serialization is necessary for services, we recommend to select from among term names of the form "AB" where "A" is one of thumbnail, trailer, lowerQuality, mediumQuality, goodQuality, bestQuality, offline and "B" is one of AccessURI, Format, Extent, FurtherInformationURL, LicensingException, ServiceExpectation (example: thumbnailAccessURI). Implementers in specific constraint languages such as XML Schema or RDF may wish to make Access URI and perhaps dcterms:format mandatory on instances of the service access point. |
| | |
| **Term Name:** | **ac:IDofContainingCollection** |
| Normative URI: | http://rs.tdwg.org/ac/terms/IDofContainingCollection |
| Label: | ID of Containing Collection |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | If the resource is contained in a Collection, this field identifies that Collection uniquely. Its form is not specified by this normative document, but is left to implementers of specific implementations. |
| Notes: | Repeatable: A media resource may be member of multiple collections |
| | |
| **Term Name:** | **ac:licenseLogoURL** |
| Normative URI: | http://rs.tdwg.org/ac/terms/licenseLogoURL |
| Label: | License Logo URL |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | A URL providing access to a logo that symbolizes the License. |
| Notes: | The originating metadata provider is strongly urged to choose a suitable logo as a graphical representation of the license. Failure to do so may leave downstream aggregators in a difficult position to supply a logo that adequately represents the professional, legal, or social aims of the licensors (license givers). Example: http://i.creativecommons.org/l/by-nc-sa/3.0/us/88x31.png provides access to a logo image. |
| | |
| **Term Name:** | **ac:licensingException** |
| Normative URI: | http://rs.tdwg.org/ac/terms/licensingException |
| Label: | Licensing Exception Statement |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | The licensing statement for this variant of the media resource if different from that given in the License Statement property of the resource. |
| Notes: | Required only if this version has different licensing than that of the media resource. For example, the highest resolution version may be more restricted than lower resolution versions. |
| | |
| **Term Name:** | **ac:metadataCreator** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataCreator |
| Label: | Metadata Creator |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Person or organization originally creating the resource metadata record. |
| Notes: | See also the entry for ac:metadataCreatorLiteral in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:metadataCreatorLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataCreatorLiteral |
| Label: | Metadata Creator |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Person or organization originally creating the resource metadata record. |
| Notes: | See also the entry for ac:metadataCreator in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:metadataLanguage** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataLanguage |
| Label: | Metadata Language |
| | **Layer:** 1 -- **Required:** Yes -- **Repeatable:** No |
| Definition: | URI from the ISO639-2 list of URIs for ISO 3-letter language codes. |
| Notes: | This is NOT dcterms:language, which is about the resource, not the metadata. Metadata Language is deliberately single-valued, imposing on unstructured serializations a requirement that multi-lingual metadata be represented as separate, complete, metadata records. Audubon Core requires that each record also contains the language-neutral terms. In the absence of this requirement, metadata consumers would need to know which terms are language-neutral and merge these terms from all provided metadataLanguages into a single record. Metadata consumers may re-combine the information based on the dcterms:identifier that identifies the multimedia resource. At least one of ac:metadataLanguage and ac:metadataLanguageLiteral must be supplied but, when feasible, supplying both may make the metadata more widely useful. They must specify the same language. In case of ambiguity, ac:metadataLanguage prevails. Nothing in this document would, however, prevent an implementer, e. g. of an XML-Schema representation, from providing a fully hierarchical schema in which language neutral terms occur only a single time, and only the language-specific terms are repeated in a way that unambigously relates them to a metadata language. In RDF it may be a simple repetition of plain literals associated with a language (e.g., xml:lang attribute in RDF/XML). The language attribute would then be required in Audubon Core and would replace ac:metadataLanguage. |
| | |
| **Term Name:** | **ac:metadataLanguageLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataLanguageLiteral |
| Label: | Metadata Language |
| | **Layer:** 1 -- **Required:** Yes -- **Repeatable:** No |
| Definition: | Language of description and other metadata (but not necessarily of the image itself) represented as an ISO639-2 three letter language code. ISO639-1 two-letter codes are permitted but deprecated. |
| Notes: | This is NOT dc:language, which is about the resource, not the metadata. Metadata Language is deliberately single-valued, imposing on unstructured serializations a requirement that multi-lingual metadata be represented as separate, complete, metadata records. Audubon Core requires that each record also contains the language-neutral terms. In the absence of this requirement, metadata consumers would need to know which terms are language-neutral and merge these terms from all provided metadataLanguages into a single record. Metadata consumers may re-combine the information based on the dcterms:identifier that identifies the multimedia resource. At least one of ac:metadataLanguage and ac:metadataLanguageLiteral must be supplied but, when feasible, supplying both may make the metadata more widely useful. They must specify the same language. In case of ambiguity, ac:metadataLanguage prevails. Nothing in this document would, however, prevent an implementer, e. g. of an XML-Schema representation, from providing a fully hierarchical schema in which language neutral terms occur only a single time, and only the language-specific terms are repeated in a way that unambigously relates them to a metadata language. In RDF it may be a simple repetition of plain literals associated with a language (e.g., xml:lang attribute in RDF/XML). The language attribute would then be required in Audubon Core and would replace ac:metadataLanguage. |
| | |
| **Term Name:** | **ac:metadataProvider** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataProvider |
| Label: | Metadata Provider |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | URI of person or organization originally responsible for providing the resource metadata record. |
| Notes: | Media resources and their metadata may be served from different institutions, e. g. in the case of aggregators adding user annotations, taxon identifications, or ratings. Compare Provider. See also the entry for ac:metadataProviderLiteral in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:metadataProviderLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/metadataProviderLiteral |
| Label: | Metadata Provider |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Person or organization originally responsible for providing the resource metadata record. |
| Notes: | Media resources and their metadata may be served from different institutions, e. g. in the case of aggregators adding user annotations, taxon identifications, or ratings. Compare Provider. See also the entry for ac:metadataProvider in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:otherScientificName** |
| Normative URI: | http://rs.tdwg.org/ac/terms/otherScientificName |
| Label: | Other Scientific Name |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | One or several Scientific Taxon Names that are synonyms to the Scientific Taxon Name may be provided here. |
| Notes: | The primary purpose of this is in support of resource discovery, not developing a taxonomic synonymy. Misidentification or misspellings may thus be of interest. Where multiple taxa are present in a resource and multiple Scientific Taxon Names are given, the association between synonyms and names may not be deducible from the AC record alone. |
| | |
| **Term Name:** | **ac:physicalSetting** |
| Normative URI: | http://rs.tdwg.org/ac/terms/physicalSetting |
| Label: | Physical Setting |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | The setting of the content represented in media such as images, sounds, and movies if the provider deems them relevant. Constrained vocabulary of: "Natural" = Object in its natural setting of the object (e. g. living organisms in their natural environment); "Artificial" = Object in an artificial environment (e. g. living organisms in an artificial environment such as a zoo, garden, greenhouse, or laboratory); "Edited" = Human media editing of a natural setting or media acquisition with a separate media background such as a photographic backdrop. |
| Notes: | Multiple values may be needed for movies or montages. See also ac:resourceCreationTechnique which should be used to describe any modifications to the resource itself. Communities of practice should form best practices for the use of these controlled terms. |
| | |
| **Term Name:** | **ac:provider** |
| Normative URI: | http://rs.tdwg.org/ac/terms/provider |
| Label: | Provider |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | URI for person or organization responsible for presenting the media resource. If no separate Metadata Provider is given, this also attributes the metadata. |
| Notes: | Media resources and their metadata may be served from different institutions, e. g. in the case of aggregators adding user annotations, taxon identifications, or ratings. See also the entry for ac:providerLiteral in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:providerID** |
| Normative URI: | http://rs.tdwg.org/ac/terms/providerID |
| Label: | Provider ID |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | A globally unique ID of the provider of the current AC metadata record. |
| Notes: | Only to be used if the annotated resource is not a provider itself - this item is for relating the resource to a provider, using an arbitrary code that is unique for a provider, contributing partner, or aggregator, or other roles (potentially defined by MARC, OAI) and by which the media resources are linked to the provider. |
| | |
| **Term Name:** | **ac:providerLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/providerLiteral |
| Label: | Provider |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | Person or organization responsible for presenting the media resource. If no separate Metadata Provider is given, this also attributes the metadata. |
| Notes: | Media resources and their metadata may be served from different institutions, e. g. in the case of aggregators adding user annotations, taxon identifications, or ratings. See also the entry for ac:provider in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:providerManagedID** |
| Normative URI: | http://rs.tdwg.org/ac/terms/providerManagedID |
| Label: | Provider-managed ID |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | A free-form identifier (a simple number, an alphanumeric code, a URL, etc.) that is unique and meaningful primarily for the data provider. |
| Notes: | Ideally, this would be a globally unique identifier (GUID), but the provider is encouraged to supply any form of identifier that simplifies communications on resources within their project and helps to locate individual data items in the provider's data repositories. It is the provider's decision whether to expose this value or not. |
| | |
| **Term Name:** | **ac:relatedResourceID** |
| Normative URI: | http://rs.tdwg.org/ac/terms/relatedResourceID |
| Label: | Related Resource ID |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Resource related in ways not specified through a collection, e.g., before-after images; time-lapse series; different orientations/angles of view |
| Notes: | The value references a related media item. Examples of relations are: Images taken in a sequence or defined time series, an exposure or focus series (e.g. for stacking), different framing or views (top, side, bottom) of the same subject, or an overview plus several details. The property makes such related media items discoverable, but does not indicate the nature of this relationship. More specific properties may be defined in a later version of AC. |
| | |
| **Term Name:** | **ac:resourceCreationTechnique** |
| Normative URI: | http://rs.tdwg.org/ac/terms/resourceCreationTechnique |
| Label: | Resource Creation Technique |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | Information about technical aspects of the creation and digitization process of the resource. This includes modification steps ("retouching") after the initial resource capture. |
| Notes: | Examples: Encoding method or settings, numbers of channels, lighting, audio sampling rate, frames per second, data rate, interlaced or progressive, multiflash lighting, remote control, automatic interval exposure.  Annotating whether and how a resource has been modified or edited significantly in ways that are not immediately obvious to, or expected by, consumers is of special significance. Examples for images are: Removing a distracting twig from a picture, moving an object to a different surrounding, changing the color in parts of the image, or blurring the background of an image. Modifications that are standard practice and expected or obvious are not necessary to document; examples of such practices include changing resolution, cropping, minor sharpening or overall color correction, and clearly perceptible modifications (e.g., addition of arrows or labels, or the placement of multiple pictures into a table.) If it is only known that significant modifications were made, but no details are known, a general statement like "Media may have been manipulated to improve appearance" may be appropriate. See also Subject Preparation Technique. |
| | |
| **Term Name:** | **ac:reviewer** |
| Normative URI: | http://rs.tdwg.org/ac/terms/reviewer |
| Label: | Reviewer |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | URI for a reviewer. If present, then resource is peer-reviewed, even if there are Reviewer Comments is absent or empty. Its presence tells whether an expert in the subject featured in the media has reviewed the media item or collection and approved its metadata description; must display a name or the literal "anonymous" (= anonymously reviewed). |
| Notes: | Provider is asserting they accept this review as competent. See also ac:reviewerLiteral in this document and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:reviewerComments** |
| Normative URI: | http://rs.tdwg.org/ac/terms/reviewerComments |
| Label: | Reviewer Comments |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Any comment provided by a reviewer with expertise in the subject, as free-form text. |
| Notes: | Reviewer Comments may refer to the resource itself (e. g., asserting a taxon name or location of a biological subject in an image), or to the relation between resource and associated metadata (e. g., asserting that the taxon name given in the metadata is wrong, without asserting a positive identification). There is a separate item "Comments" for text from commenters of unrecorded expertise. |
| | |
| **Term Name:** | **ac:reviewerLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/reviewerLiteral |
| Label: | Reviewer |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | String providing the name of a reviewer. If present, then resource is peer-reviewed, even if Reviewer Comments is absent or empty. Its presence tells whether an expert in the subject featured in the media has reviewed the media item or collection and approved its metadata description; must display a name or the literal "anonymous" (= anonymously reviewed). |
| Notes: | Provider is asserting they accept this review as competent. See also ac:reviewer and the section Namespaces, Prefixes and Term Names for discussion of the rationale for separate terms taking URI values from those taking Literal values where both are possible. Normal practice is to use the same Label if both are provided. Labels have no effect on information discovery and are only suggestions. |
| | |
| **Term Name:** | **ac:serviceExpectation** |
| Normative URI: | http://rs.tdwg.org/ac/terms/serviceExpectation |
| Label: | Service Expectation |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | A term that describes what service expectations users may have of the ac:accessURL. Recommended terms include online (denotes that the URL is expected to deliver the resource), authenticate (denotes that the URL delivers a login or other authentication interface requiring completion before delivery of the resource) published(non digital) (denotes that the URL is the identifier of a non-digital published work, for example a doi.) Communities should develop their own controlled vocabularies for Service Expectations. |
| Notes: |  |
| | |
| **Term Name:** | **ac:subjectCategoryVocabulary** |
| Normative URI: | http://rs.tdwg.org/ac/terms/subjectCategoryVocabulary |
| Label: | Subject Category Vocabulary |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Any vocabulary or formal classification from which terms in the Subject Category have been drawn. |
| Notes: | The AC recommended vocabularies do not need to be cited here. There is no required linkage between individual Subject Category terms and the vocabulary; the mechanism is intended to support discovery of the normative URI for a term, but not guarantee it. |
| | |
| **Term Name:** | **ac:subjectOrientation** |
| Normative URI: | http://rs.tdwg.org/ac/terms/subjectOrientation |
| Label: | Subject Orientation |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Specific orientation (= direction, view angle) of the subject represented in the media resource with respect to the acquisition device. |
| Notes: | Examples: "dorsal", "ventral", "frontal", etc. No formal encoding scheme as yet exists. The term is repeatable e.g., in the case of a composite image, consisting of a combination of different view orientations. |
| | |
| **Term Name:** | **ac:subjectPart** |
| Normative URI: | http://rs.tdwg.org/ac/terms/subjectPart |
| Label: | Subject Part |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | The portion or product of organism morphology, behaviour, environment, etc. that is either predominantly shown or particularly well exemplified by the media resource. |
| Notes: | No formal encoding scheme as yet exists. Examples are "whole body", "head", "flower", "leaf", "canopy" (of a rain forest stand). Several anatomical ontologies are emerging in http://www.obofoundry.org/ |
| | |
| **Term Name:** | **ac:subtype** |
| Normative URI: | http://rs.tdwg.org/ac/terms/subtype |
| Label: | Subtype |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Any URI may be used that provides for more specialization than the type. Possible values are community-defined. For exmamples see the non-normative page AC_Subtype_Examples. |
| Notes: | The subtype term may not be applied to Collection objects. However, the Description term in the Content Coverage Vocabulary may add further description to a Collection object. The subtype vocabulary may be extended by users provided they identify the term by a URI which is not in the ac namespace (for example, using "http://my.inst.org/namespace/metadata/subtype/repair-manual"). Conforming applications may choose to ignore these. See ac:subtypeLiteral for usage with strings. |
| | |
| **Term Name:** | **ac:subtypeLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/subtypeLiteral |
| Label: | Subtype |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | The subtype should provide more specialization than the type. Possible values are community-defined. For exmamples see the non-normative page AC_Subtype_Examples. |
| Notes: | The subtypeLiteral term may not be applied to Collection objects. However, the Description term in the Content Coverage Vocabulary may add further description to a Collection object. |
| | |
| **Term Name:** | **ac:tag** |
| Normative URI: | http://rs.tdwg.org/ac/terms/tag |
| Label: | Tag |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | General keywords or tags. |
| Notes: | Tags may be multi-worded phrases. Where scientific names, common names, geographic locations, etc. are separable, those should go into the more specific coverage metadata items provided further below. Examples: "flower diagram". Character or part keywords like "leaf", or "flower color" are especially desirable. |
| | |
| **Term Name:** | **ac:taxonCount** |
| Normative URI: | http://rs.tdwg.org/ac/terms/taxonCount |
| Label: | Taxon Count |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | An exact or estimated number of taxa at the lowest applicable taxon rank (usually species or infraspecific) represented by the media resource (item or collection). |
| Notes: | Primarily intended for resource collections and singular resources dealing with sets of taxa (e. g., identification tools, videos). It is recommended to give an exact or estimated number of specific taxa when a complete list of taxa is not available or practical. The count should contain only the taxa covered fully or primarily by the resource. For a taxon page and most images this will be "1", i. e. other taxa mentioned on the side or in the background should not be counted. However, sometimes a resource may illustrate an ecological or behavioral entity with multiple species, e. g., a host-pathogen interaction; taxon count would then indicate the known number of species in this interaction. This should be a single integer number. Leave the field empty if you cannot estimate the information (do not enter 0). Additional taxon counts at higher levels (e. g. how many families are covered by a digital Fauna) should be given verbatim in the resource description, not here. |
| | |
| **Term Name:** | **ac:taxonCoverage** |
| Normative URI: | http://rs.tdwg.org/ac/terms/taxonCoverage |
| Label: | Taxon Coverage |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | A higher taxon (e. g., a genus, family, or order) at the level of the genus or higher, that covers all taxa that are the primary subject of the resource (which may be a media item or a collection). |
| Notes: | Example: Where the subject of an image is several species of ducks with trees visible in the background, Taxon Coverage would still be Anatidae (and not Biota). Example: "Aves" for a bird key or a bird image collection. Do not add a rank ("Class Aves") in this field. Note that this somewhat expands the usage of ncd:taxonCoverage which, however has not yet been adopted by TDWG, and which specifies at the Family level or higher. For collections it is recommended to follow ncd:taxonCoverage to avoid conflicts between an AC record and a record arising from use of the un-adopted NCD. If the resource contains a single taxon, this should be placed in Scientific Taxon Name. In this case Taxon Coverage may be left empty, but if not, care should be taken that the entries do not conflict. Example: If Scientific Taxon Name is Quercus alba then Taxon Coverage, if provided at all, should be Quercus. |
| | |
| **Term Name:** | **ac:timeOfDay** |
| Normative URI: | http://rs.tdwg.org/ac/terms/timeOfDay |
| Label: | Time of Day |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** No |
| Definition: | Free text information beyond exact clock times. |
| Notes: | Examples in English: afternoon, twilight. |
| | |
| **Term Name:** | **ac:variant** |
| Normative URI: | http://rs.tdwg.org/ac/terms/variant |
| Label: | Variant |
| | **Layer:** 1 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | A URI designating what this Service Access Point provides. Some suggested values are the URIs ac:Thumbnail, ac:Trailer, ac:LowerQuality, ac:MediumQuality, ac:GoodQuality, ac:BestQuality, and ac:Offline. Additional URIs from communities of practice may be introduced. |
| Notes: | A URI designating what this Service Access Point provides. Some suggested values are the URIs ac:Thumbnail, ac:Trailer, ac:LowerQuality, ac:MediumQuality, ac:GoodQuality, ac:BestQuality, and ac:Offline. Additional URIs from communities of practice may be introduced. |
| | |
| **Term Name:** | **ac:variantDescription** |
| Normative URI: | http://rs.tdwg.org/ac/terms/variantDescription |
| Label: | Variant Description |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** No |
| Definition: | Text that describes this Service Access Point variant |
| Notes: | Most variants (thumb, low-res, high-res) are self-explanatory and it is best practice to leave this property empty if no special description is needed. It is provided for cases that require additional information (e.g., video shortened instead of simply quality reduced). |
| | |
| **Term Name:** | **ac:variantLiteral** |
| Normative URI: | http://rs.tdwg.org/ac/terms/variantLiteral |
| Label: | Variant |
| | **Layer:** 2 -- **Required:** No -- **Repeatable:** Yes |
| Definition: | Text that describes this Service Access Point variant. |
| Notes: | This is an alternative to ac:variant where using a string is preferred over a URI. It is best practice to use ac:variant instead of ac:variantLiteral wherever practical. Value may be free text, but it is suggested to consider including terminology based on the following: Thumbnail: Service Access Point provides a thumbnail image, short sound clip, or short movie clip that can be used in addition to the resource to represent the media object, typically at lower quality and higher compression than a preview object. A typical size for a tiny thumbnail image may be 50-100 pixels in the longer dimension. Trailer: Service Access Point provides video clip preview, in the form of a specifically authored "Trailer", which may provide somewhat different content than the original resource. Lower Quality: Service Access Point provides a lower quality version of the media resource, suitable e. g. for web sites. Medium Quality: Service Access Point provides a medium quality version of the media resource, e. g. shortened in duration, or reduced size, using lower resolution or higher compression causing moderate artifacts. Good Quality: Service Access Point provides a good quality version of the media resource intended for resources displayed as primary information; e. g. an image between 800 and 1600 px in width or height. Best Quality: Service Access Point provides the highest available quality of the media resource, whatever its resolution or quality level. Offline: Service Access Point provides data about an offline resource. |
| | |
| | |
