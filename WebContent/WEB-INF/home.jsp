<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- luam scriptul de jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.js"></script>
<!-- sau -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script> -->
<script>
	window.onload = initializeaza;

	function initializeaza() {

		//alert("javascript functioneaza...");

		var buton = document.getElementById("buton");

		// cand se apasa butonul se va apela aceasta functie anonima
		buton.onclick = function() {

			alert("butonul functioneaza...");

			// functia va genera un HTTP request catre servlet,
			// va citi datele primite si va actualiza pagina.

			// cod jquery
			$.get( // parametrul 1: URL-ul servletului
			"masini",

			// parametrul 2 sunt parametrii trimisi pe request
			// de exemplu:
			// { idmasina: id, numeuser: username },
			// { numeRata: "Donald", gen: "masculin"},
			// Noi nu o sa trimitem nici un parametru pe request

			// parametrul 3 este functia de callback care va rula
			// in momentul in care se va primi JSONul de la servlet
			// Aceasta functie va face actualizarea paginii.
			function(data) {
				// data = JSONul primit
				// in cazul nostru este un array javascript cu masini

				// alert(data); 
				// data vine sub forma de array de javascript cu cele 4 masini
				// parcurgem arrayul si punem masinile in tabel.

				var tabel = document.getElementById("tabel");

				for (var i = 0; i < data.length; i++) {

					// cream un rand
					var tr = document.createElement("tr");
					tabel.appendChild(tr);

					var tdId = document.createElement("td");
					tdId.innerHTML = data[i].id;
					tr.appendChild(tdId);

					var tdMarca = document.createElement("td");
					tdMarca.innerHTML = data[i].marca;
					tr.appendChild(tdMarca);

					var tdModel = document.createElement("td");
					tdModel.innerHTML = data[i].model;
					tr.appendChild(tdModel);

					var tdPret = document.createElement("td");
					tdPret.innerHTML = data[i].pret;
					tr.appendChild(tdPret);

				}

			}); // end $.get

		}; // end functie anonima

	} // end functie initializeaza
</script>


<script>
	var completeField;
	var completeTable;
	var autoRow;
	var req;
	var isIE;

	function init() {
		completeField = document.getElementById("complete-field");
		completeTable = document.getElementById("complete-table");
		autoRow = document.getElementById("auto-row");
		completeTable.style.top = getElementY(autoRow) + "px";
	}

	function doCompletion() {
		var url = "autocomplete?action=complete&id="
				+ escape(completeField.value);
		req = initRequest();
		req.open("GET", url, true);
		req.onreadystatechange = callback;
		req.send(null);
	}

	function initRequest() {
		if (window.XMLHttpRequest) {
			if (navigator.userAgent.indexOf('MSIE') != -1) {
				isIE = true;
			}
			return new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			isIE = true;
			return new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	function callback() {

		clearTable();

		if (req.readyState == 4) {
			if (req.status == 200) {
				parseMessages(req.responseXML);
			}
		}
	}

	function appendComposer(firstName, lastName, composerId) {

		var row;
		var cell;
		var linkElement;

		if (isIE) {
			completeTable.style.display = 'block';
			row = completeTable.insertRow(completeTable.rows.length);
			cell = row.insertCell(0);
		} else {
			completeTable.style.display = 'table';
			row = document.createElement("tr");
			cell = document.createElement("td");
			row.appendChild(cell);
			completeTable.appendChild(row);
		}

		cell.className = "popupCell";

		linkElement = document.createElement("a");
		linkElement.className = "popupItem";
		linkElement.setAttribute("href", "autocomplete?action=lookup&id="
				+ composerId);
		linkElement.appendChild(document.createTextNode(firstName + " "
				+ lastName));
		cell.appendChild(linkElement);
	}

	function getElementY(element) {

		var targetTop = 0;

		if (element.offsetParent) {
			while (element.offsetParent) {
				targetTop += element.offsetTop;
				element = element.offsetParent;
			}
		} else if (element.y) {
			targetTop += element.y;
		}
		return targetTop;
	}

	function clearTable() {
		if (completeTable.getElementsByTagName("tr").length > 0) {
			completeTable.style.display = 'none';
			for (loop = completeTable.childNodes.length - 1; loop >= 0; loop--) {
				completeTable.removeChild(completeTable.childNodes[loop]);
			}
		}
	}

	function parseMessages(responseXML) {

		// no matches returned
		if (responseXML == null) {
			return false;
		} else {

			var composers = responseXML.getElementsByTagName("composers")[0];

			if (composers.childNodes.length > 0) {
				completeTable.setAttribute("bordercolor", "black");
				completeTable.setAttribute("border", "1");

				for (loop = 0; loop < composers.childNodes.length; loop++) {
					var composer = composers.childNodes[loop];
					var firstName = composer.getElementsByTagName("firstName")[0];
					var lastName = composer.getElementsByTagName("lastName")[0];
					var composerId = composer.getElementsByTagName("id")[0];
					appendComposer(firstName.childNodes[0].nodeValue,
							lastName.childNodes[0].nodeValue,
							composerId.childNodes[0].nodeValue);
				}
			}
		}
	}
</script>
<%-- ${pageContext.request.contextPath} --%>
</head>
<body onload="init()">

	<h1>AJAX JSON</h1>

	<p>Aceasta aplicatie trimite un request de tip AJAX in momentul in
		care userul apasa pe buton.</p>
	<p>Requestul este un request normal, doar ca Servletul in loc sa
		trimita o pagina jsp (html) o sa trimita un JSON, care nu este altceva
		decat un String JSON = Javascript Object Notation.</p>
	<p>Javascript va citi acest JSON si va actualiza pagina. Totul se
		intampla fara sa se incarce o pagina noua.</p>

	<h2>Masinile noastre</h2>

	<table id="tabel">
		<tr>
			<th>id</th>
			<th>marca</th>
			<th>model</th>
			<th>pret</th>
		</tr>
	</table>

	<button id="buton">Incarca tabelul prin Ajax</button>

	<p>1. Folosim javascript pentru a trimite requestul la
		server/servlet. Biblioteca de javascript jQuery face AJAXul foarte
		usor de folosit.</p>
	<p>2. Servletul raspunde cu un JSON</p>
	<p>3. Folosim iar javascript pentru a citi JSON-ul si a actualiza
		pagina.</p>


	<h1>Aici se va aduaga javaScript pentru a intoarce instant o
		valoare utilizand AJAX si XML</h1>
		<p>Aceasta sectiune initiaza o selectie automata si instanta a numelui cautat.</p>

	<form name="autofillform" action="autocomplete">
		<table>
			<thead>
				<tr>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><strong>Numele Cautat :</strong></td>
					<td><input type="text" size="40" id="complete-field"
						onkeyup="doCompletion();"></td>
				</tr>
				<tr>
					<td id="auto-row" colspan="2">
						<table id="complete-table" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>








