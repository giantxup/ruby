require 'socket'
require 'nokogiri'
require 'thread'
require "monitor"
require './title_dispatcher.rb'

include Socket::Constants
class Get_top_title

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
    #puts results
    page = Nokogiri::HTML(results)
    #page2 = page.xpath('//div[@id="wrapper_wrapper"]/div[@id="container/div[@id="content_left"]/div[@id="result-op c-container"]')
    #page2 = page.xpath('//div[@id="container"]/div[@id="content_left"]/div[@id="5"]')
    page2 = page.xpath('//div[@id="container"]/div[@id="content_left"]')
    puts "--------------------"
    page2.xpath('//h3').each do |contents|
      contents.css('a').each do |link|
        puts "#{link.content},#{link['href']}"
        title = link.content
        url = link['href']
        @disp.insert(title,url)
      end

    end
    #puts page2.xpath('//a[@target="_blank"]')

  end

end

