inventory_hash = {
  hot_chix: 2,
  chicken_strips: 3,
  fish_fillet: 3,
  squid_rings: 3,

  french_fries: 4,
  onion_rings: 2,
  potato_wedges: 4,
  mojos: 3,

  house_blend: 8,
  red_tea: 8,
  cucumber: 8,
  lemonade: 8,


  water: 3,
  big_cups: 1000,
  separator: 1000,
  plastic_gloves: 5,
  stick: 5,
  trash_bag: 5,

  signature_dip: 1,
  garlic_mayo: 1,
  honey_mustard: 1,

  oil: 2,
  corn_starch: 1,
  flour: 1
}

inventory_hash.each do |inventory_slug, trigger_count|
  inventory_slug = inventory_slug.to_s
  Inventory.create!(
    slug: inventory_slug,
    name: inventory_slug.humanize,
    restock_trigger_count: trigger_count
  )
end
