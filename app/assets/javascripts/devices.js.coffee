$(document).ready ->
    # We only want this script to run on devices#index
    if $('#device_page').length > 0      
        sort_by = 'id'
        sort_dir = 'ASC'
        keyword = ''
        $('#sort').change ->
            sort_by = 'id'
            sort_dir = $(this).val()
            reload()
        $('#search_field').keyup ->
            keyword = $('#search_field').val()
            $('#search_message').html("Showing results for \"" + keyword + "\"").append('<span id="remove">X</span>')
            if keyword == '' 
                $('#search #search_message').fadeOut('fast')
            else
                $('#search #search_message').fadeIn('fast')
            reload()
        $('#search_message').delegate('#remove', 'click', ->
            $('#search_message').fadeOut('fast')
            keyword = ''
            reload()
        )
        reload = ->
            update_elements = ["name", "ip", "port", "last_state", "last_checked"]
            $.ajax
                type: 'get'
                url: '/devices'
                data: {'sort':{'by':'id','dir':sort_dir}, 'search': keyword}
                dataType: 'json'
                success: (json, status, response) ->    
                    $('#devices tr:gt(0)').each ->
                        $(this).remove()
                    for object in json.devices
                        dom_id = "device_"+object.id
                        last_state = if (object.device["last_state"] == true) then "up" else "down"
                        $('#devices').append('<tr id="'+dom_id+'" class="'+last_state+'">
                          <td class="name">'+object.device.name+'</td>
                          <td class="ip">'+object.device.ip+'</td>
                          <td class="port">'+object.device.port+'</td>
                      	  <td class="last_state">'+object.device.last_state+'</td>
                      	  <td class="last_checked">'+object.device.last_checked+'</td>
                      	  <td width="30"><a href="/devices/'+object.device.id+'/edit">Edit</a></td>
                        </tr>')
                                  
        # Perform an AJAX request every second    
        setInterval(reload, 2000)
        
    # TODO: Sort the table - perform an an AJAX request if the table header text is clicked (pass the sort params as data in the ajax request)
    
    
    
    