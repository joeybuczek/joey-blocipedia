class Wiki < ActiveRecord::Base
  
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  scope :visible_to, -> (user) { (user.role == 'premium') || (user.role == 'admin') ? all : where(private: false) }
  
  def private?
    self.private == true
  end
  
  def public?
    self.private == false
  end
  
  def markdown_body
    render_as_markdown(self.body)
  end
  
  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extenstions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extenstions)
    (redcarpet.render markdown).html_safe
  end
  
end
