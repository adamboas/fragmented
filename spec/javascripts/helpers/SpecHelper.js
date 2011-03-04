beforeEach(function() {
  this.addMatchers({
    toHaveClass: function(expectedClass) {
      return this.actual.hasClass(expectedClass)
    },
    toHaveId: function(expectedId) {
      return this.actual.attr('id') == expectedId;
    },
    toExist: function() {
      return this.actual != undefined && this.actual != null;
    }
  })
});
