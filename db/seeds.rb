inventory_slugs = %w(
  hot_chix chicken_strips fish_fillet squid_rings
  french_fries onion_rings potato_wedges mojos
  house_blend red_tea cucumber lemonade
  water big_cups separator plastic_gloves stick trash_bag
  signature_dip garlic_mayo honey_mustard
  oil corn_starch flour
)

inventory_slugs.each do |inventory_slug|
  Inventory.create!(
    slug: inventory_slug,
    name: inventory_slug.humanize,
    restock_trigger_count: 3
  )
end
