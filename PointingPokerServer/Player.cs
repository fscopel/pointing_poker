using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer
{
    public class Player
    {
        public int guestId { get; set; }
        public int roomNumber { get; set; }
        public string vote { get; set; }
        public string name { get; set; }
        public bool isVisible { get; set; }

    }
}
