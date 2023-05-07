# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "minitest/test_task"

RuboCop::RakeTask.new

Minitest::TestTask.create(:test) do |t|
  t.warning = false
  t.test_globs = ["test.rb"]
end

task :default => :test
