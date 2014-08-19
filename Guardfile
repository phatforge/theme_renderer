# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :development, halt_on_fail: true do
  guard :bundler do
    watch('Gemfile')
    # Uncomment next line if your Gemfile contains the `gemspec' command.
    watch(/^.+\.gemspec/)
  end

  guard :rails_best_practices, run_at_start: false, all_after_pass: true do
    watch(%r{^app/(.+)\.rb$})
  end

  guard :minitest, all_after_pass: true do
    # with Minitest::Unit
    watch(%r{^test/(.*)\/?test_(.*)\.rb$})
    watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
    watch(%r{^test/test_helper\.rb$})      { 'test' }

    # with Minitest::Spec
    watch(%r{^spec/(.*)_spec\.rb$})
    watch(%r{^test/(.*)_test\.rb$})
    watch(%r{^lib/(.+)\.rb$})         { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^lib/theme_renderer/(.+)\.rb$})         { |m| "test/model/#{m[1]}_test.rb" }
    watch(%r{^test/test_helper\.rb$}) { 'test' }

    # Rails 4
    # watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
    # watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
    # watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
    # watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
    # watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
    # watch(%r{^test/.+_test\.rb$})
    # watch(%r{^test/test_helper\.rb$}) { 'test' }

    # Rails < 4
    # watch(%r{^app/controllers/(.*)\.rb$}) { |m| "test/functional/#{m[1]}_test.rb" }
    # watch(%r{^app/helpers/(.*)\.rb$})     { |m| "test/helpers/#{m[1]}_test.rb" }
    # watch(%r{^app/models/(.*)\.rb$})      { |m| "test/unit/#{m[1]}_test.rb" }
  end

  guard :rubocop, all_on_start: false, cli: ['--display-cop-names'] do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :brakeman, run_on_start: false do
    watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
    watch(%r{^config/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch('Gemfile')
  end

  guard 'rubycritic', run_on_start: false do
    watch(%r{^app/(.+)\.rb$})
    watch(%r{^lib/(.+)\.rb$})
  end
end
