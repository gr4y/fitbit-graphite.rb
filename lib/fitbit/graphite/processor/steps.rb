module Fitbit
  module Graphite
    module Processor
      class Steps < BaseProcessor
        def process(start_date, end_date)
           unless start_date.nil? || end_date.nil?
            user_id = @client.user_info['user']['encodedId']
            [
              '/activities/steps', 
              '/activities/distance', 
              '/activities/calories',
              '/activities/activityCalories'
            ].each do |resource_path|
              key = resource_path[1..-1].gsub("/", "-")
              data = @client.data_by_time_range(resource_path, { 
                base_date: start_date, end_date: end_date
              })
              data[key].each do |item|
                time = DateTime.parse(item["dateTime"]).new_offset(0).to_time.to_i
                value = item["value"] || 0
                @socket.write "fitness.#{user_id}.#{key} #{value} #{time}\n"
              end
            end
          else
            puts 'start_date OR end_date not set. Aborting'
          end
        end
      end
    end
  end
end
