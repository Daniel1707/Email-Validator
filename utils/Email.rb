require_relative '../DependencyHelper'
require 'gmail'

class Email
  def initialize(user, password)
    @gmail = Gmail.connect(user, password)

    if @gmail.logged_in?.eql? false
      raise "Could not log in in Gmail, check user or password!!! USER: [#{user}] PASSWORD: [#{password}]"
    end
  end

  def get_email_message(date, from)
    email = @gmail.inbox.emails(:on => Date.parse(date), :from => from)

    response = ""

    if email[0].eql? nil
      response = nil
      p "IF"
    else
      response = email[0].message.body.decoded.to_s
      p "ELSE"
    end

    response
  end

  def get_purchase_link(date, from)
    email_body = get_email_message(date, from)

    string_begin = "9px;\" href=\""
    string_end = "\" title"

    email_body[/#{string_begin}(.*?)#{string_end}/m, 1]
  end
end
