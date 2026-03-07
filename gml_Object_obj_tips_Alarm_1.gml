text = q[irandom(tipsList)];

if (global.chatSpam <= 2)
    gml_Script_twitch_chat_say("/me " + string(text));

if (room != r_seasonEnd)
{
    if (global.stageType == "Forest" || global.stageType == "Grassland" || global.stageType == "Snow Trail")
    {
        for (var t = 0; t < 60; t += 1)
        {
            if (t > instance_number(obj_trees))
                gml_Script_instance_create(random_range(room_width + 600, (room_width * 2) + 600), room_height - 20, obj_trees);
        }
    }
}

alarm[1] = room_speed * 120;
