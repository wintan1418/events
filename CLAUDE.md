# Event Planning SaaS Platform

## Project Overview
High-end multi-tenant SaaS event planning "Command Center" built on Rails 8.0.4. Handles event creation, client portals, vendor management, budgeting, guest lists, and day-of timelines.

## Tech Stack
- **Framework:** Ruby on Rails 8.0.4, Ruby 3.4.3
- **Database:** PostgreSQL
- **Frontend:** Tailwind CSS v4 (CSS-first config), Hotwire (Turbo + Stimulus), importmap
- **Asset Pipeline:** Propshaft
- **Auth:** Devise (multi-role: admin, planner, client, vendor)
- **Authorization:** Pundit
- **Multi-tenancy:** acts_as_tenant (scoped by Account)
- **Background Jobs:** Sidekiq + Redis
- **WebSockets:** ActionCable with Redis adapter
- **File Uploads:** Active Storage

## Architecture

### User Roles
- **Admin** (firm owner) — full access, firm settings, team management
- **Planner** (employee) — event CRUD, task management, vendor coordination
- **Client** (the couple/corporate lead) — view their event, manage guests, approve items
- **Vendor** (caterer/DJ/etc.) — view assigned events, deliverables, payment status

### Multi-tenancy
Every model is scoped to an `Account` via `acts_as_tenant :account`. The tenant is set from `current_user.account` after Devise authentication. Devise auth lookups use `ActsAsTenant.without_tenant` to find users across tenants.

### Controller Namespaces
```
Admin::       → /admin/*           (layout: admin)
Planner::     → /planner/*         (layout: planner)
Client::      → /client/*          (layout: client)
VendorPortal:: → /vendor_portal/*  (layout: vendor_portal)
Api::V1::     → /api/v1/*          (JSON endpoints for AJAX)
```

### Models
Account, User, Event, Task, Vendor, EventVendor, LineItem, Guest, Timeline

### UI Theme
Dark luxury + glassmorphism. Gold/amber accents. Custom Tailwind utilities: `glass`, `glass-card`, `glass-sidebar`, `gold-glow`, `gold-text`. Theme defined in `app/assets/tailwind/application.css`.

## Common Commands
```bash
bin/rails server              # Start Rails server
bin/rails tailwindcss:watch   # Watch Tailwind CSS changes
bundle exec sidekiq           # Start Sidekiq worker
bin/dev                       # Start all via Procfile.dev

rails db:migrate              # Run migrations
rails db:seed                 # Seed demo data
rails test                    # Run test suite
```

## Demo Credentials
```
Admin:   admin@luxeevents.com / password123
Planner: planner@luxeevents.com / password123
Client:  client@luxeevents.com / password123
Vendor:  vendor@luxeevents.com / password123
```

## Key Patterns
- All tenant-scoped models include `acts_as_tenant :account`
- Controllers inherit from namespace `BaseController` (e.g., `Admin::BaseController`)
- Authorization via Pundit policies in `app/policies/`
- View components as partials in `app/views/components/`
- Stimulus controllers in `app/javascript/controllers/`
- Turbo Streams for real-time updates (tasks, budget, notifications)

## Conventions
- Use friendly_id slugs for public-facing URLs (Account, User, Event, Vendor)
- Enums for all status/type fields (integer-backed)
- Pagy for pagination
- All monetary fields: `decimal, precision: 12, scale: 2`
- Keep Devise views styled consistently with the dark luxury theme
