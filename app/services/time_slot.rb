class TimeSlot
  def self.build_timeslots(booked_day, duration)
    timeslots = []
    booked_day_date = booked_day.day
    start_time = Time.parse(booked_day_date + 'T00:00:00.000Z')
    end_time = Time.parse(booked_day_date + 'T23:59:00.000Z')
    interval = 15.minutes

    while (start_time <= end_time)
      # For every potential timeslot, check if it doesn't exist i.e already booked?
      booked_day.booked_times.each do |booked_time|
        # If slot already exists as a start time, make the end time the new start time and move on
        if start_time == booked_time.start
          start_time = Time.parse(booked_time.end)
          next
        end

        potential_slot = ((start_time...(start_time + duration)))
        if booked_time.overlaps potential_slot
          start_time = Time.parse(booked_time.end)
          next
        end
      end

      # Only assign the timeslot provided it's within the same day
      timeslots << start_time.strftime('%H:%M') if start_time <= end_time
      start_time += interval
    end
    timeslots
  end
end
