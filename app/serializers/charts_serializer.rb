class ChartsSerializer < ActiveModel::Serializer
  attributes :time, :sum

  def time
    parsed_date = Date.parse(object.time)
    return parsed_date.strftime("%m/%d")
  end
end
