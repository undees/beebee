require 'fileutils'

letters = 'a'..'z'
exceptions = {'y' => 'wy'}

letters.each do |letter|
  sound = exceptions[letter] || letter
  path = File.join(File.expand_path(File.dirname(__FILE__)), "#{letter}.aiff")
  FileUtils.rm path if File.exists? path
  
  `osascript -e 'say "#{sound}" saving to "#{path}"'`
end
