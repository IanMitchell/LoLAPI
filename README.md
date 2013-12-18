# League of Legends API Wrapper

A quick little Ruby wrapper for their recent [API](https://developer.riotgames.com)

Might not work, I haven't tested it that thoroughly yet (still very much being worked on).

**Note:** *I'll be traveling until December 16, 2013. The repository won't see much work until then, but will be active after that!*

## Installation

You should just be able to do

  	gem 'lolapi'

This is my first gem however, so I may have mucked something up somewhere. Just let me know!

## Example usage:

	require 'lolapi'

	LoLAPI.configure do |config|
	  config.api_key = 'KEY_HERE'
	end

	puts 'Champions:'
	puts LoLAPI::champion('na')


	puts 'Summoner:'
	summoner = LoLAPI::summoner('Sir Desch', 'na')
	puts summoner

	puts 'Game:'
	puts LoLAPI::game(summoner['id'], 'na')

	puts 'League:'
	puts LoLAPI::league(summoner['id'], 'na')

	puts 'Summary:'
	summary = LoLAPI.summary(summoner['id'], 'na')
	puts summary
