require "nokogiri"
require "byebug"

class SecWatchListMatch
  BASE_URL = "https://www.sec.gov/"

  def initialize(match)
    case match
    when Array
      raise "Only a single match is allowed" if match.length > 1
      @match = match.first
    when String
      @match = match
    end
    doc = Nokogiri::HTML(@match)
    links = doc.css("a")
    @url = BASE_URL + links.first.attribute("href").value
    @edgar_url = BASE_URL + links.reject { |n| !n.attribute("href").value.include?("browse-edgar") }.first.attribute("href").value
    parts = doc.text.split(" ")
    @date, @form, @cik = parts
    @company = parts[3, parts.length].join(" ")
    @summary = "#{@company} #{@form} Form SEC Filing"
  end

  attr_reader :url, :summary, :company, :date, :form, :cik
end
