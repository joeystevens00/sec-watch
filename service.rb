require "byebug"
require "mail"
require "slack-ruby-client"

require_relative "lib/sec/sec_watch_list"
require_relative "lib/sec/util"

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

def email(match)
  options = { :address => "smtp.gmail.com",
              :port => 587,
              :user_name => ENV["EMAIL_USERNAME"],
              :password => ENV["EMAIL_PASSWORD"],
              :authentication => "plain",
              :enable_starttls_auto => true }

  Mail.defaults do
    delivery_method :smtp, options
  end

  [ENV["ALERT_EMAIL"], ENV["ALERT_SMS_GATEWAY"]].each do |alert_email|
    mail = Mail.deliver do
      to alert_email
      from ENV["EMAIL_USERNAME"]
      subject match.summary
      body "New filing here: #{match.url}"
    end
    raise "Unable to reach #{alert_email}" unless mail
  end
end

def slack(match)
  client = Slack::Web::Client.new
  client.chat_postMessage(channel: '#alert', text: "#{match.summary} #{match.url}", as_user: true)
end

def alert(match)
  write_file("found_tickers.txt", match.summary)
  slack(match)
end

biotech_tickers = file_contents("data/biotech-domestic")
stock_reg_filings = ["S-1", "S-3", "S-8", "13G"]
sec_watch = SecWatchList.new(biotech_tickers.split("\n"), stock_reg_filings)
sec_watch.peek do |found|
  alert(found)
end
