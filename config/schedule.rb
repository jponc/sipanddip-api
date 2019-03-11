set :output, "/opt/app/log/cron.log"
ENV.each { |k, v| env(k, v) }

# 11:30 PM PHT
# every 1.day, at: '3:30pm' do
#   command "bundle exec rake daily_generate:daily_record"
# end
#
every 5.minutes do
  command "bundle exec rake daily_generate:daily_record"
end

every 5.minutes do
  command "echo `date`"
end
