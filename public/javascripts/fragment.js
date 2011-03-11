Fragment = function(holder, startInEditMode, url) {
  this.url = url;
  this.holder = $(holder);
  this.editArea = this.holder.find('.edit-area');
  this.readArea = this.holder.find('.read-area');
  this.editControls = this.holder.find('.edit-controls');
  this.readControls = this.holder.find('.read-controls');
  this.readControls.find('.edit-link').click($.proxy(this.editMode, this));
  this.editControls.find('.cancel-link').click($.proxy(this.readMode, this));
  this.editControls.find('.fragment-save').click($.proxy(this.saveFragment, this));
  this.markItUpInitialized = false;
  if (startInEditMode) {
    this.editMode();
  }
  else {
    this.readMode();
  }
};

Fragment.prototype = {

  editMode: function() {
    if (!this.markItUpInitialized) {
      this.editArea.markItUp(mySettings);
      this.markItUpInitialized = true;
    }
    else {
      this.holder.find('.markItUp').parent().show();
      this.readArea.empty();
    }
    this.editArea.val(this.readArea.html());
    this.readControls.hide();
    this.readArea.hide();
    this.editControls.show();
    this.editArea.show();
    return false;
  },
  readMode: function() {
    if (this.markItUpInitialized) {
      this.readArea.children().remove();
      this.readArea.append(this.editArea.val());
      this.editArea.val('');
    }
    this.editArea.hide();
    this.editControls.hide();
    this.readControls.show();
    this.readArea.show();
    this.holder.find('.markItUp').parent().hide();
    return false;
  },
  saveFragment: function() {
    var settings = {
      data: 'fragment[contents]=' + this.editArea.val(),
      success: this.handleSuccess,
      failure: this.handleFailure,
      type:  'PUT',
      url:  this.url
    };
    $.ajax(settings);
    return false;
  },
  handleSuccess: function(msg) {
    alert(msg);
  },
  handleFailure: function(msg) {
    alert(msg);
  }
};