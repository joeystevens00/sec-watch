def line_search(str, match)
  case str
  when String
    str.split("\n").reject { |line| !line.match?(match) }
  when Array
    str.reject { |line| !line.match?(match) }
  end
end

def file_contents(path)
  File.open(path, "r") { |f| f.read }
end

def write_file(path, content)
  File.open(path, "a") { |f| f.puts(content) }
end

def get(url)
  uri = URI(url)
  headers = {
    "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36",
    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "Accept-Language" => "en-US,en;q=0.9",
    "Device-Memory" => "8",
    "Downlink" => "10",
    "Dpr" => "1",
    "Ect" => "4g",
    "Host" => uri.hostname,
    "Referer" => "https://www.google.com/",
    "Rtt" => "50",
    "Sec-Ch-Prefers-Color-Scheme" => "light",
    "Sec-Ch-Ua" => '" Not A;Brand";v="99", "Chromium";v="96", "Google Chrome";v="96"',
    "Sec-Ch-Ua-Arch" => "x86",
    "Sec-Ch-Ua-Full-Version" => "96.0.4664.45",
    "Sec-Ch-Ua-Mobile" => "?0",
    "Sec-Ch-Ua-Platform" => '"Linux"',
    "Sec-Ch-Ua-Platform-Version" => '"5.13.0"',
    "Sec-Fetch-Dest" => "document",
    "Sec-Fetch-Mode" => "navigate",
    "Sec-Fetch-Site" => "cross-site",
    "Sec-Fetch-User" => "?1",
    "Upgrade-Insecure-Requests" => "1",
    "Viewport-Width" => "1920",
  }
  res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
    request = Net::HTTP::Get.new(uri, headers)
    response = http.request(request) # Net::HTTPResponse object
  end
end
