$(document).on("ready", function(){

  var dateInput = $(".datetimepicker");
  dateInput.parent().css("position", "relative");
  dateInput.datetimepicker();

  $("#bid-submit").on("click", function(e){
    e.preventDefault();

    var bidAmount = $("#new-bid").val();

    $.ajax({
      url:"http://localhost:3001/auctions/" + this.data("aid") + "/bids.json",
      method: "post",
      error: function(){
        alert('comment failed');
      },
      success: function(){
        
      },
      data: {amount: bidAmount}

    });
  });

});
