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

## Getting Started

* Fork & Clone
* `bundle`
* Set up DB: `rake db:setup` (Runs `db:create`, `db:schema:load` and `db:seed`)
* User: In development, see the seeds file for the user credentials so you can log in
* `routes.rb`: comment out line 7, uncomment line 10 to allow users to sign up at http://localhost:3000/users/sign_up

## Rubocop
Rubocop is used for enforcing style guide
* Rubocop: `rubocop`

## Tests
* Tests: `bundle exec rspec`

### Linters
This project uses these linters in CI:
* [reek](https://github.com/troessner/reek)
* [rubocop](https://github.com/rubocop-hq/rubocop)
* [scss-lint](https://github.com/sds/scss-lint)

Run them locally on your machine like this:
```
bundle exec reek

bundle exec rubocop

bundle exec scss-lint app/assets/stylesheets/**.scss
```

## Related Docs
* [Devise](https://github.com/plataformatec/devise)
* [Uglifier](https://github.com/lautis/uglifier) in harmony mode
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)
* [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager
