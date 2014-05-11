require 'net/http'
require 'json'
require 'configuration'
require 'LoLAPI/version'
module LoLAPI
  extend Configuration

  BASE_URL = 'http://prod.api.pvp.net'

  def self.get_champions(region, free: nil)
    if free.nil?
      query '/api/lol/' + region + '/v1.2/champion'
    else
      query '/api/lol/' + region + '/v1.2/champion', params: 'freeToPlay=' + free.to_s
    end
  end

  def self.get_champions_by_id(champion_id, region, free: nil)
    if free.nil?
      query '/api/lol/' + region + '/v1.2/champion/' + champion_id.to_s
    else
      query '/api/lol/' + region + '/v1.2/champion/' + champion_id.to_s, params: 'freeToPlay=' + free.to_s
    end
  end

  def self.get_game(summoner_id, region)
    query '/api/lol/' + region + '/v1.3/game/by-summoner/' + summoner_id.to_s + '/recent'
  end

  def self.get_challenger(region, type)
    query '/api/lol/' + region + '/v2.4/league/challenger', params: 'type=' + type.to_s
  end

  def self.get_summoner_league(summoner_id, region, entry: false)
    if entry
      query '/api/lol/' + region + '/v2.4/league/by-summoner/' + summoner_id.to_s + '/entry'
    else
      query '/api/lol/' + region + '/v2.4/league/by-summoner/' + summoner_id.to_s
    end
  end

  def self.get_team_league(team_id, region, entry: false)
    if entry
      query '/api/lol/' + region + '/v2.4/league/by-team/' + team_id.to_s + '/entry'
    else
      query '/api/lol/' + region + '/v2.4/league/by-team/' + team_id.to_s
    end
  end

  def self.get_static_champions(region, id: nil, version: nil, locale: nil, data: nil, dataById: nil)
    str = create_params locale, version, dataById
    str += 'champData=' + data + '&' unless data.nil?

    if id.nil?
      query '/api/lol/static-data/' + region + '/v1.2/champion', params: str
    else
      query '/api/lol/static-data/' + region + '/v1.2/champion/' + id.to_s, params: str
    end
  end

  def self.get_static_items(region, id: nil, version: nil, locale: nil, data: nil)
    str = create_params locale, version, 'false'
    str += 'itemData=' + data + '&' unless data.nil?

    if id.nil?
      query '/api/lol/static-data/' + region + '/v1.2/item', params: str
    else
      query '/api/lol/static-data/' + region + '/v1.2/item/' + id.to_s, params: str
    end
  end

  def self.get_static_mastery(region, id: nil, version: nil, locale: nil, data: nil)
    str = create_params locale, version, 'false'
    str += 'masteryData=' + data + '&' unless data.nil?

    if id.nil?
      query '/api/lol/static-data/' + region + '/v1.2/mastery', params: str
    else
      query '/api/lol/static-data/' + region + '/v1.2/mastery/' + id.to_s, params: str
    end
  end

  def self.get_static_realm(region)
    query '/api/lol/static-data/' + region + '/v1.2/realm'
  end

  def self.get_static_runes(region, id: nil, version: nil, locale: nil, data: nil)
    str = create_params locale, version, 'false'
    str += 'runeData=' + data + '&' unless data.nil?

    if id.nil?
      query '/api/lol/static-data/' + region + '/v1.2/rune', params: str
    else
      query '/api/lol/static-data/' + region + '/v1.2/rune/' + id.to_s, params: str
    end
  end

  def self.get_static_spells(region, id: nil, version: nil, locale: nil, data: nil, dataById: nil)
    str = create_params locale, version, dataById
    str += 'spellData=' + data + '&' unless data.nil?

    if id.nil?
      query '/api/lol/static-data/' + region + '/v1.2/summoner-spell', params: str
    else
      query '/api/lol/static-data/' + region + '/v1.2/summoner-spell/' + id.to_s, params: str
    end
  end

  def self.get_summary(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.3/stats/by-summoner/' + summoner_id.to_s + '/summary'
    else
      query '/api/lol/' + region + '/v1.3/stats/by-summoner/' + summoner_id.to_s + '/summary', params: 'season=' + season
    end
  end

  def self.get_ranked(summoner_id, region, season: nil)
    if season.nil?
      query '/api/lol/' + region + '/v1.3/stats/by-summoner/' + summoner_id.to_s + '/ranked'
    else
      query '/api/lol/' + region + '/v1.3/stats/by-summoner/' + summoner_id.to_s + '/ranked', params: 'season=' + season
    end
  end

  def self.get_summoner_by_name(name, region)
    query '/api/lol/' + region + '/v1.4/summoner/by-name/' + name.delete(' ')
  end

  def self.get_summoner_masteries(summoner_id, region)
    query '/api/lol/' + region + '/v1.4/summoner/' + summoner_id.to_s + '/masteries'
  end

  def self.get_summoner_runes(summoner_id, region)
    query '/api/lol/' + region + '/v1.4/summoner/' + summoner_id.to_s + '/runes'
  end

  def self.get_summoner(summoner_id, region)
    query '/api/lol/' + region + '/v1.4/summoner/' + summoner_id.to_s
  end

  def self.get_summoner_name(summoner_id, region)
    query '/api/lol/' + region + '/v1.4/summoner/' + summoner_id.to_s + '/name'
  end

  def self.get_team_by_summoner(summoner_id, region)
    query '/api/lol/' + region + '/v2.3/team/by-summoner/' + summoner_id.to_s
  end

  def self.get_team(team_ids, region)
    if team_ids.class == Array
      query '/api/lol/' + region + '/v2.3/team/' + team_ids * ","
    else
      query '/api/lol/' + region + '/v2.3/team/' + team_ids.to_s
    end
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

  def self.create_params(locale, version, dataById)
    str = String.new
    str += 'locale=' + locale + '&' unless locale.nil?
    str += 'version=' + version + '&' unless version.nil?
    str += 'dataById=' + dataById + '&' unless dataById == 'false'
    return str
  end

  def self.check_key
    if self.api_key.nil?
      puts "ERROR: Please initialize lolapi with an API Key."
      return 1
    end
  end
end
