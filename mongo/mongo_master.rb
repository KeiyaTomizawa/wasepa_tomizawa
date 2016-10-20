# /usr/local/bin ruby

require 'json'
require 'mongo'
require 'date'

#connection = Mongo::Connection.new
client = Mongo::Client.new(['172.17.0.3:27017'],:database => 'wasepa')
#client = Mongo::Client.new('wasepa_mongo',:database => 'wasepa')

##choice database
db = client.database


coll = db.collection('Master')
data = [{
       'board_rate' =>
       [{'board_rate' => '0~10',},
        {'board_rate' => '11~20',}, 
        {'board_rate' => '21~30',}],
       'place' =>
       [{'place_name' => 'sagamigawa'},
        {'place_name' => 'misakiguchi'}],
       'distance' =>
       [{'distance' => '3',}, 
        {'distance' => '6',}, 
        {'distance' => '9',}],
#'timestamp' => Date.today.to_time
       'timestamp' => Time.now
       }]

id = coll.insert_many(data)

