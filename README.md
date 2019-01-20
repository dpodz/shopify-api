## Shopify Developer Intern Challenge Summer 2019

A simple server-side web API that can be used to drive an online shop.

### Requirements
`Ruby 2.3.3`
`Rails 5.2.2`

### Setup
1. Clone the repository and navigate to it
2. Run `bundle install` to install gems and dependencies
3. Run `rails db:migrate` and `rails db:test:prepare` to initialize the database
4. Delete the file `config/credentials.yml.enc`
5. Regenerate credentials with `EDITOR=vim rails credentials:edit`
6. Run `bundle exec rspec` to run tests to ensure everything is set up
7. Start the server with `rails s`

### Example Usage
1. Start up your HTTP client (e.g. [httpie](https://httpie.org/))
2. Ping the server in your browser or HTTP client at `localhost:3000`
3. Sign up with `http :3000/signup name=example email=example@email.com password=foobar password_confirmation=foobar`
4. Copy your auth_token
5. Make calls and attach your auth_token, for example: `http GET :3000/products Authorization:'abhajsbdjh123819'`

### API Documentation
You must be authenticated to use the API.

You can get your authentication token by signing up at `:3000/signup name=example email=example@email.com password=foobar password_confirmation=foobar`

Attach your auth_token to the end of your API request by appending ` Authorization:'auth_token'`

| URI Base    | Request Type | URI Pattern          | Description                                     | URI Parameter Options | POST Parameters                                                                  | Example                                                                                           |
|-------------|:------------:|----------------------|-------------------------------------------------|-----------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| `/products` | GET          | `/products/`         | Retrieve a JSON object of all products          | onlyinstock=[0,1]     | n/a                                                                              | `http GET :3000/products` `http GET :3000/products?onlyinstock=1`                                 |
| `/products` | GET          | `/products/:id`      | Retrieve a JSON object of product with given id |                       | n/a                                                                              | `http GET :3000/products/3`                                                                       |
| `/products` | POST         | `/products/purchase` | "Purchase" product with given id                |                       | `{id:int}`                                                                       | `http POST :3000/products/purchase id=3`                                                          |
| `/signup`   | POST         | `/signup`            | Make an account                                 |                       | `{ name:string,  email:string,  password:string, password_confirmation:string }` | `http POST :3000/signup name=joe email=ex@email.com password=foobar password_confirmation=foobar` |
| `/auth`     | POST         | `/auth/login`        | Login with an existing account                  |                       | `{  name:string,  password:string  }`                                            | `http POST :3000/auth/login name=joe password=foobar`                                             |

