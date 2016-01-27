require 'socket'

s = TCPServer.new(8569)

loop {
 Thread.start(s.accept) {|n|
  begin
   while line = n.gets
    (n << "You wrote: #{line.inspect}\r\n").flush
   end
   rescue
    bt = $!.backtrace * "\n "
    ($stdderr <<"error: #{$!.inspect}\n #{bt}\n").flush
   ensure
    n.close
   end
  }
}
