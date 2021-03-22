using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PartyController : ControllerBase
    {
        [HttpGet]
        public IEnumerable<int> Get()
        {
            var response = Enumerable.Range(1, 34).ToList();
            return response;
        }
    }
}
