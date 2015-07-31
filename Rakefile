require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

task :cov do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].execute
end

task default: [:cov, :rubocop]
