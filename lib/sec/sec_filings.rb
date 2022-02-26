require_relative "util"
require_relative "sec_filing_match"

class SecFilings
  def initialize
    @filings = current.body
  end

  attr_reader :filings

  def current
    get("https://www.sec.gov/cgi-bin/current?q1=0&q2=6&q3=")
  end

  def by_ticker(ticker)
    SecFilingMatch.new(@filings).by_ticker(ticker)
  end

  def by_filing_type(filing_type)
    SecFilingMatch.new(@filings).by_filing_type(filing_type)
  end
end
