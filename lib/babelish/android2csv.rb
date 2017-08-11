module Babelish
  require "nokogiri"
  require "htmlentities"
  class Android2CSV < Base2Csv

    def initialize(args = {:filenames => []})
      super(args)
    end

    def load_strings(strings_filename)
      strings = {}
      xml_file = File.open(strings_filename)

      parser = Nokogiri::XML(xml_file) do |config|
        config.strict.noent
      end
      parser.xpath("//string").each do |node|
        if !node.nil? && !node["name"].nil?

          string = node.inner_html          
          strings.merge!(node["name"] => HTMLEntities.new.decode(string))
        end
      end

      xml_file.close

      [strings, {}]
    end

  end
end
