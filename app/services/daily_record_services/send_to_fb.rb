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

        === Sales ==

        Gross: #{@daily_record.format_gross_sales}
        Expenses: #{@daily_record.format_expenses}
        Deposit Amount: #{@daily_record.format_deposit_amount}
        Discrepancy: #{@daily_record.format_discrepancy}
        Notes: #{@daily_record.notes}

        == All Inventory ==

        #{inventory_text}

        == Restock Needed ==

        #{restock_text}
      HEREDOC
    end

    def inventory_text
      @daily_record.inventory_items.includes(:inventory).to_a.map do |inventory_item|
        <<~HEREDOC
        #{inventory_item.inventory.name}
        - In: #{inventory_item.in_count}
        - Out: #{inventory_item.out_count}
        - On Hand: #{inventory_item.total_count}

        HEREDOC
      end.joins("\n")
    end

    def restock_text
      items_needed_restock = @daily_record.inventory_items.includes(:inventory).restock_needed

      if items_needed_restock.any?
        @daily_record.inventory_items.restock_needed.to_a.map do |inventory_item|
          <<~HEREDOC
          #{inventory_item.inventory.name}
          - On Hand: #{inventory_item.total_count}
          - Trigger Count: #{inventory_item.inventory.restock_trigger_count}

          HEREDOC
        end.joins("\n")
      else
        "Nothing needed restocking"
      end
    end
  end
end
