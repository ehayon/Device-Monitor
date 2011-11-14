$(document).ready ->
    # function to be called on an interval
    reload = ->
        update_elements = ["name", "ip", "port", "last_state", "last_checked"]
        $.ajax
            type: 'get'
            url: '/devices'
            dataType: 'json'
            success: (json, status, response) ->
                
                for object in json
                    dom_id = "device_" + object.device.id
                    for element in update_elements
                        $('#'+dom_id+' .'+element).text(object.device[element])
                    

    # Perform an AJAX request every second    
    setInterval(reload, 1000)
        

    
    
    