# /usr/local/bin ruby

require 'bson'
require 'json'
require 'mongo'

##ARGV[0]=generated_json10
json_data = open(ARGV[0]) do |io|
   JSON.load(io)
end

#client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')
client = Mongo::Client.new(['172.17.0.1:27017'],:database => 'wasepa')

db = client.database

docs1 = []
docs2 = []

coll = db.collection('Dbref1')
docs1 ={
  'line_id' => json_data[0]['line_id'], 
}
id = coll.insert_one(docs1)
a = id.inserted_id
puts a.class
#exit(0);
#puts id.class
#a = id.to_json
##puts a.class
##a = id.to_bson
#a = BSON::ObjectId.from_string(a)
##a = ObjectId.from_bson(a)
#puts a.class
##exit(0);
b = Mongo::DBRef.new('Dbref1',a,'wasepa')
p b
puts b
#b = Mongo::DBRef.new('Players',id,'wasepa')
#dbRef = b.to_json
dbRef = b.as_json
#c = b.to_bson_key
puts "ddd".to_bson_key
puts "$ddd".to_bson_key.class
puts dbRef
puts dbRef.to_hash
#dbRef = b.as_json
#puts b.class
puts dbRef.class
coll2 = db.collection('Dbref2')
#docs2.push({
#  'line_id' => json_data[i]['line_id'], 
#})
docs3 = {:line_id => {'$ref' =>"Dbref1", '$id'=>BSON::ObjectId('57fe1b9e9873f3011709cecf'), '$db'=>"wasepa"}}
coll2.insert_one(docs3)
#coll2.insert_one({'line_id' => {"$ref"=>"Dbref1", "$id"=>BSON::ObjectId('57fe1b9e9873f3011709cecf'), "$db"=>"wasepa"}
#})
#coll2.insert_one({'line_id' => {dbRef}})
#id2 = coll2.insert_many(docs2)
