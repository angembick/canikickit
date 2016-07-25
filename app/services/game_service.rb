class GameService
  #define instance opject


  def self.get_todays_games
    today = DateTime.now.beginning_of_day.strftime('%Q')
    tomorrow = (DateTime.now.beginning_of_day + 1.day).strftime('%Q')
    todays_stored_games = Game.where('time > ?', today).where('time < ?', tomorrow)
    return if todays_stored_games.size > 0

    params = { 
          zip: '11222',
          radius: '10',
          format: 'json',
          page: '50',
          topic: 'soccer',
          time: today+','+tomorrow}
    meetup_api = MeetupApi.new
    events = meetup_api.open_events(params)

    if events["results"].present?
      events["results"].each do |game_data| 
        game = new_game_object(game_data)
        game.save
      end
    end
  end


protected

  def self.new_game_object(game_data)
    game = Game.new(      
      utc_offset: game_data["utc_offset"],
      rsvp_limit: game_data["rsvp_limit"],
      distance: game_data["distance"],
      fee_amount: game_data["fee"].present? ? game_data["fee"]["amount"] : game_data["fee"],
      yes_rsvp_count: game_data["yes_rsvp_count"],
      duration: game_data["duration"],
      name: game_data["name"],
      game_id: game_data["id"],
      time: game_data["time"],
      event_url: game_data["event_url"],
      game_updated: game_data["updated"],
      group_name: game_data["group"]["name"],
      group_lon: game_data["group"]["group_lon"],
      group_lat: game_data["group"]["group_lat"],
      group_id: game_data["group"]["id"],
      group_urlname: game_data["group"]["urlname"],
      group_who: game_data["group"]["who"],
      status: game_data["status"],
      display: true
    )
    begin
      game_details = meetup_api.events(event_id: game.game_id)["results"].first["venue"]
      game.loc_lat =  game_details["lat"]
      game.loc_lon = game_details["lon"]
      game.loc_name = game_details["name"]
    rescue
    end
    return game
  end

end