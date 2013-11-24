class Plan

  attr_accessor :meals

  def self.Name
    "Plan"
  end

  def self.model_name
    return ActiveModel::Name.new(Plan)
  end

  def to_key
    [0]
  end

  def persisted?
    false
  end

  def id
  end

end