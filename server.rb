require 'socket'

port = ARGV[0]

def server_init(port = 8569)
 s = TCPServer.new(port.to_i)

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
end

server_init(port)
