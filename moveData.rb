#encoding: UTF-8
require 'zlib'
require 'minitar'
$LOAD_PATH << '.' << './lib' << "#{File.dirname(__FILE__)}"
require_relative './lib/ftp_sync'
require_relative './lib/config_file'

def config
    @config ||= ConfigFile
end

config.config_file="primove_lirias.yml"

start_process = DateTime.now
last_run_updates = Time.parse config[:last_run_updates]

# puts config[:ftp_server]
# puts config[:ftp_server][:host]
# puts config[:file_pattern_to_download]
# puts config[:ftp_dir]
# puts config[:user]

puts "Move records from 'sftp' to elastic_data_in"
puts "last_run_updates : #{last_run_updates}"



# puts "Geting files : #{ config[:ftp_dir] }*.tar.gz"
Dir.glob("#{ config[:ftp_dir] }#{config[:file_pattern_to_download]}").each do |file| 
    if ( last_run_updates < File.mtime(file) ) 
        puts "move #{file}"
        FileUtils.cp(file, config[:download_dir])
        filegz = Zlib::GzipReader.new(File.open(file, 'rb'))
        Minitar::unpack(filegz, config[:extract_dir])
   end
end

config[:last_run_updates] = start_process.to_s



