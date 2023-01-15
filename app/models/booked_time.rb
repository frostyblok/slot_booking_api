class BookedTime
  attr_accessor :id, :start, :end
  @@all

  def initialize(arg)
    @id = arg[:id]
    @start = arg[:start]
    @end = arg[:end]
    @@all = arg[:booked_time] ? [*all_booked_times, arg[:booked_time]] : all_booked_times
  end

  def overlaps(potential_slot)
    potential_slot.overlaps?(Time.parse(self.start)..Time.parse(self.end))
  end

  def all_booked_times
    times = JSON.parse(File.read("db/booked_times.json"))['times']
    @@all ||= times
  end

  class << self
    def all_times
      new({}) && @@all
    end

    def booked_for(booked_day_id:)
      booked_times = []
      all_times.select do |booked_time|
        if booked_day_id == booked_time['booked_day_id']
          booked_times << new(id: booked_time['id'], start: booked_time['start'], end: booked_time['end'])
        end
      end

      booked_times
    end
  end
end
