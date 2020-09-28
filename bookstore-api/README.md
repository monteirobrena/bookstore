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

### GitHub Token

On GitHub logged account go to **Settings**, then:

1. Click on **Developer settings** at side menu.
2. Click on **Personal access tokens** at side menu.
3. Click on **Generate new token** button.
4. In the **Note** field fill with `Bookstore`.
5. Select `repo` at **Select scopes** checkboxes.
6. Click on **Generate token** button.
7. Copy the token to export it as environment variable.

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

Go to **Settings** on GitHub repo, then:

1. Click on **Webhooks** at side menu.
2. Click on **Add Webhook** at side menu.
3. In the **Payload URL** field paste the **Forwarding URL** generate by `ngrok` and add the path:

```ruby
/authors/webhook
```

The full **Payload URL** will be something like that:

http://09c08b902e59.ngrok.io/authors/webhook

4. Choose `application/x-www-form-urlencoded` on **Content type** selection.

5. Choose `Let me select individual events.` on **Which events would you like to trigger this webhook?**.

6. Select `Issues` checkbox.

7. Select `Active` checkbox.

8. Click on **Add webhook**.


### Books

Go to **Settings** on GitHub repo, then:

1. Click on **Webhooks** at side menu.

2. Click on **Add Webhook** at side menu.

3. In the **Payload URL** paste the **Forwarding URL** generate by `ngrok` and add the path:

```ruby
/books/webhook
```

The full **Payload URL** will be something like that:

http://09c08b902e59.ngrok.io/books/webhook

4. Choose `application/x-www-form-urlencoded` on **Content type** selection.

5. Choose `Let me select individual events.` on **Which events would you like to trigger this webhook?**.

6. Select `Issue comments` checkbox.

7. Select `Active` checkbox.

8. Click on **Add webhook**.


## Docker

To use Docker is also needed to make the steps to generate a token and webhooks on GitHub.

```
docker-compose build
docker-compose up

docker-compose run api rails db:create
docker-compose run api rails db:migrate
docker-compose run api rails db:seed

docker-compose run api rails authors:create

docker-compose run api rails db:environment:set RAILS_ENV=test

docker-compose run api rspec spec/ 
```