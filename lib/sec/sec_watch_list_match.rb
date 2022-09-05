require "nokogiri"

require_relative "sec_13g"
require_relative "sec_filing_detail"

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
    @doc = Nokogiri::HTML(@match)
    links = @doc.css("a")
    @url = BASE_URL + links.first.attribute("href").value
    @edgar_url = BASE_URL + links.reject { |n| !n.attribute("href").value.include?("browse-edgar") }.first.attribute("href").value
    parts = @doc.text.gsub("   ", "\t").gsub(/[ ]{2}/, "").split("\t").delete_if(&:empty?)
    @date, @form, @cik, @company = parts
    @summary = "#{@company} #{@form} Form SEC Filing"
  end

  attr_reader :url, :summary, :company, :date, :form, :cik

  private

  def float_acquired
    float_acquired = ""
    if @form.include?("13G")
      document_url = SecFilingDetail.new(@url).find_by_type(@form).document_url
      form_detail = Sec13g.new(document_url)
      # TODO :-'(
      byebug

      float_acquired = " (#{form_detail.float_acquired}% of float)"
    end
  end
end
