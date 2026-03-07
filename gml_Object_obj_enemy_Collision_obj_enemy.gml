if (hasCollision == true)
{
    if (instance_exists(obj_warrior))
    {
        if (myNumber > other.myNumber && other.hasCollision == true)
        {
            state = UnknownEnum.Value_0;
            x += 5;
        }
    }
}

enum UnknownEnum
{
    Value_0
}
