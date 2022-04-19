# materialSampleType Controlled Vocabulary

**Title:** materialSampleType Controlled Vocabulary

**Namespace URI:** http://rs.tdwg.org/dwcmatter/values/

**Preferred namespace abbreviation:** dwcmatter:

**Date version issued:** put ratification date here

**Date created:** put ratification date here

**Part of TDWG Standard:** http://www.tdwg.org/standards/450

**This version:** http://rs.tdwg.org/dwc/doc/matter/iso-date-here

**Latest version:** http://rs.tdwg.org/dwc/doc/matter/

**Abstract:** The Darwin Core term `materialSampleType` more specifically describes the type of material sample. The materialSampleType Controlled Vocabulary provides terms that should be used as values for `dwc:materialSampleType` and its iri-valued analog `dwciri:materialSampleType`. 

**Contributors:** Teresa J. Mayfield-Meyer (Arctos), ... 

**Creator:** TDWG Material Sample Task Group

**Bibliographic citation:** Material Sample Task Group. 2022. materialSampleType Controlled Vocabulary. Biodiversity Information Standards (TDWG). <http://rs.tdwg.org/dwc/doc/matter/iso-date-here>


## 1 Introduction (informative)

This document includes terms intended to be used as controlled values for the Darwin Core terms `dwc:materialSampleType` and `dwciri:materialSampleType`. A [JSON-LD representation](https://tdwg.github.io/rs.tdwg.org/cvJson/dwcmatter.json) of this SKOS Concept Scheme is available.

### 1.1 Status of the content of this document

Section 1 is informative (non-normative).

Section 2 is normative except as noted.

Section 3 is informative.

In Section 4, the values of the `Term IRI`, `Definition`, and `Controlled value` are normative. The value of `Usage` (if it exists for a given term) is normative.  The value of `Has broader concept` is normative. The values of `Term Name` are non-normative, although one can expect that the namespace abbreviation prefix is one commonly used for the term namespace.  `Label` and the values of all other properties (such as `Notes` or `Examples`) are non-normative.

### 1.2 RFC 2119 key words
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

## 2 Use of Terms

In accordance with the [Darwin Core Term List](http://rs.tdwg.org/dwc/doc/termlist/) document, unabbreviated term IRIs MUST be used as values of the property `dwciri:materialSampleType`. Controlled value strings MUST be used as values of the property `dwc:materialSampleType`.

## 3 Term index


[fossil specimen](#dwcmatter_m002) |
[living specimen](#dwcmatter_m000) |
[material sample concept scheme](#dwcmatter_m) |
[preserved specimen](#dwcmatter_m001) 

## 4 Vocabulary
<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcmatter_m"></a>Term Name  dwcmatter:m</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Term IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/m">http://rs.tdwg.org/dwcmatter/values/m</a></td>
		</tr>
		<tr>
			<td>Modified</td>
			<td>2022-04-19</td>
		</tr>
		<tr>
			<td>Term version IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/version/m-2022-04-19">http://rs.tdwg.org/dwcmatter/values/version/m-2022-04-19</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>material sample concept scheme</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A SKOS concept scheme for material sample types.</td>
		</tr>
		<tr>
			<td>Type</td>
			<td>http://www.w3.org/2004/02/skos/core#ConceptScheme</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcmatter_m000"></a>Term Name  dwcmatter:m000</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Term IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/m000">http://rs.tdwg.org/dwcmatter/values/m000</a></td>
		</tr>
		<tr>
			<td>Modified</td>
			<td>2022-04-19</td>
		</tr>
		<tr>
			<td>Term version IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/version/m000-2022-04-19">http://rs.tdwg.org/dwcmatter/values/version/m000-2022-04-19</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>living specimen</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A specimen that is alive.</td>
		</tr>
		<tr>
			<td>Definition derived from:</td>
			<td><a href="http://rs.tdwg.org/dwc/terms/version/LivingSpecimen-2018-09-06">http://rs.tdwg.org/dwc/terms/version/LivingSpecimen-2018-09-06</a></td>
		</tr>
		<tr>
			<td>Examples</td>
			<td>A living plant in a botanical garden. A living animal in a zoo.</td>
		</tr>
		<tr>
			<td>Controlled value</td>
			<td>LivingSpecimen</td>
		</tr>
		<tr>
			<td>Type</td>
			<td>Concept</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcmatter_m001"></a>Term Name  dwcmatter:m001</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Term IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/m001">http://rs.tdwg.org/dwcmatter/values/m001</a></td>
		</tr>
		<tr>
			<td>Modified</td>
			<td>2022-04-19</td>
		</tr>
		<tr>
			<td>Term version IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/version/m001-2022-04-19">http://rs.tdwg.org/dwcmatter/values/version/m001-2022-04-19</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>preserved specimen</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A specimen that has been preserved.</td>
		</tr>
		<tr>
			<td>Definition derived from:</td>
			<td><a href="http://rs.tdwg.org/dwc/terms/version/PreservedSpecimen-2018-09-06">http://rs.tdwg.org/dwc/terms/version/PreservedSpecimen-2018-09-06</a></td>
		</tr>
		<tr>
			<td>Examples</td>
			<td>A plant on an herbarium sheet. A cataloged lot of fish in a jar.</td>
		</tr>
		<tr>
			<td>Controlled value</td>
			<td>PreservedSpecimen</td>
		</tr>
		<tr>
			<td>Type</td>
			<td>Concept</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcmatter_m002"></a>Term Name  dwcmatter:m002</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Term IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/m002">http://rs.tdwg.org/dwcmatter/values/m002</a></td>
		</tr>
		<tr>
			<td>Modified</td>
			<td>2022-04-19</td>
		</tr>
		<tr>
			<td>Term version IRI</td>
			<td><a href="http://rs.tdwg.org/dwcmatter/values/version/m002-2022-04-19">http://rs.tdwg.org/dwcmatter/values/version/m002-2022-04-19</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>fossil specimen</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A preserved specimen that is a fossil.</td>
		</tr>
		<tr>
			<td>Definition derived from:</td>
			<td><a href="http://rs.tdwg.org/dwc/terms/version/FossilSpecimen-2018-09-06">http://rs.tdwg.org/dwc/terms/version/FossilSpecimen-2018-09-06</a></td>
		</tr>
		<tr>
			<td>Examples</td>
			<td>A body fossil. A coprolite. A gastrolith. An ichnofossil. A piece of a petrified tree.</td>
		</tr>
		<tr>
			<td>Controlled value</td>
			<td>FossilSpecimen</td>
		</tr>
		<tr>
			<td>Has broader concept</td>
			<td><a href="#dwcmatter_m001">dwcmatter:m001</a></td>
		</tr>
		<tr>
			<td>Type</td>
			<td>Concept</td>
		</tr>
	</tbody>
</table>


