class Fragment < ActiveRecord::Base
  validates_presence_of :contents

  def self.create_placeholder!
    create!(:contents => '<h1>Fragment</h1>\n<p>edit this to add your content</p>')
  end
end
