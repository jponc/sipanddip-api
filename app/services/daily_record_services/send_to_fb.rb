module DailyRecordServices
  class SendToFb
    def initialize daily_record
      @daily_record = daily_record
    end

    def process!
      FbServices::GroupPost.send(message)
    end

    def message
      <<~HEREDOC
        #{@daily_record.record_date} Sales Report by #{@daily_record.prepared_by}
        \n
        === Sales ==
        \n
        Gross: #{@daily_record.format_gross_sales}
        Expenses: #{@daily_record.format_expenses}
        Deposit Amount: #{@daily_record.format_deposit_amount}
        Discrepancy: #{@daily_record.format_discrepancy}
        Notes: #{@daily_record.notes}
        \n
        == All Inventory ==
        \n
        #{inventory_text}
        \n
        == Restock Needed ==
        \n
        #{restock_text}
      HEREDOC
    end

    private

    def inventory_text
      @daily_record.inventory_items.active.includes(:inventory).to_a.map do |inventory_item|
        <<~HEREDOC
        #{inventory_item.inventory.name} - In: #{inventory_item.in_count}, Out: #{inventory_item.out_count}, On Hand: #{inventory_item.total_count}
        HEREDOC
      end
    end

    def restock_text
      items_needed_restock = @daily_record.inventory_items.includes(:inventory).restock_needed

      if items_needed_restock.any?
        @daily_record.inventory_items.active.restock_needed.to_a.map do |inventory_item|
          <<~HEREDOC
          #{inventory_item.inventory.name} - On Hand: #{inventory_item.total_count}, Trigger Count: #{inventory_item.inventory.restock_trigger_count}
          HEREDOC
        end
      else
        "Nothing needed restocking"
      end
    end
  end
end
