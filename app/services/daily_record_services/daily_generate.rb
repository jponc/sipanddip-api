module DailyRecordServices
  class DailyGenerate
    def self.process_from!(from_date)
      (from_date..Date.today).each do |date|
        new(date).process!
      end
    end

    def self.process_today!
      new(Date.today).process!
    end

    def initialize(date)
      @date = date
      @daily_record = DailyRecord.find_or_create_by!(record_date: @date)
    end

    def process!
      @daily_record.process_reports!
    end
  end
end
