// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

(function() {
  $(window).load(function() {
    return $('a[data-target]').click(function(e) {
      var $this, new_target, url;
      e.preventDefault();
      $this = $(this);
      console.log($this.data('target'));
      if ($this.data('target') === 'Add to') {
        url = $this.data('addurl');
        new_target = "Remove from";
      } else {
        //console.log("else");
        url = $this.data('removeurl');
        new_target = "Add to";
      }
      return $.ajax({
        url: url,
        type: 'put',
        success: function(data) {
          $('.cart-count').html(data.cart);
          $('.cart-total-fee').html(data.fee);
          $this.find('span').html(new_target);
          return $this.data('target', new_target);
        }
      });
    });
  });

}).call(this);

(function() {
  $(window).load(function() {
    return $('#cart .book-cart-remove').click(function(e) {
      //console.log("remove");
      var $this, url;
      e.preventDefault();
      $this = $(this).closest('a');
      url = $this.data('targeturl');
      return $.ajax({
        url: url,
        type: 'put',
        success: function(data) {
          $('.cart-count').html(data.cart);
          $('.cart-total-fee').html(data.fee);
          return $this.closest('.cart-book').slideUp();
        }
      });
    });
  });

}).call(this);

//(function() {
//  $(window).load(function() {
//    return $('#cart .book-cart-remove').click(function(e) {
//      //console.log("remove");
//      var $this, url;
//      e.preventDefault();
//      $this = $(this).closest('a');
//      url = $this.data('targeturl');
//      return $.ajax({
//        url: '/cart/sum_fee_json',
//        type: 'get',
//        success: function(data) {
//          $('.cart-total-fee').html(data);
//          $this.find('span').html();
//          console.log($this.data('targeturl'));
//          return $this.data('targeturl');
//        }
//      });
//    });
//  });
//
//}).call(this);

// $(document).ready(function() {
//   $(".book-item").hover(function() {
//     console.log("debug hover");
//     var elId = $(this).attr("id");
//     console.log(elId);
//     $("#" + elId).after("abc");
//   },
//   function);
// });