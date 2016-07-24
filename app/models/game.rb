class Game < ActiveRecord::Base

  def am_pm(time)
    return Time.at(time/1000).to_datetime.utc.strftime("%I:%M %p")
  end
end