# Require all Libraries
[
  'fitgem', 
  'timerizer',
  'time',
  'date', 
  'json',
  'socket'
].each do |lib|
  require lib
end

# Require 
[
  'fitbit/graphite/version',
  'fitbit/graphite/base_processor',
  'fitbit/graphite/processor/steps',
  'fitbit/graphite/processor/body'
].each do |lib|
  require lib
end
