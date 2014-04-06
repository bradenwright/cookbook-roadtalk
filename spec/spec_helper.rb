# spec_helper.rb

require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/data_bag_rescue.rb'

# SafeYAML was added to resolve error when guard is used
#SafeYAML::OPTIONS[:deserialize_symbols] = true
#SafeYAML::OPTIONS[:default_mode] = :safe

