set :output, "/opt/app/log/cron.log"

# 11:30 PM PHT
every 1.day, at: '3:30pm' do
  rake "daily_generate:daily_record"
end
