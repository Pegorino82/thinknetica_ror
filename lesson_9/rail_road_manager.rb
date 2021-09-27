# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#   - Создавать станции
#   - Создавать поезда
#   - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#   - Назначать маршрут поезду
#   - Добавлять вагоны к поезду
#   - Отцеплять вагоны от поезда
#   - Перемещать поезд по маршруту вперед и назад
#   - Просматривать список станций и список поездов на станции
require_relative 'station_manager'
require_relative 'train_manager'
require_relative 'wagon_manager'
require_relative 'route_manager'

class RailRoadManager
  include StationManager
  include TrainManager
  include WagonManager
  include RouteManager

  INPUT_ATTEMPTS = 5
  STATION_ACTIONS = [
    { command: '1', title: 'create station', action: :create_station },
    { command: '2', title: 'show all stations', action: :show_all_stations },
    { command: '3', title: 'show station trains', action: :show_station_trains },
    { command: '0', title: 'back' }
  ].freeze
  TRAIN_ACTIONS = [
    { command: '1', title: 'create train', action: :create_train },
    { command: '2', title: 'show wagons', action: :show_train_wagons },
    { command: '3', title: 'add route to train', action: :add_route_to_train },
    { command: '4', title: 'add wagon to train', action: :add_wagon_to_train },
    { command: '5', title: 'delete wagon from train', action: :del_wagon_from_train },
    { command: '6', title: 'move train forward', action: :move_train_forward },
    { command: '7', title: 'move train backward', action: :move_train_backward },
    { command: '0', title: 'back' }
  ].freeze
  ROUTE_ACTIONS = [
    { command: '1', title: 'create route', action: :create_route },
    { command: '2', title: 'add station to route', action: :add_station_to_route },
    { command: '3', title: 'del station from route', action: :del_station_from_route },
    { command: '0', title: 'back' }
  ].freeze
  CHOOSE_OBJECT = [
    { command: '1', title: 'station', object: STATION_ACTIONS },
    { command: '2', title: 'train', object: TRAIN_ACTIONS },
    { command: '3', title: 'route', object: ROUTE_ACTIONS },
    { command: '0', title: 'exit' }
  ].freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      show_actions(CHOOSE_OBJECT)
      action = gets.chomp.to_i
      break if action.zero?

      sub_actions(CHOOSE_OBJECT[action - 1][:object], CHOOSE_OBJECT[action - 1][:title])
    end
  end

  private

  def show_actions(actions, title = nil)
    text = 'Type command'
    text += title ? " for #{title}:\n" : ":\n"
    actions.each do |action|
      text += " - #{action[:command]} to #{action[:title]}\n"
    end
    puts text
  end

  def sub_actions(actions, title)
    loop do
      show_actions(actions, title)
      action = gets.chomp.to_i
      break if action.zero?

      send(actions[action - 1][:action])
    end
  end

  def ask_data(question)
    print "#{question}: "
    gets.chomp
  end

  def show_failed_input(message, attempt)
    attempt < INPUT_ATTEMPTS ? "Enter valid data: #{message}" : "You failed after #{attempt} attempts."
  end
end

RailRoadManager.new.start
