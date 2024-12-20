json.array!(@shifts) do |shift|
  json.id shift.id
  json.title shift.title
  json.start shift.start.in_time_zone('Tokyo')
  json.end shift.end.in_time_zone('Tokyo')
end