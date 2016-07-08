class GameService
  #define instance opject

  #make call and for each item in return populate data

  def self.get_games
    today = DateTime.now.beginning_of_day.strftime('%Q')
    tomorrow = (DateTime.now.beginning_of_day + 1.day).strftime('%Q')
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
      events["results"].each do |r| 
        game = Game.new(      
          utc_offset: r["utc_offset"],
          rsvp_limit: r["rsvp_limit"],
          distance: r["distance"],
          fee_amount: r["fee"].present? ? r["fee"]["amount"] : r["fee"],
          yes_rsvp_count: r["yes_rsvp_count"],
          duration: r["duration"],
          name: r["name"],
          game_id: r["id"],
          time: r["time"],
          game_updated: r["updated"],
          group_name: r["group"]["name"],
          group_lon: r["group"]["group_lon"],
          group_lat: r["group"]["group_lat"],
          group_id: r["group"]["id"],
          group_urlname: r["group"]["urlname"],
          group_who: r["group"]["who"],
          status: r["status"]
        )
        begin
          game_details = meetup_api.events(event_id: game.game_id)["results"].first["venue"]
          game.loc_lat =  game_details["lat"]
          game.loc_lon = game_details["lon"]
          game.loc_name = game_details["name"]
        rescue
        end
        game.save
      end
    end
  end

  #update 
    #if  it exists 
      #WITH same updated time skip, 
      #else  update
    #else populate

    #also check if there are any ids that did no longer exist today and update




    #and it has a new updated time or if event with id does not exist 
end