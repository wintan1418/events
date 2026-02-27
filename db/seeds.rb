puts "Seeding database..."

# Create demo account (Account is not tenant-scoped, so no tenant needed)
account = Account.find_or_create_by!(subdomain: "luxe") do |a|
  a.name = "Luxe Events Co."
  a.plan_type = :professional
  a.email = "info@luxeevents.com"
  a.phone = "555-0100"
  a.active = true
end

# Set tenant before creating tenant-scoped records
ActsAsTenant.current_tenant = account

# Create admin user
admin = User.find_or_create_by!(email: "admin@luxeevents.com") do |u|
  u.account = account
  u.first_name = "Alexandra"
  u.last_name = "Sterling"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :admin
  u.confirmed_at = Time.current
end

# Create planner
planner = User.find_or_create_by!(email: "planner@luxeevents.com") do |u|
  u.account = account
  u.first_name = "Olivia"
  u.last_name = "Hart"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :planner
  u.confirmed_at = Time.current
end

# Create client
client_user = User.find_or_create_by!(email: "client@luxeevents.com") do |u|
  u.account = account
  u.first_name = "James"
  u.last_name = "Whitfield"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :client
  u.confirmed_at = Time.current
end

# Create vendor user
vendor_user = User.find_or_create_by!(email: "vendor@luxeevents.com") do |u|
  u.account = account
  u.first_name = "Marcus"
  u.last_name = "Chen"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :vendor
  u.confirmed_at = Time.current
end

# === Domain Model Seeds ===

# Create vendors
photographer = Vendor.find_or_create_by!(name: "Chen Photography") do |v|
  v.category = :photography
  v.email = "marcus@chenphotography.com"
  v.phone = "555-0201"
  v.active = true
  v.user = vendor_user
end

caterer = Vendor.find_or_create_by!(name: "Golden Plate Catering") do |v|
  v.category = :catering
  v.email = "info@goldenplate.com"
  v.phone = "555-0202"
  v.active = true
end

florist = Vendor.find_or_create_by!(name: "Bloom & Petal") do |v|
  v.category = :florist
  v.email = "hello@bloompetal.com"
  v.phone = "555-0203"
  v.active = true
end

# Create a sample event
event = Event.find_or_create_by!(title: "Whitfield-Ross Wedding") do |e|
  e.planner = planner
  e.client = client_user
  e.description = "An elegant garden wedding at The Grand Estate"
  e.event_type = :wedding
  e.event_date = 3.months.from_now
  e.start_time = "16:00"
  e.end_time = "23:00"
  e.venue = "The Grand Estate"
  e.venue_address = "1234 Estate Drive, Beverly Hills, CA 90210"
  e.status = :planning
  e.budget_total = 85_000.00
  e.estimated_guests = 150
end

# Create event vendors
EventVendor.find_or_create_by!(event: event, vendor: photographer) do |ev|
  ev.contracted_amount = 8_500.00
  ev.paid_amount = 2_500.00
  ev.status = :contracted
end

EventVendor.find_or_create_by!(event: event, vendor: caterer) do |ev|
  ev.contracted_amount = 22_000.00
  ev.paid_amount = 5_000.00
  ev.status = :confirmed
end

EventVendor.find_or_create_by!(event: event, vendor: florist) do |ev|
  ev.contracted_amount = 6_500.00
  ev.paid_amount = 0
  ev.status = :pending
end

# Create line items
[
  { category: "Venue", description: "Grand Estate rental fee", estimated_cost: 15_000, actual_cost: 15_000, paid: true },
  { category: "Catering", description: "Dinner service (150 guests)", estimated_cost: 22_000, actual_cost: 22_000, paid: false },
  { category: "Photography", description: "Full day coverage + album", estimated_cost: 8_500, actual_cost: 8_500, paid: false },
  { category: "Flowers", description: "Ceremony + reception arrangements", estimated_cost: 6_500, actual_cost: 6_500, paid: false },
  { category: "Music", description: "DJ + sound system", estimated_cost: 3_500, actual_cost: 3_200, paid: true },
  { category: "Cake", description: "5-tier custom wedding cake", estimated_cost: 2_800, actual_cost: 0, paid: false },
  { category: "Stationery", description: "Invitations + programs", estimated_cost: 1_200, actual_cost: 1_350, paid: true },
  { category: "Decor", description: "Lighting, linens, centerpieces", estimated_cost: 8_000, actual_cost: 0, paid: false },
].each do |attrs|
  LineItem.find_or_create_by!(event: event, description: attrs[:description]) do |li|
    li.category = attrs[:category]
    li.estimated_cost = attrs[:estimated_cost]
    li.actual_cost = attrs[:actual_cost]
    li.paid = attrs[:paid]
  end
end

# Create tasks
[
  { title: "Confirm final guest count", due_date: 6.weeks.from_now, status: :pending, priority: :high },
  { title: "Finalize menu selections", due_date: 8.weeks.from_now, status: :in_progress, priority: :high },
  { title: "Order wedding invitations", due_date: 2.weeks.ago, status: :completed, priority: :medium },
  { title: "Book rehearsal dinner venue", due_date: 4.weeks.from_now, status: :pending, priority: :medium },
  { title: "Schedule cake tasting", due_date: 1.week.from_now, status: :pending, priority: :low },
  { title: "Arrange transportation", due_date: 5.weeks.from_now, status: :pending, priority: :medium },
].each_with_index do |attrs, i|
  Task.find_or_create_by!(event: event, title: attrs[:title]) do |t|
    t.due_date = attrs[:due_date]
    t.status = attrs[:status]
    t.priority = attrs[:priority]
    t.assigned_to = planner
    t.created_by = planner
    t.position = i + 1
  end
end

# Create guests
[
  { first_name: "Robert", last_name: "Whitfield", rsvp_status: :confirmed, table_number: 1, party_size: 2 },
  { first_name: "Eleanor", last_name: "Ross", rsvp_status: :confirmed, table_number: 1, party_size: 2, dietary_notes: "Vegetarian" },
  { first_name: "David", last_name: "Kim", rsvp_status: :confirmed, table_number: 2, party_size: 2 },
  { first_name: "Sarah", last_name: "Mitchell", rsvp_status: :tentative, table_number: 3, party_size: 1 },
  { first_name: "Michael", last_name: "Torres", rsvp_status: :pending, party_size: 2 },
  { first_name: "Emily", last_name: "Walsh", rsvp_status: :declined, party_size: 1 },
].each do |g|
  Guest.find_or_create_by!(event: event, first_name: g[:first_name], last_name: g[:last_name]) do |guest|
    guest.email = "#{g[:first_name].downcase}@example.com"
    guest.rsvp_status = g[:rsvp_status]
    guest.table_number = g[:table_number]
    guest.party_size = g[:party_size]
    guest.dietary_notes = g[:dietary_notes]
  end
end

# Create timeline
[
  { start_time: "16:00", end_time: "16:30", title: "Guest Arrival", responsible_party: "Venue Coordinator", location: "Main Entrance" },
  { start_time: "16:30", end_time: "17:00", title: "Ceremony", responsible_party: "Officiant", location: "Garden Pavilion" },
  { start_time: "17:00", end_time: "17:30", title: "Cocktail Hour", responsible_party: "Caterer", location: "Terrace" },
  { start_time: "17:30", end_time: "18:00", title: "Family Photos", responsible_party: "Photographer", location: "Rose Garden" },
  { start_time: "18:00", end_time: "18:15", title: "Grand Entrance", responsible_party: "DJ", location: "Grand Ballroom" },
  { start_time: "18:15", end_time: "19:00", title: "Dinner Service", responsible_party: "Caterer", location: "Grand Ballroom" },
  { start_time: "19:00", end_time: "19:30", title: "Toasts & Speeches", responsible_party: "Best Man / Maid of Honor", location: "Grand Ballroom" },
  { start_time: "19:30", end_time: "19:45", title: "First Dance", responsible_party: "DJ", location: "Dance Floor" },
  { start_time: "19:45", end_time: "20:00", title: "Cake Cutting", responsible_party: "Planner", location: "Grand Ballroom" },
  { start_time: "20:00", end_time: "22:30", title: "Open Dancing", responsible_party: "DJ", location: "Dance Floor" },
  { start_time: "22:30", end_time: "23:00", title: "Send-off", responsible_party: "Planner", location: "Main Entrance" },
].each_with_index do |t, i|
  Timeline.find_or_create_by!(event: event, title: t[:title]) do |tl|
    tl.start_time = t[:start_time]
    tl.end_time = t[:end_time]
    tl.description = t[:description]
    tl.responsible_party = t[:responsible_party]
    tl.location = t[:location]
    tl.position = i + 1
  end
end

puts "Seeding complete!"
puts ""
puts "Login credentials:"
puts "  Admin:   admin@luxeevents.com / password123"
puts "  Planner: planner@luxeevents.com / password123"
puts "  Client:  client@luxeevents.com / password123"
puts "  Vendor:  vendor@luxeevents.com / password123"
