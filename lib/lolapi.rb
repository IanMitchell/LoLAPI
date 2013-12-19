require 'net/http'
require 'json'
require 'configuration'
require 'LoLAPI/version'
module LoLAPI
  extend Configuration

  BASE_URL = 'http://prod.api.pvp.net'

  def self.get_champions(region, free: nil)
    if free.nil?
      query '/api/lol/' + region + '/v1.1/champion'
    else
      query '/api/lol/' + region + '/v1.1/champion', params: 'freeToPlay=' + free.to_s
    end
  end

  def self.get_game(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/game/by-summoner/' + summoner_id.to_s + '/recent'
  end

  def self.get_league(summoner_id, region)
    query '/api/' + region + '/v2.1/league/by-summoner/' + summoner_id.to_s
  end

  def self.get_summary(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/summary'
    else
      query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/summary', params: 'season=' + season
    end
  end

  def self.get_ranked(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/ranked'
    else
      query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/ranked', params: 'season=' + season
    end
  end

  def self.get_summoner_by_name(name, region)
    query '/api/lol/' + region + '/v1.1/summoner/by-name/' + name.delete(' ')
  end

  def self.get_summoner_masteries(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/summoner/' + summoner_id.to_s + '/masteries'
  end

  def self.get_summoner_runes(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/summoner/' + summoner_id.to_s + '/runes'
  end

  def self.get_summoner(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/summoner/' + summoner_id.to_s
  end

  def self.get_summoner_name(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/summoner/' + summoner_id.to_s + '/name'
  end

  def self.get_team(summoner_id, region)
    query '/api/' + region + '/v2.1/team/by-summoner/' + summoner_id.to_s
  end

  def self.query(uri, params: nil)
    if check_key == 1
      return nil
    end

    if params.nil?
      response = Net::HTTP.get(URI(BASE_URL + uri + '?api_key=' + self.api_key))
    else
      response = Net::HTTP.get(URI(BASE_URL + uri + '?' + params + '&api_key=' + self.api_key))
    end

    JSON.parse(response)
  end

  def self.check_key
    if self.api_key.nil?
      puts "ERROR: Please initialize lolapi with an API Key."
      return 1
    end
  end
end
