class DailyGamePopulationWorker
  include Sidekiq::Worker 
  include Sidetiq::Scheduable

  #will run at 1:00 am each day based in utc time
  recurrence { daily.hour_of_day(5) }

  def perform
    GameService.get_games
  end

end