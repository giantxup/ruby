require "thread"
require './title_dispatcher.rb'
require './get_title.rb'

#spider_word 用多线程爬取输入关键词的百度页面的标题

class Spider_title

  def start(word)
    @disp = Dispatcher.new(word,0)
    threads = []
    wd = Get_top_title.new(@disp)
    wd2 = Get_top_title.new(@disp)
    wd3 = Get_top_title.new(@disp)
    wd4 = Get_top_title.new(@disp)
    wd5 = Get_top_title.new(@disp)
    threads[1] = Thread.new{wd.search(word)}
    threads[2] = Thread.new{wd2.search(word)}
    threads[3] = Thread.new{wd3.search(word)}
    threads[4] = Thread.new{wd4.search(word)}
    threads[5] = Thread.new{wd5.search(word)}

    threads[1].join
    threads[2].join(0.5)
    threads[3].join(0.6)
    threads[4].join(0.7)
    threads[5].join(0.8)

  end

  def display
    puts "-----------title list-------------"
    @disp.vwords.each do |w|
      puts w
    end
    puts "-----------url list---------------"
    @disp.urls.each do |url|
      puts url
    end

  end

end

sp = Spider_title.new
sp.start("yilong")
sp.display

