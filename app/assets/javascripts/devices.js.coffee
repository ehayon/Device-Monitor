$(document).ready ->
    # We only want this script to run on devices#index
    if $('#device_page').length > 0      
        reload = ->
            update_elements = ["name", "ip", "port", "last_state", "last_checked"]
            $.ajax
                type: 'get'
                url: '/devices'
                dataType: 'json'
                success: (json, status, response) ->    
                    for object in json.devices
                        dom_id = "device_" + object.device["id"]
                        # check if the DOM element exists - if so, update it
                        if $('#'+dom_id).length > 0
                            for element in update_elements
                                $('#'+dom_id+' .'+element).text(object.device[element])
                            if object.device["last_state"] == true
                                $('#'+dom_id).attr('class', 'up')
                            else
                                $('#'+dom_id).attr('class', 'down')
                        else
                            # The DOM element doesn't exist - append it to the table
                            last_state = if (object.device["last_state"] == true) then "up" else "down"
                            $('#devices').append('<tr id="'+dom_id+'" class="'+last_state+'">
                              <td class="name">'+object.device.name+'</td>
                              <td class="ip">'+object.device.ip+'</td>
                              <td class="port">'+object.device.port+'</td>
                          	  <td class="last_state">'+object.device.last_state+'</td>
                          	  <td class="last_checked">'+object.device.last_checked+'</td>
                          	  <td width="30"><a href="/devices/'+object.device.id+'/edit">Edit</a></td>
                            </tr>')
                            $('#'+dom_id).hide().fadeIn('fast');
                    # check for db removals
                    for elem in $('#devices tr')
                        if elem.id != ''
                           exist = false
                           for object in json.devices
                               if elem.id == "device_"+object.device.id
                                   exist = true
                           if !exist
                               $('#'+elem.id).fadeOut 'fast', ->
                                   $(this).remove();
                               
                                
        # Perform an AJAX request every second    
        setInterval(reload, 1000)
        
    # TODO: Sort the table - perform an an AJAX request if the table header text is clicked (pass the sort params as data in the ajax request)
    
    
    
    