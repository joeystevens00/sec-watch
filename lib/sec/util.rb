require "byebug"

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
