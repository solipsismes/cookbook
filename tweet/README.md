# Tweet with a shell script

This bash script allows you to post a tweet with an optional media
attachment. That's about everything you're allowed to do with a free
developer account anyway. And what else would you want to do on Twitter?
This script is intended to automatically post to Twitter the link to a
newly published article of a statically generated blog.

## Before you start

* Apply for a free X/Twitter developer plan

* Go to [Twitter Developer Portal](https://developer.twitter.com). Set app
permissions to read and write in settings>user authentication settings.

* get API key and secret, access token and secret in the "keys and
  token" tab, copy them in the corresponding variables in `tweet.sh`

## Dependencies

`jq` is needed to get the `media_id` of the attached file.

## Usage

```
./tweet.sh <text> [media_path]
```

## The X/Twitter API

* [The Twitter API](https://developer.x.com/en/docs/twitter-api/getting-started/about-twitter-api)
* [Post a Tweet with API v2](https://developer.x.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets)
* [Media upload with API v1.1](https://developer.x.com/en/docs/twitter-api/v1/media/upload-media/api-reference/post-media-upload)
* [Requests signature](https://developer.x.com/en/docs/authentication/oauth-1-0a/creating-a-signature)
