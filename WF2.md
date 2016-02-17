01
====

``` html
<!DOCTYPE html>
<html>
<head>
	<title> Hello </title>
</head>
<body>
	<p>
		Hali!
	</p>
	<script type="text/javascript">
	
		var games = [
		{
			name: 'Killing Floor',
			publisher: 'Tripwire Interactive',
			date: 2009,
			genre: [
				'First-person shooter', 
				'Survival horror'
			],
			characters: [
				'Corporal Lewis', 
				'Sergeant Powers'
			]
		},
		{
			name: 'Left 4 Dead',
			publisher: 'Valve Corporation',
			date: 2008,
			genre: [
				'First-person shooter', 
				'Survival horror'
			],
			characters: [
				'Bill', 
				'Louis'
			]
		},
		{
			name: 'How to Survive',
			publisher: '505 Games',
			date: 2013,
			genre: [
				'Action role-playing', 
				'Survival horror'
			],
			characters: [
				'Abby', 
				'Jack'
			]
		},
		{
			name: 'Plants vs. Zombies',
			publisher: 'PopCap Games',
			date: 2009,
			genre: [
				'Tower Defense'
			],
			characters: [
				'Dave'
			]
		},
		{
			name: 'The Sims',
			publisher: 'Electronic Arts',
			date: 2000,
			genre: [
				'Life simulation'
			],
			characters: []
		}
	];
		var name = 'l';
		name = name.toLowerCase();
		for(var i = 0; i < games.length; ++i)
		{
			var any = false;
			var j = 0;
			while(j < games[i].characters.length && !any)
			{
				any = games[i].characters[j].toLowerCase().indexOf(name) != -1;
				++j;
			}
			if(any)
				console.log(games[i].name);
		}
		
	
	</script>
</body>
</html>
```

02
===

``` javascript

function $(id) {
	return document.getElementById(id);
}

function init() {
	$('btnSugar').addEventListener('click', feladat2);
	$('btnUrl').addEventListener('click', feladat3);
	$('btnSzamlaloPlusz').onclick = function() { feladat5(1); };
	$('btnSzamlaloMinusz').onclick = function() { feladat5(-1); };
	$('btnTabla').addEventListener('click', feladat6);
	$('btnEvszam').addEventListener('click', feladat9);
	$('txtSzerzo').addEventListener('keyup', feladat9b);
}
window.addEventListener('load', init);

function szamolKeruletKor(r) {
	return 2 * r * Math.PI;
}

function feladat2() {
	var r = $('txtSugar').value;
	var k = szamolKeruletKor(r);
	$('spnKerulet').innerHTML = k;
}

function feladat3() {
	var url = $('txtUrl').value;
	$('imgKep').src = url;
}



function feladat5(n) {
	var num = $('txtSzamlalo').value;
	num -= -n;
	$('txtSzamlalo').value = num;
	var min = -1;
	var max = 10;
	if(min == num) {
		$('btnSzamlaloMinusz').disabled = true;
	} else if(max == num) {
		$('btnSzamlaloPlusz').disabled = true;
	}
}

function ujTablasor(cellak) {
	var s = "<tr>";
	var i = 0;
	while(true) {
		if(i == cellak.length) {
			break;
		} else {
			s += "<td>" + cellak[i] + "</td>";
		}
		i++;
	}
	//for(var i of cellak) {
		//s += "<td>" + i + "</td>";
	//}
	s += "</tr>";
	return s;
}

function feladat6() {
	var adatok = [
		$('ujSorAdat1').value,
		$('ujSorAdat2').value,
		$('ujSorAdat3').value
	];
	var sor = ujTablasor(adatok);
	$('tablazat').innerHTML += sor;
	$('ujSorAdat1').value =
	$('ujSorAdat2').value =
	$('ujSorAdat3').value = '';
}



var konyvtar = [
	{
		szerzo: "John Ajvide Lindqvist",
		cim: "Élőhalottak – Hogyan bánjunk velük?",
		kiado : "Könyvmolyképző Kiadó Kft.",
		ev : 2011
	},
	{
		szerzo : "Max Brooks",
		cim : "World War Z",
		kiado : "Könyvmolyképző Kiadó Kft.",
		ev : 2011
	},
	{
		szerzo : "Max Brooks",
		cim : "Zombi túlélő kézikönyv",
		kiado : "Könyvmolyképző Kiadó Kft.",
		ev : 2013
	},
	{
		szerzo : "Mira Grant",
		cim : "Feed – Etetés",
		kiado : "Lazi Kiadó",
		ev : 2012 
	}
];

function konyvek() {
	var kvek = [];
	var ev = $('txtEvszam').value;
	for(var i of konyvtar) {
		if(i.ev == ev) {
			kvek[kvek.length] = i;
		}
	}
	return kvek;
}

function feladat9() {
	var kvek = konyvek();
	var ki = "";
	for(var i of kvek) {
		ki += "<li>" + i.cim + "</li>";
	}
	$('konyvLista').innerHTML = ki;
	
}

function szerzok() {
	var kvek = [];
	var szerzo = $('txtSzerzo').value;
	for(var i of konyvtar) {
		if(i.szerzo.indexOf(szerzo) != -1) {
			var voltmar = false;
			for(var j of kvek) {
				voltmar = i.szerzo == j.szerzo || voltmar;
			}
			if(!voltmar)
				kvek[kvek.length] = i;
		}
	}
	return kvek;
}

function feladat9b() {
	var kvek = szerzok();
	var ki = "";
	for(var i of kvek) {
		ki += "<li>" + i.szerzo + "</li>";
	}
	$('szerzoLista').innerHTML = ki;
}
```

``` html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>X. gyakorlat - Webfejlesztés 2.</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link href="css/sablon.css" rel="stylesheet" media="screen">
		<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
		<script type="text/javascript" src="gyak.js"></script>
	</head>
	<body>
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container-fluid">
					<a class="brand" href="#">Webfejlesztés 2.</a>
				</div>
			</div>
		</div>
		
	    <div class="container-fluid">
			<div class="row-fluid">
				
				<div class="span3">
					<div class="well sidebar-nav">
						<ul class="nav nav-list">
							<li><a href="#feladat2">2. feladat</a></li>
							<li><a href="#feladat3">3. feladat</a></li>
							<li><a href="#feladat5">5. feladat</a></li>
							<li><a href="#feladat6">6. feladat</a></li>
							<li><a href="#feladat9">9. feladat</a></li>
						</ul>
					</div><!--/.well -->
				</div><!--/span-->
				
				<div class="span9">
					<div class="well">
						<h1>2. gyakorlat <small>Webfejlesztés 2.</small></h1>
					</div>
					
					<h2 id="feladatok">Feladatok</h2>
					
					<h3 id="feladat2">2. feladat</h3>
					<p>Írj egy kör kerületét kiszámoló programot!</p>
					<div class="megoldas well">
						<h4>Megoldas</h4>
						Sugár: <input type="text" id="txtSugar" />
						<input type="button" value="Kerület" id="btnSugar" />
						<p> Kerület: <span id="spnKerulet"> </span> </p>
					</div>

					<h3 id="feladat3">3. feladat</h3>
					<p>Egy szöveges beviteli mezőben legyen lehetőség megadni egy interneten elérhető kép URL-jét. Egy mellette lévő gombra kattintva jelenítsd meg a képet a dokumentumban!</p>
					<div class="megoldas well">
						<h4>Megoldas</h4>
						Kép linkje: <input type="text" id="txtUrl" />
						<input type="button" value="Mehet!" id="btnUrl" /> <br>
						<img src="https://oktato.neptun.elte.hu/App_Themes/New_Common_Images/loading.gif" id="imgKep"/>
					</div>

					<h3 id="feladat5">5. feladat</h3>
					<p>Készíts egy számlálót komponenst!</p>
					<p>a.A számláló egy csak olvasható szöveges beviteli mezőből és két gombból (plusz, mínusz) áll! A gombok meg nyomásával a szöveges beviteli mezőben lévő szám eggyel nő vagy csökken.</p>
					<p>b.Definiálj a szkriptben egy minimum és egy maximum értéket! Ha a számláló eléri valamelyik értéket, akkor a megfelelő gomb ne legyen elérhető!</p>
					<div class="megoldas well">
						<h4>Megoldas</h4>
						<input type="text" id="txtSzamlalo" value="0" readonly /> <input type="button" value="+" id="btnSzamlaloPlusz" /> <input type="button" value="-" id="btnSzamlaloMinusz" />
					</div>

					<h3 id="feladat6">6. feladat</h3>
					<p>Adott egy három oszlopból álló táblázat! A táblázat felett 3 szöveges beviteli mezővel és egy gombbal. A gombra kattintva a 3 beviteli mező értéke új sorként szúródjon be a táblázatba.</p>
					<div class="megoldas well">
						<h4>Megoldas</h4>
						Oszlopok:
						<input type="text" id="ujSorAdat1" value="" />
						<input type="text" id="ujSorAdat2" value="" />
						<input type="text" id="ujSorAdat3" value="" />
						<input type="button" id="btnTabla" value="Mehet!" />
						<br>
						<table id="tablazat">
						</table>
					</div>

					<h3 id="feladat9">9. feladat</h3>
					<p>Adott egy könyvtári nyilvántartás. Egy könyvről a következő adatokat tároljuk:</p>
					<ul>
					<li>szerző</li>
					<li>cím</li>
					<li>kiadás éve</li>
					<li>kiadó</li>
					<li>ISBN szám</li>
					</ul>
					</p>
					<p>a.Felületen kérj be egy évszámot, és listázd ki az abban az évben megjelent könyvcímeket!</p>
					<p>b.Egy beviteli mezőben gépelve folyamatosan frissíts egy listát, melyben azok a szerzők jelennek meg, kiknek neve tartalmazza a beviteli mezőbe beírt szövegrészletet!</p>
					<div class="megoldas well">
						<h4>Megoldas</h4>
						Év: <input type="text" id ="txtEvszam" value="2011" /> <input type="button" id="btnEvszam" value="Listázd!" />
						<ul id="konyvLista">
						</ul>
						<br>
						Szerző: <input type="text" id ="txtSzerzo" value="" />
						<ul id="szerzoLista">
						</ul>
					</div>


				</div><!--/span-->
				
			</div><!--/row-->
		</div>
	</body>
</html>
```
