$(function() {
  Iugu.setAccountID("63c332e2-9a1b-44b3-8699-1bf2a6b96d43");
  Iugu.setTestMode(true);

  $('#payment-form').submit(function(evt) {
    var form = $(this);

    if ($('#cc').hasClass("active")) {
      Iugu.createPaymentToken(this, function(data) {
        if (data.errors) {
          alert(JSON.stringify(data.errors));
        } else {
          $('#token').val(data.id);
          form.get(0).submit();
        }
      });
    } else {
      form.get(0).submit();
    }

    return false;
  });
});
