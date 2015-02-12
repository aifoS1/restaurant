[ 'models','controllers'].each do |component|
  Dir["#{component}/*.rb"].sort.each do |file|
    require File.expand_path(file)
  end
end