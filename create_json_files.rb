File.open("/home/stackexpress/kestrel-script/pending_alerts").each do |line|
  id_att = line.split('_')
  unless id_att.size == 1
    id = id_att.join('-')
    File.open("/home/stackexpress/kestrel-script/json/kestrel_#{line.chop}.json", 'w') { |file|
      file.puts '{'
      file.puts '  "id": "kestrel-'+id.gsub("\n",'')+'",'
      file.puts '  "hostgroup_name": "queue",'
      file.puts '  "command_line":     "$USER1$/check_memcached -v other -H $HOSTADDRESS$ -p 22133 -l '+line.chop+' -W 1000 -C 2000",'
      file.puts '  "service_template": "default-service"'
      file.puts '}'
  }
  end
end
