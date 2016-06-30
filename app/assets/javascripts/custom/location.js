var addr_1,addr_2,postCode,lat,lon;
var values;

function validate_distance(event) {
  event.preventDefault();
  var paramArray = [lat, lon];
  validated(addr_1, addr_2, postCode, lat, lon, function(response, errors){
    if (response === true){
      var aed_data = {
        addr_1: addr_1.value,
        addr_2: addr_2.value,
        post_code: postCode.value,
        lat: lat.value,
        lon: lon.value
      }
      sendLatLonCheck(aed_data, report_distance)
    } else {
      for (var i = 0; i < errors.length; i++) {
        if (!errors[i].classList.contains("error")){
          errors[i].className += " error";
          var p = document.createElement("p");
          p.className = "inline-errors";
          p.innerText = "Required Field";
          errors[i].appendChild(p);
        }
      }
      alert("You need to fill in highlighted fields");
    }
  });
}

function validated(addr_1, addr_2, postCode, lat, lon, callback){
  var response = true;
  var errors  = [];
  var paramArray = [addr_1, addr_2, postCode, lat, lon];
  for (var i = 0; i < paramArray.length; i++) {
    if ( paramArray[i].value == null || paramArray[i].value == ""){
      errors.push(paramArray[i].parentElement)
      response = false;
    }
  }
  callback(response, errors);
}

function report_distance(distance_max){
  var result = JSON.parse(distance_max);
  if (result.over_limit === true){
    if (window.confirm(
      "This is over 0.1 miles away from address. Suggested co-ordinates are: " + result.suggested + ". Are you sure to continue?"
    ))
    {
      console.log('confirmed');
      document.getElementById('aed_validated?').checked = true;
      submitTheForm();
    } else {
      document.getElementById('aed_validated?').checked = false;
      console.log('not confirmed');
    }
  } else {
    document.getElementById('aed_validated?').checked = true;
    submitTheForm();
  }
}


function submitTheForm(){
  document.getElementsByTagName('form')[0].submit();
}

function sendLatLonCheck(aed_data, callback){
  $.ajax(
    {
      url: '/admin/aeds/validate_distance',
      dataType: 'html',
      type: 'get',
      data: aed_data,
      success: function(distance_value) {
        callback(distance_value);
      }
    }
  );
}

function autoPop(){
  if( this.value != "" || this.value != null){
    checkLatLon();
  }
}

function checkLatLon(){
  var addr_1 = document.getElementById('aed_address_line_1');
  var addr_2 = document.getElementById('aed_address_line_2');
  var postCode = document.getElementById('aed_post_code');
  var paramArray = [addr_1, addr_2, postCode];
  var response = true;
  for (var i = 0; i < paramArray.length; i++) {
    if ( paramArray[i].value == null || paramArray[i].value == ""){
      response = false;
    }
  }
  if(response){
    var aed_data = {
      addr_1: addr_1.value,
      addr_2: addr_2.value,
      post_code: postCode.value,
    }
    sendLatLonCheck(aed_data, function(distance_value){
      var result = JSON.parse(distance_value);
      updateLatLon(result.suggested, function(){
        values[addr_1.id] = addr_1.value;
        values[addr_2.id] = addr_2.value;
        values[postCode.id] = postCode.value;
      });
    })
  }
}

function updateLatLon(suggested, callback){
  latLonArray = suggested.split(",");
  lat.value = latLonArray[0];
  lon.value = latLonArray[1];
  values[lat.id] = latLonArray[0];
  values[lon.id] = latLonArray[1];
  var mapViewString = "http://maps.google.com/maps?q=loc:" + latLonArray;
  mapPreview();
  callback();
}


function mapPreview(){
  var mapViewString = "http://maps.google.com/maps?q=loc:" +lat.value  + "," + lon.value;
  var mapPreview = document.getElementById('mapViewDiv');
  if (mapPreview){
    mapPreview.href = mapViewString;
  } else {
    var mapDiv = document.createElement("a");
    mapDiv.href = mapViewString;
    mapDiv.className = "button";
    mapDiv.innerText = "Map Preview Link"
    mapDiv.target = "_blank"
    mapDiv.id = "mapViewDiv";
    lon.parentElement.appendChild(mapDiv);
  }
}

$(document).ready(function() {
  console.log("Loaded Location Data");
  // grab all variables
  addr_1 = document.getElementById('aed_address_line_1');
  addr_2 = document.getElementById('aed_address_line_2');
  postCode = document.getElementById('aed_post_code');
  lat = document.getElementById('aed_latitude');
  lon = document.getElementById('aed_longitude');
  values = {};
  // add event listeners on change
  addr_1.addEventListener("change", autoPop);
  addr_2.addEventListener("change", autoPop);
  postCode.addEventListener("change", autoPop);
  lat.addEventListener("change", mapPreview);
  lon.addEventListener("change", mapPreview);
});