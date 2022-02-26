require "net/http"
require "nokogiri"

require_relative "util"

class Sec13g
  def initialize(url)
    @url = url
    doc = Nokogiri::HTML(get_filing)
    pairs = {}
    percentage_acquired = []
    doc.css('p:contains("Percent of Class Represented by Amount")').each do |p|
      percentage_acquired.append(p.parent.css("p").text.match(/\d+(?:\.\d+|)%/)[0].delete("%").to_f)
    end
    if percentage_acquired.compact.length == 0
      doc.css("table").each_cons(2) do |k, v|
        if k.text.include?("Percent of Class Represented by Amount")
          percentage_acquired.append(v.text.strip.delete("%").split("").reject { |e| e.to_i == 0 && e != "." }.join("").to_f)
        end
      end
    end
    @float_acquired = percentage_acquired.sum
  end

  attr_reader :float_acquired, :url

  def get_filing
    get(@url).body
  end
end
