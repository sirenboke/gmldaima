global.showRelic += 1;

if (global.showRelic >= 4)
    global.showRelic = 1;

global.buildingMsgDisplay += 1;

if (global.buildingMsgDisplay >= 2)
    global.buildingMsgDisplay = 0;

alarm[1] = (room_speed * 10) / 3;
