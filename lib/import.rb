
# if !Ezra::Application.config.respond_to?(:big_audio_root)
#   abort("No config information!")
# end

require 'json'
require 'fileutils'
  
module Import

  def self.load_json(filename)
    File.open(filename, 'r') do |f|
      JSON.load(f)
    end 
  end

  def self.load_param(filename)
    params = File.open(filename, 'r') do |f| f.read() end
    the_hash = Hash.new
    params.lines do |l|
      s = l.chomp.split(/ |\t/)
      the_hash[s[0]] = s[1..-1].join(' ').gsub(/<\/div>$/,'').lstrip.rstrip
    end
    the_hash
  end

  def self.process_audio_file(current_file, dest_dir, dest_fname)
    full_dest = File.join(dest_dir, dest_fname)
    if File.exist? full_dest
      puts "destination file already exists: #{full_dest}"
      return false
    end
    if not File.exist? current_file
      puts "file not found: #{current_file}"
      return false
    end
    dir = File.dirname full_dest
    begin
      FileUtils.mkdir_p dir
    rescue SystemCallError
      # dir already exists
    end
    FileUtils.cp current_file, full_dest
    return true
  end

  def self.load_target(username, target_string, target_directory)  
    user = User.where(username: username).first
    target = Target.new(phrase: target_string)
    target.user_id = user.id
    target.save!
    Dir.foreach target_directory do |f|
      if f =~ /param$/
        p_hash = self.load_param (File.join target_directory, f)
        h = Hit.new(confirmed: 0)
        h.location =  [p_hash["SEEK"].to_f, 1.0].max 
        h.target_id = target.id
        ### audio file
        audio_file_dest = p_hash["MP3"].gsub(/http:\/\//, "")
        audio_file_src  = File.join(target_directory, f.gsub(/param$/,"mp3"))
        audio_root = "/home/ezra/ezra/audio"
        full_dest = File.join(audio_root, audio_file_dest)
        puts "copy #{audio_file_src} to #{full_dest}" 
        self.process_audio_file(audio_file_src, audio_root, audio_file_dest)
        h.audio_file = audio_file_dest

        ### transcript / timing
        h.transcript = "#{p_hash["LEFTCONTEXT"]} #{target_string} #{p_hash["RIGHTCONTEXT"]}"
        h.window_start = [h.location - 12.0, 0.5].max
        h.window_duration = 20.0
        puts h.attributes
        h.save!
      end
    end
  end

end # import module

