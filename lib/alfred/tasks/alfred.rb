# frozen_string_literal: true

namespace :alfred do
  task :release do
    TablePlus::Alfred::Workflow.publish
    exclusions = [
      '*.alfredworkflow',
      '.git/*',
      'Gemfile.lock',
      'lib/tableplus/*',
      'vendor/*',
    ]
    `zip -r ./TablePlus.alfredworkflow . #{exclusions.map { |x| "-x '#{x}'" }.join(' ')}`
  end
end
