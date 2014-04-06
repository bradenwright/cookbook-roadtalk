# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :rspec, cli: '--color', all_on_start: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { 'spec' }

  watch(%r{^attributes/(.+)\.rb$})  { 'spec' }
  watch(%r{^recipes/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^resources/(.+)\.rb$})  { 'spec' }
  watch(%r{^providers/(.+)\.rb$})  { 'spec' }
end

# guard :foodcritic, cookbook_paths: '.', all_on_start: false do
#   watch(%r{attributes/.+\.rb$})
#   watch(%r{providers/.+\.rb$})
#   watch(%r{recipes/.+\.rb$})
#   watch(%r{resources/.+\.rb$})
# end

#guard "foodcritic" do
#  watch(%r{attributes/.+\.rb$})
#  watch(%r{providers/.+\.rb$})
#  watch(%r{recipes/.+\.rb$})
#  watch(%r{resources/.+\.rb$})
#end

