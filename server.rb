require 'socket'
require 'thread'

ssock = TCPServer.new(8569)
msgs = Queue.new

participants = []

Thread.start {
 while msg = msgs.pop;
  participants.each { |u|
   (u << msg).flush rescue IOError
  }
 end
}

loop {
 Thread.start(ssock.accept) { |sock|
   participants << sock
   begin
    while line = sock.gets; 
       msgs << ": #{line.chomp!}\r\n"
    end
    rescue
     bt = $!.backtrace * "\n"
     ($stderr << "error: #{$!.inspect}\n #{bt}\n").flush
    ensure
     participants.delete sock
     sock.close
    end
  }
}
    
