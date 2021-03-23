﻿using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer
{
    public class SignalRChat : Hub
    {
        private readonly IDistributedCache _distributedCache;

        public SignalRChat(IDistributedCache distributedCache)
        {
            _distributedCache = distributedCache;
        }

        public async Task JoinRoom(string playerJson)
        {
            var player = JsonConvert.DeserializeObject<Player>(playerJson);
            
            await Groups.AddToGroupAsync(Context.ConnectionId, player.roomNumber.ToString());
            var cacheKey = player.roomNumber.ToString();
            
            var playersInRoom = _distributedCache.GetString(cacheKey);
            if (playersInRoom != null)
            {
                var players = JsonConvert.DeserializeObject<List<Player>>(playersInRoom);
                if (players.Any(p => p.guestId == player.guestId))
                {
                    players.Find(p => p.guestId == player.guestId).vote = player.vote;
                }
                else
                {
                    players.Add(player);
                    _distributedCache.SetString(cacheKey, JsonConvert.SerializeObject(players));
                }
            }
            else {
                var players = new List<Player>();
                players.Add(player);
                _distributedCache.SetString(cacheKey, JsonConvert.SerializeObject(players));
            }
            
        }

        public async Task SetVote(string playerJson)
        {
            var player = JsonConvert.DeserializeObject<Player>(playerJson);
            var cacheKey = player.roomNumber.ToString();
            var playersInRoom = _distributedCache.GetString(cacheKey);
            if (playersInRoom != null)
            {
                var players = JsonConvert.DeserializeObject<List<Player>>(playersInRoom);
                if (players.Any(p => p.guestId == player.guestId))
                {
                    players.Find(p => p.guestId == player.guestId).vote = player.vote;

                    var playersJson = JsonConvert.SerializeObject(players);
                    _distributedCache.SetString(cacheKey, playersJson);
                    await Clients.Group(cacheKey).SendAsync("ReceiveLatestList", playersJson);
                }
            }
        }

        public async Task ClearAll(string cacheKey)
        {
            
            var playersInRoom = _distributedCache.GetString(cacheKey);
            if (playersInRoom != null)
            {
                var players = JsonConvert.DeserializeObject<List<Player>>(playersInRoom);
                foreach (var player in players)
                {
                    player.vote = 0;
                }

                var playersJson = JsonConvert.SerializeObject(players);
                _distributedCache.SetString(cacheKey, playersJson);
                await Clients.Group(cacheKey).SendAsync("ReceiveLatestList", playersJson);
            }
        }


        public async Task LeaveRoom(string roomName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomName);
        }

        public async Task GetLatestList(string roomName)
        {
            await Clients.Group(roomName).SendAsync("ReceiveLatestList", _distributedCache.GetString(roomName));

        }
    }
}
