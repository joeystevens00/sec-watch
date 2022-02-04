require_relative "sec"

class SecFilingMatch
  def initialize(filings)
    @filings = filings
    @sec = Sec.new
    @result = nil
  end

  attr_reader :result

  def by_ticker(ticker)
    @result = line_search(active_object, @sec.lookup_ticker(ticker).gsub(/^0+/, ""))
    self
  end

  def by_filing_type(filing_type)
    @result = line_search(active_object, filing_type)
    self
  end

  private

  def active_object
    @result || @filings
  end
end
