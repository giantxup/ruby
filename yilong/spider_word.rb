require "thread"
require './word_dispatcher.rb'
require './get_word.rb'

#spider_word 用多线程爬取输入关键词的百度页面的相关搜索词

class Spider_word

  def start(word,limit) # word 第一个搜索词，limit 要获得搜索词的总数
    @disp = WordDispatcher.new(word,0,limit)
    threads = []
    wd = Get_ref_words.new(@disp)
    wd2 = Get_ref_words.new(@disp)
    wd3 = Get_ref_words.new(@disp)
    wd4 = Get_ref_words.new(@disp)
    wd5 = Get_ref_words.new(@disp)
    threads[1] = Thread.new{wd.all_search}
    threads[2] = Thread.new{wd2.all_search}
    threads[3] = Thread.new{wd3.all_search}
    threads[4] = Thread.new{wd4.all_search}
    threads[5] = Thread.new{wd5.all_search}

    threads[1].join
    threads[2].join(0.5)
    threads[3].join(0.6)
    threads[4].join(0.7)
    threads[5].join(0.8)

  end

  def display
    puts "-----------list-------------"
    @disp.vwords.each do |w|
      puts w
    end
  end

end

sp = Spider_word.new

sp.start("yilong",100)
sp.display

