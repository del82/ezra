module Clone

  def self.clone_target(username, target, annotatorID, startID = nil, endID = nil)
    user = User.where(username: username).first
    clone_name = target.phrase + annotatorID
    clone = Target.new(phrase: clone_name)
    clone.user_id = user.id
    clone.save!

    startID ||= target.hits[0].id
    endID ||= target.hits[-1].id

    target.hits.each do |h|
      if h.confirmed == 1 && h.id >= startID.to_i && h.id <= endID.to_i
        hc = Hit.new(confirmed: 1)
        hc.target_id = clone.id
        hc.flagged = h.flagged
        hc.audio_file = h.audio_file
        hc.transcript = h.transcript
        hc.location = h.location
        hc.window_duration = h.window_duration
        hc.window_start = h.window_start
        hc.notes = "Original Ezra target: " + target.id.to_s + "\nOriginal Ezra ID: " + h.id.to_s

        hc.save!
      end
    end
  end

end # clone module
