# frozen_string_literal: true

require_relative "sydecar/version"
require_relative "sydecar/constants"
require_relative "sydecar/connection"
require_relative "sydecar/person"
require_relative "sydecar/profile"
require_relative "sydecar/profile/entity"
require_relative "sydecar/profile/individual"

module Sydecar
  class TokenNotSetError < StandardError; end
  # Your code goes here...
end
