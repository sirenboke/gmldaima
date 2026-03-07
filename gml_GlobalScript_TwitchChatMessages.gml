self.twitch_chat_say = function(arg0)
{
    with (obj_gameControl)
    {
        if (string_pos("/color", arg0) != 0)
            exit;
        
        if (global.textBulkCount > 0)
            global.textBulk += (" || " + string(arg0));
        else
            global.textBulk = string(arg0);
        
        global.textBulkCount += 1;
        
        if (!global.bulkActive)
        {
            global.bulkActive = true;
            alarm[8] = room_speed / 2;
        }
        
        if (global.textBulkCount >= 10)
            alarm[8] = 1;
    }
};

self.twitch_chat_say_bulk = function()
{
    with (obj_gameControl)
    {
        if (global.textBulkCount <= 0)
            exit;
        
        var prefix = "";
        
        if (global.textBulkCount > 1)
            prefix = "(" + string(global.textBulkCount) + ") ";
        
        var finalText = prefix + global.textBulk;
        finalText = string_replace_all(finalText, "/me ", "");
        finalText = "/me " + finalText;
        show_debug_message("CHAT BULK MESSAGING: " + finalText);
        gml_Script_twitch_chat_say_direct(finalText);
        global.textBulk = "";
        global.textBulkCount = 0;
        global.bulkActive = false;
    }
};

self.twitch_chat_say_direct = function(arg0)
{
    if (global.chatSpam < 3)
    {
        if (global.isTwitch == 1)
        {
            if (global.IRC_socket < 0 || global.IRC_channel == "" || string(arg0) == "")
            {
                gml_Script_twitch_log("Message sending failed, check connection and message content");
                return -1;
            }
        }
        
        with (obj_player)
        {
            if (string_pos(name, arg0) != 0)
            {
                personalMessages += 1;
                alarm[4] = room_speed;
                
                if (personalMessages >= 6)
                    exit;
            }
        }
        
        var _maxLength = 400;
        var _textLength = _maxLength - 20;
        
        if (string_length(arg0) > _maxLength)
        {
            show_debug_message("Message too long, splitting safely (optimized)");
            var _start = 1;
            var _part = 0;
            var _prevHadContinuation = false;
            var _totalLength = string_length(arg0);
            
            while (_start <= _totalLength)
            {
                var _remaining = _totalLength - (_start - 1);
                var _chunkLength = min(_textLength, _remaining);
                var _temp = string_copy(arg0, _start, _chunkLength);
                var _cutPos = string_last_pos(" ", _temp);
                
                if (_cutPos > 0 && _chunkLength == _textLength)
                {
                    _temp = string_copy(_temp, 1, _cutPos - 1);
                    _chunkLength = _cutPos;
                }
                
                var _finalMsg = _temp;
                var _hasMore = ((_start + _chunkLength) - 1) < _totalLength;
                
                if (_hasMore)
                    _finalMsg += " (...)";
                
                if (_prevHadContinuation)
                    _finalMsg = "(...) " + _finalMsg;
                
                show_debug_message("Split " + string(_part + 1) + ": " + _finalMsg);
                
                if (string_length(_finalMsg) > 6)
                {
                    if (string_pos("/me", _finalMsg) == 0)
                        _finalMsg = "/me " + _finalMsg;
                    
                    gml_Script_twitch_chat_say_direct(_finalMsg);
                }
                
                _prevHadContinuation = _hasMore;
                _start += _chunkLength;
                _part += 1;
            }
        }
        else
        {
            if (global.isTwitch == 1)
            {
                var send_str = "PRIVMSG " + string(global.IRC_channel) + " :" + string(arg0);
                var send_buff = buffer_create(8 + string_length(send_str), buffer_fixed, 1);
                buffer_seek(send_buff, buffer_seek_start, 0);
                buffer_write(send_buff, buffer_string, string(send_str) + "\r\n");
                network_send_raw(global.IRC_socket, send_buff, buffer_tell(send_buff));
                buffer_delete(send_buff);
                ds_list_add(global.Chat_list, string(global.IRC_name) + ": " + string(arg0));
                gml_Script_twitch_log("Chat message sent!");
                gml_Script_twitch_log(string(global.IRC_name) + ": " + string(arg0) + "\n");
            }
            
            if (global.isKick == 1)
            {
                if (instance_exists(obj_kick))
                {
                    var mensaje = string(arg0);
                    mensaje = string_replace(mensaje, "/me ", "");
                    
                    if (string_pos("/color", mensaje))
                        exit;
                    
                    with (obj_kick)
                    {
                        global.___struct___202 = function() constructor
                        {
                            self.text = argument[0];
                        };
                        
                        var json_msg = json_stringify(new function() constructor
                        {
                            self.text = argument[0];
                        }(mensaje)) + "\n";
                        var str_length = string_length(json_msg);
                        var send_buff = buffer_create(str_length * 2, buffer_fixed, 2);
                        
                        for (var i = 1; i <= str_length; i++)
                        {
                            var char = string_char_at(json_msg, i);
                            buffer_write(send_buff, buffer_u16, ord(char));
                        }
                        
                        network_send_raw(global.kick_socket, send_buff, buffer_tell(send_buff));
                        buffer_delete(send_buff);
                    }
                }
            }
        }
    }
};
