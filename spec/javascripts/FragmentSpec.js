describe("Fragment", function() {

  var fragment;

  beforeEach(function() {
    var fixture = '<div class="fragment editable" id="fragment_2"<a href="#markItUpContents_2" class="edit-link" title="editing content">edit</a><div style="display:none;"><textarea class="edit-area" id="contents_2" name="contents">&lt;h1&gt;New Fragment&lt;/h1&gt;&lt;p&gt;This one has been edited&lt;/p&gt;</textarea></div><div class="read-area"><h1>New Fragment</h1><p>This one has been edited</p></div></div>';
    fragment = new Fragment(fixture, '/');
  });

  it("should get a reference to the outer container", function() {
    expect(fragment.holder).toExist();
  });

  it("should get a reference to the edit area", function() {
    expect(fragment.editArea).toExist();
  });

  it("should get a reference to the read area", function() {
    expect(fragment.readArea).toExist();
  });

  it("should make the editing text area invisible", function() {
    expect(fragment.holder.find('textarea')).toBeHidden();
  });

  describe("#updateAndDisplayReadMode", function(){
    it("should clear the existing text from the read area", function() {
      spyOn(fragment.readArea, 'empty');
      fragment.updateAndDisplayReadMode();
      expect(fragment.readArea.empty).toHaveBeenCalled();
    });

    it("should put the text from the (html)text area into the read area", function() {
      spyOn(fragment.readArea, 'append');
      fragment.updateAndDisplayReadMode('text');
      expect(fragment.readArea.append).toHaveBeenCalledWith('text');
    });

  });
});