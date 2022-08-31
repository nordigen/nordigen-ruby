# frozen_string_literal: true

require "rake/testtask"
require "bundler/gem_tasks"

task default: %i[test]

Rake::TestTask.new do |t|
  t.pattern = "./tests/test_*.rb"
end
