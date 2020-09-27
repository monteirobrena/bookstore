# Bookstore API

## Install

```ruby
bundle
```

## Running Tests

```ruby
rails db:environment:set RAILS_ENV=test
Go to **Settings** on GitHub repo, click on **Webhooks**, then click on **Add Webhook**.

In the **Payload URL** paste the
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

Start API:

```ruby
rails s
```

## GitHub Webhooks

Start tunel to localhost and copy the Forwarding URL to use as **Payload URL** on GitHub:

```
ngrok http 3000
```

### Authors

Go to **Settings** on GitHub repo, click on **Webhooks**, then click on **Add Webhook**.

In the **Payload URL** paste the **Forwarding URL** generate by `ngrok` and add the path:

```ruby
/authors/webhook
```

The full **Payload URL** will be something like that:

http://09c08b902e59.ngrok.io/authors/webhook

1. Choose `application/x-www-form-urlencoded` on **Content type** selection.

2. Choose `Let me select individual events.` on **Which events would you like to trigger this webhook?**.

3. Select `Issues` checkbox.

4. Select `Active` checkbox.

5. Click on **Add webhook**.


### Books

Go to **Settings** on GitHub repo, click on **Webhooks**, then click on **Add Webhook** again.

In the **Payload URL** paste the **Forwarding URL** generate by `ngrok` and add the path:

```ruby
/books/webhook
```

The full **Payload URL** will be something like that:

http://09c08b902e59.ngrok.io/books/webhook

1. Choose `application/x-www-form-urlencoded` on **Content type** selection.

2. Choose `Let me select individual events.` on **Which events would you like to trigger this webhook?**.

3. Select `Issue comments` checkbox.

4. Select `Active` checkbox.

5. Click on **Add webhook**.
