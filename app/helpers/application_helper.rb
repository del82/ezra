module ApplicationHelper
  def audio_path(path)
    if Ezra::Application.config.respond_to?(:relative_url_root)
      root = Ezra::Application.config.relative_url_root
    end
    if Ezra::Application.config.respond_to?(:audio_root)
      audio_root = Ezra::Application.config.audio_root
    end
    return [root, audio_root, path].join('')
  end
end
