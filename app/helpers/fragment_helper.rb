module FragmentHelper
  def fragment_tag(fragment, saveUrl, editable = true)
    classes = 'fragment'
    classes << ' editable' if editable
    content_tag('div', raw(outer_containers(fragment, saveUrl, editable)),
                :class => classes, :id => "fragment_#{fragment.id}")
  end

  def read_controls(fragment)
    content_tag('div', link_to('edit', "#markItUpContents_#{fragment.id}",
                               :class => 'edit-link', :title => 'editing content'),
                :class => 'read-controls')
  end

  def script_block(fragment, saveUrl)
    script = <<-EOS
      $(document).ready(function(){
        new Fragment("#fragment_#{fragment.id}", "#{saveUrl}");
        $("#fragment_#{fragment.id} a.edit-link").fancybox({
          'opacity': false,
          'overlayShow': false,
          'transitionIn': 'elastic',
          'transitionOut': 'elastic',
          'speedIn': 200,
          'speedOut': 200,
          'titlePosition': 'inside'
        });
      });
    EOS
    content_tag('script', raw(script), :type => 'text/javascript')
  end

  private

  def outer_containers(fragment, saveUrl, editable)
    text = fragment.present? ? fragment.contents : ''
    tag_contents = content_tag('div', raw(text), :class => 'read-area')
    if editable
      tag_contents = [script_block(fragment, saveUrl), read_controls(fragment),
                      content_tag('div', text_area_tag('contents', text, :class => 'edit-area',
                                                       :id => "contents_#{fragment.id}"), :style => 'display:none;'),
      ] << tag_contents
    end
    tag_contents
  end
end