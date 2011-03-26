module FragmentHelper
  def fragment_tag(fragment, saveUrl, editable = true)
    classes = 'fragment'
    classes << ' editable' if editable
    content = editable ? edit_tags(fragment, saveUrl) : ''
    content += content_tag('div', raw(fragment.contents), :class => 'read-area')
    content_tag('div', raw(content), :class => classes, :id => "fragment_#{fragment.id}")
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

  def edit_tags(fragment, saveUrl)
      script_block(fragment, saveUrl) +
      link_to('edit', "#markItUpContents_#{fragment.id}",
                               :class => 'edit-link', :title => 'editing content') +
      content_tag('div', text_area_tag('contents', fragment.contents, :class => 'edit-area',
                                                       :id => "contents_#{fragment.id}"), :style => 'display:none;')
  end
end