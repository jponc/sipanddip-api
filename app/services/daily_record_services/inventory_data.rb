module DailyRecordServices
  class InventoryData < WorksheetBase

    RANGE_START_ROW = 4
    RANGE_START_DATE = Date.new(2019, 2, 1)

    def process!
      return if sheet_row.blank?

      inventories = Inventory.all.to_a

      inventory_slugs.each do |inventory_slug|
        inventory = inventories.find { |i| i.slug == inventory_slug }

        inventory_item =
          @daily_record.inventory_items.find_or_initialize_by(
            inventory_id: inventory.id
          )

        inventory_item.update_attributes!(
          in_count: mapping_hash["#{inventory_slug}_in"],
          out_count: mapping_hash["#{inventory_slug}_out"],
          total_count: mapping_hash["#{inventory_slug}_total"]
        )
      end

      send_slack_notifications
    end

    private

    def send_slack_notifications
      send_slack_inventory_changes_notification
      send_slack_restock_notification
    end

    def send_slack_inventory_changes_notification
      return if @daily_record.inventory_items.with_changes.empty?

      webhook_url = Rails.application.secrets[:slack][:webhook_url]
      notifier = Slack::Notifier.new webhook_url

      text = "*#{@daily_record.record_date}* - Inventory Changes"

      attachment = {
        fallback: slack_changed_inventory_items_text,
        text: slack_changed_inventory_items_text,
        color: "warning",
        mrkdwn_in: ["text"]
      }

      notifier.post text: text, attachments: [attachment]
    end

    def slack_changed_inventory_items_text
      @daily_record.inventory_items.with_changes.includes(:inventory).to_a.map do |inventory_item|
        inventory = inventory_item.inventory
        "*#{inventory.name}* - IN: *#{inventory_item.in_count}*, OUT: *#{inventory_item.out_count}*, TOTAL: *#{inventory_item.total_count}*"
      end.join("\n")
    end

    def send_slack_restock_notification
      return if @daily_record.inventory_items.restock_needed.empty?

      webhook_url = Rails.application.secrets[:slack][:webhook_url]
      notifier = Slack::Notifier.new webhook_url

      text = "*#{@daily_record.record_date}* - Restock Needed!"

      attachment = {
        fallback: slack_restock_text,
        text: slack_restock_text,
        color: "danger",
        mrkdwn_in: ["text"]
      }

      notifier.post text: text, attachments: [attachment]
    end

    def slack_restock_text
      @daily_record.inventory_items.restock_needed.includes(:inventory).to_a.map do |inventory_item|
        inventory = inventory_item.inventory
        "*#{inventory.name}* - remaining: *#{inventory_item.total_count}*, trigger: *#{inventory.restock_trigger_count}*"
      end.join("\n")
    end

    def range
      date_diff = (@daily_record.record_date - RANGE_START_DATE).to_i
      row = RANGE_START_ROW + date_diff

      "Inventory!A#{row}:BF#{row + 1}"
    end

    def mapping_hash
      {}.tap do |h|
        # Since 0th index is the date
        values = sheet_row[1..-1]

        inventory_slugs.each_with_index do |slug, idx|
          val_idx = (idx * 3)

          h["#{slug}_in"] = values[val_idx].presence || 0
          h["#{slug}_out"] = values[val_idx+1].presence || 0
          h["#{slug}_total"] = values[val_idx+2].presence || 0
        end
      end
    end

    def inventory_slugs
      %w(
        hot_chix
        chicken_strips
        fish_fillet

        french_fries
        onion_rings
        mojos

        house_blend
        cucumber
        lemonade

        water

        big_cups
        separator
        plastic_gloves
        stick
        trash_bag

        signature_dip
        garlic_mayo
        honey_mustard

        oil
      )
    end
  end
end
