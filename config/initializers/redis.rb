# don't need to set url env in development mode, it sets it to nil and uses localhost
$redis = Redis.new(:url => ENV['REDISTOGO_URL'])