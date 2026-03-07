if (instance_exists(target))
{
    target.spr_move = target.ospr_move;
    target.spr_idle = target.ospr_idle;
    target.spr_attack = target.ospr_attack;
    target.spr_dead = target.ospr_dead;
    target.polymorphed = false;
}

if (instance_exists(player))
    player.alarm[2] = 1;

instance_destroy();
