# This client is targetted at Rails REST apps.
# It is intended as a replacement for ActiveResource
class Wrest::Mappers::Resource::Base
  class << self
    def host=(host_url)
      self.class_eval "def self.host; '#{host_url.clone}';end"
    end

    def resource_path
      @resource_path ||= "/#{self.name.underscore.pluralize}"
    end

    def find_all
      Wrest::Uri.new("#{host}#{resource_path}").get.deserialise
    end
    
    def find(id)
      response_hash = Wrest::Uri.new("#{host}#{resource_path}/#{id}").get.deserialise
      resource_type = response_hash.keys.first
      if(resource_type.underscore.camelize == self.name)
        self.new(response_hash[resource_type])      
      else
        response_hash
      end  
    end
  end
  attr_reader :attributes
  
  def initialize(attributes)
    @attributes = attributes
  end
  
  def method_missing
    super
  end
end
