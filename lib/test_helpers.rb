module TestHelpers
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      cattr_accessor :test_helper_paths
      @@test_helper_paths = []
      self.test_helper_path = RAILS_ROOT + '/test/helpers' if defined? RAILS_ROOT
    end
  end
  
  module ClassMethods
        
    def test_helper(*names)
      test_helpers = []
      test_helper_paths.each { |path| test_helpers += Dir[path + '/*_test_helper.rb'] }
      test_helpers.map! { |filename| File.expand_path(filename) }
      names.each do |name|
        name = name.to_s
        name = $1 if name =~ /^(.*?)_test_helper$/i
        name = name.singularize
        first_time = true
        begin
          constant = (name.camelize + 'TestHelper').constantize
          self.class_eval { include constant }
        rescue NameError
          filename = test_helpers.find { |path| path =~ %r{/#{name}_test_helper.rb$} }
          raise "invalid test helper #{name}" unless filename
          require filename if first_time
          first_time = false
          retry
        end
      end
    end
    alias :test_helpers :test_helper
    
    def test_helper_path=(path)
      self.test_helper_paths = [path]
    end
  
  end
  
end