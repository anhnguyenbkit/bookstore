// Generated by CoffeeScript 1.11.1
(function() {
  $(window).load(function() {
    return $('#cart .book-cart-remove').click(function(e) {
      var $this, url;
      e.preventDefault();
      $this = $(this).closet('a');
      url = $this.data('targeturl');
      return $.ajax({
        url: url,
        type: 'put',
        success: function(data) {
          $('.cart-count').html(data);
          return $this.closet('.cart-book').slideUp();
        }
      });
    });
  });

}).call(this);