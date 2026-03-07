with (obj_warrior)
{
    if (onHitHeal > oonHitHeal)
        onHitHeal -= other.onHit;
    
    if (onHitTrue > oonHitTrue)
        onHitTrue -= other.onHit;
}

part_emitter_clear(global.over_partsys, global.blessing_partemitter);
instance_destroy();
