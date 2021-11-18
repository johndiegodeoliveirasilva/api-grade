class TimeStartValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if correrct_time_start(attribute, record)
      record.errors.add(:base, "Time Start is invalid")
    end
  end

  private
  def correrct_time_start(attribute, record)
    DateTime.current.strftime("%d-%m-%y") > record.time_start.strftime("%d-%m-%y") if attribute.eql?(:time_start)
  end
end