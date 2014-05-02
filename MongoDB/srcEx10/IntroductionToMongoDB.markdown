#MongoDB - ExWeek 10

##Installation on OS X

**Bash:**

	brew update
	brew install mongoDB
	
	mkdir /data/db/
	chown -r username /data/db
	
	#Start Server
	mongod
	
	#Start Mongo Console
	mongo
	
##Exercise 01
These commands need to be entered into the mongo console unless specified otherwise. These exercises are based on the [little-monogdb-book](https://github.com/karlseguin/the-little-mongodb-book/blob/master/en/mongodb.markdown).

**1. Create a database named ex01**

	use ex01
*Doesn't actually create the db until you store something in it.*

**2. Create a collection with one element**

	db.unicorns.insert({name: 'Aurora',
    gender: 'f', weight: 450})
*Creates a collection called unicorns with one unicorn in it.*

**3. Get alle elements inside the collection**
	
	db.unicorns.find()
	
**4. Add another element to the collection with different properties**

	db.unicorns.insert({name: 'Leto', gender: 'm', home: 'Arrakeen', worm:false})
*Apparently it doesn't matter what properties the elements have that we insert into a collection*

**5. Export the collection into a file**

	mongoexport --db ex1 -collection unicorns --out ~/test/unicornCollection
*This needs to be executed in bash and not in the mongo console.*

**6. Delete the unicorns collection**

	db.unicorns.remove({})
*Using just unicorns.remove() doesn't work for some reason even though it says so in the exercise.*

**7. Re-Import the unicorn collection from the file**

	mongoimport ~/test/unicornCollection
*It has now re-imported the collection, but under a different name. It uses the filename as name for the collection. I assume there's a argument that can be used to specify the collection name on import*

##Exercise 02
For this exercise we first need to import a bunch of data and make a new db called ex02. See http://wiki.hsr.ch/Datenbanken/Dbs2FS14UebW10 for more info.

**1. Find the unicorn with the name "Aurora"**

	db.unicorns.find({"name": "Aurora"})

**2. Find all females that like apples**
	
	db.unicorns.find({"gender":"f", "loves":"apple"})
	
**3. Find all females that like apples and carrots**
	
	db.unicorns.find({gender:"f",loves:{ $all:["apple","carrot"]}})
	
**4. Find all females that like apples or carrots**

	db.unicorns.find({"gender": "f", $or: [{"loves":"apple"}, {"loves":"carrot"}]})
*To make a or-statement: "$or: [{someProperties: "whatever"}, {someOtherProp: "whatever"}]"*
	
**5. Find everyone with a weight between 600 and 900**

	db.unicorns.find({$and: [{weight: {$gte: 600}}, {weight: {$lte: 900}}]})
*gte = greater then or equal, lte = less then or equal*

**6. Return only the names and gender of all females the like carrots and apples**

	db.unicorns.find({gender:"f",loves:{ $all:["apple","carrot"]}}, {"name":1, "gender":1})
*Apparently we need to specify that there is a value assign to "name" by adding :1. ("name":"whatever" works too)*

##Exercise 3
**1. Run the command below**

	db.unicorns.update({name: 'Roooooodles'}, {weight: 590})

**2. What changed?**  
We're unable to find the unicorn named "Roo**dles".

**3. What's the correct command to "update" a value?**

	db.unicorns.update({name: 'Solnara'},{$set: {weight: 590}})
*Though I'm still not entirely sure what happend to our Ro..odles.. For all I know it has disappear from the face of the earth lol.*

**4. Add "suger" to the things the unicorn "Aurora" likes**

	db.unicorns.update({name: 'Aurora'},{$push: {loves: "suger"}})
*So we can add things to an array with $push*

**5. Add "tomato" to the things all female unicorns that like carrots and apples like.**

	db.unicorns.update({"gender": "f", $or: [{"loves":"apple"}, {"loves":"carrot"}]}, {$push: {loves: "tomato"}}, { multi: true })
*We have to specify {multi: true}, if we don't it will only update the first unicorn it finds*

##Exercise 4
For exercises we have to again import new data. See the link in exercise 2.

**1. Create a query that returns the manager of "moneo"**

	db.employees.findOne({_id: db.employees.findOne({name:"Moneo"}).manager})
	
**2. Create a query to find the person whose mother is called "Chani"**

	db.employees.find({"family.mother": "Chani"})