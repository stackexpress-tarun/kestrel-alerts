con = []
File.open("/home/stackexpress/kestrel-script/telnet_output").each do |line|
    con << line.split(' ')[1] if (line['STAT'])
end
File.open("/home/stackexpress/kestrel-script/all_alerts", 'w') { |file| 
  con.each do |c|
    file.puts(c)
  end
}
