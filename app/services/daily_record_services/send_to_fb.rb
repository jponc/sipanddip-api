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
      <<~HEREDOC
        #{@daily_record.record_date} Sales Report by #{@daily_record.prepared_by}
        Gross: #{@daily_record.format_gross_sales}
        Expenses: #{@daily_record.format_expenses}
        Deposit Amount: #{@daily_record.format_deposit_amount}
      HEREDOC
    end
  end
end
