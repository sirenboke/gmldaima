self.scr_string = function(arg0)
{
    var search = arg0;
    var lang;
    
    switch (global.language)
    {
        case 0:
            lang = "english";
            break;
        
        case 1:
            lang = "spanish";
            break;
        
        case 2:
            lang = "german";
            break;
        
        case 3:
            lang = "french";
            break;
        
        case 4:
            lang = "japanese";
            break;
        
        case 5:
            lang = "chinese";
            break;
        
        case 6:
            lang = "korean";
            break;
        
        default:
            lang = "english";
            break;
    }
    
    ini_open(string(global.platformDir) + "Language.ini");
    var findstr = ini_read_string(lang, string(search), "No String Found!");
    ini_close();
    findstr = string_replace_all(findstr, "*", "#");
    return findstr;
};
