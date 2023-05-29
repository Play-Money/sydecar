# frozen_string_literal: true

# TODO: find a way to load all dependencies automatically for any ENV
require 'faraday'
require 'active_support'
require 'faraday/multipart'
require 'faraday/logging/color_formatter'
require 'uri'

require_relative "sydecar/version"
require_relative "sydecar/constants"
require_relative "sydecar/base_connection"
require_relative "sydecar/connection"
require_relative "sydecar/file_connection"
require_relative "sydecar/person"
require_relative "sydecar/profile"
require_relative "sydecar/profile/entity"
require_relative "sydecar/profile/individual"
require_relative "sydecar/entity"
require_relative "sydecar/bank_account"
require_relative "sydecar/spv"
require_relative "sydecar/vendor"
require_relative "sydecar/expense"
require_relative "sydecar/subscription"
require_relative "sydecar/document"

module Sydecar
  class TokenNotSetError < StandardError; end
  class BaseUrlNotSetError < StandardError; end
  # Your code goes here...
end
