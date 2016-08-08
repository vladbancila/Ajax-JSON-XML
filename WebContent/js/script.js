
window.onload = initializeaza;

function initializeaza(){
	
	//alert("javascript functioneaza...");
	
	var buton = document.getElementById("buton");
	
	// cand se apasa butonul se va apela aceasta functie anonima
	buton.onclick = function(){
		
		alert("butonul functioneaza...");
		
		// functia va genera un HTTP request catre servlet,
		// va citi datele primite si va actualiza pagina.
		
		// cod jquery
		$.get(  // parametrul 1: URL-ul servletului
				"masini",
				
				// parametrul 2 sunt parametrii trimisi pe request
				// de exemplu:
				// { idmasina: id, numeuser: username },
				// { numeRata: "Donald", gen: "masculin"},
				// Noi nu o sa trimitem nici un parametru pe request
				
				// parametrul 3 este functia de callback care va rula
				// in momentul in care se va primi JSONul de la servlet
				// Aceasta functie va face actualizarea paginii.
				function(data){
					// data = JSONul primit
					// in cazul nostru este un array javascript cu masini
					
					// alert(data); 
					// data vine sub forma de array de javascript cu cele 4 masini
					// parcurgem arrayul si punem masinile in tabel.
					
					var tabel = document.getElementById("tabel");
					
					for( var i=0; i<data.length; i++ ){
						
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
					
				}
		); // end $.get
		
		
	}; // end functie anonima
	
	
} // end functie initializeaza

