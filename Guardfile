guard 'bundler' do
  watch('Gemfile')
  watch('Gemfile.lock')
end

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch('spec/factories.rb')
  watch(%r{^spec/factories/(.+)\.rb})
  watch('config/routes.rb')
end

guard 'rspec', :version => 2, :cli => "--drb" do
  watch('spec/spec_helper.rb')                       { "spec" }
  watch('spec/factories.rb')                         { "spec" }
  watch('config/routes.rb')                          { "spec/routing" }
  watch(%r{^spec/(.+)_spec\.rb})                     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/helpers/(.+)_spec\.rb})             { |m| "spec/helpers/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/factories/(.+)\.rb})                { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }

  watch(%r{^app/controllers/(.+)_(controller)\.rb})  do |m|
    ["spec/routing/#{m[1]}_routing_spec.rb",
    "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
    "spec/acceptance/#{m[1]}_spec.rb"]
  end

  watch('app/controllers/application_controller.rb') { "spec/controllers" }
end
