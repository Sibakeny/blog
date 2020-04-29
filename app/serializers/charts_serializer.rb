# frozen_string_literal: true

class ChartsSerializer < ActiveModel::Serializer
  attributes :time, :sum

  def time
    parsed_date = Date.parse(object.time)
    parsed_date.strftime('%m/%d')
  end
end
