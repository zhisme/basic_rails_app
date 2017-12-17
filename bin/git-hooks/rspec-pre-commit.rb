require 'pty'

  html_path = 'rspec_results.html'
  begin
    PTY.spawn('rspec spec --format h > rspec_results.html') do |stdin, _stdout, _pid|
      begin
        stdin.each { |line| print line }
      rescue Errno::EIO
      end
    end
  rescue PTY::ChildExited
    puts 'Child process exit!'
  end

  # find out if there were any errors
  html = open(html_path).read
  examples = html.match(/(\d+) examples/)[0].to_i rescue 0
  errors = html.match(/(\d+) errors/)[0].to_i rescue 0
  if errors == 0 then
    errors = html.match(/(\d+) failure/)[0].to_i rescue 0
  end
  pending = html.match(/(\d+) pending/)[0].to_i rescue 0

  if errors.zero?
    puts "0 failed! #{examples} run, #{pending} pending"
    # HTML Output when tests ran successfully:
    # puts "View spec results at #{File.expand_path(html_path)}"
    sleep 1
    exit 0
  else
    puts "\aCOMMIT FAILED!!"
    puts "View your rspec results at #{File.expand_path(html_path)}"
    puts
    puts "#{errors} failed! #{examples} run, #{pending} pending"
    # Open HTML Ooutput when tests failed
    # `open #{html_path}`
    exit 1
  end
