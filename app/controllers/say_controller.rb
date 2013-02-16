class SayController < ApplicationController
  def hello
    @time = Time.new
  end

  def goodbye
  end
end
