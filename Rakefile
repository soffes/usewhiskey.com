# frozen_string_literal: true

desc 'Build'
task :build do
  system 'bundle exec jekyll build --config _config.yml --trace'
end

task default: :build

desc 'Clean'
task :clean do
  system 'rm -rf _site .jekyll-cache'
end

desc 'Local server'
task :server do
  system 'bundle exec jekyll serve --config _config.yml --trace --incremental'
end

namespace :lint do
  desc 'Lint Ruby'
  task :ruby do
    sh 'bundle exec rubocop --parallel --config .rubocop.yml'
  end

  desc 'Lint YAML'
  task :yaml do
    if `which yamllint`.chomp.empty?
      abort 'yamllint is not installed. Install it with `pip3 install yamllint`.'
    end

    sh 'yamllint -c .yamllint.yml .'
  end
end

desc 'Run all linters'
task lint: %i[lint:ruby lint:yaml]
