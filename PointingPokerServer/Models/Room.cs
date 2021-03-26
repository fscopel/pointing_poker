using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer.Models
{
    public class Room
    {
        public int RoomNumber { get; set; }
        public List<Player> Players { get; set; }
        public List<Stats> Stats { get; set; }

    }
}
