module Messages
  def self.included(base)
    base.extend ClassMethods::Train
    base.extend ClassMethods::Station
    base.extend ClassMethods::Route
    base.extend ClassMethods::Wagon
  end

  module ClassMethods
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
          meth_name.humanize
        end
      end
    end

    module Station
      %w[
        train_already_on_station
        no_such_train_on_station
      ].each do |meth_name|
        define_method meth_name do
          meth_name.humanize
        end
      end
    end

    module Route
      %w[
        not_enough_stations
        has_this_station
        no_such_station
        can_not_delete_first_station
        can_not_delete_last_station
      ].each do |meth_name|
        define_method meth_name do
          meth_name.humanize
        end
      end
    end

    module Wagon
      %w[
        there_is_nothing_to_pull
        there_is_no_more_free_space_to_push
        free_space_is_too_small_for_this_qty
        you_trying_to_pull_more_then_loaded
        you_trying_to_push_more_than_wagon_can_carry
      ].each do |meth_name|
        define_method meth_name do
          meth_name.humanize
        end
      end
    end
  end
end
