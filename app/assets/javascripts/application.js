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
//= require turbolinks
//= require_tree .

function delData(num){
    if(confirm('削除しますか?')){
        document.location = "/jalpoint/delete/" + num;
    }
    return false;
}

jQuery(function($){
    $('input#mileage').keyup(function(){
        $.ajax({
            //url: "#{jalpoint_calpoint_path}",
            url: "jalpoint/calpoint",
            type: "GET",
            data: { departure : $('select#departure').val(),
                    destination : $('select#destination').val(),
                    flightclass : $('select#flightclass').val(),
                    mileage : $('input#mileage').val()
                    },
            dataType: "json",
                    success: function(data) {
                      $('input#registeredmileage').val(data.registeredmileage);
                      $('input#registeredfop').val(data.registeredfop);
                    }
                    //error: function(data) {
                    //    alert("errror");
                    //}
    });
  });
});
