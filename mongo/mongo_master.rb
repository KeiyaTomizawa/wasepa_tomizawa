# /usr/local/bin ruby

require 'json'
require 'mongo'

#connection = Mongo::Connection.new
client = Mongo::Client.new(['172.17.0.3:27017'],:database => 'wasepa')
#client = Mongo::Client.new('wasepa_mongo',:database => 'wasepa')

##choice database
#db = connection.db('wasepa')
db = client.database


coll = db.collection('Master')
board = [{'board_rate' => '0~10',},
        {'board_rate' => '11~20',}, 
        {'board_rate' => '21~30',}]
board_id = coll.insert_many(board)

place = [{'place_name' => 'sagamigawa'},
        {'place_name' => 'misakiguchi'}]
place_id = coll.insert_many(place)

distance = [{'distance' => '3',}, 
        {'distance' => '6',}, 
        {'distance' => '9',}] 
distance_id = coll.insert_many(distance)
