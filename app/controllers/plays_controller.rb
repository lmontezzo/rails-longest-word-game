class PlaysController < ApplicationController

  def game
  end

  def game2
    @size = params[:size]
    @grid = generate_grid(@size.to_i)
  end

  def score
    @word = params[:word]
    @result = run_game(params[:word], params[:grid], params[:time2], Time.now )
  end


  def generate_grid(grid_size)
    alphabet = []
    grid_size.times { alphabet << ("A".."Z").to_a.sample }
    alphabet
  end


  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result

      result = Hash.new(0)
      result[:time] = end_time.to_time - start_time.to_time

    grid_hash = Hash.new(0)
    grid.gsub!(/\W+/, '').split(//).each do |x|
      if grid_hash[x].nil?
        grid_hash[x] = 1
      else
        grid_hash[x] += 1
      end
    end

    attempt_hash = Hash.new(0)
    attempt.upcase.split(//).each do |x|
      if attempt_hash[x].nil?
        attempt_hash[x] = 1
      else
        attempt_hash[x] += 1
      end
    end

    if !attempt_hash.all?  { |k, v| v <= grid_hash[k] }
      result[:message] = "not in the grid"
      result[:score] = 0
    elsif
      url = "https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=d28309f0-423d-4f92-b7c8-fce06e653b28&input=#{attempt}"
      api_serialized = open(url).read
      api = JSON.parse(api_serialized)
      score = attempt.size * 10
      if attempt == api["outputs"][0]["output"]
        result[:message] = "not an english word"
        result[:score] = 0
        result[:translation] = nil

      else
        result[:translation] = api["outputs"][0]["output"]
        result[:score] = (attempt.size * 100) - (result[:time] * 10)
        result[:message] = "well done"
    end
    end
   result
  end


end

