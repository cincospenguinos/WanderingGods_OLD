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
 * @param onFailure
 */
function submitCommand(command, commandData, onSuccess, onFailure){
    $.ajax({
        type: 'POST',
        url: '/' + command,
        data: commandData,
        success: onSuccess,
        error: onFailure
    });
}

$(document).ready(function(){

    // Sending a command
    $(document).keydown(function(event){
        var commandNode = $('#player_command');

        // Enter Key
        if(event.which === 13) {
            var command = commandNode.val();
            commandNode.val('');

            submitCommand(command, {}, function(response){
                // TODO: Figure out how to show the response
            }, function(){
                // TODO: Show a response indicating failure
            });
        }
    });

    $(document).click(function(){
        $('#player_command').select();
    });
});