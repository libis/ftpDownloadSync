# ftpDownloadSync
Download new files from (s)ftp-server
## configuration

## get files from FTP
$ docker-compose up --build ftp_download_sync  
$ docker-compose run --rm ftp_download_sync bash  

OR

$ docker-compose run --rm ftp_download_sync ruby downloadData.rb  


$ docker-compose run --rm ftp_download_sync ruby moveData.rb 

# build

## build image based on .env  
$ build.sh  

## push to registry   
$ build.sh push 


