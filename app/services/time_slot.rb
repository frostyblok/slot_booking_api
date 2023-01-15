class TimeSlot
  def self.build_timeslots(booked_day, duration)
    timeslots = []
    booked_day_date = booked_day.day
    start_time = Time.parse(booked_day_date + 'T00:00:00.000Z')
    end_time = Time.parse(booked_day_date + 'T23:59:00.000Z')
    interval = 15.minutes

    while (start_time <= end_time)
      booked_day.booked_times.each do |booked_time|
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

      timeslots << start_time.strftime('%H:%M') if start_time <= end_time
      start_time += interval
    end
    timeslots
  end
end
