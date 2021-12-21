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

#puts config[:ftp_server]
#puts config[:ftp_server][:host]
#puts config[:file_pattern_to_download]
#puts config[:user]

start_process = DateTime.now

ftp = FtpSync.new( config[:ftp_server][:host], config[:ftp_server][:user], config[:ftp_server][:passwd], { passive: true, :verbose => true})

unless File.directory?(config[:download_dir])
    FileUtils.mkdir_p(config[:download_dir])
end

downloads = ftp.download config[:download_dir], config[:ftp_server][:path], { :since => Time.parse(config[:last_run_updates]),  :filepattern => config[:file_pattern_to_download] }

ftp.close

config[:last_run_updates] = start_process.to_s

downloads.each do |df|
    puts "New file #{df}"
    tgz = Zlib::GzipReader.new(File.open(df, 'rb'))
    Minitar::unpack(tgz, config[:extract_dir])
end



