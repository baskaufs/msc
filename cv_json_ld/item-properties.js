var isoLanguage = 'en';

// If the URL has a search string, then set the initial language alternative to something other than English
// The local ID needs to be parsed from the search ("?") part of the URL
var localID = location.search;
// ignore the initial "?"
if (localID.length>1)
	{
	isoLanguage=localID.substring(1);
	if (isoLanguage=='en') {document.getElementById("box0").selectedIndex = "0";}
	if (isoLanguage=='pt') {document.getElementById("box0").selectedIndex = "1";}
	if (isoLanguage=='de') {document.getElementById("box0").selectedIndex = "2";}
	if (isoLanguage=='es') {document.getElementById("box0").selectedIndex = "3";}
	if (isoLanguage=='zh-hans') {document.getElementById("box0").selectedIndex = "4";}
	if (isoLanguage=='zh-hant') {document.getElementById("box0").selectedIndex = "5";}
	redrawLabels(isoLanguage)
	}

function redrawLabels(isoLanguage) {
	if (isoLanguage=='en') {
	$("#boxLabel0").text("Language");
	$("#boxLabel1").text("Character");
	document.getElementById("pageHeader").innerHTML = "Wikidata superheroes picklist demo page";
	document.title = "Wikidata superheroes";
	}
	if (isoLanguage=='pt') {
	$("#boxLabel0").text("LÃ­ngua");
	$("#boxLabel1").text("Personagem");
	document.getElementById("pageHeader").innerHTML = "PÃ¡gina de demonstraÃ§Ã£o do picklist dos super-herÃ³is do Wikidata";
	document.title = "Super-herÃ³is do Wikidata";
	}
	if (isoLanguage=='de') {
	$("#boxLabel0").text("Sprache");
	$("#boxLabel1").text("Charakter");
	document.getElementById("pageHeader").innerHTML = "Wikidata Superhelden Auswahlliste Demo-Seite";
	document.title = "Wikidata Superhelden";
	}
	if (isoLanguage=='es') {
	$("#boxLabel0").text("Idioma");
	$("#boxLabel1").text("Personaje");
	document.getElementById("pageHeader").innerHTML = "PÃ¡gina de demostraciÃ³n de lista de superhÃ©roes de Wikidata";
	document.title = "SuperhÃ©roes de Wikidata";
	}
	if (isoLanguage=='zh-hans') {
	$("#boxLabel0").text("è¯­è¨€");
	$("#boxLabel1").text("å­—ç¬¦");
	document.getElementById("pageHeader").innerHTML = "ç»´åŸºæ•°æ®è¶…çº§è‹±é›„é€‰é¡¹åˆ—è¡¨æ¼”ç¤ºé¡µé¢";
	document.title = "ç»´åŸºæ•°æ®è¶…çº§è‹±é›„";
	}
	if (isoLanguage=='zh-hant') {
	$("#boxLabel0").text("èªžè¨€");
	$("#boxLabel1").text("å­—ç¬¦");
	document.getElementById("pageHeader").innerHTML = "ç¶­åŸºæ•¸æ“šè¶…ç´šè‹±é›„é¸é …åˆ—è¡¨æ¼”ç¤ºé é¢";
	document.title = "ç¶­åŸºæ•¸æ“šè¶…ç´šè‹±é›„";
	}
}

function setStatusOptions(isoLanguage) {
	// start the status dropdown over with "Select/Selecionar/WÃ¤hlen" as the first option
	$("#box1 option:gt(0)").remove();
	if (isoLanguage=='en') {$("#box1 option").text("(Select)");}
	if (isoLanguage=='pt') {$("#box1 option").text("(Selecionar)");}
	if (isoLanguage=='de') {$("#box1 option").text("(WÃ¤hlen)");}
	if (isoLanguage=='es') {$("#box1 option").text("(Seleccionar)");}
	if (isoLanguage=='zh-hans') {$("#box1 option").text("(é€‰æ‹©)");}
	if (isoLanguage=='zh-hant') {$("#box1 option").text("(é¸æ“‡)");}

	// create URI-encoded query string to get superhero names and IRIs
		var string = 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>'
					+'PREFIX wd: <http://www.wikidata.org/entity/>'
					+'PREFIX wdt: <http://www.wikidata.org/prop/direct/>'
                    +'SELECT DISTINCT ?name ?iri WHERE {'
                    +'?iri wdt:P106 wd:Q188784.'
					+'?iri wdt:P1080 wd:Q931597.'
                    +'?iri rdfs:label ?name.'
                    +"FILTER(lang(?name)='"+isoLanguage+"')"
                    +'}'
                    +'ORDER BY ASC(?name)';
		var encodedQuery = encodeURIComponent(string);

        // send query to endpoint
        $.ajax({
            type: 'GET',
            url: 'https://query.wikidata.org/sparql?query=' + encodedQuery,
            headers: {
                Accept: 'application/sparql-results+json'
            },
            success: function(returnedJson) {
				for (i = 0; i < returnedJson.results.bindings.length; i++) {
					label = returnedJson.results.bindings[i].name.value
					iri = returnedJson.results.bindings[i].iri.value
					// add the new information to the dropdown list
					$("#box1").append("<option value='"+iri+"'>"+label+'</option>');
				}
			}
        });

	}

$(document).ready(function(){
		
	// not searching initially, so hide the spinner icon
	$('#searchSpinner').hide();
    
	// fires when there is a change in the language dropdown
	$("#box0").change(function(){
			// searching, so show the spinner icon
			$('#searchSpinner').show();
			var isoLanguage= $("#box0").val();
			redrawLabels(isoLanguage)
			setStatusOptions(isoLanguage);
			$("#div1").html('');
			$('#searchSpinner').hide();
	});

	// fires when there is a change in the character dropdown
	$("#box1").change(function(){
		var iri = $("#box1").val();
		var isoLanguage= $("#box0").val();
		// create URI-encoded query string to get superhero names and IRIs
		var string = 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>'
					+'PREFIX wd: <http://www.wikidata.org/entity/>'
					+'PREFIX wdt: <http://www.wikidata.org/prop/direct/>'
					+'SELECT DISTINCT ?property ?value WHERE {'
					+ '<' + iri + '> ?propertyUri ?valueUri.'
					+'?valueUri rdfs:label ?value.'
					+'?genProp <http://wikiba.se/ontology#directClaim> ?propertyUri.'
					+'?genProp rdfs:label ?property.'
					+'FILTER(substr(str(?propertyUri),1,36)="http://www.wikidata.org/prop/direct/")'
					+'FILTER(LANG(?property) = "'+isoLanguage+'")'
					+'FILTER(LANG(?value) = "'+isoLanguage+'")'
					+'}'
					+'ORDER BY ASC(?property)';
		var encodedQuery = encodeURIComponent(string);

		// send query to endpoint
		$.ajax({
			type: 'GET',
			url: 'https://query.wikidata.org/sparql?query=' + encodedQuery,
			headers: {
				Accept: 'application/sparql-results+json'
			},
			success: function(returnedJson) {
				text = ''
				for (i = 0; i < returnedJson.results.bindings.length; i++) {
					property = returnedJson.results.bindings[i].property.value
					value = returnedJson.results.bindings[i].value.value
					text = text + property + ': ' + value + '<br/>'
					$("#div1").html(text);
				$('#searchSpinner').hide();
				}
			}
		});
	});
	
	// Main routine: execute SPARQL queries to get values and add them to the select options
	setStatusOptions(isoLanguage);

});

