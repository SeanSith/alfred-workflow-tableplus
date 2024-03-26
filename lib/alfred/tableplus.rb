# frozen_string_literal: true

require 'tableplus'

class TablePlus
  class Alfred
    module Workflow
      VERSION = '1.0.0'
      README = "#{Dir.pwd}/README.md"
      PLIST_FILE = "#{Dir.pwd}/info.plist"

      def self.publish
        raise "Project #{File.basename PLIST_FILE} not found in #{Dir.pwd}" unless File.exist? PLIST_FILE
        raise "Project #{File.basename README} not found in #{Dir.pwd}" unless File.exist? README

        plist = Plist.parse_xml(PLIST_FILE)
        plist['version'] = VERSION
        plist['readme'] = File.read(README)
        File.write(PLIST_FILE, plist.to_plist)
      end
    end

    class Connection < TablePlus::Connection
      def title
        title = [@connection_name]
        title << "(#{@database_name})" unless @database_name.empty?
        title.join(' ')
      end
    end

    class Utility
      def self.build_alfred_match(connection)
        values = [
          connection.title,
          group_name(connection),
          connection.driver,
        ]
        text = values.join(' ')
        text.gsub!(%r{[/())-.]}, ' ')
        text.gsub!(/\s{2,}/, "\s")
        text.downcase!
        text.split(' ').uniq.join(' ')
      end

      def self.group_name(connection)
        _group, output =
          TablePlus::Utility.find_group(
            TablePlus::ConnectionGroup.new(group_id: connection.group_id),
            ''
          )
        output
      end

      def self.subtitle(connection)
        output = []
        output << "#{group_name(connection)} - " unless group_name(connection).empty?
        output << [
          connection.environment.capitalize,
          '-',
          connection.database_host.downcase,
        ]
        output.flatten!
        output.join(' ')
      end
    end
  end
end
