require 'net/http'
require 'cgi'
require 'json'
require 'configuration'
class LoLAPI
  extend Configuration

  def self.champion(region)
    query '/api/lol/' + region + '/v1.1/champion'
  end

  def self.game(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/game/by-summoner/' + summoner_id.to_s + '/recent'
  end

  def self.league(summoner_id, region)
    query '/api/' + region + '/v2.1/league/by-summoner/' + summoner_id.to_s
  end

  def self.summary(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/summary', 'season=SEASON3'
  end

  def self.ranked(summoner_id, region)
    query '/api/lol/' + region + '/v1.1/stats/by-summoner/' + summoner_id.to_s + '/ranked'
  end

  def self.summoner(name, region)
    query '/api/lol/' + region + '/v1.1/summoner/by-name/' + name.delete(' ')
  end

  def self.team(summoner_id, region)
    query '/api/' + region + '/v2.1/team/by-summoner/' + summoner_id.to_s
  end

  def self.query(uri, params = nil)
    if params.nil?
      response = Net::HTTP.get(URI('http://prod.api.pvp.net' + uri + '?api_key=' + self.api_key))
    else
      response = Net::HTTP.get(URI('http://prod.api.pvp.net' + uri + '?' + params + '&api_key=' + self.api_key))
    end

    JSON.parse(response)
  end
end
