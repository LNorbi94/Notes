Web-fejlesztés 2.
=== 

## 2016. február 10. ##

Javascript beillesztése HTML állományba:
``` HTML
	<!-- inline -->
	<script type="text/javascript">
		<!-- JavaScript instant! -->
	</script>
	
	<!-- from source file -->
	<script src="whatever.js" type="text/javascript"></script>
	
	<!-- or directly into console (f12) -->
```

Kommunikáció fehasználóval:
``` javascript
	// console
	console.log("Hello World!");
	
	// alert
	alert("Hello World!");
	
	// prompt
	prompt("What do you want to do today?", "Greet the world like every day.");
	
	// confirm - Yes for Hodor, no for Hodor
	confirm("Hodor?");
	
	// directly into document
	document.writeln("Hello World!");

```

Vezérlési szerkezetek hasonlóan C++ -hoz:
``` javascript
	if(condition)
	{ } else if(..) ...
	
	while(condition)
	{ }
	
	do
	{ } while (condition);
	
	switch(condition)
	{
		case 1: // do something
		break;
		default: // do something else
	}
	
	for(var i = 0; i < n; ++i)
	{ }
	
	// Object
	for(var i of array)
	{ }
	
	// Index
	for(var i in array)
	{ }
```

Tömbök:
``` javascript
	var t = [];
	t[t.length] = 3;
	t[t.length] = 'a';
	t.length; 					// => 1
	t[0]; 						// => 3
	t[1]; 						// => 'a'
	
	// only for user-defined properties
	delete t[1];
	
	1 in t; // => false
	0 in t; // => true
```

Gyengén típusos nyelv:
``` javascript
	var i = 0;
	i = "almafa";
```

Műveletek kiértékelése lvalue-tól függ:
``` javascript
	var a = "0";
	a += 1; 	// = 01
	a -= (-1)	// on original variable it will return 1
```

Függvények:
``` javascript
	// valid function, return will be undefined any given time.
	function areYouAnIdiot()
	{
		if(false)
			return false;
	}
```

## 2016. február 17. ##

HTML elemek elérése javascript-ből:
``` javascript
	document.getElementById('name')
	document.querySelector('#name')
	document.querySelector('input[type=text]')
	document.querySelector('body > form:nth-child(1) > input:nth-child(1)')
	
	// Getting every element:
	var inputs = document.querySelectorAll('input');

	// For fast use:
	function $(id)
	{ return document.querySelector(id); }
	function $$(id)
	{ return document.querySelectorAll(id); }
	

```

Egéresemények:
* click
* dblclick
* mouseup
* mousedown
* mouseover
* mousemove
* mouseout

Billentyűzetesemények:
* keydown
* keyup
* keypress

Oldalesemények:
* load (window, frame, object, image)
* unload (window, frame)
* abort (image, object)
* error (object, image, frame)
* resize (document)
* scroll (document)

Űrlap- és űrlapelemesemények:
* submit (form)
* reset (form)
* select (input, textarea)
* change (input, select, textarea)
* focus (input, select, textarea, label, button)
* blur (input, select, textarea, label, button)

Események hozzáadása / elvétele:
``` javascript
	elem.addEventListener('type', funct, false);
	elem.removeEventListener('type', funct, false);
	
	// function must be function, so calling it with parameters:
	elem.type = function() { funct(parameter1, 2, ...); };
```

Belső tartalom elérése:
``` javascript
	elem.innerHTML = "Hello World"; // where, for instance, elem is a <p> element.
```
