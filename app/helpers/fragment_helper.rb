module FragmentHelper
  def fragment_tag(fragment, saveUrl, editable = true)
    content_tag('div', raw(outer_containers(fragment, saveUrl, editable)), :class => 'fragment', :id => "fragment_#{fragment.id}")
  end

  def read_controls
    content_tag('div', link_to('edit', '#', :class => 'edit-link'), :class => 'read-controls')
  end

  def edit_controls
    content_tag('div', raw([link_to('cancel', '#', :class => 'cancel-link'),
                            content_tag('button', 'save', :class => 'fragment-save')]), :class => 'edit-controls')
  end

  def script_block(fragment, saveUrl)
    script = <<-EOS
      $(document).ready(function(){
        new Fragment("#fragment_#{fragment.id}", false, "#{saveUrl}");
      });
    EOS
    content_tag('script', raw(script), :type => 'text/javascript')
  end

  private

  def outer_containers(fragment, saveUrl, editable)
    text = fragment.present? ? fragment.contents : ''
    tag_contents = content_tag('div', raw(text), :class => 'read-area')
    if editable
      tag_contents = [script_block(fragment, saveUrl), read_controls, edit_controls,
                      text_area_tag('contents', text, :class => 'edit-area', :id => "contents_#{fragment.id}"),
      ] << tag_contents
    end
    tag_contents
  end
end