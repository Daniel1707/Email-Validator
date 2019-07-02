Dir[File.join(File.dirname(__FILE__), './pages/*.rb')].each { |file| require file }

require 'rubygems' if RUBY_VERSION < '1.9'

require 'sinatra'
require 'gmail'
require 'json'
