class TimeEndValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if correct_time_end(attribute, record)
      record.errors.add(:base, "Time End is invalid")
    end
  end

  private

  def correct_time_end(attribute, record)
    record.time_end < record.time_start
  end
end