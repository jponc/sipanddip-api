set :output, "/opt/app/log/cron.log"
set :environment, ENV["RAILS_ENV"]
ENV.each_key do |key|
  env key.to_sym, ENV[key]
end

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
