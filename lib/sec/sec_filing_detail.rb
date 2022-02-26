require_relative "sec_filing_detail_match"

class SecFilingDetail
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(get(url).body)
  end

  def find_by_type(filing_type)
    SecFilingDetailMatch.new(@doc, filing_type: filing_type)
  end
end
