require "monitor"
require "thread"

class WordDispatcher

  def initialize(word,count,limit)

   @words = Array.new
   @vwords = Array.new
   @uvdwords = Array.new
   @count = count
   @limit = limit
   @m = Mutex.new
   @global_flag = 1
   @words.push(word)
  end

  def count
    @count
  end

  def count=(count)
    @count = count
  end

  def limit
    @limit
  end

  def limit=(limit)
    @limit = limit
  end

  def global_flag
    @global_flag
  end

  def global_flag=(flag)
    @global_flag = flag
  end

  def words
    @words
  end

  def vwords
    @words
  end

  def uvwords
    @uvwords
  end

  def get_word
        @m.synchronize{
          puts @words
          while @words.empty?
             @global_flag = 0
             sleep(0.5)

          end
          word = @words.fetch(0)
          @vwords.push(word)
          @words.delete(word)
          return word
        }
        @global_flag = 1

  end

  def insert(word)
      if (!@words.include?(word)) && (!@vwords.include?(word))
         @words.push(word)
         @count=@count + 1
         puts "inserting..."
      end

    end

end

