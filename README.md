# SecWatchList

        SecWatchList.new(["GOOGL", "TSLA"], ["10-Q", "10-K"]) { |match| puts "#{match.company}" filed a #{match.form} today check it out at #{match.url}" }