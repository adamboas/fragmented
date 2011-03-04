describe("Fragment", function() {

  var fragment;

  beforeEach(function() {
    var fixture = '<div id="fragment" class="fragment"><div class="fragment-controls"><a id="fragment_edit_link" href="#">edit</a></div><textarea id="markItUp"></textarea></div>';
    fragment = new Fragment(fixture, false);
  });

  it("should get a reference to the outer container", function() {
    expect(fragment.holder).toExist();
  });

  it("should get a reference to the edit link", function() {
    expect(fragment.editLink).toExist();
  });

  it("should sa click listener to the edit link to toggle into edit mode")

  it("should make the editing text area invisible", function() {
    expect(fragment.holder.find('textarea')).toHaveClass('invisible');
  });

  describe("editMode", function(){
    it("should make the editArea visible");

    it("should replace the edit link with save|cancel|preview links")

    it("should load the rich text editor")
  });
});