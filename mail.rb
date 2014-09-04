require 'net/smtp'

filename = "/home/stackexpress/kestrel-script/pending_alerts.zip"
# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

marker = "AUNIQUEMARKER"

body =<<EOF
Hi StackexpressTeam,

This is zip file for pending alerts. Please place all file in uburter/data-bags/nagios-services folder.

Thanks and Reagrds,
Kestrel Admin
EOF

# Define the main headers.
part1 =<<EOF
From: Tarun <tarun.garg@stackexpress.com>
To: User <tarun.garg@stackexpress.com>
Subject: Kestrel Pending Alerts
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit

#{body}
--#{marker}
EOF

# Define the attachment section
part3 =<<EOF
Content-Type: applicaiton/octet-stream; name=\"#{filename}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{filename}"

#{encodedcontent}
--#{marker}--
EOF

mailtext = part1 + part2 + part3

# Let's put our code in safe area
begin 
  Net::SMTP.start('localhost') do |smtp|
     smtp.sendmail(mailtext, 'tarun.garg@stackexpress.com',
    #                      ['tanmaya@StackExpress.com'])
			['tarun.garg@stackexpress.com'])
  end
rescue Exception => e  
  print "Exception occured: " + e  
end
