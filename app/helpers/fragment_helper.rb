module FragmentHelper
  def fragment_tag(fragment, save_url, editable = true)
    contents = fragment.contents
    id = fragment.id
    content = editable ? edit_tags(id, contents, save_url) : ''
    content += content_tag('div', raw(contents), :class => 'read-area')
    content_tag('div', raw(content), :class => get_classes(editable), :id => "fragment_#{id}")
  end

  def script_block(id, save_url)
    script = <<-EOS
      $(document).ready(function(){
        new Fragment("#fragment_#{id}", "#{save_url}");
        $("#fragment_#{id} a.edit-link").fancybox({
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

  def edit_tags(id, contents, save_url)
    script_block(id, save_url) +
        link_to('edit', "#markItUpContents_#{id}", :class => 'edit-link', :title => 'editing content') +
        content_tag('div', text_area_tag('contents', contents, :class => 'edit-area',
                                         :id => "contents_#{id}"), :style => 'display:none;')
  end

  def get_classes(editable)
    editable ? 'fragment editable' : 'fragment'
  end
end