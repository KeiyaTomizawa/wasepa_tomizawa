
require json
require mongo

client = Mongo::Client.new(['172.17.0.4:27017'],:database => 'wasepa')
#db = client.database


# update document ##
### use $set to add
### without $set to replace
### change one document -> use 'update_one'
### change many documents -> use 'updae_many'

coll = db.collection('Players')



### delete document###
#result = coll.deleted_one({'name' => 'Keiya Tomizawa'}})
result = coll.deleted_one({_id:ARGV[0]})

#result = coll.update_many(dbref,{'$set' => {'name' => 'Keiya Tomizawa'}})


