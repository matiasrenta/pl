City.seed_once(:name) do |s|
  s.name = "DF"
  s.region_state_id = RegionState.find_by_name("DF").id
  s.state_id = State.find_by_i18n_name("active")
end

City.seed_once(:name) do |s|
  s.name = "Guadalajara"
  s.region_state_id = RegionState.find_by_name("Jalisco").id
  s.state_id = State.find_by_i18n_name("active")
end

City.seed_once(:name) do |s|
  s.name = "Culiacan"
  s.region_state_id = RegionState.find_by_name("Sinaloa").id
  s.state_id = State.find_by_i18n_name("active")
end