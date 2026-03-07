self.Number_Abbreviate = function(arg0)
{
    var numLog_ = array_length(arg0);
    var realnum_ = 0;
    var decimalnum_ = "";
    
    if (numLog_ > 1)
    {
        realnum_ = arg0[numLog_ - 1];
        var strDec_ = string(arg0[numLog_ - 2]);
        var decimal_ = string_repeat("0", 3 - string_length(strDec_)) + strDec_;
        
        if (string_length(realnum_) < 3)
            decimalnum_ = "." + string_copy(decimal_, 1, 3 - string_length(realnum_));
        else
            decimalnum_ = "";
    }
    else
    {
        var strDec_ = string(arg0[numLog_ - 1]);
        var decimal_ = string_repeat("0", 3 - string_length(strDec_)) + strDec_;
        decimalnum_ = "." + string_copy(decimal_, 1, 2);
    }
    
    var unit = "";
    var num_ = string(realnum_) + decimalnum_;
    
    switch (numLog_ - 1)
    {
        case 0:
            unit = "";
            break;
        
        case 1:
            unit = "";
            break;
        
        case 2:
            unit = "K";
            break;
        
        case 3:
            unit = "M";
            break;
        
        case 4:
            unit = "B";
            break;
        
        case 5:
            unit = "T";
            break;
        
        default:
            var firstNotation = (numLog_ - 7) div 26;
            var secondNotation = (numLog_ - 7) % 26;
            unit = chr(firstNotation + 97) + chr(secondNotation + 97);
            break;
    }
    
    return num_ + unit;
};

self.Number_Adjust = function(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] > 999)
        {
            adjust_ = true;
            var numberleft = arg0[i] % 1000;
            
            if (i == (array_length(arg0) - 1))
            {
                arg0[i + 1] = floor(arg0[i] / 1000);
                arg0[i] = numberleft;
            }
            else
            {
                arg0[i + 1] += floor(arg0[i] / 1000);
                arg0[i] = numberleft;
            }
        }
        else if (arg0[i] < 0)
        {
            adjust_ = true;
            arg0[i + 1] -= 1;
            arg0[i] = 1000 + arg0[i];
        }
        else
        {
            adjust_ = false;
        }
    }
    
    return arg0;
};

self.Number_isSufficient = function(arg0, arg1)
{
    if (array_length(arg0) < array_length(arg1))
        return false;
    else if (array_length(arg0) > array_length(arg1))
        return true;
    
    var i = array_length(arg0) - 1;
    
    while (i >= 0)
    {
        if (arg0[i] < arg1[i])
            return false;
        
        i--;
    }
    
    return true;
};

self.Number_TrimArray = function(arg0)
{
    var len_ = array_length(arg0) - 1;
    
    for (var i = len_; i >= 0; i--)
    {
        if (arg0[i] <= 0)
            array_resize(arg0, i);
        else
            return arg0;
    }
    
    if (array_length(arg0) == 0)
        arg0[0] = 0;
    
    return arg0;
};

self.Number_Convert_StringToArray = function(arg0)
{
    var arr;
    arr[0] = 0;
    var firstLetter_ = 92;
    var notation_ = string_letters(arg0);
    var not1_ = string_char_at(notation_, 1);
    var not2_ = string_char_at(notation_, 2);
    var value_ = string_replace(arg0, notation_, "");
    var place1_ = 0;
    var place2_ = 0;
    
    switch (notation_)
    {
        case "":
            place2_ = 1;
            break;
        
        case "K":
            place2_ = 2;
            break;
        
        case "M":
            place2_ = 3;
            break;
        
        case "B":
            place2_ = 4;
            break;
        
        case "T":
            place2_ = 5;
            break;
        
        default:
            place1_ = ord(not1_) - firstLetter_ - 5;
            place2_ = (ord(not2_) - firstLetter_) + 1;
            break;
    }
    
    var finalnotValue_ = (place1_ * 26) + place2_;
    var hasDecimal = false;
    var sub_str = "";
    
    for (var i = 1; i < (string_length(value_) + 1); i++)
    {
        var next_char = string_char_at(value_, i);
        
        if (next_char != ".")
        {
            sub_str = sub_str + next_char;
        }
        else
        {
            hasDecimal = true;
            
            if (sub_str != "")
                arr[finalnotValue_--] = real(sub_str);
            
            sub_str = "";
        }
    }
    
    if (sub_str != "")
    {
        if (hasDecimal)
            arr[finalnotValue_] = real("." + sub_str) * 1000;
        else
            arr[finalnotValue_] = real(sub_str);
    }
    
    return arr;
};

self.Number_Add_StringToString = function(arg0, arg1)
{
    var array_ = gml_Script_Number_Convert_StringToArray(arg0);
    var otherArray_ = gml_Script_Number_Convert_StringToArray(arg1);
    var lenMoney = array_length(array_);
    var lenTemp = array_length(otherArray_);
    
    if (lenTemp > lenMoney)
        array_[lenTemp - 1] = 0;
    
    for (var i = 0; i < lenTemp; i++)
        array_[i] += otherArray_[i];
    
    return array_;
};

self.Number_Add_ArrayToString = function(arg0, arg1)
{
    var otherArray_ = gml_Script_Number_Convert_StringToArray(arg1);
    var lenMoney = array_length(arg0);
    var lenTemp = array_length(otherArray_);
    
    if (lenTemp > lenMoney)
        arg0[lenTemp - 1] = 0;
    
    for (var i = 0; i < lenTemp; i++)
        arg0[i] += otherArray_[i];
    
    return arg0;
};

self.Number_Add_ArrayToArray = function(arg0, arg1)
{
    var lenMoney = array_length(arg0);
    var lenTemp = array_length(arg1);
    
    if (lenTemp > lenMoney)
        arg0[lenTemp - 1] = 0;
    
    for (var i = 0; i < lenTemp; i++)
        arg0[i] += arg1[i];
    
    return arg0;
};

self.Number_Deduct_StringToString = function(arg0, arg1)
{
    var array_ = gml_Script_Number_Convert_StringToArray(arg0);
    var otherArray_ = gml_Script_Number_Convert_StringToArray(arg1);
    var lenTemp = array_length(otherArray_);
    
    if (!gml_Script_Number_isSufficient(array_, otherArray_))
        return array_;
    
    for (var i = 0; i < lenTemp; i++)
        array_[i] -= otherArray_[i];
    
    return array_;
};

self.Number_Deduct_ArrayToString = function(arg0, arg1)
{
    var otherArray_ = gml_Script_Number_Convert_StringToArray(arg1);
    var lenTemp = array_length(otherArray_);
    
    if (!gml_Script_Number_isSufficient(arg0, otherArray_))
        return arg0;
    
    for (var i = 0; i < lenTemp; i++)
        arg0[i] -= otherArray_[i];
    
    return arg0;
};

self.Number_Deduct_ArrayToArray = function(arg0, arg1)
{
    var lenTemp = array_length(arg1);
    
    if (!gml_Script_Number_isSufficient(arg0, arg1))
        return arg0;
    
    for (var i = 0; i < lenTemp; i++)
        arg0[i] -= arg1[i];
    
    return arg0;
};
