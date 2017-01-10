class Api::JsonController < ApplicationController
#  def index
#    tweets = TweetMongo.desc(:_id).limit(100).map {|tweet| JSON.parse(tweet.data)}
#    render json: tweets
#  end
##  def index
##    @user2s = User2.all
##
##    render json: @user2s
##  def show
##    render json: @user2s
##  end

  def show
    @json = JsonMongo.all
    render json: @json
  end

  def insert
    require 'json'
    require 'mongo'
    require 'mongoid'
    Mongoid.load!("../../../config/mongoid.yml", :development)
    json_data = open("./demo_data.json") do |io|
       JSON.load(io)
    end
#    client = Mongo::Client.new(['172.0.0.1:27017'],:database => 'wasepa')
#    client = Mongo::Client.new(['127.0.0.1:27017'],:database => 'wasepa')
#    client = Mongo::Client.new(['172.17.0.1:27017'],:database => 'wasepa')
#    db = client.database
    
    for i in 0..9 do
      for j in 0..9 do
        ### Pleyers collection ###
        ##choice collection
#        coll = db.collection('Players')
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
            'board' => json_data[i]['records'][j]['board'],
            'place' => json_data[i]['records'][j]['place'], 
            'distance' => json_data[i]['records'][j]['distance'], 
            'datetime' => json_data[i]['records'][j]['datetime'],
            'wind_speed' => json_data[i]['records'][j]['wind_speed'], 
            'weather' => json_data[i]['records'][j]['weather'], 
            'temparature' => json_data[i]['records'][j]['temparature'],
            }]
        }]
#       players_id = coll.insert_many(players)
        JsonMongo.new(players)
      end
    end
  end
end
