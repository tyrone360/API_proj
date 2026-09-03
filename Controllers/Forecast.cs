using Microsoft.AspNetCore.Mvc;

namespace API_proj.Controllers
{//start of namespace

    [Route("API/[controller]")]
    [ApiController]

    public class Forecast : ControllerBase
    {//start of class

        public string Name { get; set; }
        public string Surname { get; set; }

        public int Age { get; set; }

        public string Description { get; set; }

        public string Message { get; set; }



    }//end of class
}//end of namespace
