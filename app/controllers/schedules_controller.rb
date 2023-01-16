class SchedulesController < ApplicationController
  include Response

  def create
    already_existing_day = BookedDay.existing_day? params['day']
    return create_new_booked_day_and_time if already_existing_day.nil?

    append_new_time_slot_to_booked_day(already_existing_day)
  end

  def list_time_slots
    booked_day = BookedDay.find(day: params[:day])
    booked_day = create_booked_day_entry if booked_day.blank?

    time_slots = TimeSlot.build_timeslots(booked_day, params[:duration].to_i)
    return json_response(time_slots, 'Timeslots retrieved successfully') if time_slots.present?

    json_response([], 'There are not available timeslots', 404)
  end

  private

  def create_new_booked_day_and_time
    new_booked_day = create_booked_day_entry

    append_new_time_slot_to_booked_day(new_booked_day)
  end

  def create_booked_day_entry
    last_booked_day = get_last_element(BookedDay.new.all_booked_days)
    new_booked_id = last_booked_day['id'] + 1
    BookedDay.new(new_booked_id, params['day'],{ 'id' => new_booked_id, 'day' => params['day'] })
  end

  def append_new_time_slot_to_booked_day(booked_day)
    last_booked_time = get_last_element(BookedTime.new({}).all_booked_times)
    new_time_id = last_booked_time['id'] + 1
    start_time = format_time(booked_day, params['start'])
    duration_in_secs = params['duration'].to_i * 60

    new_booked_time = BookedTime.new(
      { booked_time: { 'id' => new_time_id, 'start' => format_time_to_default(start_time),
                       'end' => format_time_to_default(start_time + duration_in_secs),
                       'booked_day_id' => booked_day['id'] }})

    json_response(new_booked_time, 'Timeslot saved successfully', 201)
  end

  def get_last_element(object)
    return object.last
  end

  def format_time(booked_day_date, time)
    Time.parse("#{booked_day_date}T#{time}:00.000Z")
  end

  def format_time_to_default(time)
    time.iso8601(3)
  end
end
