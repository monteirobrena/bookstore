# Bookstore API

## Install

```ruby
bundle
```

## Running Tests

```ruby
rails db:environment:set RAILS_ENV=test

rspec spec/

open coverage/index.html
```

## Database

```ruby
rails db:create
rails db:migrate
rails db:seed
```

## Tasks

Define token to access GitHub:

```
export GITHUB_TOKEN="YOUR_TOKEN"
```

Import authors to GitHub:

```ruby
rails authors:create
```

## Running / Development

```ruby
rails s
```