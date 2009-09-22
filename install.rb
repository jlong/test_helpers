# Create the test/helpers directory
print "Creating test/helpers directory..."
begin
  Dir.mkdir '../../test/helpers'
  puts "OK"
rescue => e
  puts "FAILED"
  puts e
end