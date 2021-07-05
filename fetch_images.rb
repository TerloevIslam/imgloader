require 'open-uri'
folder = "Downloads"
file = ARGV.first
message = ""

Dir.mkdir(folder) unless File.exists?(folder)

if File.extname(file) == ".txt"
  if File.exist?(file)
    text = File.read(file).split
    downloaded_images = 0
    download_path = File.expand_path(File.dirname(__FILE__)).to_s + "/" + folder

    text.each do |string|
      t = Time.now.strftime "%d%m%y%H%M".to_s
      ns = Time.now.nsec.to_s[5..-1]
      name = t + ns
      format = string[-3,3]
      new_file_name = "#{name}.#{format}"

      if string =~ /\A#{URI::regexp}\z/
        URI.open(string) do |image|
          File.open("#{folder}/#{new_file_name}", "wb") do |file|
        file.write(image.read)
      end
      downloaded_images += 1
      info = "#{downloaded_images} Images successfully saved in " + download_path.to_s
      message = "\e[32m" + info.to_s + "\e[0m"
  end
end
    end
  else
    message = "\e[1m\e[31mFile not found\e[0m"
  end
else
  message = "\e[1m\e[31mFileformat invalid, only '.txt' allowed\e[0m"
end

puts message
