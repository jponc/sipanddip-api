set :output, "/opt/app/log/cron.log"

every 1.day, at: '3:30pm' do
  rake "daily_generate:daily_record"
end
