# Mostly taken from http://qiita.com/masuidrive/items/1042d93740a7a72242a3

require 'sinatra/base'
require 'json'
require 'rest-client'

class App < Sinatra::Base
  post '/linebot/callback' do
    params = JSON.parse(request.body.read)

    params['result'].each do |msg|
      request_content = {
        to: [msg['content']['from']],
        toChannel: 1383378250, # Fixed  value
        eventType: "138311608800106203", # Fixed value
        content: msg['content']
      }

      endpoint_uri = 'https://trialbot-api.line.me/v1/events'
      content_json = request_content.to_json

      RestClient.proxy = ENV['http://fixie:IApd3vt1WPpgPiu@velodrome.usefixie.com:80'] if ENV['http://fixie:IApd3vt1WPpgPiu@velodrome.usefixie.com:80']
      RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => ENV["1463824575"],
        'X-Line-ChannelSecret' => ENV["ec5f794ecc15551ac207c695ba785436"],
        'X-Line-Trusted-User-With-ACL' => ENV["u96ddfcabdb7818299a1ca0120afc7176"],
      })
    end

    "OK"
  end
end
