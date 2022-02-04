require "net/http"
require_relative "util"
require_relative "sec_filings"

class Sec
  def url(cik)
    "https://data.sec.gov/submissions/CIK#{cik}.json"
  end

  def lookup_cik(ticker)
    tickers = File.open("data/sec-ticker-lookup", "r") { |f| f.read }
    match = line_search(tickers, "^#{ticker.downcase}")

    if match && match.first
      cik = match.first.split("\t")[-1]
      cik.rjust(10, "0")
    else
      raise "no match found for #{ticker}"
    end
  end

  def lookup_ticker(ticker)
    lookup_cik(ticker)
  end

  def lookup_ticker_url(ticker)
    url(lookup_ticker(ticker))
  end

  def get_recent_filings
    SecFilings.new
  end
end
