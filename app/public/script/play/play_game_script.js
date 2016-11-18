/**
 * Created by andre on 11/15/16.
 */

/**
 * Gets a response from the server and executes whatever functions are passed
 * given a success or failure from the server.
 *
 * @param command
 * @param commandData
 * @param onSuccess
 */
function submitPlayCommand(command, commandData, onSuccess){
    $.ajax({
        type: 'POST',
        url: '/' + command,
        data: commandData,
        success: onSuccess,
        error: function(){
            $('#response_container').append($('<div/>', {content:"<p>An error occurred server side.</p>"}));
        }
    });
}

var commandNumber = 1;

function appendResponse(command, serverResponse){
    var response = $('<div/>', {id:"response" + commandNumber, "class":"response"});
    var header = $('<div/>', {"class":"response_header"})
    var responseCommand = $('<div/>', {"class":"response_command"});
    var responseRoom = $('<div/>', {"class":"response_room", content: serverResponse.room});
    var responseContent = $('<div/>', {"class":"response_description"})

    $('#response_container').append(response);
    response.append(header);
    header.append(responseCommand);
    header.append(responseRoom);
    response.append(responseContent);

    responseCommand.append("<strong><span>&gt;</span> " + command + "</strong>");
    responseRoom.append("" + serverResponse['room']);
    responseContent.append("" + serverResponse['description']);

    commandNumber += 1;
}

$(document).ready(function(){
    var responseSpace = $('#response_space'); // where we will be dumping everything

    // Sending a command
    $(document).keydown(function(event){
        var commandNode = $('#player_command');

        // Enter Key
        if(event.which === 13) {
            var command = commandNode.val();
            commandNode.val('');

            // TODO: Data?
            submitPlayCommand(command, {}, function(response){
                appendResponse(command, JSON.parse(response));
                console.log(response);
            })
        }
    });

    $(document).click(function(){
        $('#player_command').select();
    });
});