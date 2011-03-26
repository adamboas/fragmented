Fragment = function(holder, url) {
  this.url = url;
  this.holder = $(holder);
  this.editArea = this.holder.find('.edit-area');
  this.readArea = this.holder.find('.read-area');
  $(document).bind('saveContent', $.proxy(this.saveFragment, this));
  $(document).bind('cancelEdit', $.proxy(this.cancelEdit, this));
  this.editArea.markItUp(mySettings);
};

Fragment.prototype = {
  updateAndDisplayReadMode: function(text) {
    this.readArea.empty();
    this.readArea.append(text);
  },
  cancelEdit: function() {
    this.editArea.val(this.readArea.html());
  },
  saveFragment: function() {
    var settings = {
      data: 'fragment[contents]=' + this.editArea.val(),
      success: $.proxy(this.handleSuccess, this),
      failure: this.handleFailure,
      type:  'PUT',
      url:  this.url
    };
    $.ajax(settings);
    return false;
  },
  handleSuccess: function(jqXHR) {
    this.editArea.val(jqXHR.fragment.contents);
    this.updateAndDisplayReadMode(jqXHR.fragment.contents);
  },
  handleFailure: function(msg) {
    alert(msg);
  }
};