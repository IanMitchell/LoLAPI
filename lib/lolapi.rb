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
    query '/api/lol/' + region + '/v1.3/game/by-summoner/' + summoner_id.to_s + '/recent'
  end

  def self.get_league(region, summoner_id: nil, entry: nil, type: nil)
    if summoner_id.nil?
      query '/api/lol/' + region + '/v2.3/league/challenger', params: 'type=' + type.to_s
    else
      if entry.nil?
        query '/api/lol/' + region + '/v2.3/league/by-summoner/' + summoner_id.to_s
      else
        query '/api/lol/' + region + '/v2.3/league/by-summoner/' + summoner_id.to_s + '/' + entry.to_s
      end
    end
  end

  # data must be in the format EX: "champData=image" or "itemData=gold"
  def self.get_static_data(region, type, id: nil, locale: nil, version: nil, data: nil)
    if id.nil?
      if locale.nil?
        if version.nil?
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type
          else
            query '/api/lol/static-data/' + region + '/v1/' + type, params: data.to_s
          end
        else
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'version=' + version.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'version=' + version.to_s + '&' + data.to_s
          end
        end
      else
        if version.nil?
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'locale=' + locale.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'locale=' + locale.to_s + '&' + data.to_s
          end
        else
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'locale=' + locale.to_s + '&version=' + version.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type, params: 'locale=' + locale.to_s + '&version=' + version.to_s + '&' + data.to_s
          end
        end
      end
    else
      if locale.nil?
        if version.nil?
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: data.to_s
          end
        else
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'version=' + version.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'version=' + version.to_s + '&' + data.to_s
          end
        end
      else
        if version.nil?
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'locale=' + locale.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'locale=' + locale.to_s + '&' + data.to_s
          end
        else
          if data.nil?
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'locale=' + locale.to_s + '&version=' + version.to_s
          else
            query '/api/lol/static-data/' + region + '/v1/' + type + '/' + id.to_s, params: 'locale=' + locale.to_s + '&version=' + version.to_s + '&' + data.to_s
          end
        end
      end
    end
  end

  def self.get_summary(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.2/stats/by-summoner/' + summoner_id.to_s + '/summary'
    else
      query '/api/lol/' + region + '/v1.2/stats/by-summoner/' + summoner_id.to_s + '/summary', params: 'season=' + season
    end
  end

  def self.get_ranked(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.2/stats/by-summoner/' + summoner_id.to_s + '/ranked'
    else
      query '/api/lol/' + region + '/v1.2/stats/by-summoner/' + summoner_id.to_s + '/ranked', params: 'season=' + season
    end
  end

  def self.get_summoner_by_name(name, region)
    query '/api/lol/' + region + '/v1.3/summoner/by-name/' + name.delete(' ')
  end

  def self.get_summoner_masteries(summoner_id, region)
    query '/api/lol/' + region + '/v1.3/summoner/' + summoner_id.to_s + '/masteries'
  end

  def self.get_summoner_runes(summoner_id, region)
    query '/api/lol/' + region + '/v1.3/summoner/' + summoner_id.to_s + '/runes'
  end

  def self.get_summoner(summoner_id, region)
    query '/api/lol/' + region + '/v1.3/summoner/' + summoner_id.to_s
  end

  def self.get_summoner_name(summoner_id, region)
    query '/api/lol/' + region + '/v1.3/summoner/' + summoner_id.to_s + '/name'
  end

  def self.get_team_by_summoner(summoner_id, region)
    query '/api/' + region + '/v2.2/team/by-summoner/' + summoner_id.to_s
  end

  def self.get_team(team_ids, region)
    query '/api/lol/' + region + '/v2.2/team/' + team_ids * ","
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
