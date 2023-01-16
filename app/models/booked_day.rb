class BookedDay
  attr_accessor :id, :day
  @@all

  def initialize(id = nil, day = nil, booked_day = nil)
    @id = id
    @day = day
    @@all = booked_day ? [*all_booked_days, booked_day] : all_booked_days
  end

  def booked_times
    BookedTime.booked_for(booked_day_id: self.id)
  end

  def all_booked_days
    days = JSON.parse(File.read("db/booked_days.json"))['days']
    @@all ||= days
  end

  class << self
    def all_days
      new && @@all
    end

    def find(day:)
      all_days.each do |booked_day|
        return new(booked_day['id'], booked_day['day']) if day == booked_day['day']
      end

      nil
    end

    def existing_day?(day)
      all_days.any? do |booked_day|
        return booked_day if booked_day['day'] == day
      end

      nil
    end
  end
end
