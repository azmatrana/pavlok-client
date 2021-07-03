

# Pavlok::Client

`pavlok-client` is the Ruby SDK for Pavlok.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'pavlok-client', github: 'azmatrana/pavlok-client'
```

And then execute:

    $ bundle install

## Credentials

Grab an account here:
https://app.pavlok.com/users/sign_up

Then create new application from below link and get your oauth credentials(Client ID, Secret ID, Callback urls) from here:
https://app.pavlok.com/oauth/applications



## Usage

1. Initialize

    ` pavlok = PavlokApp::Client.new(client_id: PAVLOK_CLIENT_ID, redirect_uri: PAVLOK_REDIRECT_URI, client_secret: PAVLOK_CLIENT_SECRET)`


2. Generate code url to get authorisation code

    ` pavlok.code_url `

    Visit the url to generate the code

3. Set your code which you get on visiting the above url

    ` access_token = pavlok.fetch_access_token(code) `

    Note: this will exchange the code with the pavlok oauth and will set the access_token

4. Initialise pavlok client with `access_token`
  (if you already have `access_token` saved in db you can use that one and skip the step 1, 2 and 3)

  ` pavlok = PavlokApp::Client.new(access_token: access_token)`


5. Call pavlok functions.

    ` pavlok.zap(127) `

    ` pavlok.beep(2)  `

    ` pavlok.vibration(127) `


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/azmatrana/pavlok-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/azmatrana/pavlok-client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pavlok::Client project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/azmatrana/pavlok-client/blob/master/CODE_OF_CONDUCT.md).
