class Meal < ActiveRecord::Base
  validates :chef, presence: true
  validates :name, presence: true

  validates :day, presence: true
  validates :dishwasher, presence: true

  validate :valid_day

  belongs_to :chef_user, class_name: User, foreign_key: :chef, primary_key: :name
  belongs_to :dishwasher_user, class_name: User, foreign_key: :dishwasher, primary_key: :name

  MEALTIMES_HASH = {
    early_breakfast: ["0600", "0700"],
    breakfast: ["0730","0830"],
    second_breakfast: ["0900","1000"],
    brunch: ["1000","1100"],
    elevensies: ["1100","1200"],
    lunch: ["1200","1300"],
    sunday_dinner: ["1300","1400"],
    sunday_desert: ["1500","1600"],
    afternoon_tea: ["1600","1700"],
    supper: ["1800","1900"],
    dinner_with_prep: ["1800","2000"],
    dinner: ["1900","2000"],
    late_dinner: ["2000","2100"],
    drinks: ["2100","2200"],
    bachelors_dinner: ["2400","2500"]
 }

  MEALTIMES = MEALTIMES_HASH.keys.map &:to_s

  def valid_day
    errors.add(:day, "Date must not be in the past") if day < Time.zone.now.to_date
  end

  def time_range
    daytimes = MEALTIMES_HASH[meal.to_sym].map {|h| h[-2,2].to_f/60 + (h[-4,2].to_f) }
    starttime = day + daytimes.first.hours
    endtime = day + daytimes.last.hours
    Range.new starttime, endtime
  end

  def long_description
    "Chef: #{chef}\n" + "Dishwasher: #{dishwasher}\n" + description 
  end

  def to_ics

    times = time_range.minmax

    event = Icalendar::Event.new
    event.start = (times.first).strftime("%Y%m%dT%H%M%S")
    event.end = (times.last).strftime("%Y%m%dT%H%M%S")
    event.summary = "#{self.meal.titleize}: #{self.name}"
    event.description = self.long_description
    event.location = 'SSH/West House'
    event.klass = "PUBLIC"
    event.created = self.created_at.strftime("%Y%m%dT%H%M%S")
    
    event
  end

end