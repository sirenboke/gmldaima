global.g_live_token_constructors = ["header", "macro_def", "macro_start", "hash", "semico", "comma", "period", "colon", "qmark", "at_sign", "dollar_sign", "keyword", "ident", "undefined_hx", "boolean", "number", "cstring", "un_op", "adjfix", "bin_op", "set_op", "par_open", "par_close", "sqb_open", "sqb_close", "cub_open", "cub_close", "arg_const", "null_co", "null_co_set", "pragma"];
global.g_live_node_def_constructors = ["undefined_hx", "boolean", "number", "cstring", "other_const", "enum_ctr", "array_decl", "object_decl", "ensure_array_for_local", "ensure_array_for_global", "ensure_array_for_field", "ensure_array_for_index", "ensure_array_for_index2d", "ident", "self_hx", "other_hx", "global_ref", "script", "native_script", "const", "arg_const", "arg_index", "arg_count", "call", "call_script", "call_script_at", "call_script_id", "call_script_with_array", "call_field", "call_func", "call_func_at", "construct", "func_literal", "prefix", "postfix", "un_op", "bin_op", "set_op", "delete_hx", "null_co", "to_bool", "from_bool", "in", "local_hx", "local_set", "local_aop", "static_hx", "static_set", "static_aop", "global_hx", "global_set", "global_aop", "script_static", "script_static_set", "script_static_aop", "field", "field_set", "field_aop", "env", "env_set", "env_aop", "env_fd", "env_fd_set", "env_fd_aop", "env1d", "env1d_set", "env1d_aop", "alarm", "alarm_set_hx", "alarm_aop", "index", "index_set", "index_aop", "index2d", "index2d_set", "index2d_aop", "raw_id", "raw_id_set", "raw_id_aop", "raw_id2d", "raw_id2d_set", "raw_id2d_aop", "ds_list", "ds_list_set_hx", "ds_list_aop", "ds_map", "ds_map_set_hx", "ds_map_aop", "ds_grid", "ds_grid_set_hx", "ds_grid_aop", "key_id", "key_id_set", "key_id_aop", "var_decl", "block", "if_then", "ternary", "switch_hx", "wait", "fork", "while_hx", "do_until", "do_while", "repeat_hx", "for_hx", "with_hx", "once", "return_hx", "exit_hx", "break_hx", "continue_hx", "debugger", "try_catch", "throw_hx"];
global.mq_live_pos = [undefined, undefined, 0, 0, undefined, 0];
global.mq_live_scope = [undefined, undefined, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];

self.sprite_set_live = function(arg0, arg1)
{
};

self.path_set_live = function(arg0, arg1)
{
};

self.animcurve_set_live = function(arg0, arg1, arg2 = 16)
{
};

self.file_set_live = function(arg0, arg1, arg2)
{
};

self.room_set_live = function(arg0, arg1)
{
};

self.room_goto_live = function(arg0)
{
    room_goto(arg0);
};

self.live_call = function()
{
    return false;
};

self.live_defcall = function()
{
    return false;
};

self.live_call_ext = function(arg0)
{
    return false;
};

self.live_defcall_ext = function(arg0, arg1)
{
    return false;
};

self.live_auto_call_1 = function()
{
    return false;
};

self.live_auto_call_2 = function(arg0)
{
    return false;
};

self.live_async_http = function(arg0)
{
};

self.shader_set_live = function(arg0, arg1)
{
};

self.live_method = function(arg0, arg1)
{
    return method(arg0, arg1);
};

self.live_method_get_self = function(arg0)
{
    return method_get_self(arg0);
};

self.live_thread_method_script = function()
{
    return undefined;
};

self.live_update_script_impl = function(arg0, arg1, arg2)
{
};

self.live_constant_add = function(arg0, arg1)
{
};

self.live_constant_delete = function(arg0)
{
    return false;
};

self.live_variable_add = function(arg0, arg1)
{
};

self.live_variable_delete = function(arg0)
{
    return false;
};

self.live_function_add = function(arg0, arg1)
{
};

self.live_function_delete = function(arg0)
{
    return false;
};

self.live_throw_error = function(arg0)
{
};

self.live_execute_string = function(arg0)
{
    return false;
};

self.live_snippet_create = function(arg0, arg1 = "snippet")
{
    return undefined;
};

self.live_snippet_destroy = function(arg0)
{
};

self.live_snippet_call = function(arg0)
{
    return false;
};

self.live_update = function()
{
};

self.live_init = function(arg0, arg1, arg2)
{
};

self.live_room_start = function()
{
};

self.vm_v2_GmlStructBase = function() constructor
{
    static __class__ = global.mt_vm_v2_GmlStructBase;
};
