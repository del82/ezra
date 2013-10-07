
if !Ezra::Application.config.respond_to?(:big_audio_root)
  abort("No config information!")
end

module Export
  def export_target(target)
    to_dir = "tmp/#{target.id}_#{target.phrase.gsub(/ /,'_')}"
    if Dir.exists?(to_dir)
      Dir.foreach(to_dir) {|f| File.delete(File.join(to_dir,f)) if f != '.' && f != '..' }
      Dir.rmdir(to_dir)
    end
    Dir.mkdir(to_dir)
    target.hits.each do |h|
      if h.confirmed == 0 # FIXME
        export_hit(h, to_dir, target.phrase.gsub(/ /,'_'))
      end
    end
  end

  private

  def export_hit(hit, to_dir, phrase)
    # files for this hit will have the same name and different extensions
    file_prefix = File.join(to_dir, "#{hit.id}_#{phrase}") 
    if !_export_mp3(hit, file_prefix, phrase)
      raise "cutmp3 failed for hit #{h.id}, fp #{file_prefix}"
    end
    _export_transcript(hit, file_prefix, phrase)
    _export_feat_vals(hit, file_prefix, phrase)
    _export_notes(hit, file_prefix, phrase)
  end

  def _export_mp3(h, file_prefix, phrase)
    outfile = "#{file_prefix}.mp3"
    bar = Ezra::Application.config.big_audio_root
    infile = File.join(bar, h.audio_file)
    if !File.exist?(infile)
      raise "Input file doesn't exist: #{infile}"
    end
    start_time = ":#{h.window_start}"
    end_time = ":#{h.window_start + h.window_duration}"
    command = "cutmp3 -i #{infile} -a #{start_time} -b #{end_time} -O #{outfile}"
    system command

  end


  def _export_transcript(h, file_prefix, phrase)
    File.open("#{file_prefix}.lab", 'w') do |f|
      # there has got to be a better way to do this.
      f.write(h.transcript.upcase.tr('^ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ','').strip)
    end
  end

  def _export_notes(h, file_prefix, phrase)
    if !(h.notes.nil? or h.notes == "")
      File.open("#{file_prefix}.note",'w') do |f|
        f.write(h.notes)
      end
    end
  end

  def export_feat_vals(h, file_prefix, phrase)
    def safe_feature_name(h, id)
      begin
        h.features.find(id).name
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
    fv = Hash[h.feat_vals.map{|k,v| [safe_feature_name(h, k.to_i) ,v] } ].except(nil)
    File.open("#{file_prefix}.feat", 'w') do |f|
      f.write(JSON.dump(fv))
    end    
  end


end # export module