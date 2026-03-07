self.net_client_destroy = function()
{
    network_destroy(global.clientSocket);
    buffer_delete(global.buffer);
};
