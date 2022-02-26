class SecFilingDetailMatch
  def initialize(doc, filing_type: nil)
    @doc = doc

    @match = nil
    if filing_type
      @match = doc.css("table").css("td:contains('#{filing_type}')").first.parent
    end

    raise "No match found" if @match.nil?

    line_num, @description, @file_name, @filing_type, @size = @match.css("td").collect(&:text)
    @document_url = "https://www.sec.gov" + @match.css("a").first.values.first
  end

  attr_reader :description, :file_name, :filing_type, :size, :document_url
end
