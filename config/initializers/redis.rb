$redis = if Rails.env.production?
  Redis.new(:url => ENV['REDISTOGO_URL'])
else
  Redis.new
end