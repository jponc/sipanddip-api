module DailyRecordServices
  class SendToFb
    def initialize daily_record
      @daily_record = daily_record
    end

    def process!
      FbServices::GroupPost.send(message)
    end

    private

    def message
      "
      #{@daily_record.record_date} Sales Report by #{@daily_record.prepared_by}
      \n
      \n
      Gross: #{@daily_record.format_gross_sales}\n
      Expenses: #{@daily_record.format_expenses}\n
      Deposit Amount: #{@daily_record.format_deposit_amount}\n
      "
    end
  end
end
