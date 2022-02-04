require_relative "sec"
require_relative "sec_watch_list_match"

class SecWatchList
  def initialize(watchlist, filing_types)
    @watchlist = watchlist
    @filing_types = filing_types
    @sec = Sec.new
  end

  def peek
    filings = @sec.get_recent_filings
    @watchlist.each do |ticker|
      @filing_types.each do |filing_type|
        match = filings.by_ticker(ticker).by_filing_type(filing_type).result
        if match
          yield(SecWatchListMatch.new(match)) unless match.empty?
        end
      end
    end
  end
end
