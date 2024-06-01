# Tweet with a shell script

* Go to [Twitter Developer Portal](https://developer.twitter.com). Set app
permissions to read and write in settings>user authentication settings.

* get API key and secret, bearer token, access token and secret in the "keys and
  token" tab.


* Install the required packages:
  ```
  python3 -m venv ~/.venv
  source ~/.venv/bin/activate
  python3 -m pip install tweepy python-dotenv
  ```

* Create a `.env` file with your keys and tokens:

  ```
  TWITTER_API_KEY="XXX"
  TWITTER_API_KEY_SECRET="XXX"
  TWITTER_ACCESS_TOKEN="XXX"
  TWITTER_ACCESS_TOKEN_SECRET="XXX"
  TWITTER_BEARER_TOKEN="XXX"
  ```

* Done. You can now `./tweet.sh "Hello, world!"`
