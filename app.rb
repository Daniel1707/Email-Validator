require 'sinatra'
require 'json'
require_relative 'utils/Email'
require_relative 'utils/Decoder'
require_relative 'DependencyHelper'

#set :bind, '0.0.0.0'
#set :port, 4569

get '/email/health' do
  content_type :json
  {'response': 'System is up =]'}.to_json
end

get '/email/message/:user/:password' do
  content_type :json

  user = params["user"]
  password = params["password"]

  date_header = request.env['HTTP_DATE']
  from_header = request.env['HTTP_FROM']

  gmail = Email.new(user, password)
  message = gmail.get_email_message(date_header, from_header)

  if message.eql? nil
    content_type :json
    status 404
    {
      "Message": "There is no message with data [#{date_header}] and from [#{from_header}]"
    }.to_json
  else
    purchase_link = Decoder.decode_purchase_link(message)

    content_type :json
    status 200
    {
      "Message": "Link found!",
      "Link": "#{purchase_link}"
    }.to_json
  end
end
