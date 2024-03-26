#!/usr/bin/ruby
# frozen_string_literal: true

require 'json'
require_relative './lib/alfred/tableplus'

def subtitle(connection)
  TablePlus::Alfred::Utility.subtitle(connection)
end

def build_alfred_match(connection)
  TablePlus::Alfred::Utility.build_alfred_match(connection)
end

results = {}
cache_time = 5
if cache_time.positive?
  results[:cache] = { seconds: cache_time, loosereload: true }
  results[:rerun] = cache_time
end
results[:items] = TablePlus::Utility.load_connections.map do |c|
  {
    uid: c.id,
    icon: c.icon,
    title: c.title,
    subtitle: subtitle(c),
    arg: c.url,
    match: build_alfred_match(c),
  }
end
results[:items] = results[:items].sort_by { |r| r[0] }

puts results.to_json
