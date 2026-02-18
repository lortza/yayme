# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

YayMe is a Rails 7.2 microposting application for tracking personal accomplishments across different categories: TILs (Today I Learned), Merit, Praise, and Gratitude. Posts support markdown with code syntax highlighting (via CodeRay), image attachments (via ActiveStorage + Dropbox), and can be organized with custom categories and filtered by timeframes.

Live on Heroku: http://yay-me.herokuapp.com

**Tech Stack:**
- Ruby 3.3.10
- Rails 7.2.3
- PostgreSQL
- Bootstrap 5.3.3
- Plain CSS with CSS custom properties (no SASS/SCSS)
- Vanilla JavaScript
- RSpec for testing
- Standard RB for linting
- Devise for authentication
- Pundit for authorization

## Development Setup

```bash
# Initial setup (installs dependencies, prepares database, clears logs)
bin/setup

# Or manual setup
bundle install
rake db:setup  # Runs db:create, db:schema:load, and db:seed

# Start server
rails server
```

**User authentication:** In development, use credentials from `db/seeds.rb` to log in. User signup is disabled by default in `config/routes.rb` (line 7-8). To enable signup, comment line 7 and uncomment line 10, then visit http://localhost:3000/users/sign_up.

## Running Tests & Linters

```bash
# Full test suite
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/post_spec.rb

# Run specific test by line number
bundle exec rspec spec/models/post_spec.rb:42

# Linters (used in CI)
bundle exec reek
bundle exec standardrb

# Auto-fix standardrb issues
bundle exec standardrb --fix
```

**VS Code Ruby version issues:** If VS Code doesn't recognize the correct Ruby version, set it via terminal: `RBENV_VERSION='3.3.10'`

## Architecture Overview

### Data Model Hierarchy

The core data model follows this structure:

```
User
  ├─ has_many :post_types
  │    └─ has_many :posts
  └─ has_many :categories

Post
  ├─ belongs_to :post_type
  ├─ has_many :categories (through :post_categories)
  └─ has_one_attached :image (via ActiveStorage)
```

**Key relationships:**
- Users own PostTypes (custom types like "TIL", "Merit", "Praise", "Gratitude")
- PostTypes define templates for posts (e.g., Merit has template with sections for Project, Problem, Solution)
- Posts belong to one PostType and can have multiple Categories
- Posts access their user via `post.post_type.user`

### Non-Standard Models
- **Report** (`app/models/report.rb`): Plain Ruby class (not ActiveRecord) providing class methods for analytics and word cloud generation
- **Sortable** (`app/models/sortable.rb`): Concern for sorting functionality

### Services
- **UserDataSetupService** (`app/services/user_data_setup_service.rb`): Creates default PostTypes and Categories for new users. Called from `RegistrationsController` when users sign up.

### Authorization
Uses **Pundit** for authorization. Policies are in `app/policies/`. Always check policy permissions before controller actions that modify resources.

## Key Features & Implementation Details

### Post Search & Filtering
Posts can be filtered by:
- **Timeframes**: "Past Week" (7 days), "Past Month" (30 days), "Past Quarter" (90 days), "Past Half Year" (182 days), "Past Year" (365 days), "All Time"
- **Year**: Specific calendar year
- **Text**: Full-text search across `description` and `given_by` fields using PostgreSQL ILIKE
- **Bookmarked**: Boolean flag for favoriting posts
- **PostType**: Filter by one or more post types
- **Categories**: Filter by one or more categories

See `Post.search` and `Post.filter_for_export` methods for implementation.

### Word Cloud Feature

The word cloud (`/word_cloud` route) generates frequency analysis of words in posts:
- Filters out common words, code artifacts, HTML tags, and template words
- Requires minimum word count threshold (configurable)
- Implementation: `Report.generate_word_cloud` and `Post#word_cloud`

### Markdown & Code Blocks

Posts render markdown using **Redcarpet** gem with syntax highlighting via **CodeRay**. Code blocks are preserved in rendering but stripped out during word cloud analysis.

### Image Handling

- Uses ActiveStorage with Dropbox backend (configured in `config/storage.yml`)
- Images validated for size (<1MB) and type (JPEG/PNG only)
- See `Post#acceptable_image` validation
- Images can be removed via `remove_attached_image` virtual attribute

### Post Exports

- **CSV Export** (`/post_exports`): Filtered export to CSV via `Post.to_csv`
- **Raise Prep** (`/raise_prep`): Special view for merit and praise posts from last calendar year, formatted for performance reviews
- **New Years Eve** (`/new_years_eve`): Special view for gratitude and praise posts

## Important Code Patterns

### Scopes & Query Methods

Posts use multiple scopes for filtering:
```ruby
Post.in_post_type_ids(ids)      # Filter by post type
Post.in_category_ids(ids)        # Filter by category (joins through post_categories)
Post.bookmarked                  # Only bookmarked posts
Post.by_date                     # Order by date descending
Post.in_chronological_order      # Order by date ascending
```

### Date Queries
- `Post.for_year(year)` - Posts for specific year using PostgreSQL `extract(year from date)`
- `Post.for_timeframe(label)` - Posts within timeframe (e.g., "Past Week" = last 7 days)
- Timeframe constants defined in `Report::TIMEFRAMES`

### Post Type Templates

PostTypes can have `description_template` (markdown text). When creating a new post, the template pre-fills the description field. See `UserDataSetupService` for default templates.

## Stylesheets

**Recent migration:** SCSS variables have been converted to CSS custom properties (variables.scss defines `:root` CSS variables). All stylesheets now use `var(--variable-name)` instead of `$variable-name`.

**Color scheme** for post types defined in `variables.scss`:
- Gratitude: `--gratitude`
- TIL: `--til`
- Praise: `--praise`
- Merit: `--merit`

**SCSS to CSS conversions:**
- `darken(color, %)` → `color-mix(in srgb, color X%, black)`
- `lighten(color, %)` → `color-mix(in srgb, color X%, white)`

## Testing
- **Framework**: RSpec with FactoryBot for fixtures
- **Matchers**: Shoulda Matchers for model testing
- **Structure**: `spec/` directory mirrors `app/` structure
- Tests include models, controllers, services, and policies

## CI/CD
- **CircleCI**: Runs tests and linters on every push
- **CodeClimate**: Monitors maintainability (badge in README)
- **Dependabot**: Automated dependency updates

## Common Gotchas
- **User signup is disabled by default** - Must modify routes.rb to allow new user registration
- **Dropbox required** - Image uploads require Dropbox API credentials configured
- **Dev credentials in seeds** - Don't commit actual credentials, use seeds.rb pattern
- **PostType ownership** - Posts don't directly belong to users; access user via `post.post_type.user`
- **Timeframe labels** - Must use exact strings from `Report::TIMEFRAMES` keys for filtering

## Coding Style
- IMPORTANT: Any new code should be written in idiomatic Rails 8 (or the current version). This means reaching for a Turbo solution (turbo links, streams, frames, or Stimulus) before writing vanilla javascript.
- Do not ask to run the server
- Any new features must have tests written for them
- Use rails helpers instead of vanilla HTML to avoid interpolating with ERB tags
- When using a Rails `tag` helper, in block format, the options should be wrapped in parenthesis.
