class ParserController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def nhl
    source = 'http://stats.nhlnumbers.com/teams/'
    teamdoc = Nokogiri::HTML(open(source))
    urls = [ ]
    @team_list = teamdoc.css('.data a').map{ |i| i['href'] }
    @team_list.each_with_index do |x, index|
      urls[index] = "http://stats.nhlnumbers.com#{x}"
    end
    #получили массив из ссылок
      urls.each do |link|
      doc = Nokogiri::HTML(open(link)) 
      @player = doc.css('.team-cell').map{ |x| x.text.gsub(/\n/,'')} #берем список игроков
      @caphit = doc.css('.caphit').map{ |x| x.text}  #берем список зарплаты
      @positionheading = doc.css('.positionheading').map{ |x| x.text} # берем амплуа
      title_el = doc.at_css('.page-header h1')
      title_el.children.each { |c| c.remove if c.name == 'span' } #отрезаем лишнее
      @title = title_el.text.strip  #получили название комманды
    end
  end
end

    #@a = each.@caphit do |x|
     # x.push @players
    #end
    #res = @a.each_with_object(Hash.new { |h, k| h[k] = [] }) { |a, m| m[a.first] << a.last }
 
#puts JSON.pretty_generate(@a)
#{ |x| x.text.gsub(/\A[a-zA-Z\s]+\z/i,'').strip}