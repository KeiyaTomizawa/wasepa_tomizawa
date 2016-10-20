# /usr/local/bin ruby

require 'json'
require 'mongo'

##read json file
##ARGV[0]=generated_json
json_data = open(ARGV[0]) do |io|
   JSON.load(io)
end

#puts json_data[0]['records']
#exit(0);

#connection = Mongo::Connection.new
client = Mongo::Client.new(['172.17.0.3:27017'],:database => 'wasepa')
#client = Mongo::Client.new(['173.17.0.1:27017'],:database => 'wasepa')
#client = Mongo::Client.new('wasepa_mongo',:database => 'wasepa')

##choice database
#db = connection.db('wasepa')
db = client.database

for i in 0..9 do
  for j in 0..9 do
    ### Pleyers collection ###
    ##choice collection
    coll = db.collection('Players')
    #make document
    players = [{
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
      'registry_hash' => json_data[i]['registry_hash'],
      'records' =>
        [{
        'record_id' => json_data[i]['records'][j]['record_id'], 
        'record_time' => json_data[i]['records'][j]['record_time'], 
        'board_id' => json_data[i]['records'][j]['board_id'],
        'place_id' => json_data[i]['records'][j]['place_id'], 
        'distance_id' => json_data[i]['records'][j]['distance_id'], 
        'datetime' => json_data[i]['records'][j]['datetime'],
        'wind_speed' => json_data[i]['records'][j]['wind_speed'], 
        'weather' => json_data[i]['records'][j]['weather'], 
        'temparature' => json_data[i]['records'][j]['temparature'],
        }]
    }]
    players_id = coll.insert_many(players)
  end
end


