# /usr/local/bin ruby

require 'json'
#require 'rubygems'
require 'mongo'

##read json file
##ARGV[0]=generated_json
json_data = open(ARGV[0]) do |io|
   JSON.load(io)
end
#puts json_data

#connection = Mongo::Connection.new
#client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')
client = Mongo::Client.new(['127.0.0.1:27017'],:database => 'wasepa')

##choice database
#db = connection.db('wasepa')
db = client.database

for i in 0..9 do
  ### Pleyers collection ###
  ##choice collection
  coll = db.collection('Players')
  #make document
  doc = {
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
  }
  #insert document
  #id = objectid
  id[i] = coll.insert_one(doc)
  #DBref
  Mongo::DBRef.new('Players',id[i],'wasepa')
  puts dbref
  
  ### Records collection ###
  coll2 = db.collection('Records')
  doc2 = {
    'record_id' => json_data[i]['record_id'], 
    'record_time' => json_data[i]['record_time'], 
    'board_id' => json_data[i]['board_id'],
    'place_id' => json_data[i]['place_id'], 
    'distance_id' => json_data[i]['distance_id'], 
    'datetime' => json_data[i]['datetime'],
    'wind_speed' => json_data[i]['wind_speed'], 
    'weather' => json_data[i]['weather'], 
    'temparature' => json_data[i]['temparature'],
  }
  id2[i] = coll2.insert_one(doc2)
end

coll = db.collection('Board_rate')
doc = {
  'board_rate' => '0~10', 
  'board_rate' => '11~20', 
  'board_rate' => '21~30',
}

coll = db.collection('Place_information')
doc = {
  'place_name' => '相模川', 
  'place_name' => '三崎口',
} 
coll = db.collection('Distance_info')
doc = {
  'distance' => '3', 
  'distance' => '6', 
  'distance' => '9', 
}
#for json
#kousinn
#sakujyo
#sentaku
