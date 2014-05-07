# League of Legends API Wrapper

A quick little Ruby wrapper for their recent [API](https://developer.riotgames.com). Still very much being worked on, so be careful about using it in production.

## Installation

You should just be able to do

  	gem 'lolapi'

This is my first gem however, so I may have mucked something up somewhere. Just let me know!

## Example usage:

	require 'lolapi'

	LoLAPI.configure do |config|
	  config.api_key = 'KEY_HERE'
	end

	puts "Champions:"
	puts LoLAPI::get_champions 'na'

	puts "Free Champions:"
	puts LoLAPI::get_champions 'na', free: true

	puts "Summoner by Name:"
	puts LoLAPI::get_summoner_by_name 'Sir Desch', 'na'

A full list of methods available:

	Champions
	LoLAPI::get_champions(region, free: nil)
	LoLAPI::get_champions_by_id(champion_id, region, free: nil)

	Game
	LoLAPI::get_game(summoner_id, region)

	League
	LoLAPI::get_challenger(region, type)
	LoLAPI::get_summoner_league(summoner_id, region, entry: false)
	LoLAPI::get_team_league(team_id, region, entry: false)

	Static Data
	LoLAPI::get_static_champions(region, id: nil, version: nil, locale: nil, data: nil, dataById: nil)
	LoLAPI::get_static_items(region, id: nil, version: nil, locale: nil, data: nil)
	LoLAPI::get_static_mastery(region, id: nil, version: nil, locale: nil, data: nil)
	LoLAPI::get_static_realm(region)
	LoLAPI::get_static_runes(region, id: nil, version: nil, locale: nil, data: nil)
	LoLAPI::get_static_spells(region, id: nil, version: nil, locale: nil, data: nil, dataById: nil)
	
	Stats
	LoLAPI::get_summary(summoner_id, region, season: nil)
	LoLAPI::get_ranked(summoner_id, region, season: nil)
	
	Summoner
	LoLAPI::get_summoner_by_name(name, region)
	LoLAPI::get_summoner_masteries(summoner_id, region)
	LoLAPI::get_summoner_runes(summoner_id, region)
	LoLAPI::get_summoner(summoner_id, region)
	LoLAPI::get_summoner_name(summoner_id, region)
	
	Team
	LoLAPI::get_team(summoner_id, region)
	LoLAPI::get_team_by_summoner(summoner_id, region)
