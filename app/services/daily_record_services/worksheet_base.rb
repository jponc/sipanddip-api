require 'google/apis/sheets_v4'

module DailyRecordServices
  class WorksheetBase
    def initialize daily_record
      @daily_record = daily_record
    end

    def process!
      raise 'Implement me!'
    end

    def range
      raise 'Implement me!'
    end

    private

    def send_notifications
      send_slack_notification
    end

    def send_slack_notification
      webhook_url = Rails.application.secrets[:slack][:webhook_url]
      notifier = Slack::Notifier.new webhook_url, channel: "#app", username: "appbot"

      attachment = {
        fallback: slack_attachment_text,
        text: slack_attachment_text,
        color: "good",
        mrkdwn_in: ["text"]
      }
      notifier.post text: slack_text, attachments: [attachment]
    end

    def spreadsheet_id
      Rails.application.secrets[:google][:sheet_id]
    end

    def sheet_row
      sheet_values.find do |sheet_value|
        sheet_value.first == @daily_record.record_date.strftime('%-m/%d/%Y')
      end
    end

    def sheet_values
      @sheet_values ||=
        begin
          sheet_service.get_spreadsheet_values(spreadsheet_id, range).values
        end
    end

    def sheet_service
      @sheet_service ||=
        begin
          service = Google::Apis::SheetsV4::SheetsService.new
          service.key = Rails.application.secrets[:google][:api_key]
          service
        end
    end
  end
end
