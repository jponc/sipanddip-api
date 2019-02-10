module DailyRecordServices
  class SalesData < WorksheetBase

    RANGE_START_ROW = 2
    RANGE_START_DATE = Date.new(2019, 2, 1)

    def process!
      return if sheet_row.blank?

      @daily_record.update_attributes!(
        gross_sales: Monetize.parse(sheet_row[1]).to_d,
        expenses: Monetize.parse(sheet_row[2]).to_d,
        combo_cups_count: sheet_row[3].presence || 0,
        combo_cups_dc_count: sheet_row[4].presence || 0,
        sides_count: sheet_row[5].presence || 0,
        sides_dc_count: sheet_row[6].presence || 0,
        drinks_count: sheet_row[7].presence || 0,
        drinks_dc_count: sheet_row[8].presence || 0,
        dips_count: sheet_row[9].presence || 0,
        dips_dc_count: sheet_row[10].presence || 0,
        deposit_amount: Monetize.parse(sheet_row[11]).to_d,
        prepared_by: sheet_row[12],
        discrepancy: Monetize.parse(sheet_row[13]).to_d,
        notes: sheet_row[14]
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
      date_diff = (@daily_record.record_date - RANGE_START_DATE).to_i
      row = RANGE_START_ROW + date_diff

      "Sales!A#{row}:O#{row + 1}"
    end

    def slack_text
      "*#{@daily_record.record_date}* Sales Report by #{@daily_record.prepared_by}"
    end

    def slack_attachment_text
      <<~HEREDOC
        Gross: *#{@daily_record.format_gross_sales}*
        Expenses: *#{@daily_record.format_expenses}*
        Deposit Amount: *#{@daily_record.format_deposit_amount}*
        Discrepancy: *#{@daily_record.format_discrepancy}*
      HEREDOC
    end
  end
end
