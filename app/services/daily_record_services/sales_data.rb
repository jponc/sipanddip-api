module DailyRecordServices
  class SalesData < WorksheetBase
    def process!
      return if sheet_row.blank?

      @daily_record.update_attributes!(
        gross_sales: Monetize.parse(sheet_row[1]).to_d,
        expenses: Monetize.parse(sheet_row[2]).to_d,
        deposit_amount: Monetize.parse(sheet_row[5]).to_d,
        food_cups_count: sheet_row[3],
        drink_cups_count: sheet_row[4],
        prepared_by: sheet_row[6]
      )

      send_slack_notification
    end

    private

    def send_slack_notification
      webhook_url = Rails.application.secrets[:slack][:webhook_url]
      notifier = Slack::Notifier.new webhook_url

      attachment = {
        fallback: slack_attachment_text,
        text: slack_attachment_text,
        color: "good",
        mrkdwn_in: ["text"]
      }

      notifier.post text: slack_text, attachments: [attachment]
    end

    def range
      # TODO: Make this range dynamically change
      "Sales!A2:G100"
    end

    def slack_text
      "*#{@daily_record.record_date}* Sales Report by #{@daily_record.prepared_by}"
    end

    def slack_attachment_text
      [
        "Gross: *#{@daily_record.format_gross_sales}*",
        "Expenses: *#{@daily_record.format_expenses}*",
        "Deposit Amount: *#{@daily_record.format_deposit_amount}*",
        "Food Cups: *#{@daily_record.food_cups_count}*, Drink Cups: *#{@daily_record.drink_cups_count}*",
      ].join("\n")
    end
  end
end
