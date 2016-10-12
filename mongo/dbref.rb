# /usr/local/bin ruby

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
docs1.push({
  'line_id' => json_data[0]['line_id'], 
})
id = coll.insert_many(docs1)
#a = id.to_json
#puts a
b = Mongo::DBRef.new('Players',id,'wasepa')
dbRef = b.to_json

coll2 = db.collection('Dbref2')
#docs2.push({
#  'line_id' => json_data[i]['line_id'], 
#})
coll2.insert_one({'line_id' => dbRef,})
#id2 = coll2.insert_many(docs2)
