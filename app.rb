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

get '/email/message/:date/:from' do
  content_type :json

  date = params["date"]
  from = params["from"]

  user_header = request.env['HTTP_USER']
  password_header = request.env['HTTP_PASSWORD']
  string_begin_header = request.env['HTTP_BEGIN']
  string_end_header = request.env['HTTP_END']

  gmail = Email.new(user_header, password_header)

  if gmail.is_logged.eql? false
    content_type :json
    status 404
    {
      "Message": "Could not log in in Gmail, check user or password!!!",
      "User": "#{user_header}",
      "Password": "#{password_header}"
    }.to_json
  else
    message = gmail.get_email_message(date, from)

    if message.eql? nil
      content_type :json
      status 404
      {
        "Message": "There is no message with data [#{date_header}] and from [#{from_header}]"
      }.to_json
    else
      purchase_link = Decoder.decode_data(message, string_begin_header, string_end_header)

      content_type :json
      status 200
      {
        "Message": "Message found!",
        "Link": "#{purchase_link}"
      }.to_json
    end
  end
end
