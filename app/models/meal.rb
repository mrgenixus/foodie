class Meal < ActiveRecord::Base
  validates :chef, presence: true
  validates :name, presence: true

  validates :day, presence: true
  validates :dishwasher, presence: true

  validate :valid_day

  belongs_to :chef_user, class_name: User, foreign_key: :chef, primary_key: :name
  belongs_to :dishwasher_user, class_name: User, foreign_key: :dishwasher, primary_key: :name

  MEALTIMES_HASH = {
    early_breakfast: [6, 7],
    breakfast: [7.5,8.5],
    second_breakfast: [9,10],
    brunch: [10,11],
    elevensies: [11,12],
    lunch: [12,13],
    sunday_dinner: [13,14],
    sunday_desert: [15,16],
    holiday_dinner: [15,16],
    afternoon_tea: [16,17],
    supper: [18,19],
    dinner_with_prep: [18,20],
    dinner: [19,20],
    late_dinner: [20,21],
    drinks: [21,22],
    coffee: [21,22],
    bachelors_dinner: [24,25]
  }

  MEALTIMES = MEALTIMES_HASH.keys.map &:to_s

  def valid_day
    errors.add(:day, "Date must not be in the past") if day < Time.zone.now.to_date
  end

  def times
    MEALTIMES_HASH[meal.to_sym];
  end

  def start_time(zone)
    Time.use_zone(zone) { day + times.first.hours }
  end

  def end_time(zone)
    Time.use_zone(zone) { day + times.last.hours }
  end

  def long_description
    "Chef: #{chef}\n" + "Dishwasher: #{dishwasher}\n" + description 
  end

  def to_ics(zone)

    event = Icalendar::Event.new
    event.start = start_time(zone).utc.strftime("%Y%m%dT%H%M%SZ")
    event.end = end_time(zone).utc.strftime("%Y%m%dT%H%M%SZ")
    event.summary = "#{self.meal.titleize}: #{self.name}"
    event.description = self.long_description
    event.location = 'SSH/West House'
    event.klass = "PUBLIC"
    event.created = self.created_at.strftime("%Y%m%dT%H%M%S")
    
    event
  end

end