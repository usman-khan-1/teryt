# frozen_string_literal: true

require "savon"
require_relative "teryt/version"
require_relative "teryt/client"
require_relative "teryt/jednostka_terytorialna"

module Teryt
  WSDL = "https://uslugaterytws1.stat.gov.pl/wsdl/terytws1.wsdl"

  class Error < StandardError; end
  # Your code goes here...
end
