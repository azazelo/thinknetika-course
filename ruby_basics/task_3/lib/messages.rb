module Messages
  module Train
    %w[
      there_is_no_route
      add_route
      can_not_add_wagon
      can_not_remove_wagon
      no_next_station
      no_previous_station
      at_first_station
      at_last_station
      speed_is_zero
      speed_is_not_zero
      wagon_has_incompatible_type
      wagon_already_added
      wagon_not_in_list
    ].each do |meth_name|
      define_method meth_name do
        meth_name.gsub("_", " ") + ". "
      end
    end
  end

  module Station
    %w[
      train_already_on_station
      no_such_train_on_station
    ].each do |meth_name|
      define_method meth_name do
        meth_name.gsub("_", " ") + ". "
      end
    end
  end

  module Route
    %w[
      no_such_station
      can_not_delete_first_station
      can_not_delete_last_station
    ].each do |meth_name|
      define_method meth_name do
        meth_name.gsub("_", " ") + ". "
      end
    end
  end
end
