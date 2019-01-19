## Shopify Developer Intern Challenge Summer 2019

A simple server-side web API that can be used to drive an online shop.

### Requirements
`Ruby 2.3.3`
`Rails 5.2.2`

### Setup
1. Clone the repository and navigate to it
2. Run `bundle install` to install gems and dependencies
3. Run `rails db:migrate` to initialize the database
4. Run `bundle exec rspec` to run tests, ensuring that everything is setup correctly
5. Start the server with `rails s`

### Example Usage
1. Start up your HTTP client for testing (e.g. [httpie](https://httpie.org/))
2. Ping the server in your browser or HTTP client at `localhost:3000`
3. Sign up with `http :3000/signup name=test email=test@email.com password=foobar password_confirmation=foobar`
4. Copy your auth_token
5. Make calls and attach your auth_token, for example: `http GET :3000/products Authorization:'abhajsbdjh123819'`