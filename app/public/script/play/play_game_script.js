/**
 * Created by andre on 11/15/16.
 */

$(document).ready(function(){

    // Sending a command
    $(document).keydown(function(event){
        var commandNode = $('#player_command');

        // Enter Key
        if(event.which === 13) {
            var command = commandNode.val();
            commandNode.val('');

            // TODO: Actually send the command
        }
    });

    $(document).click(function(){
        $('#player_command').select();
    });
});