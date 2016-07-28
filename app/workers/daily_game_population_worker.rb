class DailyGamePopulationWorker
  include Sidekiq::Worker 
  include Sidetiq::Schedulable

  #will run at 1:00 am each day based in utc time
  recurrence { daily.hour_of_day(5) }

  def perform
    if GameService.todays_stored_games.blank?
      todays_games = GameService.get_todays_games
      GameService.create_games(todays_games)
    end
  end

end