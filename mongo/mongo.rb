# /usr/local/bin ruby

require 'json'
#require 'rubygems'
require 'mongo'
#require 'bson'

##read json file
##ARGV[0]=generated_json
json_data = open(ARGV[0]) do |io|
   JSON.load(io)
end
#puts json_data

#connection = Mongo::Connection.new
client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')

##choice database
#db = connection.db('wasepa')
db = client.database

docs1 = []
docs2 = []
for i in 0..9 do
  ### Pleyers collection ###
  ##choice collection
  coll = db.collection('Players')
  #make document
  #docs1.push([
  docs1.push({
    'player_id' => json_data[i]['player_id'], 
    'line_id' => json_data[i]['line_id'], 
    'name' => json_data[i]['name'],
    'gender' => json_data[i]['gender'],
    'hp_permission' => json_data[i]['hp_permission'], 
    'ranking_permission' => json_data[i]['ranking_permission'],
    'image' => json_data[i]['image'],
    'comment' => json_data[i]['comment'], 
    'join_year' => json_data[i]['join_year'],
    'registry_status' => json_data[i]['registry_status'],
    'registry_hash' => json_data[i]['registry_hash']
  })
  #insert document
  #id = objectid
  #id = coll.insert_one(docs1[i])
  #id = coll.insert_many(docs1)
  
  ### Records collection ###
  coll2 = db.collection('Records')
#doc2 = {
 #docs2.push([
  docs2.push({
    'record_id' => json_data[i]['record_id'], 
    'line_id' => json_data[i]['line_id'], 
    'record_time' => json_data[i]['record_time'], 
    'board_id' => json_data[i]['board_id'],
    'place_id' => json_data[i]['place_id'], 
    'distance_id' => json_data[i]['distance_id'], 
    'datetime' => json_data[i]['datetime'],
    'wind_speed' => json_data[i]['wind_speed'], 
    'weather' => json_data[i]['weather'], 
    'temparature' => json_data[i]['temparature'],
  })
 #id2 = coll2.insert_one(docs2[i])
 #id2 = coll2.insert_many(docs2)
end
id = coll.insert_many(docs1)
#DBref
a = Mongo::DBRef.new('Players',id,'wasepa')
puts a.to_json
id2 = coll2.insert_many(docs2)

coll = db.collection('Board_rate')
docs = [{'board_rate' => '0~10',},
        {'board_rate' => '11~20',}, 
        {'board_rate' => '21~30',}]
id = coll.insert_many(docs)

coll = db.collection('Place_information')
docs = [{'place_name' => ''},
        {'place_name' => ''}]
id = coll.insert_many(docs)

coll = db.collection('Distance_info')
docs = [{'distance' => '3',}, 
        {'distance' => '6',}, 
        {'distance' => '9',}] 
id = coll.insert_many(docs)
#for json
#kousinn
#sakujyo
#sentaku
