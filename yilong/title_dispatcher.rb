require "monitor"
require "thread"

class Dispatcher

  def initialize(word,count)

    @words = Array.new
    @vwords = Array.new
    @uvdwords = Array.new
    @urls = Array.new
    @count = count
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

  def urls
    @urls
  end

  def get_word
    #synchronize do
    @m.synchronize{
      puts @words
      while @words.empty?
        @global_flag = 0
        puts "g is "
        puts @global_flag
        sleep(0.5)
        puts "while....."
        #Thread.pass
      end
      word = @words.fetch(0)
      @vwords.push(word)
      @words.delete(word)
      return word
    }
    @global_flag = 1
    #end
  end

  def insert(title,url)
    #synchronize do
    #@m.synchronize{
    if (!@words.include?(title)) && (!@vwords.include?(title))
      @words.push(title)
      @urls.push(url)
      @count=@count + 1
      puts "inserting..."
    end
    #end
    #}
  end

end

