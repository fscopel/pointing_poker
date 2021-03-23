using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer
{
    public class SignalRChat : Hub
    {
        public async Task JoinRoom(string userName, string roomName)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, roomName);
        }

        public async Task LeaveRoom(string roomName)
        { 
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomName);
        }

        public async Task SendMessage(string user, string message, string roomName)
        {
            try
            {
                await Clients.Group(roomName).SendAsync("ReceiveMessage", user, message);
            }
            catch (Exception e)
            {

                
            }
        }
    }
}
