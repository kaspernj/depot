class SayController < ApplicationController
  def hello
    @time = Time.new
  end

  def goodbye
    
  end
  
  def files
    list = Dir.glob("*")
    @files = list.select{|file| File.file?(file)}.sort{|f1, f2| f1.downcase <=> f2.downcase}
    @dirs = list.select{|file| File.directory?(file)}.sort{|f1, f2| f1.downcase <=> f2.downcase}
  end
end
