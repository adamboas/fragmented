Fragment = function(holder, url) {
  this.url = url;
  this.holder = $(holder);
  this.editArea = this.holder.find('.edit-area');
  this.readArea = this.holder.find('.read-area');
  this.editControls = this.holder.find('.edit-controls');
  this.readControls = this.holder.find('.read-controls');
  this.editControls.find('.cancel-link').click($.proxy(this.readMode, this));
  this.editControls.find('.fragment-save').click($.proxy(this.saveFragment, this));
  this.editArea.markItUp(mySettings);
  this.readMode();
};

Fragment.prototype = {
  readMode: function(updateContent) {
    this.holder.find('.markItUp').parent().hide();
    return false;
  },
  updateAndDisplayReadMode: function() {
    this.readArea.empty();
    this.readArea.append(this.editArea.val());
    this.editArea.val('');
    return this.readMode();
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
    this.updateAndDisplayReadMode();
  },
  handleFailure: function(msg) {
    alert(msg);
  }
};