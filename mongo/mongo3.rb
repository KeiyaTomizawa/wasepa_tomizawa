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
#client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')
client = Mongo::Client.new(['172.17.0.1:27017'],:database => 'wasepa')

##choice database
#db = connection.db('wasepa')
db = client.database

coll = db.collection('Board_rate')
docs = [{'1' => '0~10',},
        {'2' => '11~20',}, 
        {'3' => '21~30',}]
boardId = coll.insert_many(docs)
a = boardId.to_json
b = Mongo::DBRef.new('Board_rate', a,'wasepa')
boardRef = b.to_json

coll = db.collection('Place_information')
docs = [{'1' => 'sagamigawa'},
        {'2' => 'misakiguchi'}]
id = coll.insert_many(docs)
a = id.to_json
b = Mongo::DBRef.new('Place_infomation', a,'wasepa')
placeRef = b.to_json

coll = db.collection('Distance_info')
docs = [{'1' => '3',}, 
        {'2' => '6',}, 
        {'3' => '9',}] 
id = coll.insert_many(docs)
a = id.to_json
b = Mongo::DBRef.new('Distance_info', a,'wasepa')
distanceRef = b.to_json


#docs1 = []
#docs2 = []
for i in 0..9 do
  docs1 = []
  docs2 = []
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
#exit(0);
  id = coll.insert_many(docs1)
#  a = to_json(id)
#  a = Mongo::DBRef.new('Players',id,'wasepa')
  a = id.to_json
  b = Mongo::DBRef.new('Players', a,'wasepa')
  playersRef = b.to_json

#  puts a[_id]

#  exit(0);
#  id4=BSON::ObjectId.new
#  puts id4
  ### Records collection ###
  coll2 = db.collection('Records')
#doc2 = {
 #docs2.push([
  docs2.push({
    'record_id' => json_data[i]['record_id'], 
#   'line_id' => json_data[i]['line_id'], 
    'record_time' => json_data[i]['record_time'], 
#    'board_id' => json_data[i]['board_id'],
#    'place_id' => json_data[i]['place_id'], 
#    'distance_id' => json_data[i]['distance_id'], 
    'datetime' => json_data[i]['datetime'],
    'wind_speed' => json_data[i]['wind_speed'], 
    'weather' => json_data[i]['weather'], 
    'temparature' => json_data[i]['temparature'],
  })
 #id2 = coll2.insert_one(docs2[i])
  id2 = coll2.insert_many(docs2)
  line_id = json_data[i]['line_id']
#  puts "#{line_id}"
#  puts playersRef
#coll2.insert_one({'line_id' => playersRef["#{line_id}"],})
  coll2.insert_one({'line_id' => playersRef,})
  board_id = json_data[i]['board_id']
#  puts board_id
#  puts boardRef
#  coll2.insert_one({'board_rate' => boardRef["#{board_id}"],})
#  puts boardId.find("#{json_data[i]['board_id']}")
  coll2.insert_one({'board_rate' => boardRef["#{board_id}"],})
#  exit(0);
  place_id = json_data[i]['place_id']
  coll2.insert_one({'place_name' => placeRef["#{place_id}"],})
  distance_id = json_data[i]['distance_id']
  coll2.insert_one({'distance' => distanceRef["#{distance_id}"],})
end

