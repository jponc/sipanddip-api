inventory_hash = {
  hot_chix: 2,
  chicken_strips: 5,
  fish_fillet: 3,
  squid_rings: 2,

  french_fries: 8,
  onion_rings: 1,
  potato_wedges: 4,
  mojos: 2,

  house_blend: 5,
  red_tea: 5,
  cucumber: 5,
  lemonade: 5,

  water: 3,
  big_cups: 1_200,
  separator: 1_200,
  plastic_gloves: 10,
  stick: 5,
  trash_bag: 50,

  signature_dip: 1,
  garlic_mayo: 1,
  honey_mustard: 1,

  oil: 1,
  corn_starch: 1,
  flour: 1,

  # Addiotional
  cup_lids: 100,
  straw: 1,
  dip_container: 200,
  tissue: 2
}

inventory_hash.each do |inventory_slug, trigger_count|
  inventory_slug = inventory_slug.to_s

  inventory = Inventory.find_or_initialize_by(slug: inventory_slug)
  inventory.update_attributes!(
    name: inventory_slug.humanize,
    restock_trigger_count: trigger_count
  )
end
