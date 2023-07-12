extends Node

var logo_paths: Dictionary = {
		"Burger King":"res://assets/Logos/Lesson1/burgerking.webp",
		"Coca Cola":"res://assets/Logos/Lesson1/cocacola.webp",
		"Domino's":"res://assets/Logos/Lesson1/dominos.webp",
		"Doritos":"res://assets/Logos/Lesson1/doritos.webp",
		"Dunkin":"res://assets/Logos/Lesson1/dunkin.webp",
		"Gerber":"res://assets/Logos/Lesson1/gerber.webp",
		"KFC":"res://assets/Logos/Lesson1/kfc.webp",
		"Knorr":"res://assets/Logos/Lesson1/knorr.webp",
		"Lay's":"res://assets/Logos/Lesson1/lays.webp",
		"Lipton":"res://assets/Logos/Lesson1/lipton.webp",
		"McDonald's":"res://assets/Logos/Lesson1/mcdonalds.webp",
		"Monster":"res://assets/Logos/Lesson1/monster.webp",
		"Pepsi":"res://assets/Logos/Lesson1/pepsi.webp",
		"Pizza Hut":"res://assets/Logos/Lesson1/pizzahut.webp",
		"Pringles":"res://assets/Logos/Lesson1/pringles.webp",
		"Snickers":"res://assets/Logos/Lesson1/snickers.webp",
		"Starbucks":"res://assets/Logos/Lesson1/starbucks.webp",
		"Subway":"res://assets/Logos/Lesson1/subway.webp",
		"Taco Bell":"res://assets/Logos/Lesson1/tacobell.webp",
		"Wendy's":"res://assets/Logos/Lesson1/wendys.webp",

		"Amazon":"res://assets/Logos/Lesson2/amazon.webp",
		"Android":"res://assets/Logos/Lesson2/android.webp",
		"Apple":"res://assets/Logos/Lesson2/apple.webp",
		"Atari":"res://assets/Logos/Lesson2/atari.webp",
		"Dell":"res://assets/Logos/Lesson2/dell.webp",
		"Dolby":"res://assets/Logos/Lesson2/dolby.webp",
		"Excel":"res://assets/Logos/Lesson2/excel.webp",
		"Facebook":"res://assets/Logos/Lesson2/facebook.webp",
		"Firefox":"res://assets/Logos/Lesson2/firefox.webp",
		"Gmail":"res://assets/Logos/Lesson2/gmail.webp",
		"Google":"res://assets/Logos/Lesson2/google.webp",
		"Instagram":"res://assets/Logos/Lesson2/instagram.webp",
		"Intel":"res://assets/Logos/Lesson2/intel.webp",
		"Kodak":"res://assets/Logos/Lesson2/kodak.webp",
		"LG":"res://assets/Logos/Lesson2/lg.webp",
		"Microsoft":"res://assets/Logos/Lesson2/microsoft.webp",
		"Nintendo":"res://assets/Logos/Lesson2/nintendo.webp",
		"Paypal":"res://assets/Logos/Lesson2/paypal.webp",
		"Reddit":"res://assets/Logos/Lesson2/reddit.webp",
		"Safari":"res://assets/Logos/Lesson2/safari.webp",
		"Samsung":"res://assets/Logos/Lesson2/samsung.webp",
		"Skype":"res://assets/Logos/Lesson2/skype.webp",
		"Snapchat":"res://assets/Logos/Lesson2/snapchat.webp",
		"Spotify":"res://assets/Logos/Lesson2/spotify.webp",
		"T-Mobile":"res://assets/Logos/Lesson2/tmobile.webp",
		"Twitter":"res://assets/Logos/Lesson2/twitter.webp",
		"Visa":"res://assets/Logos/Lesson2/visa.webp",
		"Wikipedia":"res://assets/Logos/Lesson2/wikipedia.webp",
		"Xbox":"res://assets/Logos/Lesson2/xbox.webp",
		"Xerox":"res://assets/Logos/Lesson2/xerox.webp",
		"Yahoo":"res://assets/Logos/Lesson2/yahoo.webp",
		"YouTube":"res://assets/Logos/Lesson2/youtube.webp",

		"Adidas":"res://assets/Logos/Lesson3/adidas.webp",
		"Air Jordan":"res://assets/Logos/Lesson3/airjordan.webp",
		"Carhartt":"res://assets/Logos/Lesson3/carhartt.webp",
		"Champion":"res://assets/Logos/Lesson3/champion.webp",
		"Chanel":"res://assets/Logos/Lesson3/chanel.webp",
		"Fila":"res://assets/Logos/Lesson3/fila.webp",
		"Gap":"res://assets/Logos/Lesson3/gap.webp",
		"Gucci":"res://assets/Logos/Lesson3/gucci.webp",
		"Guess":"res://assets/Logos/Lesson3/guess.webp",
		"Kangol":"res://assets/Logos/Lesson3/kangol.webp",
		"Lacoste":"res://assets/Logos/Lesson3/lacoste.webp",
		"Levi's":"res://assets/Logos/Lesson3/levi.webp",
		"Louis Vuitton":"res://assets/Logos/Lesson3/louis.webp",
		"Lululemon":"res://assets/Logos/Lesson3/lululemon.webp",
		"New Balance":"res://assets/Logos/Lesson3/newbalance.webp",
		"Nike":"res://assets/Logos/Lesson3/nike.webp",
		"Puma":"res://assets/Logos/Lesson3/puma.webp",
		"Rolex":"res://assets/Logos/Lesson3/rolex.webp",
		"Starter":"res://assets/Logos/Lesson3/starter.webp",
		"Swarovski":"res://assets/Logos/Lesson3/swarovski.webp",
		"Tiffany":"res://assets/Logos/Lesson3/tiffany.webp",
		"Tommy Hilfiger":"res://assets/Logos/Lesson3/tommy.webp",
		"Umbro":"res://assets/Logos/Lesson3/umbro.webp",
		"Under Armour":"res://assets/Logos/Lesson3/underarmour.webp",
		"Wilson":"res://assets/Logos/Lesson3/wilson.webp",

		"Acura":"res://assets/Logos/Lesson4/acura.webp",
		"Alfa Romeo":"res://assets/Logos/Lesson4/alfaromeo.webp",
		"Audi":"res://assets/Logos/Lesson4/audi.webp",
		"Bentley":"res://assets/Logos/Lesson4/bentley.webp",
		"BMW":"res://assets/Logos/Lesson4/bmw.webp",
		"Buick":"res://assets/Logos/Lesson4/buick.webp",
		"Cadillac":"res://assets/Logos/Lesson4/cadillac.webp",
		"Chevrolet":"res://assets/Logos/Lesson4/chevrolet.webp",
		"Corvette":"res://assets/Logos/Lesson4/corvette.webp",
		"Ferrari":"res://assets/Logos/Lesson4/ferrari.webp",
		"Fiat":"res://assets/Logos/Lesson4/fiat.webp",
		"Ford":"res://assets/Logos/Lesson4/ford.webp",
		"Honda":"res://assets/Logos/Lesson4/honda.webp",
		"Hyundai":"res://assets/Logos/Lesson4/hyundai.webp",
		"Infiniti":"res://assets/Logos/Lesson4/infiniti.webp",
		"Jaguar":"res://assets/Logos/Lesson4/jaguar.webp",
		"Lexus":"res://assets/Logos/Lesson4/lexus.webp",
		"Lincoln":"res://assets/Logos/Lesson4/lincoln.webp",
		"Maserati":"res://assets/Logos/Lesson4/maserati.webp",
		"Mazda":"res://assets/Logos/Lesson4/mazda.webp",
		"Mercedes":"res://assets/Logos/Lesson4/mercedes.webp",
		"Mini":"res://assets/Logos/Lesson4/mini.webp",
		"Mustang":"res://assets/Logos/Lesson4/mustang.webp",
		"Nissan":"res://assets/Logos/Lesson4/nissan.webp",
		"Opel":"res://assets/Logos/Lesson4/opel.webp",
		"Peugeot":"res://assets/Logos/Lesson4/peugeot.webp",
		"Porsche":"res://assets/Logos/Lesson4/porsche.webp",
		"Scion":"res://assets/Logos/Lesson4/scion.webp",
		"Seat":"res://assets/Logos/Lesson4/seat.webp",
		"Skoda":"res://assets/Logos/Lesson4/skoda.webp",
		"Subaru":"res://assets/Logos/Lesson4/subaru.webp",
		"Suzuki":"res://assets/Logos/Lesson4/suzuki.webp",
		"Tesla":"res://assets/Logos/Lesson4/tesla.webp",
		"Toyota":"res://assets/Logos/Lesson4/toyota.webp",
		"Volvo":"res://assets/Logos/Lesson4/volvo.webp",

		"Austria":"res://assets/Logos/Lesson5/austria.webp",
		"Belgium":"res://assets/Logos/Lesson5/belgium.webp",
		"Bulgaria":"res://assets/Logos/Lesson5/bulgaria.webp",
		"Croatia":"res://assets/Logos/Lesson5/croatia.webp",
		"Czech Republic":"res://assets/Logos/Lesson5/czech.webp",
		"Estonia":"res://assets/Logos/Lesson5/estonia.webp",
		"Finland":"res://assets/Logos/Lesson5/finland.webp",
		"France":"res://assets/Logos/Lesson5/france.webp",
		"Germany":"res://assets/Logos/Lesson5/germany.webp",
		"Greece":"res://assets/Logos/Lesson5/greece.webp",
		"Ireland":"res://assets/Logos/Lesson5/ireland.webp",
		"Italy":"res://assets/Logos/Lesson5/italy.webp",
		"Latvia":"res://assets/Logos/Lesson5/latvia.webp",
		"Lithuania":"res://assets/Logos/Lesson5/lithuania.webp",
		"North Macedonia":"res://assets/Logos/Lesson5/macedonia.webp",
		"Norway":"res://assets/Logos/Lesson5/norway.webp",
		"Poland":"res://assets/Logos/Lesson5/poland.webp",
		"Portugal":"res://assets/Logos/Lesson5/portugal.webp",
		"Romania":"res://assets/Logos/Lesson5/romania.webp",
		"Serbia":"res://assets/Logos/Lesson5/serbia.webp",
		"Slovenia":"res://assets/Logos/Lesson5/slovenia.webp",
		"Spain":"res://assets/Logos/Lesson5/spain.webp",
		"Sweden":"res://assets/Logos/Lesson5/sweden.webp",
		"United Kingdom":"res://assets/Logos/Lesson5/uk.webp",
		"Ukraine":"res://assets/Logos/Lesson5/ukraine.webp",

		"Argentina":"res://assets/Logos/Lesson6/argentina.webp",
		"Bolivia":"res://assets/Logos/Lesson6/bolivia.webp",
		"Brazil":"res://assets/Logos/Lesson6/brazil.webp",
		"Canada":"res://assets/Logos/Lesson6/canada.webp",
		"Chile":"res://assets/Logos/Lesson6/chile.webp",
		"Columbia":"res://assets/Logos/Lesson6/columbia.webp",
		"Cuba":"res://assets/Logos/Lesson6/cuba.webp",
		"Ecuador":"res://assets/Logos/Lesson6/ecuador.webp",
		"El Salvador":"res://assets/Logos/Lesson6/elsalvador.webp",
		"Guatemala":"res://assets/Logos/Lesson6/guatemala.webp",
		"Honduras":"res://assets/Logos/Lesson6/honduras.webp",
		"Jamaica":"res://assets/Logos/Lesson6/jamaica.webp",
		"Mexico":"res://assets/Logos/Lesson6/mexico.webp",
		"Nicaragua":"res://assets/Logos/Lesson6/nicaragua.webp",
		"Panama":"res://assets/Logos/Lesson6/panama.webp",
		"Paraguay":"res://assets/Logos/Lesson6/paraguay.webp",
		"Peru":"res://assets/Logos/Lesson6/peru.webp",
		"Uruguay":"res://assets/Logos/Lesson6/uruguay.webp",
		"United States":"res://assets/Logos/Lesson6/usa.webp",
		"Venezuela":"res://assets/Logos/Lesson6/venezuela.webp",

		"Armenia":"res://assets/Logos/Lesson7/armenia.webp",
		"Bahrain":"res://assets/Logos/Lesson7/bahrain.webp",
		"Bhutan":"res://assets/Logos/Lesson7/bhutan.webp",
		"Brunei":"res://assets/Logos/Lesson7/brunei.webp",
		"Cambodia":"res://assets/Logos/Lesson7/cambodia.webp",
		"China":"res://assets/Logos/Lesson7/china.webp",
		"Cyprus":"res://assets/Logos/Lesson7/cyprus.webp",
		"East Timor":"res://assets/Logos/Lesson7/easttimor.webp",
		"Georgia":"res://assets/Logos/Lesson7/georgia.webp",
		"India":"res://assets/Logos/Lesson7/india.webp",
		"Indonesia":"res://assets/Logos/Lesson7/indonesia.webp",
		"Iran":"res://assets/Logos/Lesson7/iran.webp",
		"Iraq":"res://assets/Logos/Lesson7/iraq.webp",
		"Israel":"res://assets/Logos/Lesson7/israel.webp",
		"Japan":"res://assets/Logos/Lesson7/japan.webp",
		"Jordan":"res://assets/Logos/Lesson7/jordan.webp",
		"Kuwait":"res://assets/Logos/Lesson7/kuwait.webp",
		"Laos":"res://assets/Logos/Lesson7/laos.webp",
		"Lebanon":"res://assets/Logos/Lesson7/lebanon.webp",
		"Malaysia":"res://assets/Logos/Lesson7/malaysia.webp",
		"Maldives":"res://assets/Logos/Lesson7/maldives.webp",
		"Mongolia":"res://assets/Logos/Lesson7/mongolia.webp",
		"Myanmar":"res://assets/Logos/Lesson7/myanmar.webp",
		"Nepal":"res://assets/Logos/Lesson7/nepal.webp",
		"North Korea":"res://assets/Logos/Lesson7/northkorea.webp",
		"Oman":"res://assets/Logos/Lesson7/oman.webp",
		"Pakistan":"res://assets/Logos/Lesson7/pakistan.webp",
		"Qatar":"res://assets/Logos/Lesson7/qatar.webp",
		"Russia":"res://assets/Logos/Lesson7/russia.webp",
		"Saudi Arabia":"res://assets/Logos/Lesson7/saudi arabia.webp",
		"Singapore":"res://assets/Logos/Lesson7/singapore.webp",
		"South Korea":"res://assets/Logos/Lesson7/southkorea.webp",
		"Sri Lanka":"res://assets/Logos/Lesson7/srilanka.webp",
		"Syria":"res://assets/Logos/Lesson7/syria.webp",
		"Taiwan":"res://assets/Logos/Lesson7/taiwan.webp",
		"Thailand":"res://assets/Logos/Lesson7/thailand.webp",
		"Turkey":"res://assets/Logos/Lesson7/turkey.webp",
		"United Arab Emirates":"res://assets/Logos/Lesson7/unitedarabemirates.webp",
		"Vietnam":"res://assets/Logos/Lesson7/vietnam.webp",
		"Yemen":"res://assets/Logos/Lesson7/yemen.webp",

		"Algeria":"res://assets/Logos/Lesson8/algeria.webp",
		"Angola":"res://assets/Logos/Lesson8/angola.webp",
		"Benin":"res://assets/Logos/Lesson8/benin.webp",
		"Botswana":"res://assets/Logos/Lesson8/botswana.webp",
		"Burkina Faso":"res://assets/Logos/Lesson8/burkinafaso.webp",
		"Burundi":"res://assets/Logos/Lesson8/burundi.webp",
		"Cameroon":"res://assets/Logos/Lesson8/cameroon.webp",
		"Cape Verde":"res://assets/Logos/Lesson8/capeverde.webp",
		"Chad":"res://assets/Logos/Lesson8/chad.webp",
		"Comoros":"res://assets/Logos/Lesson8/comoros.webp",
		"Djibouti":"res://assets/Logos/Lesson8/djibouti.webp",
		"Egypt":"res://assets/Logos/Lesson8/egypt.webp",
		"Eritrea":"res://assets/Logos/Lesson8/eritrea.webp",
		"Eswatini":"res://assets/Logos/Lesson8/eswatini.webp",
		"Ethiopia":"res://assets/Logos/Lesson8/ethiopia.webp",
		"Gabon":"res://assets/Logos/Lesson8/gabon.webp",
		"Gambia":"res://assets/Logos/Lesson8/gambia.webp",
		"Ghana":"res://assets/Logos/Lesson8/ghana.webp",
		"Guinea":"res://assets/Logos/Lesson8/guinea.webp",
		"Ivory Coast":"res://assets/Logos/Lesson8/ivorycoast.webp",
		"Kenya":"res://assets/Logos/Lesson8/kenya.webp",
		"Lesotho":"res://assets/Logos/Lesson8/lesotho.webp",
		"Liberia":"res://assets/Logos/Lesson8/liberia.webp",
		"Libya":"res://assets/Logos/Lesson8/libya.webp",
		"Malawi":"res://assets/Logos/Lesson8/malawi.webp",
		"Mali":"res://assets/Logos/Lesson8/mali.webp",
		"Mauritius":"res://assets/Logos/Lesson8/mauritius.webp",
		"Morocco":"res://assets/Logos/Lesson8/morocco.webp",
		"Namibia":"res://assets/Logos/Lesson8/namibia.webp",
		"Niger":"res://assets/Logos/Lesson8/niger.webp",
		"Nigeria":"res://assets/Logos/Lesson8/nigeria.webp",
		"Rwanda":"res://assets/Logos/Lesson8/rwanda.webp",
		"Senegal":"res://assets/Logos/Lesson8/senegal.webp",
		"Sierra Leone":"res://assets/Logos/Lesson8/sierraleone.webp",
		"Somalia":"res://assets/Logos/Lesson8/somalia.webp",
		"South Africa":"res://assets/Logos/Lesson8/southafrica.webp",
		"South Sudan":"res://assets/Logos/Lesson8/southsudan.webp",
		"Sudan":"res://assets/Logos/Lesson8/sudan.webp",
		"Tanzania":"res://assets/Logos/Lesson8/tanzania.webp",
		"Togo":"res://assets/Logos/Lesson8/togo.webp",
		"Tunisia":"res://assets/Logos/Lesson8/tunisia.webp",
		"Uganda":"res://assets/Logos/Lesson8/uganda.webp",
		"Zambia":"res://assets/Logos/Lesson8/zambia.webp",
		"Zimbabwe":"res://assets/Logos/Lesson8/zimbabwe.webp",
}

var logos_in_levels: Dictionary = {
		"Lesson1":[
			"Burger King","Coca Cola","Domino's","Doritos","Dunkin","Gerber","KFC","Knorr","Lay's","Lipton","McDonald's","Monster","Pepsi","Pizza Hut","Pringles","Snickers","Starbucks","Subway","Taco Bell","Wendy's"
		],
		"Test1":[
			"Burger King","Coca Cola","Domino's","Doritos","Dunkin","Gerber","KFC","Knorr","Lay's","Lipton","McDonald's","Monster","Pepsi","Pizza Hut","Pringles","Snickers","Starbucks","Subway","Taco Bell","Wendy's"
		],
		"Lesson2":[
			"Amazon","Android","Atari","Dolby","Excel","Firefox","Google","Instagram","LG","Microsoft","Nintendo","Reddit","Samsung","Skype","T-Mobile","Visa"
		],
		"Lesson3":[
			"Apple","Dell","Facebook","Gmail","Intel","Kodak","Paypal","Safari","Snapchat","Spotify","Twitter","Wikipedia","Xbox","Xerox","Yahoo","YouTube"
		],
		"Test2":[
			"Amazon","Android","Atari","Dolby","Excel","Firefox","Google","Instagram","LG","Microsoft","Nintendo","Reddit","Samsung","Skype","T-Mobile","Visa",
			"Apple","Dell","Facebook","Gmail","Intel","Kodak","Paypal","Safari","Snapchat","Spotify","Twitter","Wikipedia","Xbox","Xerox","Yahoo","YouTube"
		],
		"Lesson4":[
			"Adidas","Air Jordan","Carhartt","Champion","Chanel","Fila","Gap","Gucci","Guess","Kangol","Lacoste","Levi's","Louis Vuitton","Lululemon","New Balance","Nike","Puma","Rolex","Starter","Swarovski","Tiffany","Tommy Hilfiger","Umbro","Under Armour","Wilson"
		],
		"Test3":[
			"Adidas","Air Jordan","Carhartt","Champion","Chanel","Fila","Gap","Gucci","Guess","Kangol","Lacoste","Levi's","Louis Vuitton","Lululemon","New Balance","Nike","Puma","Rolex","Starter","Swarovski","Tiffany","Tommy Hilfiger","Umbro","Under Armour","Wilson"
		],
		"Lesson5":[
			"Acura","Audi","Bentley","BMW","Ci migadillac","Ferrari","Fiat","Honda","Jaguar","Lexus","Mazda","Mini","Mustang","Opel","Seat"
		],
		"Lesson6":[
			"Alfa Romeo","Buick","Chevrolet","Corvette","Ford","Hyundai","Infiniti","Lincoln","Maserati","Mercedes","Nissan","Peugeot","Porsche","Scion","Skoda","Subaru","Suzuki","Tesla","Toyota","Volvo"
		],
		"Test4":[
			"Acura","Audi","Bentley","BMW","Cadillac","Ferrari","Fiat","Honda","Jaguar","Lexus","Mazda","Mini","Mustang","Opel","Seat","Alfa Romeo","Buick","Chevrolet","Corvette","Ford","Hyundai","Infiniti","Lincoln","Maserati","Mercedes","Nissan","Peugeot","Porsche","Scion","Skoda","Subaru","Suzuki","Tesla","Toyota","Volvo"
		],
		"Exam1":[
			"Burger King","Coca Cola","Domino's","Doritos","Dunkin","Gerber","KFC","Knorr","Lay's","Lipton","McDonald's","Monster","Pepsi","Pizza Hut","Pringles","Snickers","Starbucks","Subway","Taco Bell","Wendy's",
			"Amazon","Android","Atari","Dolby","Excel","Firefox","Google","Instagram","LG","Microsoft","Nintendo","Reddit","Samsung","Skype","T-Mobile","Visa",
			"Apple","Dell","Facebook","Gmail","Intel","Kodak","Paypal","Safari","Snapchat","Spotify","Twitter","Wikipedia","Xbox","Xerox","Yahoo","YouTube",
			"Adidas","Air Jordan","Carhartt","Champion","Chanel","Fila","Gap","Gucci","Guess","Kangol","Lacoste","Levi's","Louis Vuitton","Lululemon","New Balance","Nike","Puma","Rolex","Starter","Swarovski","Tiffany","Tommy Hilfiger","Umbro","Under Armour","Wilson",
			"Acura","Audi","Bentley","BMW","Cadillac","Ferrari","Fiat","Honda","Jaguar","Lexus","Mazda","Mini","Mustang","Opel","Seat","Alfa Romeo","Buick","Chevrolet","Corvette","Ford","Hyundai","Infiniti","Lincoln","Maserati","Mercedes","Nissan","Peugeot","Porsche","Scion","Skoda","Subaru","Suzuki","Tesla","Toyota","Volvo"
		],

		"Lesson7":[
			"Austria","Belgium","Bulgaria","Croatia","Czech Republic","Estonia","Finland","France","Germany","Greece","Ireland","Italy","Latvia","Lithuania","North Macedonia","Norway","Poland","Portugal","Romania","Slovenia","Serbia","Spain","Sweden","United Kingdom","Ukraine"
		],
		"Test5":[
			"Austria","Belgium","Bulgaria","Croatia","Czech Republic","Estonia","Finland","France","Germany","Greece","Ireland","Italy","Latvia","Lithuania","North Macedonia","Norway","Poland","Portugal","Romania","Slovenia","Serbia","Spain","Sweden","United Kingdom","Ukraine"
		],
		"Lesson8":[
			"Argentina","Bolivia","Brazil","Canada","Chile","Columbia","Cuba","Ecuador","El Salvador","Guatemala","Honduras","Jamaica","Mexico","Nicaragua","Panama","Paraguay","Peru","Uruguay","United States","Venezuela"
		],
		"Test6":[
			"Argentina","Bolivia","Brazil","Canada","Chile","Columbia","Cuba","Ecuador","El Salvador","Guatemala","Honduras","Jamaica","Mexico","Nicaragua","Panama","Paraguay","Peru","Uruguay","United States","Venezuela"
		],
		"Lesson9":[
			"Armenia","Bhutan","China","Cyprus","Georgia","India","Indonesia","Iran","Japan","Jordan","Malaysia","Mongolia","Pakistan","Nepal","South Korea","Taiwan","Syria","Turkey","Vietnam","Yemen"
		],
		"Lesson10":[
			"Bahrain","Brunei","Cambodia","East Timor","Iraq","Israel","Kuwait","Laos","Lebanon","Maldives","Myanmar","North Korea","Oman","Qatar","Russia","Saudi Arabia","Sri Lanka","Thailand","United Arab Emirates","Singapore"
		],
		"Test7":[
			"Armenia","Bhutan","China","Cyprus","Georgia","India","Indonesia","Iran","Japan","Jordan","Malaysia","Mongolia","Pakistan","Nepal","South Korea","Taiwan","Syria","Turkey","Vietnam","Yemen","Bahrain","Brunei","Cambodia","East Timor","Iraq","Israel","Kuwait","Laos","Lebanon","Maldives","Myanmar","North Korea","Oman","Qatar","Russia","Saudi Arabia","Sri Lanka","Thailand","United Arab Emirates","Singapore"
		],
		"Lesson11":[
			"Algeria","Angola","Botswana","Chad","Egypt","Eritrea","Gambia","Ghana","Kenya","Liberia","Libya","Mali","Morocco","Niger","Senegal","Sierra Leone","Somalia","South Africa","Sudan","Tunisia","Zambia","Zimbabwe"
		],
		"Lesson12":[
			"Benin","Burkina Faso","Burundi","Cameroon","Cape Verde","Comoros","Djibouti","Eswatini","Ethiopia","Gabon","Guinea","Ivory Coast","Lesotho","Malawi","Mauritius","Namibia","Nigeria","Rwanda","Uganda","South Sudan","Tanzania","Togo"
		],
		"Test8":[
			"Algeria","Angola","Botswana","Chad","Egypt","Eritrea","Gambia","Ghana","Kenya","Liberia","Libya","Mali","Morocco","Niger","Senegal","Sierra Leone","Somalia","South Africa","Sudan","Tunisia","Zambia","Zimbabwe","Benin","Burkina Faso","Burundi","Cameroon","Cape Verde","Comoros","Djibouti","Eswatini","Ethiopia","Gabon","Guinea","Ivory Coast","Lesotho","Malawi","Mauritius","Namibia","Nigeria","Rwanda","Uganda","South Sudan","Tanzania","Togo"
		],
		"Exam2":[
			"Austria","Belgium","Bulgaria","Croatia","Czech Republic","Estonia","Finland","France","Germany","Greece","Ireland","Italy","Latvia","Lithuania","North Macedonia","Norway","Poland","Portugal","Romania","Slovenia","Serbia","Spain","Sweden","United Kingdom","Ukraine",
			"Argentina","Bolivia","Brazil","Canada","Chile","Columbia","Cuba","Ecuador","El Salvador","Guatemala","Honduras","Jamaica","Mexico","Nicaragua","Panama","Paraguay","Peru","Uruguay","United States","Venezuela",
			"Armenia","Bhutan","China","Cyprus","Georgia","India","Indonesia","Iran","Japan","Jordan","Malaysia","Mongolia","Pakistan","Nepal","South Korea","Taiwan","Syria","Turkey","Vietnam","Yemen","Bahrain","Brunei","Cambodia","East Timor","Iraq","Israel","Kuwait","Laos","Lebanon","Maldives","Myanmar","North Korea","Oman","Qatar","Russia","Saudi Arabia","Sri Lanka","Thailand","United Arab Emirates","Singapore",
			"Algeria","Angola","Botswana","Chad","Egypt","Eritrea","Gambia","Ghana","Kenya","Liberia","Libya","Mali","Morocco","Niger","Senegal","Sierra Leone","Somalia","South Africa","Sudan","Tunisia","Zambia","Zimbabwe","Benin","Burkina Faso","Burundi","Cameroon","Cape Verde","Comoros","Djibouti","Eswatini","Ethiopia","Gabon","Guinea","Ivory Coast","Lesotho","Malawi","Mauritius","Namibia","Nigeria","Rwanda","Uganda","South Sudan","Tanzania","Togo"
		]
}

var level_question_amount: Dictionary = {
		"Lesson1":20,
		"Test1":10,
		"Lesson2":16,
		"Lesson3":16,
		"Test2":20,
		"Lesson4":25,
		"Test3":15,
		"Lesson5":15,
		"Lesson6":20,
		"Test4":20,
		"Exam1":35,

		"Lesson7":25,
		"Test5":15,
		"Lesson8":20,
		"Test6":15,
		"Lesson9":20,
		"Lesson10":20,
		"Test7":25,
		"Lesson11":22,
		"Lesson12":22,
		"Test8":30,
		"Exam2":50,
}

var time_for_test: Dictionary = {
		"Test1":100,
		"Test2":180,
		"Test3":135,
		"Test4":180,
		"Exam1":300,
		"Test5":220,
		"Test6":100,
		"Test7":180,
		"Test8":240,
		"Exam2":500,
}

var random_lessons = ["Test1","Test2","Test3","Test4","Test5","Test6","Test7","Test8"]
var used_logos = []

func get_random_logo(lesson: String) -> String:
	var logo = ""
	var logo_array: Array = logos_in_levels[lesson]

	if used_logos.size() == logo_array.size():
		return ""

	while true:
		logo = logo_array.pick_random()
		if used_logos.has(logo):
			continue
		else:
			break

	used_logos.append(logo)

	return logo
