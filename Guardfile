# frozen_string_literal: true

# Require Guard and Minitest
require 'guard/minitest'

# Enable color in the terminal
ENV['MT_NO_PLUGINS'] = '1' # Disable minitest plugins for Guard
ENV['COLOR'] = 'true'      # Force color output

guard :minitest, spring: true, all_on_start: false do
  # Run all tests
  watch(%r{^test/(.*)/?(.*)_test\.rb$})

  # Run model tests when model files change
  watch(%r{^app/models/(.*)\.rb$}) do |m|
    "test/models/#{m[1]}_test.rb"
  end

  # Run controller tests when controller files change
  watch(%r{^app/controllers/(.*)_controller\.rb$}) do |m|
    "test/controllers/#{m[1]}_controller_test.rb"
  end

  # Run system tests when integration/system files change
  watch(%r{^app/(.*)\.rb$}) do |m|
    "test/system/#{m[1]}_test.rb"
  end

  # Run integration tests when routes change
  watch(%r{^config/routes\.rb$}) do
    'test/integration'
  end

  # Run all tests when test_helper changes
  watch(%r{^test/test_helper\.rb$}) do
    'test'
  end

  # Run all tests when fixtures change
  watch(%r{^test/fixtures/(.*)\.yml$}) do
    'test'
  end
end

# Optional: Add notifications (requires 'guard-notify' gem)
# guard :notify, :watchers => [:minitest]
