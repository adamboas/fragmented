Fragment = function(holder, startInEditMode) {
  this.holder = $(holder);
  this.editArea = this.holder.find('.edit_area');
  this.readArea = this.holder.find('.read_area');
  this.editControls = this.holder.find('.edit-controls');
  this.readControls = this.holder.find('.read-controls');
  this.holder.find('#fragment_edit_link').click($.proxy(this.editMode, this));
  this.holder.find('#fragment_cancel_link').click($.proxy(this.readMode, this));
  this.holder.find('.fragment-save').click($.proxy(this.saveFragment, this));
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
      this.editArea.val(this.readArea.html());
      this.readArea.empty();
    }
    this.readControls.hide();
    this.readArea.hide();
    this.editControls.show();
    this.editArea.show();
  },
  readMode: function() {
    this.readArea.append(this.editArea.val());
    this.editArea.val('');
    this.editArea.hide();
    this.editControls.hide();
    this.readControls.show();
    this.readArea.show();
    this.holder.find('.markItUp').parent().hide();
  },
  saveFragment: function() {
    $.ajax({
      type: 'POST',
      url: '/fragments',
      data: 'fragment[contents]=' + this.editArea.val(),
      success: this.handleSuccess
    });
  },
  handleSuccess: function(msg) {
    alert(msg);
  }
};