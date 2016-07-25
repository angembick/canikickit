class Game < ActiveRecord::Base

  def am_pm(time, utc_offset)
    return Time.at((time + utc_offset)/1000).to_datetime.utc.strftime("%I:%M %p")
  end
end

