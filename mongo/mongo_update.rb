
require json
require mongo

client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')
#db = client.database


## update document ##
### use $set to add
### without $set to replace
### change one document -> use 'update_one'
### change many documents -> use 'updae_many'

### change name in my page###
coll = db.collection('Players')
result = coll.update_one({_id:ARGV[0],'$set' => {'name' => 'Keiya Tomizawa'}})

#result = coll.update_many(
#{_id:ARGV[0],'$set' => {'name' => 'Keiya Tomizawa'}},
#{_id:ARGV[1],'$set' => {'name' => 'Keiya Tomizawa'}})


