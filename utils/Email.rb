require_relative '../DependencyHelper'
require 'gmail'

class Email
  def initialize(user, password)
    @gmail = Gmail.connect(user, password)
  end

  def is_logged
    return @gmail.logged_in?
  end

  def get_email_message(date, from)
    email = @gmail.inbox.emails(:on => Date.parse(date), :from => from)

    response = ""

    if email[0].eql? nil
      response = nil
    else
      response = email[0].message.body.decoded.to_s
    end

    response
  end
end
