module Messages
  module Train
    def there_is_no_route
      "There is NO route."
    end

    def add_route
      "Add route."
    end

    def can_not_add_wagon
      "Can not add wagon if train moving. Speed is not zero. Stop train first."
    end

    def can_not_remove_wagon
      "Can not remove wagon if train moving. Speed is not zero. Stop train first."
    end

    def no_next_station
      "There is NO next station!"
    end

    def no_previous_station
      "There is NO previous station!"
    end

    def at_first_station
      "Can not go backward: At FIRST station!"
    end

    def at_last_station
      "Can not go forward: At LAST station!"
    end

    def speed_is_zero
      "Speed is zero. Can not go forward. Increase speed."
    end
  end

  module Station
    def train_already_on_station
      "This train already on station."
    end

    def no_such_train_on_station
      "No such train on station."
    end
  end

  module Route
    def no_such_station; "No such station" end
    def can_no_delete_first_station; "Can NOT delete first station" end
    def can_no_delete_last_station; "Can NOT delete last station" end
  end
end
