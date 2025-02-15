class GreeterController < ApplicationController
  def hello
    random_names = ['aasdad','asdasdb','cdfdfe']
    @name = random_names.sample
    @time = Time.now
    @display_time ||= 0
    @display_time += 1
  end
  def goodbye
  end
end
