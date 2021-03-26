using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PointingPokerServer.Controllers
{
	[Route("api/[controller]")]
	public class HomeController : Controller
	{
		private readonly IDistributedCache _distributedCache;
        private readonly ILogger _logger;

        public HomeController(IDistributedCache distributedCache, ILogger<HomeController> logger)
		{
			_distributedCache = distributedCache;
			_logger = logger;
			logger.LogInformation("Hello");
		}

		[HttpGet]
		public async Task<string> Get()
		{
			var cacheKey = "TheTime";
			var existingTime = _distributedCache.GetString(cacheKey);
			if (!string.IsNullOrEmpty(existingTime))
			{
				_logger.LogInformation($"Fetched from cache : {existingTime}");

				return "Fetched from cache : " + existingTime;
			}
			else
			{
				existingTime = DateTime.UtcNow.ToString();
				_distributedCache.SetString(cacheKey, existingTime);
				return "Added to cache : " + existingTime;
			}
		}
	}
}
