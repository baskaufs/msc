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


[casual (category C1)](#dwcdoe_d006) |
[colonising (category D1)](#dwcdoe_d009) |
[cultivated (category B2)](#dwcdoe_d003) |
[established (category C3)](#dwcdoe_d008) |
[failing (category C0)](#dwcdoe_d005) |
[introduced (alien, exotic, non-native, nonindigenous)](#dwcem_e003) |
[introduced: assisted colonisation](#dwcem_e004) |
[native (category A)](#dwcdoe_d001) |
[released (category B3)](#dwcdoe_d004) |
[reproducing (category C2)](#dwcdoe_d007) |
[uncertain (unknown, cryptogenic)](#dwcem_e006)
[vagrant (casual)](#dwcem_e005) |
[widespread invasive (category E)](#dwcdoe_d011) |

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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d001-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d001-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>native (category A)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Not transported beyond limits of native range</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Considered native and naturally occuring. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category A</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d002-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d002-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>captive (category B1)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals in captivity or quarantine (i.e. individuals provided with conditions suitable for them, but explicit measures of containment are in place)</td>
		</tr>
		<tr>
			<td>Usage</td>
			<td>Only for cases where specific actions have been taken place to prevent escape of individuals or propagules</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category B1</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d003-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d003-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>cultivated (category B2)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals in cultivation (i.e. individuals provided with conditions suitable for them, but explicit measures to prevent dispersal are limited at best)</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Examples include gardens, parks and farms. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category B2</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d004-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d004-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>released (category B3)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals directly released into novel environment</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>For example, fish stocked for angling, birds for hunting. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category B3</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d005-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d005-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>failing (category C0)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals released outside of captivity or cultivation in a location, but incapable of surviving for a significant period</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Such as frost tender plants sown or planted in a cold climate. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category C0</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d006-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d006-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>casual (category C1)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, no reproduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Trees planted in the wild for forestry or ornament may come under this category. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category C1</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d007-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d007-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>reproducing (category C2)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, reproduction is occurring, but population not self-sustaining</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Offspring are produced, but these either do not survive or are fertile enough to maintain the population. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category C2</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d008-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d008-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>established (category C3)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Individuals surviving outside of captivity or cultivation in a location, reproduction occurring, and population self-sustaining</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>The population is maintained by reproduction, but is not spreading. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category C3</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d009-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d009-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>colonising (category D1)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Self-sustaining population outside of captivity or cultivation, with individuals surviving a significant distance from the original point of introduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>The population is maintained by reproduction and is spreading. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category D1</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d010-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d010-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>invasive (category D2)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Self-sustaining population outside of captivity or cultivation, with individuals surviving and reproducing a significant distance from the original point of introduction</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>The population is maintained by reproduction, is spreading, and their progeny is also reproducing and spreading. See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category D2</td>
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
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/doe/version/d011-2020-06-15">http://rs.tdwg.org/dwc/doe/version/d011-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>widespread invasive (category E)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Fully invasive species, with individuals dispersing, surviving and reproducing at multiple sites across a greater or lesser spectrum of habitats and extent of occurrence</td>
		</tr>
		<tr>
			<td>Usage</td>
			<td>This term is only used for those invasives with the highest degree of encroachment</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>See also Blackburn et al. 2011 <a href="https://doi.org/10.1016/j.tree.2011.03.023">https://doi.org/10.1016/j.tree.2011.03.023</a> category E</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>widespreadInvasive</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcem_e001"></a>Term Name: dwcem:e001</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e001">http://rs.tdwg.org/dwc/em/e001</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e001-2020-06-15">http://rs.tdwg.org/dwc/em/version/e001-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>native (indigenous)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A taxon occurring within its natural range</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>What is considered native to an area varies with the biogeographic history of an area and the local interpretation of what is a "natural range".  </td>
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
			<th colspan="2"><a id="dwcem_e002"></a>Term Name: dwcem:e002</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e002">http://rs.tdwg.org/dwc/em/e002</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e002-2020-06-15">http://rs.tdwg.org/dwc/em/version/e002-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>native: reintroduced</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>A taxon re-established by direct introduction by humans into an area which was once part of its natural range, but from where it had become extinct.</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Where a taxon has become extirpated from an area where it had naturally occurred it may be returned to that area deliberately with the intension of re-establishing it. </td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>nativeReintroduced</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcem_e003"></a>Term Name: dwcem:e003</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e003">http://rs.tdwg.org/dwc/em/e003</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e003-2020-06-15">http://rs.tdwg.org/dwc/em/version/e003-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>introduced (alien, exotic, non-native, nonindigenous)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Establishment of a taxon by human agency into an area that is not part of its natural range</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Organisms can be introduced to novel areas and habitats by human activity, either on purpose or by accident. Humans can also inadvertently create corridors that breakdown natural barriers to dispersal and allow organisms to spread beyond their natural range.</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>introduced</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcem_e004"></a>Term Name: dwcem:e004</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e004">http://rs.tdwg.org/dwc/em/e004</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e004-2020-06-15">http://rs.tdwg.org/dwc/em/version/e004-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>introduced: assisted colonisation</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>Establishment of a taxon specifically with the attention of creating a self-sustaining  wild population in an area that is not part of the taxon's natural range</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>In the event of environmental change and habitat destruction a conservation option is to introduce a taxon into an area it did not naturally occur</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>introducedAssistedColonisation</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcem_e005"></a>Term Name: dwcem:e005</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e005">http://rs.tdwg.org/dwc/em/e005</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e005-2020-06-15">http://rs.tdwg.org/dwc/em/version/e005-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>vagrant (casual)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>The temporary occurrence of a taxon far outside its natural or migratory range.</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>Natural events and human activity can disperse organisms unpredictably into places where they may stay or survive for a period.</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>vagrant</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th colspan="2"><a id="dwcem_e006"></a>Term Name: dwcem:e006</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Normative IRI:</td>
			<td><a href="http://rs.tdwg.org/dwc/em/e006">http://rs.tdwg.org/dwc/em/e006</a></td>
		</tr>
		<tr>
			<td>Version</td>
			<td><a href="http://rs.tdwg.org/dwc/em/version/e006-2020-06-15">http://rs.tdwg.org/dwc/em/version/e006-2020-06-15</a></td>
		</tr>
		<tr>
			<td>Label</td>
			<td>uncertain (unknown, cryptogenic)</td>
		</tr>
		<tr>
			<td>Definition</td>
			<td>The origin of the occurrence of the taxon in an area is obscure</td>
		</tr>
		<tr>
			<td>Notes</td>
			<td>When there is a lack of fossil or historical evidence for the occurrence of a taxon in an area it can be impossible to know if the taxon is new to the area or native.</td>
		</tr>
		<tr>
			<td>Controlled Value</td>
			<td>uncertain</td>
		</tr>
	</tbody>
</table>


