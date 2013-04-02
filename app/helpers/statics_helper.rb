module StaticsHelper
  require 'redcarpet'
  def render_markdown(content)
    options = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intraemphasis: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(content).html_safe
  end
end
