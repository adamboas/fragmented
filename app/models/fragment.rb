class Fragment < ActiveRecord::Base
  validates_presence_of :contents

  def self.createPlaceholder!
    create!(:contents => '<h1>Fragment</h1>\n<p>edit this to add your content</p>')
  end
end
