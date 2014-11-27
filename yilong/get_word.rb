require 'socket'
require 'nokogiri'
require 'thread'
require "monitor"

require './word_dispatcher.rb'
include Socket::Constants

class Get_ref_words

  def initialize(disp)
    @disp = disp
    @mutex = Mutex.new
  end

  def search(word)
    word=word
    @socket = TCPSocket.open("www.baidu.com",80)
    str = "GET /s?wd="+word+" HTTP/1.0\r\n\r\n"
    @socket.write(str)
    results = @socket.read
    page = Nokogiri::HTML(results)
    page2 = page.xpath('//div[@id="rs"]/table')
    page2.xpath('//th/a').each do |link|
      puts link.content
      @disp.insert(link.content)

    end

  end

  def all_search()

    while @disp.global_flag == 0
        #Thread.pass
    end

    word = @disp.get_word
    puts word
    puts @disp.global_flag
    self.search(word)
    for w in @disp.words
      self.search(w)
      if @disp.count > @disp.limit
        puts "total:"
        puts @disp.count
        break
      end
    end

  end

end

