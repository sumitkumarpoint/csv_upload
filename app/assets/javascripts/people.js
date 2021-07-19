$(document).ready(function (){
// This is useful to validate csv file field.
    $('form#upload_csv').validate({
        rules: {
            csv_file: {
                required: true
            }
        },
        messages: {
            csv_file: {
                required: "Please select CSV file."
            }
        }
    });

// This is useful to show people lists.
    $.ajax({
        url: "/people",
        method: "get",
        contentType: "application/json",
        dataType: "json",
        success: function(response){
            append_data(response)
        },
        error: function(response){
            alert(response.responseText)
        }
    });

// This is useful to create people by csv upload.
    $("form#upload_csv").on("submit",function(event){
        event.preventDefault();
        var fd = new FormData();
        var files = $('#csv_file')[0].files;

        // Check file selected or not
        if(files.length > 0 ) {
            fd.append('csv_file', files[0]);

            $.ajax({
                url: "/people",
                method: "post",
                data: fd,
                contentType: false,
                processData: false,
                success: function (response) {
                    append_data(response)
                },
                error: function(response){
                    alert(response.responseText)
                }
            });
        }
    });

// This is useful to create person which are failed after csv upload.
    $(document).on("submit","form.person_form",function(event){
        event.preventDefault();
        $(this).valid()
        var current_form = $(this);
        var form_data = new FormData();
        var data_fields = $(this).serializeArray();
        form_data.append('person[first_name]', data_fields[0]['value']);
        form_data.append('person[last_name]', data_fields[1]['value']);
        form_data.append('person[email]', data_fields[2]['value']);
        form_data.append('person[phone]]', data_fields[3]['value']);
        $.ajax({
            url: "/people",
            method: "post",
            data: form_data,
            contentType: false,
            processData: false,
            success: function (response) {
                append_data([response])
                current_form.parent().remove();
            },
            error: function(response){
                alert(response.responseText)
            }
        });
    });
})

// This function to used to append data iin listing.
function append_data(data){
    $.each(data, function( index, value ) {
        var errors='';
        if( (typeof value["error_messages"]!= 'undefined') && Object.keys(value["error_messages"]).length > 0 ) {
             value['first_name'] =(value['first_name']== null ? '' : value['first_name']);
             value['last_name'] = (value['last_name']==null ? '' : value['last_name']);
             value['email'] = (value['email']==null ? '' : value['email']);
             value['phone'] = (value['phone']==null ? '' : value['phone']);
             errors = JSON.stringify(value["error_messages"]);

            $('.people').append('<div>' +
             '        <form action="/people" class="person_form" method="patch">' +
             '          <ul class="list-group  list-group-horizontal row text-center form-input">' +
             '            <li class="list-group-item flex-fill col-sm-1">'+value['id']+'</li>' +
             '            <li class="list-group-item flex-fill col-sm-1"><input type="text" placeholder="First name" value="'+value['first_name']+'" name=person[first_name]" class="input"></li>' +
             '            <li class="list-group-item flex-fill col-sm-1"><input type="text" placeholder="Last name" value="'+value['last_name']+'" name="person[last_name]" class="input" ></li>' +
             '            <li class="list-group-item flex-fill col-sm-2"><input type="text" placeholder="Email" value="'+value['email']+'" name="person[email]" class="input"></li>' +
             '            <li class="list-group-item flex-fill col-sm-2"><input type-="text" placeholder="Phone" value="'+value['phone']+'" name="person[phone]" class="input"></li>' +
             '            <li class="list-group-item flex-fill col-sm-4">'+errors+'</li>' +
             '            <li class="list-group-item flex-fill col-sm-1">' +
             '              <button type="submit" class="btn btn-success">Save</button>' +
             '            </li>' +
             '          </ul>' +
             '        </form>' +
             '      </div>');
        }else{
            $('.people').append('<ul class="list-group  list-group-horizontal row text-center">' +
                '<li class="list-group-item flex-fill col-sm-1">'+value["id"]+'</li>' +
                '<li  class="list-group-item  flex-fill col-sm-1">'+value["first_name"]+'</li>' +
                '<li class="list-group-item flex-fill col-sm-1">'+value["last_name"]+'</li>' +
                '<li  class="list-group-item flex-fill col-sm-2">'+value["email"]+'</li>' +
                '<li  class="list-group-item flex-fill col-sm-2">'+value["phone"]+'</li>' +
                '<li  class="list-group-item flex-fill col-sm-4">'+errors+'</li>' +
                '<li  class="list-group-item flex-fill col-sm-1"></li>' +
                '</ul>');
        }
    });
}
