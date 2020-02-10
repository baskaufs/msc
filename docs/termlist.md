---
permalink: /termlist/
---

# Degree of Establishment Term List

**Title:** Degree of Establishment Term List

**Namespace URI:** http://rs.tdwg.org/dwc/doe/

**Preferred namespace abbreviation:** dwcdoe:

**Date version issued:** 2020-02-10

**Date created:** 2020-02-10

**Part of TDWG Standard:** http://www.tdwg.org/standards/450

**This version:** http://rs.tdwg.org/dwc/doc/doetermlist/2020-02-10

**Latest version:** http://rs.tdwg.org/dwc/doc/doetermlist/

**Abstract:** The abstract goes here

**Contributors:** contributor list goes here

**Creator:** Darwin Core Maintenance Group ???

**Bibliographic citation:** put a citation here


## 1 Introduction

This document includes terms intended to be used as values for the Darwin Core term `degreeOfEstablishment`.

### 1.1 Status of the content of this document

In Section 4, the values of the Normative IRI, Definition, and Controlled Value are normative. The value of Usage (if it exists for a given term) is normative.  The values of Term Name is non-normative, although one can expect that the namespace abbreviation prefix is one commonly used for the term namespace.  Labels and the values of all other properties (such as notes) are non-normative.

### 1.2 RFC 2119 key words
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

## 2 Use of Terms

Due to the requirements of [Section 1.4.3 of the Darwin Core RDF Guide](https://dwc.tdwg.org/rdf/#143-use-of-darwin-core-terms-in-rdf-normative), term IRIs MUST be used as values of `dwciri:degreeOfEstablishment`. Controlled value strings MUST be used as values of `dwc:degreeOfEstablishment`.

## 3 Term index


[captive](#dwcdoe_d002) |
[casual](#dwcdoe_d006) |
[colonising](#dwcdoe_d009) |
[cultivated](#dwcdoe_d003) |
[established](#dwcdoe_d008) |
[failing](#dwcdoe_d005) |
[invasive](#dwcdoe_d010) |
[native](#dwcdoe_d001) |
[released](#dwcdoe_d004) |
[reproducing](#dwcdoe_d007) |
[widespreadInvasive](#dwcdoe_d011)

## 4 Vocabulary
<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d001"></a>Term Name: dwcdoe:d001</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d001">http://rs.tdwg.org/dwc/doe/d001</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>native</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Not transported beyond limits of native range</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category A</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>native</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d002"></a>Term Name: dwcdoe:d002</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d002">http://rs.tdwg.org/dwc/doe/d002</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>captive</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals in captivity or quarantine (i.e. individuals provided with conditions suitable for them, but explicit measures of containment are in place)</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category B1</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>captive</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d003"></a>Term Name: dwcdoe:d003</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d003">http://rs.tdwg.org/dwc/doe/d003</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>cultivated</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals in cultivation (i.e. individuals provided with conditions suitable for them, but explicit measures to prevent dispersal are limited at best)</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category B2</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>cultivated</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d004"></a>Term Name: dwcdoe:d004</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d004">http://rs.tdwg.org/dwc/doe/d004</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>released</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals directly released into novel environment</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category B3</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>released</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d005"></a>Term Name: dwcdoe:d005</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d005">http://rs.tdwg.org/dwc/doe/d005</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>failing</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals released outside of captivity or cultivation in a location, but incapable of surviving for a significant period</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category C0</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>failing</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d006"></a>Term Name: dwcdoe:d006</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d006">http://rs.tdwg.org/dwc/doe/d006</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>casual</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, no reproduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category C1</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>casual</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d007"></a>Term Name: dwcdoe:d007</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d007">http://rs.tdwg.org/dwc/doe/d007</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>reproducing</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, reproduction is occurring, but population not self-sustaining</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category C2</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>reproducing</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d008"></a>Term Name: dwcdoe:d008</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d008">http://rs.tdwg.org/dwc/doe/d008</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>established</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, reproduction occurring, and population self-sustaining</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category C3</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>established</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d009"></a>Term Name: dwcdoe:d009</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d009">http://rs.tdwg.org/dwc/doe/d009</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>colonising</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Self-sustaining population outside of captivity or cultivation, with individuals surviving a significant distance from the original point of introduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category D1</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>colonising</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d010"></a>Term Name: dwcdoe:d010</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d010">http://rs.tdwg.org/dwc/doe/d010</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>invasive</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Self-sustaining population outside of captivity or cultivation, with individuals surviving and reproducing a significant distance from the original point of introduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category D2</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>invasive</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcdoe_d011"></a>Term Name: dwcdoe:d011</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/d011">http://rs.tdwg.org/dwc/doe/d011</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>widespreadInvasive</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Fully invasive species, with individuals dispersing, surviving and reproducing at multiple sites across a greater or lesser spectrum of habitats and extent of occurrence</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Blackburn et al. (2011) category E</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>widespreadInvasive</td>
		</tr>
	</tbody>
</table>


