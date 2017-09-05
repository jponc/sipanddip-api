namespace :daily_generate do
  desc "Processes the daily record object for today"
  task :daily_record => :environment do
    DailyRecordServices::DailyGenerate.process_today!
  end
end
