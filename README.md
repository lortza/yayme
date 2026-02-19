# Yay Me Post Tracking App

[![CircleCI](https://circleci.com/gh/lortza/yayme.svg?style=svg)](https://circleci.com/gh/lortza/yayme)

[![Maintainability](https://api.codeclimate.com/v1/badges/5900dd05417f73a806a7/maintainability)](https://codeclimate.com/github/lortza/yayme/maintainability)

Microposting app for tracking, TILs, merit, praise, and gratitude.

Live on heroku as [yayme](http://yay-me.herokuapp.com)

## Features

* create different types of posts (ex: praise, TIL)
* renders posts in markdown
* takes codeblocks in markdown
* create markdown templates for types of posts

## Tech Stack
- Ruby
- Rails
- PostgreSQL
- Bootstrap
- Plain CSS with CSS custom properties (no SASS/SCSS)
- Stimulus for Javascript
- RSpec for testing
- Standard RB for linting
- Devise for authentication
- Pundit for authorization
- Dropbox API for image storage

## Getting Started

* Fork & Clone
* `bundle`
* Set up DB: `rake db:setup` (Runs `db:create`, `db:schema:load` and `db:seed`)
* User: In development, see the seeds file for the user credentials so you can log in
* `routes.rb`: comment out line 7, uncomment line 10 to allow users to sign up at http://localhost:3000/users/sign_up
* Note to myself: remember to set up the master.key with the value stored in the password manager 

## Required Technologies
* You will also need a Dropbox account and a dedicated folder in your account for images. See [Dropbox API](https://www.dropbox.com/developers/documentation). At the moment, the image url for posts is highly unsophisticated and is expecting a Dropbox url. If you want to use something other than non-smart url field (like being able to upload photos), go for it! :) You'll have a some work to do in this area.

## Tests
* Tests: `bundle exec rspec`

### Linters
This project uses these linters in CI:
* [reek](https://github.com/troessner/reek)
* [standard rb](https://github.com/standardrb/standard) (in support of the [VS Code extension](https://github.com/standardrb/vscode-standard-ruby?tab=readme-ov-file)). If VS Code is being a jerk about not recognizing the right version of ruby, you can set the ruby version via the VS Code terminal like: `RBENV_VERSION='3.3.10'`
* FactoryBot.lint -- coming soon

Run them locally on your machine like this:
```
bundle exec reek

bundle exec standardrb
```

https://guides.rubyonrails.org/8_0_release_notes.html

## Solid Trio Implementation
The Solid Trio (`solid_cache`, `solid_cable`, `solid_queue`) are implemented as tables in the main database instead of separate tables.


## Editing the credentials file

Never open the `master.key` or `credentials.yml.enc` in Atom. This will add newline characters that you can't remove and it will not be able to be unencrypted.

To edit this file, run:

```
EDITOR="code --wait" bin/rails credentials:edit
```

If this file gets borked, [this post](https://stackoverflow.com/a/54279636/5009528) and [this post](https://medium.com/@kirill_shevch/encrypted-secrets-credentials-in-rails-6-rails-5-1-5-2-f470accd62fc) will help.


## Related Docs
* [Devise](https://github.com/plataformatec/devise) user authentication (sign up/in/out)
* [Pundit](https://github.com/varvet/pundit) user authorization (restricts access to content)
* [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) for testing model relationships and validations
* [FactoryBot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md) to build test objects
* [Pagy](https://ddnexus.github.io/pagy/guides/quick-start/) for pagination
* [Dropbox API](https://www.dropbox.com/developers/documentation)
