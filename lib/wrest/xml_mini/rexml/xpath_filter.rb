module Xml_Mini
  module Rexml
    module XPathFilter
      #enables filtering an xml response using a specified xpath
      #it returns the first element that matches the xpath
      def filter(xml_body,xpath)
        doc = REXML::Document.new(xml_body)
        REXML::XPath.first(doc,xpath).to_s
      end
    end
  end
end


