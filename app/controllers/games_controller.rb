class GamesController < ApplicationController

  def index
    GameService.update_games
    @games = Game.where('time > ?', (DateTime.now - 1.hour).strftime('%Q')).where('time < ?', (DateTime.now.beginning_of_day + 1.day).strftime('%Q')).order(:time)
    @hash = Gmaps4rails.build_markers(@games) do |game, marker|
      if (game.loc_lat.nil? || game.loc_lon.nil?)
        marker.lat game.group_lat
        marker.lng game.group_lon
        marker.picture({
          "url" => "http://imgur.com/a/78MEL",
          "width" => 27,
          "height" => 27
          })
      else
        marker.lat game.loc_lat
        marker.lng game.loc_lon
        marker.infowindow game.am_pm(game.time, game.utc_offset) + ' - ' + game.group_name
        marker.picture({
          "url" => "http://i.imgur.com/2j6UX2Q.png?3",
          "width" => 27,
          "height" => 27
          })
      end
    end
  end

end



#64